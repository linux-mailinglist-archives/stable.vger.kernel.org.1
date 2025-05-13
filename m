Return-Path: <stable+bounces-144251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB452AB5CCC
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2EF03A8605
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D8F1E521A;
	Tue, 13 May 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4SXLupZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46FF8479
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162234; cv=none; b=VZrqbb7ZYL3hJf8Es6UgiUT/d6EAP6trU0sMH2I6xCKtFz6PCZhuvfHVRWLraQJ+ME6kmNo5mhzZYlMHl/dUnJIHJtqwtuwHF4o5yBhKZ0KK8oLceeTpfR4JmyhglYAFBHG46L4NWzO30cIiCuXpdO9SB9e4pqUkI5KoIFfz7Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162234; c=relaxed/simple;
	bh=Wc94Lek5kkmc2kkbhHxDpbUZutyawfJZ2DYSyw74rKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYXhwW8HUY8doM7oeS27LxmElUzGtgfqX30tNsqx8vZnb7erNcDbnlon+JbaxaZO1Er0R2Ns/T1aVnkk3uNQXItn6ylGu88MzO7pBnv46ooM0U4b9DcFNO7YsxHIpguDkIOFeeH52Zqs6WVJL6iZm/sGuMyOAYOZvBnotJJZSYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4SXLupZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E39BC4CEE4;
	Tue, 13 May 2025 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162234;
	bh=Wc94Lek5kkmc2kkbhHxDpbUZutyawfJZ2DYSyw74rKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4SXLupZPwFOGvUf8yrxm0jGV0dibaq4v9hDv4PBmaT4BwUPREjszfzuXGOUQ2f8A
	 BSGlaQpiSJYFUlSXx3Z5tJGYPs0lt17fShSswNrgAXTailiuAMEc08jc3XRCB9dxCW
	 NKhlMaduc9dQmJXUkLcjZIpLYZpkNfnBKHUJImQEd+qxZfMQL1tO45HjI6bKx3pOJd
	 5Vopwl6iSpbj142d6mQ1147Dxr8gplvsE4yKohg3+OAqZ5y6VTlkZvbWzS/iv+/uqW
	 9hl5bE2aai6iBL04RL4VNdBd/16PA0/xr2e3iuDFAxVJOOc8WrRHR6px/0Nue7M/I5
	 7dHoWKkrf9yhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	namjain@linux.microsoft.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] uio_hv_generic: Fix sysfs creation path for ring buffer
Date: Tue, 13 May 2025 14:50:30 -0400
Message-Id: <20250513113942-895dce4988b93607@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513051942.1762-1-namjain@linux.microsoft.com>
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

Note: The patch differs from the upstream commit:
---
1:  f31fe8165d365 ! 1:  0f7ab12a823b8 uio_hv_generic: Fix sysfs creation path for ring buffer
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
    @@ drivers/uio/uio_hv_generic.c: static void hv_uio_rescind(struct vmbus_channel *c
       * The ring buffer is allocated as contiguous memory by vmbus_open
       */
     -static int hv_uio_ring_mmap(struct file *filp, struct kobject *kobj,
    --			    const struct bin_attribute *attr,
    +-			    struct bin_attribute *attr,
     -			    struct vm_area_struct *vma)
     +static int
     +hv_uio_ring_mmap(struct vmbus_channel *channel, struct vm_area_struct *vma)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

