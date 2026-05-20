Return-Path: <stable+bounces-249987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANOkBdfODWr53QUAu9opvQ
	(envelope-from <stable+bounces-249987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:10:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 695AB5908A2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584A73365C85
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D807F2FFFB8;
	Wed, 20 May 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lK9RUw7X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A530171C
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288384; cv=none; b=epBbYg5XAGm3NOzm/SbfhHHmNbn5BNRoRiPE48RmVROx6flGmiCOr2BqUHPY7ORXR8x/uDQ4PWr3EDRWDJ5TjUTXnJIR6GrU4je3zGds3588Yir5gEWPnoQJ2NEsI612J0eG2d0j+5kWyrklG56cYhhwiIQMQL54GGTTIs5p1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288384; c=relaxed/simple;
	bh=5s1ob1axP2YyvOlMlJO+COIQ0RFrxi/frqiijfVuST8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HnzmKzbyifdqHM2bBdwYcGIPtoD+DbK757tt11DbD4qH1xMfNNMV8avmu8FpuAQPHz6NnnJ4K60kYmipWiwld56Bd+NfQRbqtjeX8Zt7p/hmLOFiIlW0LwWLlVe/rXwZQz7Pn35gukX0a1AOM2kweOKfWchfdjtau9Hq1RffBtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lK9RUw7X; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E79F1F000E9;
	Wed, 20 May 2026 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288383;
	bh=5PyQs+3e7JRPui4jjIPZloQVMMkpy2mhOLCmaXXInIY=;
	h=Subject:To:Cc:From:Date;
	b=lK9RUw7XBagKg6mCBYa+B42g1OFfcPZefyPZQFKaNvBnjetgfX8Yd/IDrABiBtepi
	 8oi6syzxG/WW12gCYdISoH7KbClXgpdX7CZZvy/5J4hS3/QZiszVBoN1HRjtHeRKI2
	 wlQY1FFeEaH5xnFIdRubgyhsQ5L19RPHclAe82oA=
Subject: FAILED: patch "[PATCH] iommu/vt-d: Avoid NULL pointer dereference or refcount" failed to apply to 6.12-stable tree
To: zhenzhong.duan@intel.com,baolu.lu@linux.intel.com,joerg.roedel@amd.com,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:46:18 +0200
Message-ID: <2026052018-tamper-duchess-b780@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249987-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,intel.com:email,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: 695AB5908A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 79ea2feb917b05366b49d85573c9c5331f043b2c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052018-tamper-duchess-b780@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79ea2feb917b05366b49d85573c9c5331f043b2c Mon Sep 17 00:00:00 2001
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
Date: Sat, 9 May 2026 10:43:46 +0800
Subject: [PATCH] iommu/vt-d: Avoid NULL pointer dereference or refcount
 corruption

Commit 60f030f7418d ("iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE")
fixed a NULL pointer dereference in an unlikely situation partly.

If dev_pasid is not found in the dev_pasids list, it remains NULL.
However, the teardown operations are executed unconditionally, this lead
to a NULL pointer dereference or refcount corruption.

If the domain was never attached to this IOMMU, info will be NULL, which
would cause an immediate dereference when checking --info->refcnt.

Even if info is not NULL, decrementing the refcount without having removed
a valid PASID might unbalance the count. This could lead to premature
dropping of the refcount to 0, potentially causing a use-after-free for the
remaining active devices sharing the domain.

Fix it by returning early if dev_pasid is NULL, before executing the
teardown operations.

Issue found by AI review and suggested by Kevin Tian.
https://sashiko.dev/#/patchset/20260421031347.1408890-1-zhenzhong.duan%40intel.com

Fixes: 60f030f7418d ("iommu/vt-d: Avoid use of NULL after WARN_ON_ONCE")
Cc: stable@vger.kernel.org
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20260422033538.95000-1-zhenzhong.duan@intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a4b123c33022..4d0e65bc131d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3545,12 +3545,13 @@ void domain_remove_dev_pasid(struct iommu_domain *domain,
 	}
 	spin_unlock_irqrestore(&dmar_domain->lock, flags);
 
+	if (WARN_ON_ONCE(!dev_pasid))
+		return;
+
 	cache_tag_unassign_domain(dmar_domain, dev, pasid);
 	domain_detach_iommu(dmar_domain, iommu);
-	if (!WARN_ON_ONCE(!dev_pasid)) {
-		intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
-		kfree(dev_pasid);
-	}
+	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
+	kfree(dev_pasid);
 }
 
 static int blocking_domain_set_dev_pasid(struct iommu_domain *domain,


