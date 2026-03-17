Return-Path: <stable+bounces-225975-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fo1IpBQuWmuAQIAu9opvQ
	(envelope-from <stable+bounces-225975-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:01:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BAF2AA56F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E523303C39A
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50383C6A33;
	Tue, 17 Mar 2026 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dyNECTKH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791FE3C6A28
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752385; cv=none; b=Om7na+ppYorm1YcOSmHXaTjEtAgrawmiOD2sbVmMGDokdk6hKZOOHkDEY4qC4jiGmg/B7DDyqqXtNHlcE1ksGsQOMadzU0Nh03ZcxAQel9bgARCKa9LgBwWpV/x8+tEwBmUs/13gcIEFxSMHYTEc0U+bkSfJClTjPiYYlj7yGic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752385; c=relaxed/simple;
	bh=80eVG4gYvJzcGigUEjQ7IaYc3B0bCDf9HAvAShADkhc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FyF5PSrnhuRfGBVu9MPmK4gjvfofGh2T7NGCTy5xZxbbJV3A4h1ALQsNg8TVk1xOPMkdss9oObLwLOU5J8s6XsU4jXIDgvX7RwFX/lhGrPqFNE7pw06XAqB2zJyRq/81vn3eAmy7WT1oI608A7xLvnXA75DEvmq8Ttl+bh2CYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dyNECTKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DFAC4CEF7;
	Tue, 17 Mar 2026 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773752385;
	bh=80eVG4gYvJzcGigUEjQ7IaYc3B0bCDf9HAvAShADkhc=;
	h=Subject:To:Cc:From:Date:From;
	b=dyNECTKH4gdIqfcKUc3pcf2+Cih9fKY4FR6BVGHhnnLrARNg6OCv5Gzbi+qzQrzfp
	 FS7EL5Ir22lalirUbSLe5WbTCiBVROr0ifVi05DGHvTEUhsCqkU6D1tUxRFHv3d906
	 scWo4MvQDDNH0uccbGjUzK4GCwVW5qthl8aVQJjI=
Subject: FAILED: patch "[PATCH] scsi: core: Fix error handling for scsi_alloc_sdev()" failed to apply to 5.10-stable tree
To: junxiao.bi@oracle.com,bvanassche@acm.org,john.g.garry@oracle.com,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:59:35 +0100
Message-ID: <2026031735-bondless-reversal-f233@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225975-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[acm.org:query timed out,oracle.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[john.g.garry.oracle.com:query timed out];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,msgid.link:url,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 60BAF2AA56F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4ce7ada40c008fa21b7e52ab9d04e8746e2e9325
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031735-bondless-reversal-f233@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4ce7ada40c008fa21b7e52ab9d04e8746e2e9325 Mon Sep 17 00:00:00 2001
From: Junxiao Bi <junxiao.bi@oracle.com>
Date: Wed, 4 Mar 2026 08:46:03 -0800
Subject: [PATCH] scsi: core: Fix error handling for scsi_alloc_sdev()

After scsi_sysfs_device_initialize() was called, error paths must call
__scsi_remove_device().

Fixes: 1ac22c8eae81 ("scsi: core: Fix refcount leak for tagset_refcnt")
Cc: stable@vger.kernel.org
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260304164603.51528-1-junxiao.bi@oracle.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 2cfcf1f5d6a4..7b11bc7de0e3 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -360,12 +360,8 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	 * default device queue depth to figure out sbitmap shift
 	 * since we use this queue depth most of times.
 	 */
-	if (scsi_realloc_sdev_budget_map(sdev, depth)) {
-		kref_put(&sdev->host->tagset_refcnt, scsi_mq_free_tags);
-		put_device(&starget->dev);
-		kfree(sdev);
-		goto out;
-	}
+	if (scsi_realloc_sdev_budget_map(sdev, depth))
+		goto out_device_destroy;
 
 	scsi_change_queue_depth(sdev, depth);
 


