Return-Path: <stable+bounces-144433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E4FAB7692
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE2F7A5E89
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D14C295537;
	Wed, 14 May 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7tHfi9o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF59295517
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253645; cv=none; b=QCoqQxp279UG+A1La1/F/rTol4TTovCa9or43OFR9V2SiQLshtpyp+lWHZ12LDh4I4hQ12eUQKT3/K4Pl27L1szSjHSib01qSBZhNREwaVdAtN3xHQR3CYiF0uhDpYwW5Iaim+9POB1HRDQz6XmhVA0AvHgzMbH0P9t39DjEeTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253645; c=relaxed/simple;
	bh=IN/2G/Q2GM96m1QruzUDgR+fGn9BTNYATLtM0pJrWSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIbq1iqvtKl/IF4Sq1gqgnByKx5Cy3MVJPsbqMICctEzcJsZn//yBoywlmB2CqKbTQZ4illO//KElrM6XpxOHXLb1MVuvv2EZylHbg70sk7RmvI8xMv9QZbdvi1a/WfYkfNXDA7c+iZNLtxj7ScLrCxZfBAuL511Ilsw0M1Y9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7tHfi9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE95C4CEE3;
	Wed, 14 May 2025 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253645;
	bh=IN/2G/Q2GM96m1QruzUDgR+fGn9BTNYATLtM0pJrWSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p7tHfi9oxROnRVwL2leFljTG5CKT9l2rE8AnIWuYcJxawxPL4c5t/8zv+php75fim
	 zC32a0lc47Pp9BRx87WIIFmGQEvRZfDBjk4B31xuMtzqZkVe/+C+mBSOPjEpuAmm4V
	 7EZTdqzM3U+vSCydmdmQLq5STELwfdmQBBYFtAAaGvHd4TaV/1RrNW82djG8pW+wmP
	 ICo1iAQJ6WxE+9NjSlmjgOb67GKmVnqrGjmOism+ZrjM4NwmItrN8HitV80EgOErJD
	 52BKZGP4ZSBSDUCZKK1SZXYK6lSQCMUuJk0T0KJPWk9KF/pxVLC36tRAo1uYtt9U36
	 HyxXrCXESn9gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	namjain@linux.microsoft.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] uio_hv_generic: Fix sysfs creation path for ring buffer
Date: Wed, 14 May 2025 16:14:01 -0400
Message-Id: <20250514102003-1e96340cfdda0d0f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513130426.1636-1-namjain@linux.microsoft.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: f31fe8165d365379d858c53bef43254c7d6d1cfd

Status in newer kernel trees:
6.14.y | Present (different SHA1: 419663d2d8f5)
6.12.y | Present (different SHA1: 5235de792838)

Note: The patch differs from the upstream commit:
---
1:  f31fe8165d365 ! 1:  655fda9f47dce uio_hv_generic: Fix sysfs creation path for ring buffer
    @@ Commit message
         Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
         Link: https://lore.kernel.org/r/20250502074811.2022-2-namjain@linux.microsoft.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    (cherry picked from commit f31fe8165d365379d858c53bef43254c7d6d1cfd)
     
      ## drivers/hv/hyperv_vmbus.h ##
     @@ drivers/hv/hyperv_vmbus.h: static inline int hv_debug_add_dev_dir(struct hv_device *dev)
    @@ drivers/hv/vmbus_drv.c: static ssize_t subchannel_id_show(struct vmbus_channel *
      static VMBUS_CHAN_ATTR_RO(subchannel_id);
      
     +static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
    -+				       const struct bin_attribute *attr,
    ++				       struct bin_attribute *attr,
     +				       struct vm_area_struct *vma)
     +{
     +	struct vmbus_channel *channel = container_of(kobj, struct vmbus_channel, kobj);
    @@ drivers/hv/vmbus_drv.c: static umode_t vmbus_chan_attr_is_visible(struct kobject
      }
      
     +static umode_t vmbus_chan_bin_attr_is_visible(struct kobject *kobj,
    -+					      const struct bin_attribute *attr, int idx)
    ++					      struct bin_attribute *attr, int idx)
     +{
     +	const struct vmbus_channel *channel =
     +		container_of(kobj, struct vmbus_channel, kobj);
    @@ drivers/hv/vmbus_drv.c: static umode_t vmbus_chan_attr_is_visible(struct kobject
     +	return attr->attr.mode;
     +}
     +
    - static const struct attribute_group vmbus_chan_group = {
    + static struct attribute_group vmbus_chan_group = {
      	.attrs = vmbus_chan_attrs,
     -	.is_visible = vmbus_chan_attr_is_visible
     +	.bin_attrs = vmbus_chan_bin_attrs,
    @@ drivers/hv/vmbus_drv.c: static umode_t vmbus_chan_attr_is_visible(struct kobject
     +	.is_bin_visible = vmbus_chan_bin_attr_is_visible,
      };
      
    - static const struct kobj_type vmbus_chan_ktype = {
    -@@ drivers/hv/vmbus_drv.c: static const struct kobj_type vmbus_chan_ktype = {
    + static struct kobj_type vmbus_chan_ktype = {
    +@@ drivers/hv/vmbus_drv.c: static struct kobj_type vmbus_chan_ktype = {
      	.release = vmbus_chan_release,
      };
      
    @@ drivers/uio/uio_hv_generic.c: static void hv_uio_rescind(struct vmbus_channel *c
       * The ring buffer is allocated as contiguous memory by vmbus_open
       */
     -static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
    --			    const struct bin_attribute *attr,
    +-			    struct bin_attribute *attr,
     -			    struct vm_area_struct *vma)
     +static int
     +hv_uio_ring_mmap(struct vmbus_channel *channel, struct vm_area_struct *vma)
    @@ drivers/uio/uio_hv_generic.c: static int hv_uio_ring_mmap(struct file *filp, str
     -		.name = "ring",
     -		.mode = 0600,
     -	},
    --	.size = 2 * SZ_2M,
    +-	.size = 2 * HV_RING_SIZE * PAGE_SIZE,
     -	.mmap = hv_uio_ring_mmap,
     -};
     -
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

