Return-Path: <stable+bounces-218051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC6NLBpQnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:27:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF4318EADC
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24A2B300E4AA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283F024A06D;
	Wed, 25 Feb 2026 01:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="It/pYQwi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9334369A;
	Wed, 25 Feb 2026 01:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982818; cv=none; b=KvjyC//vRFOLqFWLCJe0yVNv8a3edOi/8mSk2tOSh3PPmPiuQUfs0AZoDplP7frf7wgzGCFcyie+k8cdu11rT14dNot28ivlqUN1wmbasbZEzzFhS9DIRhkqwFYgFYRuoCg8pyodeIXRqkEkFsMCbVDb5Qtid+Ru4vQdyX+ioFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982818; c=relaxed/simple;
	bh=WbSayXlnwo92uEVBXVwTz9KVb+2trXFDtt0xRo7uGgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWKMbttWc0UEQXNlybPiQZf3ityojEWR6Q8VWH2SK7iyZ6MVzzWBX2WxuxhYlNnluQBcU1z4TBOHvxaMcRKUFu/S/OlemG4WvZ2+pWLrFDFj049m254AwrqtDFALWfGbT1FQBv5kGFvP23HCnq0kKAt2eAyS1uOAqhRbX0sKugw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=It/pYQwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55759C116D0;
	Wed, 25 Feb 2026 01:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982818;
	bh=WbSayXlnwo92uEVBXVwTz9KVb+2trXFDtt0xRo7uGgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=It/pYQwiIYPrHL6uTc7H+L2oaQFE0d5prn0mbHcB2H/eq5Oo/MbGXOBQH09iUWXEn
	 KaEPlJn2H3mb1Cn6eYbtR6J10cPMECmUQoEU2S+1V8QMFDZgpLh9bVw5uMv5apiXx9
	 t6g8BN8HZvvMjK6luqPj7brCKQCN6SHIQDHu0PSY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ferry Meng <mengferry@linux.alibaba.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 014/781] erofs: Use %pe format specifier for error pointers
Date: Tue, 24 Feb 2026 17:12:03 -0800
Message-ID: <20260225012400.051822242@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218051-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DAF4318EADC
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ferry Meng <mengferry@linux.alibaba.com>

[ Upstream commit 19bfef0178c64a6281a44687380b082e69215e06 ]

%pe will print a symbolic error name (e.g,. -ENOMEM), opposed to the
raw errno (e.g,. -12) produced by PTR_ERR().

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Stable-dep-of: 9aa64b62a73c ("erofs: avoid noisy messages for transient -ENOMEM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 3d31f7840ca04..70e1597dec8a6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1324,8 +1324,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, bool eio)
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
 		if (IS_ERR(reason)) {
-			erofs_err(be->sb, "failed to decompress (%s) %ld @ pa %llu size %u => %u",
-				  alg->name, PTR_ERR(reason), pcl->pos,
+			erofs_err(be->sb, "failed to decompress (%s) %pe @ pa %llu size %u => %u",
+				  alg->name, reason, pcl->pos,
 				  pcl->pclustersize, pcl->length);
 			err = PTR_ERR(reason);
 		} else if (unlikely(reason)) {
-- 
2.51.0




