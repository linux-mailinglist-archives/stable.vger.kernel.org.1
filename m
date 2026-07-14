Return-Path: <stable+bounces-274407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FDIeB0xcVmoO4AAAu9opvQ
	(envelope-from <stable+bounces-274407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:57:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AAE756B40
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 17:56:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=hpTjHG8Z;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274407-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274407-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25D1830333C0
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33624A1391;
	Tue, 14 Jul 2026 15:56:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ECC496906
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:56:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044617; cv=none; b=I8iYGgV88YoSbA9X8V2wVfp6DDq+0IVSoznVpYZB19rJRIcbx3JZI0DQofy5X2+oM433Du18uVqColE6NlWMSZ4dh6fnQc0ivI6BsNQ+zriz+dMOfYlAitfESXcoub/c0MJtirJey37gtZ+e0F4AN4IP9LbM4KUqPGorJVVWic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044617; c=relaxed/simple;
	bh=zBqLbTYtlDQRHV7hbFO0aKoY1Vf+s3uCyuYKf/8WLhE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KidI6lUgO74ZHoa+T4nN8FnzZ87pgO0OmWabqcHuJ5SLfzwllfucOxD0yST/z2WV/M26V8OjQPAe8aPDlImyeXoUJxxVvfQ58gAf16JpSrYer5GFxFvg/CS4w+2zJbs8vr/K48sNsSlMyn5sG8x5zkL/OMAmiWeI9PBE9C6cz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hpTjHG8Z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C681F000E9;
	Tue, 14 Jul 2026 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044616;
	bh=fXJ3EPsHBiYkd+luqOba64g9M0/iPUHb3I+zYlJSLuQ=;
	h=Subject:To:Cc:From:Date;
	b=hpTjHG8ZJPS1nG3XXdbUgoSXLkFsptBkq+SUPEnPNKmIhsW8pkwi4j3XJ3UDSnKzi
	 cTSkwwxzes8SwO04SVrBFB/PnTvjJm8IJ5peX1A1cNevZd02hasQZLyglS8GfW7Lcf
	 mko8wmrmQtDiLQdgclUsnwnLfzgXi8cKKN3EC1hI=
Subject: FAILED: patch "[PATCH] xfs: only log freed extents for the current RTG in zoned" failed to apply to 6.18-stable tree
To: hch@lst.de,cem@kernel.org,djwong@kernel.org,dlemoal@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:56:41 +0200
Message-ID: <2026071441-surfacing-postwar-8451@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274407-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:cem@kernel.org,m:djwong@kernel.org,m:dlemoal@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,gregkh:mid,lst.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A9AAE756B40


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 44cccefe65749821d9a13523c8b763bf1262ef73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071441-surfacing-postwar-8451@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 44cccefe65749821d9a13523c8b763bf1262ef73 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Wed, 10 Jun 2026 07:07:21 +0200
Subject: [PATCH] xfs: only log freed extents for the current RTG in zoned
 growfs

Otherwise a power fail or crash during growfs could lead to an
elevated sb_rblocks counter.

Note that the step function is much simpler compared to the classic RT
allocator as zoned RT sections must be aligned to real time group
boundaries.

Fixes: 01b71e64bb87 ("xfs: support growfs on zoned file systems")
Cc: <stable@vger.kernel.org> # v6.15
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index debbcefdf07f..7a3f97686989 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -890,8 +890,7 @@ xfs_growfs_rt_sb_fields(
 
 static int
 xfs_growfs_rt_zoned(
-	struct xfs_rtgroup	*rtg,
-	xfs_rfsblock_t		nrblocks)
+	struct xfs_rtgroup	*rtg)
 {
 	struct xfs_mount	*mp = rtg_mount(rtg);
 	struct xfs_mount	*nmp;
@@ -903,7 +902,8 @@ xfs_growfs_rt_zoned(
 	 * Calculate new sb and mount fields for this round.  Also ensure the
 	 * rtg_extents value is uptodate as the rtbitmap code relies on it.
 	 */
-	nmp = xfs_growfs_rt_alloc_fake_mount(mp, nrblocks,
+	nmp = xfs_growfs_rt_alloc_fake_mount(mp,
+			xfs_rtgs_to_rfsbs(mp, rtg_rgno(rtg) + 1),
 			mp->m_sb.sb_rextsize);
 	if (!nmp)
 		return -ENOMEM;
@@ -1226,7 +1226,7 @@ xfs_growfs_rtg(
 	}
 
 	if (xfs_has_zoned(mp)) {
-		error = xfs_growfs_rt_zoned(rtg, nrblocks);
+		error = xfs_growfs_rt_zoned(rtg);
 		goto out_rele;
 	}
 


