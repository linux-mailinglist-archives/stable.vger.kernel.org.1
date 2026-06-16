Return-Path: <stable+bounces-264062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cUs6Gi9uMWqLjAUAu9opvQ
	(envelope-from <stable+bounces-264062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:39:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C8C6913E8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:39:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=R52IFHSX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264062-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-264062-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62FCC31F2B36
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2F743DA2D;
	Tue, 16 Jun 2026 15:32:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B519244105C;
	Tue, 16 Jun 2026 15:31:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623920; cv=none; b=dC52x1FMT7JD04j4x6nAOxB/A6LzRK9f3qXm/X54mA7P/fCrUAiNeVHoIGbcGr2LL26GXfmXDAfn/2CvgwG+T9qc8mIrAoYhKDhR8FbUvI6MdtEzhT3wHfhWR9ev4+23kTb0/8pf0GmdFLjacIpodDMHU4srLjp4z7tV23QVMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623920; c=relaxed/simple;
	bh=0X4pz4sm9Whq5jgs3cfdeW8dTB5aue2NIIYKzxYhcdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vv8bCjK1L56nRCJWnihtG0krHTXNzBSNLFbgfrxOG/ZvDX+Qg7sH1SChhg1yGGGS5GaiKX3uaTyfr1A4ZATLXmFCBRL3apVSKA/eLHodQqah3UhShXB/IJREC3cCUah4BjeJ6XjdtK8KaHWZMn/6mF7ewkxXPqPTpweIZ88E0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R52IFHSX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57521F000E9;
	Tue, 16 Jun 2026 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623919;
	bh=xdysFicO/y3g+hasVatrSoBUST82dNx0krLD+yNgP58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R52IFHSXUKLotI+ISFymDFWXZTYH8+7SDanO8MGFcFAsflAui5hHTnnYXe1/JDE08
	 wLJB8hz6crHozORj2mpF9Lu4Pd4p7yC9yortv4gPYwqgY2nghjAcoDXddOcyT7UuOF
	 +AMA8/nZV8JH4HA/EgbMGa7JRqy0a7iZPbgf7tBU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yingjie Gao <gaoyingjie@uniontech.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 7.0 241/378] xfs: fix rtgroup cleanup in CoW fork repair
Date: Tue, 16 Jun 2026 20:27:52 +0530
Message-ID: <20260616145122.900033858@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264062-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:gaoyingjie@uniontech.com,m:djwong@kernel.org,m:cem@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6C8C6913E8

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yingjie Gao <gaoyingjie@uniontech.com>

commit c3e073894379532c00cca7ba5762e18fafe29da8 upstream.

xrep_cow_find_bad_rt() initializes scrub rtgroup state before the
force-rebuild path calls xrep_cow_mark_file_range(). If that call
fails, the code jumps directly to out_rtg, which skips the scrub
rtgroup cleanup and only drops the local rtgroup reference.

Remove the unnecessary jump so the function falls through to out_sr,
ensuring the realtime cursors, lock state, and sr->rtg reference are
released before returning.

Fixes: fd97fe111208 ("xfs: fix CoW forks for realtime files")
Cc: <stable@vger.kernel.org> # v6.14
Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/scrub/cow_repair.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/fs/xfs/scrub/cow_repair.c
+++ b/fs/xfs/scrub/cow_repair.c
@@ -382,12 +382,9 @@ xrep_cow_find_bad_rt(
 	 * CoW fork and then scan for staging extents in the refcountbt.
 	 */
 	if ((sc->sm->sm_flags & XFS_SCRUB_IFLAG_FORCE_REBUILD) ||
-	    XFS_TEST_ERROR(sc->mp, XFS_ERRTAG_FORCE_SCRUB_REPAIR)) {
+	    XFS_TEST_ERROR(sc->mp, XFS_ERRTAG_FORCE_SCRUB_REPAIR))
 		error = xrep_cow_mark_file_range(xc, xc->irec.br_startblock,
 				xc->irec.br_blockcount);
-		if (error)
-			goto out_rtg;
-	}
 
 out_sr:
 	xchk_rtgroup_btcur_free(&sc->sr);



