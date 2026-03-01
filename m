Return-Path: <stable+bounces-222403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KplIbW3o2mLKgUAu9opvQ
	(envelope-from <stable+bounces-222403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:51:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E74471CE767
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88672301C131
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 03:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79316312825;
	Sun,  1 Mar 2026 03:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmdxjAi/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFD62737E3
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772337057; cv=none; b=rLoN83JRUq4Qr6h+4kfb/OjdSp3etvJxixqjIs/CpSv3g3P75dncABNg+bhfl4UCB0Q2eZdCr9we63ltAN+LjJA6VDP0m453DIAPrncaQNnim3rn/GUn8JitMQb0UHYSj+PrvblGVznGtdPel60w5c5y5dGLtHnK/OOFkwnf1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772337057; c=relaxed/simple;
	bh=dMPwz83V0EGBSQGUv+05EFSISdqfMRyZjBUGlzSck3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwsWMvv4uDyIIUyt/GTvBVPgU2N1UbrEATBymjByIZJWVmH3nyhgvzHJpz4osRPHrfaSoMZ4FAxqEzhqt4umnj5o4TtHX2/n+vQyo8SrflTXm03gGNkVfWrT/mwBqZgahdyTMz3K5Ph1QAJHGwi6CloXpVhJ8Mg6Rql0TwRNPBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmdxjAi/; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so1149805a12.0
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 19:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772337055; x=1772941855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WmlZ9Q2/zs3s/Gu9x2MdBKtAiPtvLREfo+aflS322E=;
        b=cmdxjAi/gfi1J5TR/i0YJ0HOqOCQk7KZtAbM/bqJb5dJf6Kr3XHc5n8XfNkS7plm9f
         cnjBc6Qd6TYs+zLbqZ2lyVQFllQu71EAecdhEKD0CTGVIn6tpou61oRyLYXq4t9FwYR9
         PvR/sxC+ORvwWVZFOpIPH2y1IyNCGUb3faxJvEF/UE4+rB/9CfJYhXnnZ2dMmZA/QWi6
         ikYP1lDulDESCW1nipI2GYk7fvFAn8Nw0T2QqdNfXCMMEYIniEoqveiXow3+HCT5pCTk
         hjQkWYqsUYGztBqc8G5soXZjt/Tqa0DRGVduhr/DhnbUV6NoQxAA0rVIil3QTjvceGcQ
         Ehwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772337055; x=1772941855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WmlZ9Q2/zs3s/Gu9x2MdBKtAiPtvLREfo+aflS322E=;
        b=InHZcUHMJdN5KoSpThAEHf7B+cuez4cVHbQqHyH5VIxl87WWMUggsiKAsN6eq2bW3H
         uwF5RcIl6F9IeJPkos25mGaZDKkVOB7yUMLWbbtfJKxLyrARaVaJ23SdmAvCFbLFwPJE
         9JnUPXEb/6ZzLA3z22CUQvrjfULymQ8G2XFFOvk6KBSBJlUSDvYbu033AauWGpBwPnFs
         kLW2E6Rv2Ir3arPn1y14ct0wF7IADLq9FeSeh0jnTCfIbpllzL2ANtWKPJ57uX24qdaH
         xbZ7QYX6z8UZh66f4zJtptAulD59BK98q46r5UzwYZ2G11tj1Hku0yA+C80x7Yny0v3F
         8NUg==
X-Forwarded-Encrypted: i=1; AJvYcCWYw/U1yzErmbNMie7+P0ysatxKNQzn3x/s/svZdq37o5Cx3h0lYwOZ18voTMbz8kxa7cpXrGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmM36TGtmaj32927U46MvW7m1LNlrRzCOPDtHQr7Z/gAqui6S+
	HBPxq+nkMJGygtxCi6KLb3l25jxsXQ3ngHilwHM2SM0WQIosXTdV0zOu
X-Gm-Gg: ATEYQzyZ2BOsQYtqs2IdSMRPiVg0QMzvIPg927qC0hld46uPal7bfJNGj/s3uDT0/fP
	SLpynQoYvqwQw++auRHzcIhQddNyHAattM3K87JsgxyprcmaFthO+ypVWqNx+dATZvshHpkjaye
	umI8tGH5ScMltf7XcS/ZBLv4fmHtKyuO20vTjptMtQUUzowZIJapYW8BEcSvPU4U2FFEGr3kqa+
	46qEMQlT0Bzjq20sy98aX7xZPCjVwBfxmRjJhLd6XGjXWF+5f4gYtrRw/1hqdP/LI26SZZUaALH
	aYSGVdcn+sbRRH4Gmcw4HTEI6Sh0mSrTiTA3QI1H/n/O4f6CRo+R3e1T/5UkDubXEon0YOByeey
	E9GOeyVfNYD3zITy+EbhQe6ETsq0E5h6E2G1fORfkyY0IAK4RPLdWEbx+Q8eIvlThYWzKpoc3Cg
	39SOzV7kLXkTQwYDDUSbGLPnOfFbM5e7wRuI5aRGqOzI+ZQX94V1SU16GB4c/wiBSn28MDbLDXA
	AFhirJBeJtnddc7JOBipMo=
X-Received: by 2002:a05:6a00:4503:b0:827:3b1b:43e6 with SMTP id d2e1a72fcca58-8274d94caf9mr6631233b3a.21.1772337055416;
        Sat, 28 Feb 2026 19:50:55 -0800 (PST)
Received: from [26.26.26.1] (107.153.212.35.bc.googleusercontent.com. [35.212.153.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d4d880sm9534477b3a.7.2026.02.28.19.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 19:50:55 -0800 (PST)
Message-ID: <0a506efc-a06d-4523-b149-eb74eb5df067@gmail.com>
Date: Sun, 1 Mar 2026 11:50:51 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] iommu/vt-d: Skip dev-iotlb flush for inaccessible
 PCIe device
To: Jinhui Guo <guojinhui.liam@bytedance.com>, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20251211035946.2071-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-222403-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[etzhao1900@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E74471CE767
X-Rspamd-Action: no action



On 12/11/2025 11:59 AM, Jinhui Guo wrote:
> Hi, all
> 
> We hit hard-lockups when the Intel IOMMU waits indefinitely for an ATS invalidation
> that cannot complete, especially under GDR high-load conditions.
> 
> 1. Hard-lock when a passthrough PCIe NIC with ATS enabled link-down in Intel IOMMU
>     non-scalable mode. Two scenarios exist: NIC link-down with an explicit link-down
>     event and link-down without any event.
> 
>     a) NIC link-down with an explicit link-dow event.
>        Call Trace:
>         qi_submit_sync
>         qi_flush_dev_iotlb
>         __context_flush_dev_iotlb.part.0
>         domain_context_clear_one_cb
>         pci_for_each_dma_alias
>         device_block_translation
>         blocking_domain_attach_dev
>         iommu_deinit_device
>         __iommu_group_remove_device
>         iommu_release_device
>         iommu_bus_notifier
>         blocking_notifier_call_chain
>         bus_notify
>         device_del
>         pci_remove_bus_device
>         pci_stop_and_remove_bus_device
>         pciehp_unconfigure_device
>         pciehp_disable_slot
>         pciehp_handle_presence_or_link_change
>         pciehp_ist
> 
>     b) NIC link-down without an event - hard-lock on VM destroy.
>        Call Trace:
>         qi_submit_sync
>         qi_flush_dev_iotlb
>         __context_flush_dev_iotlb.part.0
>         domain_context_clear_one_cb
>         pci_for_each_dma_alias
>         device_block_translation
>         blocking_domain_attach_dev
>         __iommu_attach_device
>         __iommu_device_set_domain
>         __iommu_group_set_domain_internal
>         iommu_detach_group
>         vfio_iommu_type1_detach_group
>         vfio_group_detach_container
>         vfio_group_fops_release
>         __fput
> 
> 2. Hard-lock when a passthrough PCIe NIC with ATS enabled link-down in Intel IOMMU
>     scalable mode; NIC link-down without an event hard-locks on VM destroy.
>     Call Trace:
>      qi_submit_sync
>      qi_flush_dev_iotlb
>      intel_pasid_tear_down_entry
>      device_block_translation
>      blocking_domain_attach_dev
>      __iommu_attach_device
>      __iommu_device_set_domain
>      __iommu_group_set_domain_internal
>      iommu_detach_group
>      vfio_iommu_type1_detach_group
>      vfio_group_detach_container
>      vfio_group_fops_release
>      __fput
> 
> Fix both issues with two patches:
> 1. Skip dev-IOTLB flush for inaccessible devices in __context_flush_dev_iotlb() using
>     pci_device_is_present().
> 2. Use pci_device_is_present() instead of pci_dev_is_disconnected() to decide when to
>     skip ATS invalidation in devtlb_invalidation_with_pasid().
If what I remembered right, using pci_device_is_present() to replace
pci_device_is_disconnected() might not be the correct choice against
link down case, you might misunderstand the function of pci_device_is
_present() when device is there but link is not up. if you want to check
link status, just check link status.

Bjorn, correct me if I am wrong.

Thanks,
Ethan


> 
> Best Regards,
> Jinhui
> 
> ---
> v1: https://lore.kernel.org/all/20251210171431.1589-1-guojinhui.liam@bytedance.com/
> 
> Changelog in v1 -> v2 (suggested by Baolu Lu)
>   - Simplify the pci_device_is_present() check in __context_flush_dev_iotlb().
>   - Add Cc: stable@vger.kernel.org to both patches.
> 
> Jinhui Guo (2):
>    iommu/vt-d: Skip dev-iotlb flush for inaccessible PCIe device without
>      scalable mode
>    iommu/vt-d: Flush dev-IOTLB only when PCIe device is accessible in
>      scalable mode
> 
>   drivers/iommu/intel/pasid.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 


