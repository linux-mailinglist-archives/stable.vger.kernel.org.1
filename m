Return-Path: <stable+bounces-223194-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PniICNxqWnH7AAAu9opvQ
	(envelope-from <stable+bounces-223194-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 13:03:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C932112A1
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 13:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D12330FD9A5
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B2439B4BF;
	Thu,  5 Mar 2026 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBWE+kKM"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A090839A814
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 11:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711841; cv=pass; b=MjfoEsFDuGVXaLI+lGgK+zw/hTsCyNkjKKTfTgEfUPUryeUm8feZWXuLRqaQ7yJcRpnV6V10mV+TFFYLqlx1+GGBkJhWCM4SjQ0+dJo3VX29cRRy0aFbyUUpN5AiVkiUw538jBfkNb2mKD/eMEI/0EDunWMAQh1foOKsp0ZdrUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711841; c=relaxed/simple;
	bh=pyfLXJ5tH+UuhUvOqbSizCPD2ZoHU9KWmBROO0vV3so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rm1vAJbfU30Wum2z5OmG5GxBdpf0Q6myiK0E8pPFqN6Kqhh17MxTWtdyy7XLIHcwpwprFhUbaIoLqKvp0smOHuMKddLAYzv6HJuFI3gyH/md7lAoUwTXLWrc3SKaOYupD1LhJOsyp+3muAUeo64EoI55ZxAy9Vh7TgNh2yqqkGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qBWE+kKM; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a1362c9a3cso138754e87.2
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 03:57:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772711838; cv=none;
        d=google.com; s=arc-20240605;
        b=TEUIu0/i2FefD2VxQOtDUxlV7jfeb7ylR/Ligk11qvHS4YJrBkQNO4qF1awFZf/XVA
         G7uhuc9JveIF+4OiGudBODKvt7zAZ0hcn2Ie801cZQdfcNp0KqB+XOQh3+bpPm6Mcgqf
         6OOfnKYgBy63A0RwRZq4h2iz3MgOxKFy8eJAGzwEXphFAnNCkR7ZAdZ0k9dnjFVB25vM
         2uXQW1ZMt3/pLFzoXc10hYN9/iWOQ74Asp2/UUZV4uSQ7pyCsHo4fcC5gZ/eGRWUuWnY
         HyaFyhxbL/tK/yCubugINskaRGLRsRJlUagcVAMN9x3yVPXcMmfsmPevJGJ3w13tFP8Q
         TPmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ph8ZC8yqyaXovjtTHU6caidynC4T+PLAYaAHUSYMjys=;
        fh=P++IzPDyv3a3vBAb/03ZZ/7s9lTn5tl0Gi03EZ8w6wA=;
        b=F/qY6Z+nsIuY0s2fDC0fIOj9/pf2dUdvsz/cOgIxYVzPZFCB2+RtLFf9Mi1oqo+Iww
         TsvqukjfbSfGqrwoZqSilMu4FcUfGOWZHUFHVBBSCoOMgjsogO9mN2lGkBxP5DodOcFf
         j/hoQRCCjLxYoDDix4yKP0SbvNhDTYYFstLNxNXV9qYK4ReZttueLUJ+dMncvMzi/jxI
         RlAIaqcLtgTN4JG1lH8ouLkqsiFfGyihAhUej6/7J96jTQw3KsJZ+1ay2UxHLnPimIqy
         UZ8ze+cuP+IXemUsWyo5C97Gc/sINQpRRGxN67JBe8cvxEQyeapx4JQB0gHd6/ZOs/kB
         /uqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772711838; x=1773316638; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ph8ZC8yqyaXovjtTHU6caidynC4T+PLAYaAHUSYMjys=;
        b=qBWE+kKMddGItbMbel4SbjPrRrfVMGpS4N0LcKFaMI+KsX9O7nt/V3YudJECrSgEoh
         DPBFlNpipEYsW/LbZqGPakHMkp9gZXDszaDwwgyJEj/6SpwXsjmtIyfrcSvruNrO6iu3
         anO4RBj6rLbt+bkM4ZCNbVvw61c6x422xLQRx7lO3Z2gI7oPOiopEO91St8uWTSKPOM3
         PexPTvgS0gqD6Tdgm5R3s1fnJkxAMm5xVwGltaEqg+2OkyHjyjo8gycxROQX9ZnxtxBi
         Ioz/IUFFy8xEMFPW2gsOUgf4vGPXA+a4sIKewAF+8bPHy8VHKczYjts/aEqSNQr++6iQ
         fRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711838; x=1773316638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph8ZC8yqyaXovjtTHU6caidynC4T+PLAYaAHUSYMjys=;
        b=KCHuIVzTo3DSbDCKQZzpVqTO84e3TKbQoxMeLq7MmFDVs3mTfWh1y0nTvgbaGX2XGz
         jTGHBWB4pwlVQIFqzjvsQKsc/rHptmvsugs+demEkxEnSp/CxYJ35x0uZatbPXSQlNF+
         gTMBKMzDTQZsukJ2WpdhBfXbbaeRCC2AcOLLIzwYdGBmGdWi+5hZU1RCL9ZGdEINSGYV
         mhlPYS7DUBwG5yRDLOidiLUjVHbvUuR7u3rxlF8zwfsJHQmczLLmNkkGfI4lBAdd9Ep+
         0dfqi3D171ySc7fA9Ij/AK1eLUT1iNF8RJYoQr4cS4xfadneIml59EIiWYPXuRuCXVU+
         8xSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy0bOHablvvg2y3ZwtImJ7/A+sEMg52hIonrbEzrj5yMAzgJKO9/g2lpLp5FeiR6dGjSS6PPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzquiOlZVTKgz7Ce4FdjMyEc0CBGJ+d47CJSquGcoVPHnAvKfNi
	sFMvoRyMUSmnmS2EudsSDNyVQl5hjz4XvWqeyJ43cXg0UObCPK72dWj9eeqrn07MC6fLYmrDP4a
	k2MuQAqM7k/TzpkSgqU5Q3Lx98UH3SeIkahVdOr9i7g==
X-Gm-Gg: ATEYQzxrN86xlVvpTyEctDuh49GjxZz5GHiq1Gz8iIcJFQOEuaRvjIi7AtLXQq0Jd5n
	IfeGjkDQoS6ATxST7+huCgIiQ2K0bmV6nNftNg1/S0ozbSrY0ZCyISTSTYRZxnamPjp2pC6KeQZ
	/NiKdfdV8RtAkyvjnRRd/mLNb508FboFyDrA2h6isnbUvKFNC7ZpWilNNYzICL779wK8cGXoSG4
	78CZ+EjlMNh+VC+PAeK94fJJnXDnCQ+Uo8xBdGKCD7yvdCahZg3q761ffUAYhqUMT+5tIsCvm50
	NChiS93j
X-Received: by 2002:a05:6512:1310:b0:59e:57d2:75f0 with SMTP id
 2adb3069b0e04-5a12c2a7335mr757421e87.32.1772711837789; Thu, 05 Mar 2026
 03:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302210717.1159159-1-matthew.schwartz@linux.dev>
In-Reply-To: <20260302210717.1159159-1-matthew.schwartz@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Mar 2026 12:56:42 +0100
X-Gm-Features: AaiRm52pvj2zUe_TpocqnZcJOsKiyXAj5UvLIbFePU9N0VW89wsfVt26WUjr0tI
Message-ID: <CAPDyKFqXhwT4FPE8iAEBnLyEz51MvOPAb7o6b4koogSyDDkgkg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F0C932112A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223194-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linaro.org:dkim,mail.gmail.com:mid,intel.com:email,linux.dev:email]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 at 22:08, Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> The GL9750 SD host controller has intermittent data corruption during
> DMA write operations. The GM_BURST register's R_OSRC_Lmt field
> (bits 17:16), which limits outstanding DMA read requests from system
> memory, is not being cleared during initialization. The Windows driver
> sets R_OSRC_Lmt to zero, limiting requests to the smallest unit.
>
> Clear R_OSRC_Lmt to match the Windows driver behavior. This eliminates
> write corruption verified with f3write/f3read tests while maintaining
> DMA performance.
>
> Cc: stable@vger.kernel.org
> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
> Closes: https://lore.kernel.org/linux-mmc/33d12807-5c72-41ce-8679-57aa11831fad@linux.dev/
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
> - Move GM_BURST register defines
> - Clear R_OSRC_Lmt in gli_set_9750 instead of gl9750_hw_setting to survive resets
> - Link to v1: https://lore.kernel.org/linux-mmc/20260227075909.3860183-1-matthew.schwartz@linux.dev/
>
> Changes in v1:
> - Use the proper name for the register field
> - Link to RFC: https://lore.kernel.org/linux-mmc/20260117234800.931664-1-matthew.schwartz@linux.dev/
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index b0f91cc9e40e4..6e4084407662a 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -68,6 +68,9 @@
>  #define   GLI_9750_MISC_TX1_DLY_VALUE    0x5
>  #define   SDHCI_GLI_9750_MISC_SSC_OFF    BIT(26)
>
> +#define SDHCI_GLI_9750_GM_BURST_SIZE             0x510
> +#define   SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT  GENMASK(17, 16)
> +
>  #define SDHCI_GLI_9750_TUNING_CONTROL            0x540
>  #define   SDHCI_GLI_9750_TUNING_CONTROL_EN          BIT(4)
>  #define   GLI_9750_TUNING_CONTROL_EN_ON             0x1
> @@ -345,10 +348,16 @@ static void gli_set_9750(struct sdhci_host *host)
>         u32 misc_value;
>         u32 parameter_value;
>         u32 control_value;
> +       u32 burst_value;
>         u16 ctrl2;
>
>         gl9750_wt_on(host);
>
> +       /* clear R_OSRC_Lmt to avoid DMA write corruption */
> +       burst_value = sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
> +       burst_value &= ~SDHCI_GLI_9750_GM_BURST_SIZE_R_OSRC_LMT;
> +       sdhci_writel(host, burst_value, SDHCI_GLI_9750_GM_BURST_SIZE);
> +
>         driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
>         pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
>         sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
> --
> 2.53.0
>

