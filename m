Return-Path: <stable+bounces-249974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEIZLKnNDWr53QUAu9opvQ
	(envelope-from <stable+bounces-249974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:05:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11551590773
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9F630D2665
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4671D3EC2CE;
	Wed, 20 May 2026 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mA6BlUgO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025329C328
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288121; cv=none; b=FVFtW9DApKAvmBI84unbJh2/iyn7QLayeHpEfXuSvNoMwIKOPUXdQ2nNCeoWhIioU6jvJQ+xbJvSEA8XOdJwgv2SJ2KW26RyUbgUQ/6elva5A4DchEoLdTOI8doprRMTD+vWITSH1G4R4aym5BTVMt65+OcS7ctDoUEwWvhPIiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288121; c=relaxed/simple;
	bh=pK4IO+SDQGh04jwsgwyT0MA+WK/ih2BkgLbtqGRubSA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cg7ffFHeT6yqSQIXUu1BnpXq3ZtpcgO8LRNxOPDsiqxhjdmaqvbKxYEJX9geJagkZ6tMcuFOMasOTVa/3fo7sdX9YCMB5RLpLO/N9JPFcAEVLyIP95cLtdOeY/kpbGdLC86WcVbwK83Zorfm8lP/ipiUJ8eHkedvYrX/ufbV+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mA6BlUgO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529211F000E9;
	Wed, 20 May 2026 14:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779288119;
	bh=5187bF8HFIPLkL8FkhoH7QuaGEKT2KWvwRJWtBsxtpM=;
	h=Subject:To:Cc:From:Date;
	b=mA6BlUgOpOEUntaRhnfLyC+srQLmkalKUSqiUZ/fExZ9Rhmvk4oCbMV+ThQh+9Cn5
	 XTi7VVIZpLlKfviMaVtUh9xdLvGcmBrqy5mywZIjcMqQ/DXETDPpN42T4cXX1T5eiF
	 8kz6ti5DKt1pskpo1tx5a2663GAh+A3u1gV5PnUY=
Subject: FAILED: patch "[PATCH] iommu/amd: Remove latent out-of-bounds access in IOMMU" failed to apply to 6.18-stable tree
To: ezulian@redhat.com,joerg.roedel@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:41:55 +0200
Message-ID: <2026052055-satirical-mousy-05cf@gregkh>
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
	TAGGED_FROM(0.00)[bounces-249974-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,amd.com:email]
X-Rspamd-Queue-Id: 11551590773
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8dfd3d8d74435344ee8dc9237596959c8b2a6cbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052055-satirical-mousy-05cf@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8dfd3d8d74435344ee8dc9237596959c8b2a6cbe Mon Sep 17 00:00:00 2001
From: Eder Zulian <ezulian@redhat.com>
Date: Fri, 10 Apr 2026 14:55:50 +0200
Subject: [PATCH] iommu/amd: Remove latent out-of-bounds access in IOMMU
 debugfs

In iommu_mmio_write() and iommu_capability_write(), the variables
dbg_mmio_offset and dbg_cap_offset are declared as int. However, they
are populated using kstrtou32_from_user(). If a user provides a
sufficiently large value, it can become a negative integer.

Prior to this patch, the AMD IOMMU debugfs implementation was already
protected by different mechanisms.

1. #define OFS_IN_SZ 8 ensures the user string <= 8 bytes, so
   e.g. 0xffffffff isn't a valid input.

  if (cnt > OFS_IN_SZ)
     return -EINVAL;

2. Implicit type promotion in iommu_mmio_write(), dbg_mmio_offset is int
   and iommu->mmio_phys_end is u64

  if (dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64))
      return -EINVAL;

3. The show handlers would currently catch the negative number and
   refuse to perform the read.

Replace kstrtou32_from_user() with kstrtos32_from_user() to parse the
input, and check for negative values to explicitly prevent out-of-bounds
memory accesses directly in iommu_mmio_write() and
iommu_capability_write().

Signed-off-by: Eder Zulian <ezulian@redhat.com>
Fixes: 7a4ee419e8c1 ("iommu/amd: Add debugfs support to dump IOMMU MMIO registers")
Cc: stable@vger.kernel.org
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 4e66473d7cea..4c53b6361314 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -31,11 +31,12 @@ static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 	if (cnt > OFS_IN_SZ)
 		return -EINVAL;
 
-	ret = kstrtou32_from_user(ubuf, cnt, 0, &dbg_mmio_offset);
+	ret = kstrtos32_from_user(ubuf, cnt, 0, &dbg_mmio_offset);
 	if (ret)
 		return ret;
 
-	if (dbg_mmio_offset > iommu->mmio_phys_end - sizeof(u64))
+	if (dbg_mmio_offset < 0 || dbg_mmio_offset >
+			iommu->mmio_phys_end - sizeof(u64))
 		return -EINVAL;
 
 	iommu->dbg_mmio_offset = dbg_mmio_offset;
@@ -71,12 +72,12 @@ static ssize_t iommu_capability_write(struct file *filp, const char __user *ubuf
 	if (cnt > OFS_IN_SZ)
 		return -EINVAL;
 
-	ret = kstrtou32_from_user(ubuf, cnt, 0, &dbg_cap_offset);
+	ret = kstrtos32_from_user(ubuf, cnt, 0, &dbg_cap_offset);
 	if (ret)
 		return ret;
 
 	/* Capability register at offset 0x14 is the last IOMMU capability register. */
-	if (dbg_cap_offset > 0x14)
+	if (dbg_cap_offset < 0 || dbg_cap_offset > 0x14)
 		return -EINVAL;
 
 	iommu->dbg_cap_offset = dbg_cap_offset;


