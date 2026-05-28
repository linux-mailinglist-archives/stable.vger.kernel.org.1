Return-Path: <stable+bounces-255340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI2PLy2hGGqblggAu9opvQ
	(envelope-from <stable+bounces-255340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:10:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393C5F7F90
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC2123199BCA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D592832E6BC;
	Thu, 28 May 2026 20:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yzwSgehT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C924677F;
	Thu, 28 May 2026 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998635; cv=none; b=W+FGuVvUHYu+AqnTCLmhuLMb3aAATVR/6+BbiVTGJXxa42CCUqp2BDpV18IGnGejVhpgZ1FsSytbMLZZI+a8YaqIPaASSmE1AmiWxJb5gUsVthhLTgjeya2lqt5SPmHFfnk29S3x/4dXmBJ/r2bmuTR75qQ1/bsHz4WnhxGA0gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998635; c=relaxed/simple;
	bh=SOI5kw2xMsX1VZ12/HEz5yXzcWKqjgmmidy7+GJk/Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEa4yIchTYAY52TrLBDg5V+VNLOYCbrdfhJuHodXWQIyaAXoGXYxL4hya32nI7TyOVBo0nTl5qMwNM4V641uEgC9jCtXrNuopZEHxw5kety7jZSIQJqnx4OSJk2C9RcmsMeAZYsSJVYa+T81F4haHdrLWG7neyeN4ROI5kffln0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yzwSgehT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242D41F000E9;
	Thu, 28 May 2026 20:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998634;
	bh=+yewiXP6n/3j2sTyoaD93kjwMCr4yShRlxGV4IYHuRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yzwSgehTkiBWFC446nEDbdtt68ArXTEeO92Wlt56tqJivMWzmbrFwteAExboCBZSc
	 ga7+sFNrFodEA6REKnBCiK93gV7xGFmtk1fHCCTktWK3cvHAW4QKnz2fzuur+vi9+N
	 dCH6Dun8480sMcGsAt/ZeQ7PfmZE/owwO1kuSAsc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 244/461] zonefs: handle integer overflow in zonefs_fname_to_fno
Date: Thu, 28 May 2026 21:46:13 +0200
Message-ID: <20260528194654.208498504@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,wdc.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255340-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,wdc.com:email]
X-Rspamd-Queue-Id: 2393C5F7F90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

[ Upstream commit 3a8389d42bdf4213730f4067f8bfa78bae6564ef ]

In zonefs the file name in one of the two directories corresponds to the
zone number.

Here Alexey reported a possible integer overflow in zonefs_fname_to_fno(),
where the parsing of the zone number from the file name can overflow the
'long' data type.

Add a check for integer overflows and if the fno 'long' did overflow
return -ENOENT.

Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
Fixes: d207794ababe ("zonefs: Dynamically create file inodes when needed")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/zonefs/super.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index e83b2ec5e49f8..d0976c874b74b 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -610,10 +610,14 @@ static long zonefs_fname_to_fno(const struct qstr *fname)
 		return c - '0';
 
 	for (i = 0, rname = name + len - 1; i < len; i++, rname--) {
+		long digit;
+
 		c = *rname;
 		if (!isdigit(c))
 			return -ENOENT;
-		fno += (c - '0') * shift;
+		digit = (c - '0') * shift;
+		if (check_add_overflow(fno, digit, &fno))
+			return -ENOENT;
 		shift *= 10;
 	}
 
-- 
2.53.0




