Return-Path: <stable+bounces-201138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53041CC0EFE
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 05:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 53C9A3163CE3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 04:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A073242D9;
	Tue, 16 Dec 2025 04:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFezzDs4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C82F0C45
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 04:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765858574; cv=none; b=tOc+PvALIlMwk5DP0bso6EwO3CzFlgLwJU+sG5Psq2KzQXYObAz2FTGiFZQglRKyGK0RZ6+8B/3SffqHZDFXCj2R5VsiX7vbF7B6kXIWhheFchidN3nhF13OsSwB98Ny4C+utRVh7wiHsYK28B1rc8Ay0q0qkRLPAFrLIk6f9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765858574; c=relaxed/simple;
	bh=AgY+GOvmUFMhLNI02Ee8pkeMWHjqF3erk8uQ1KxoWxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6ei4rIenBqwC6fhSzOPv5NT0ma1rG5w6he32cNlSqOFVrR/6iMqMTtTlDmx1lo3EH8rIb/e3g2B2IDztqx5rLVsn0RaIQkOCVf06gsZgRt1jNZF0xhJ4CiStwOGdypdzbUeDCOVfYspJZkWgwqUv1i3J2xlXgDhp5lq2VniFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DFezzDs4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d6f647e2so29614505ad.1
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 20:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765858561; x=1766463361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=et7rgi+ejTAPK8/dLU1hy2DZMt3jWJfRXX3Q1B4YMY0=;
        b=DFezzDs4o1Ox0afhV8KX3u8B6NDUs9EK653qBnYZxjtCFFOrChpirEo5abhowIxKOF
         mbqbKcL3EP31BdovZT31/XsjNDjr6f1dOWHAD9zR+yOAmNQjx+vI6Rj6bCuDbb1zQvZ+
         uXSqyLAolsHKLtAWBjRu+bKibFDjdwJiYgOsFiao2vO8ue0PNSCPh1xsXz5595ddx6zp
         Dh5Gg9MF+6iTQkMZzPrqNco+P+t3ILYMwp1YB8E3Z1K/Fr+SLJdw2JVP1Uunzz04Xmsc
         pKdBleKUd80fN2icfi2JD6hZUNUm0fSKk068wwe2nElxrt1rjHmU4K84yKgqg3ll1x51
         wwtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765858561; x=1766463361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=et7rgi+ejTAPK8/dLU1hy2DZMt3jWJfRXX3Q1B4YMY0=;
        b=HpF9UtcddFed2m7Rko8M/5QJitfUYF5w7KpdFxBpRNtHBiibVUGiOiUVqsI+tpWheY
         Gx9IsWkDeX9dQKFGn09OT7wZjw8D0qz199oIawmErznrEIi4HWI8icGpmboViOe6GFB4
         5oceVPCcVRH8Z0Is3qBTXWtQki54tsUaqcR8R/qhaj04q6QPFNyRNxvGJ0+Es9s8SbCy
         FKrYaIcSzlGbYlqDkJ8Osr0KG8W6WEXfZxcsTR9eUfLLNEAiawBX0Tn2SepwODlxujSR
         XySZlDLjcC/Lglbmbf2Dky/9foX6N4sIgTlPIHETR2jQeIlDxTIlXobpnJKDjRPKOfjl
         SzTA==
X-Forwarded-Encrypted: i=1; AJvYcCXwFE/WktyY5c05HHE5SS8qe89qcIDeLDYUArVtZ70RWCZ8fhxvRmkYcDgoYFTERLwD6YE8cpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvvfi9I8V37COEOiESAo5VF94IyFSm6hpVUrbSiqxrIKC+tdjt
	ikO+c3+LP1XyjnBEDKHyvoarniIk6k/k8Jf8y239aVOnNaA7XNnsVJJP
X-Gm-Gg: AY/fxX6wUiQ9uhUriL0cl1TxNo5rlmd8s8cC8jfuwDkaWNa/nvo7dnD5snVD19jHzFt
	1Djt5j4/PjliirMt4iBr5duawtfwMcd1L9M52CmL0xeF8iheK6YBxwgwxjBkcOZwB5KuqQnNBFo
	hccBqvYK0uodMpJOcpuBtvO6w5wGQ+lEhdI2XBpHc5DEbvA1xgbhwJmIE+c2gPud2AgYaDFaISQ
	DMD7O7hGQZsxeR28wjCeEN8kRhAxmnfyyYwOOZhCCwsgw05/HrihCVHfrubpb8rkIgjO2FfW8mc
	zfJOcVDCYq9OQjArPyyfHGNf9M6inGAj/XRVZS1Ak2lbaHzAhwGFxvumoTcLxX3itkdu6Ix1DFa
	/hLvFbowYwPt0e2ksDCy+MsyBOa84jRydaOCvY9e5pJ9jtr1uuz9DmoVTnlbfDRu0Damyj2Y8/y
	2szkcl/9x2LDfbJUgrHJXjZ4I=
X-Google-Smtp-Source: AGHT+IH2mqQovxiCkW/b95paNZBu6LthD4xUYLjFce1Y8OnfM5LhJSe8DpxB02zxDVWoel9wWIWNWQ==
X-Received: by 2002:a05:701b:2302:b0:11b:9386:7ece with SMTP id a92af1059eb24-11f34c4ef17mr7076288c88.43.1765858561192;
        Mon, 15 Dec 2025 20:16:01 -0800 (PST)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f43ced319sm17548713c88.9.2025.12.15.20.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 20:16:00 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: gregkh@linuxfoundation.org
