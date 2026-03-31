Return-Path: <stable+bounces-232192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIFcGs0EzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:30:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9F636ED7D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 131EF32AD263
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24B421EE4;
	Tue, 31 Mar 2026 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wnvBQjJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACD3F8E04;
	Tue, 31 Mar 2026 16:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976114; cv=none; b=oxsysbYxhuTdCVi+/nRVGx3a9PiqJmCbLwoD/SxelVVQLFJ5kuxiydiUDLT7DApuhIIAwtPvUCTIwQ+YQskHLUYDFMURshzJI32gtT90EohjlCjldhMv7U43FCiF+c07LHySZgaruvONo7o6BWkaI+kXpc9IdQf5X1UDzPh5aww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976114; c=relaxed/simple;
	bh=1PYR1RXgk1B2YZ+9G7HzlcN1hZV42Vx/98Vhp+tcz2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xt5yGrjKwM4gTZkNvB2DWteJvABxZBp2jz/5fZJIq4GuimmU93pqZ7tuKOgoQBfbpWgI/03Hq4+STK99sZ5WaobhafLKd0FfT1OOhivIf5F9b+hTkNKdfhtLuHTUcKZsN5k5lzC8ql1LqCjmNYoBqwGqk2RclTaR9JBTSaV6WOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wnvBQjJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D48C19423;
	Tue, 31 Mar 2026 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976114;
	bh=1PYR1RXgk1B2YZ+9G7HzlcN1hZV42Vx/98Vhp+tcz2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wnvBQjJlHA7LhwhKOExcWhQ3teSBN5TcSyrU1eEvkKSmhWsmzWnR4hs+b7NmPuHpm
	 4N7CTTO0of+uoI2gBU3r3xKvjQmSPJA06TUZ7o2c1WebC0BwEAKWDrEFze8xYrSPC3
	 algRdGof7iKvvRNGbIqR8FJav7ElNEse09l62Ohs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	hongao <hongao@uniontech.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 6.12 179/244] xfs: scrub: unlock dquot before early return in quota scrub
Date: Tue, 31 Mar 2026 18:22:09 +0200
Message-ID: <20260331161748.366666004@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232192-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:email]
X-Rspamd-Queue-Id: BF9F636ED7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: hongao <hongao@uniontech.com>

commit 268378b6ad20569af0d1957992de1c8b16c6e900 upstream.

xchk_quota_item can return early after calling xchk_fblock_process_error.
When that helper returns false, the function returned immediately without
dropping dq->q_qlock, which can leave the dquot lock held and risk lock
leaks or deadlocks in later quota operations.

Fix this by unlocking dq->q_qlock before the early return.

Signed-off-by: hongao <hongao@uniontech.com>
Fixes: 7d1f0e167a067e ("xfs: check the ondisk space mapping behind a dquot")
Cc: <stable@vger.kernel.org> # v6.8
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/scrub/quota.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/xfs/scrub/quota.c
+++ b/fs/xfs/scrub/quota.c
@@ -174,8 +174,10 @@ xchk_quota_item(
 
 	error = xchk_quota_item_bmap(sc, dq, offset);
 	xchk_iunlock(sc, XFS_ILOCK_SHARED);
-	if (!xchk_fblock_process_error(sc, XFS_DATA_FORK, offset, &error))
+	if (!xchk_fblock_process_error(sc, XFS_DATA_FORK, offset, &error)) {
+		mutex_unlock(&dq->q_qlock);
 		return error;
+	}
 
 	/*
 	 * Warn if the hard limits are larger than the fs.



