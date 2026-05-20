Return-Path: <stable+bounces-249977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLJRBNDNDWr53QUAu9opvQ
	(envelope-from <stable+bounces-249977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:05:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC645907AF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A8EA30D6319
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B613EAC84;
	Wed, 20 May 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GN229wgD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9F72D877B
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288162; cv=none; b=FCdVkbI5Xyksgv0WuGWhNrQiCNU57PAAsLU4jTSJanEprcN2Ul6a4ijydjSdmfxNNYYEuFP4UO5oNwtUtLd1IKfcTOq8NNujeDlwmbNphlJOctTiCfffWrCsf3CYAqUQ6iw2irljUldMiDmXVKzrShlJpsfcQeHQrOh70/jZTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288162; c=relaxed/simple;
	bh=VkEkz6vCxjrUZgz8oDDi49uZG/DgbNyePfHseNVGUJs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=oqL03TzggtH0RZ4YQv3nXDojDZJ1qN/7u3mM2X/1DBR+j7qHTYjrhjjexEA/+vxF2iFGDjKO4vZFYmmjmIpIBKLNg817EFy0vYWUzQVGFoc89CuptatJj0yj7ZeWUHN51SWrGhi5ZEgP375QepOTHP+EeA09XaQTI3Ys52JPe4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GN229wgD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CB11F000E9;
	Wed, 20 May 2026 14:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288161;
	bh=wsojP8GWrGQFMS+1UXb8EbEJKGnZ4pjt1+M4sMJBHck=;
	h=Subject:To:Cc:From:Date;
	b=GN229wgD1vOY6vAWPbTOipNHvnPEbx07V1Y/WgEdEXsufqxhvgnnkfmvMrPV9pL0a
	 A/mLJjuzdGzP3DpxLhhZrUcv7w5Tvhm7lf7xr0m8w7dc/87dDAi4C/gJCKenHrutwH
	 myQovU/+njUjp0nj0qCSv5w7IqpnPo7NEW44uYt8=
Subject: FAILED: patch "[PATCH] xfs: fix memory leak for data allocated by" failed to apply to 6.18-stable tree
To: wilfred.mallawa@wdc.com,cem@kernel.org,djwong@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:42:36 +0200
Message-ID: <2026052036-iciness-broiler-4c5d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249977-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lst.de:email]
X-Rspamd-Queue-Id: 7FC645907AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x af47a4be6a90c8bfc874f9994ac9c15813b9718b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052036-iciness-broiler-4c5d@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af47a4be6a90c8bfc874f9994ac9c15813b9718b Mon Sep 17 00:00:00 2001
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Date: Fri, 17 Apr 2026 12:16:30 +1000
Subject: [PATCH] xfs: fix memory leak for data allocated by
 xfs_zone_gc_data_alloc()

In xfs_zone_gc_mount(), on error, a struct xfs_zone_gc_data allocated
with xfs_zone_gc_data_alloc() is freed with kfree(), however, this
doesn't free the underlying folios or the rmap_irecs.

Use xfs_zone_gc_data_free() to correctly free this memory.

Fixes: 080d01c41d44 ("xfs: implement zoned garbage collection")
Cc: stable@vger.kernel.org # v6.15
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index fedcc47048af..c8a1d5c0332c 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -1221,7 +1221,7 @@ out_put_oz:
 	if (data->oz)
 		xfs_open_zone_put(data->oz);
 out_free_gc_data:
-	kfree(data);
+	xfs_zone_gc_data_free(data);
 	return error;
 }
 