Cc: ashish.kalra@amd.com,
	joerg.roedel@amd.com,
	patches@lists.linux.dev,
	sarunkod@amd.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	vasant.hegde@amd.com
Subject: Re: [PATCH 6.6 194/529] iommu/amd: Skip enabling command/event buffers for kdump
Date: Tue, 16 Dec 2025 12:15:59 +0800
Message-ID: <20251216041559.3348663-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251121130237.919671254@linuxfoundation.org>
References: <20251121130237.919671254@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Nov 2025 14:08:13 +0100, gregkh@linuxfoundation.org wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.

The remaining 3 prerequisite patches in [1] should probably also be integrated,
otherwise it may cause the capture kernel to fail to run properly:

  [    8.336262][    T0] AMD-Vi: Completion-Wait loop timed out
  [    8.457132][    T0] AMD-Vi: Completion-Wait loop timed out
  [    8.578015][    T0] AMD-Vi: Completion-Wait loop timed out
  [    8.601978][    T0] Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
  [    8.612329][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.6.119-s #1
  [    8.620057][    T0] Hardware name: Tencent AC222/TC2-SLMB-A, BIOS 1.17.00 08/26/2025
  [    8.628759][    T0] Call Trace:
  [    8.632297][    T0]  <TASK>
  [    8.635445][    T0]  dump_stack_lvl+0x32/0x50
  [    8.640354][    T0]  panic+0x156/0x310
  [    8.644579][    T0]  panic_if_irq_remap+0x19/0x20
  [    8.649875][    T0]  setup_IO_APIC+0x7cb/0x8e0
  [    8.654878][    T0]  ? _raw_spin_unlock_irqrestore+0xb/0x20
  [    8.661146][    T0]  ? ioapic_read_entry+0x39/0x50
  [    8.666539][    T0]  ? clear_IO_APIC_pin+0xbb/0x130
  [    8.672025][    T0]  apic_intr_mode_init+0x62/0x110
  [    8.677511][    T0]  x86_late_time_init+0x20/0x40
  [    8.682804][    T0]  start_kernel+0x3e4/0x6d0
  [    8.687707][    T0]  x86_64_start_reservations+0x14/0x30
  [    8.693679][    T0]  x86_64_start_kernel+0x92/0xa0
  [    8.699057][    T0]  secondary_startup_64_no_verify+0x18f/0x19b
  [    8.705715][    T0]  </TASK>
  [    8.708966][    T0] Rebooting in 10 seconds..

[1] https://lore.kernel.org/all/cover.1756157913.git.ashish.kalra@amd.com/

thanks,
Jinliang Zheng :)

> 
> ------------------
> 
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> [ Upstream commit 9be15fbfc6c5c89c22cf6e209f66ea43ee0e58bb ]
> 
> After a panic if SNP is enabled in the previous kernel then the kdump
> kernel boots with IOMMU SNP enforcement still enabled.
> 
> IOMMU command buffers and event buffer registers remain locked and
> exclusive to the previous kernel. Attempts to enable command and event
> buffers in the kdump kernel will fail, as hardware ignores writes to
> the locked MMIO registers as per AMD IOMMU spec Section 2.12.2.1.
> 
> Skip enabling command buffers and event buffers for kdump boot as they
> are already enabled in the previous kernel.
> 
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> Link: https://lore.kernel.org/r/576445eb4f168b467b0fc789079b650ca7c5b037.1756157913.git.ashish.kalra@amd.com
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/iommu/amd/init.c | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 431cea41df2af..1897619209f14 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -840,11 +840,16 @@ static void iommu_enable_command_buffer(struct amd_iommu *iommu)
>  
>  	BUG_ON(iommu->cmd_buf == NULL);
>  
> -	entry = iommu_virt_to_phys(iommu->cmd_buf);
> -	entry |= MMIO_CMD_SIZE_512;
> -
> -	memcpy_toio(iommu->mmio_base + MMIO_CMD_BUF_OFFSET,
> -		    &entry, sizeof(entry));
> +	if (!is_kdump_kernel()) {
> +		/*
> +		 * Command buffer is re-used for kdump kernel and setting
> +		 * of MMIO register is not required.
> +		 */
> +		entry = iommu_virt_to_phys(iommu->cmd_buf);
> +		entry |= MMIO_CMD_SIZE_512;
> +		memcpy_toio(iommu->mmio_base + MMIO_CMD_BUF_OFFSET,
> +			    &entry, sizeof(entry));
> +	}
>  
>  	amd_iommu_reset_cmd_buffer(iommu);
>  }
> @@ -893,10 +898,15 @@ static void iommu_enable_event_buffer(struct amd_iommu *iommu)
>  
>  	BUG_ON(iommu->evt_buf == NULL);
>  
> -	entry = iommu_virt_to_phys(iommu->evt_buf) | EVT_LEN_MASK;
> -
> -	memcpy_toio(iommu->mmio_base + MMIO_EVT_BUF_OFFSET,
> -		    &entry, sizeof(entry));
> +	if (!is_kdump_kernel()) {
> +		/*
> +		 * Event buffer is re-used for kdump kernel and setting
> +		 * of MMIO register is not required.
> +		 */
> +		entry = iommu_virt_to_phys(iommu->evt_buf) | EVT_LEN_MASK;
> +		memcpy_toio(iommu->mmio_base + MMIO_EVT_BUF_OFFSET,
> +			    &entry, sizeof(entry));
> +	}
>  
>  	/* set head and tail to zero manually */
>  	writel(0x00, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
> -- 
> 2.51.0

