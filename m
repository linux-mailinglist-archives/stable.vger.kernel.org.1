Return-Path: <stable+bounces-244197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIvJGkcL+mlsIgMAu9opvQ
	(envelope-from <stable+bounces-244197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:22:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3454D0207
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 17:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E5F9300D4E1
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 15:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6FB48165B;
	Tue,  5 May 2026 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.in header.i=shivamkalra98@zohomail.in header.b="MhduX7DC"
X-Original-To: stable@vger.kernel.org
Received: from sender-pp-o91.zoho.in (sender-pp-o91.zoho.in [103.117.158.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0843C06A;
	Tue,  5 May 2026 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=103.117.158.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994560; cv=pass; b=lY3zgrMyS3yI1IwVut33A+4T8YSd4VYFsCbTbqK9EWU7sEju+Uv5kHZtsVRt2hkLO71TYnBOspCs+fbhrmOlxZMo7Ay3y6o1UwSotOnwp8htSzZfxH58H+B3FX9JDcnDL26AN0/AEQOIm/y8YfZCoa3POiNcIGsczR2opO3DD90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994560; c=relaxed/simple;
	bh=bpIQk+s+SCOVh6fSqSKOtm/dIveCVcKpnoIoaIWHHx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lj6XL5JVdy4IqQVMnPK3ALA+m85L7L0/aWS06qICrwu0l+4ORtkqLB6h0X/DZOoCwrr4OyHZe4JT1jYQFwcrupX7Y/S3y88VXXPNkZD0RR9C41AA6ATmvMwUwT/ABZ3RR1JGiJwxC2j63YadVxAPobp4wpmx0vPdVrg9xrhKYY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in; spf=pass smtp.mailfrom=zohomail.in; dkim=pass (1024-bit key) header.d=zohomail.in header.i=shivamkalra98@zohomail.in header.b=MhduX7DC; arc=pass smtp.client-ip=103.117.158.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.in
ARC-Seal: i=1; a=rsa-sha256; t=1777994541; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=RC+2+SVs+OzrTqBQDwUA6y/tPL1GI0ar0YkpqhWTlQf8GEfbTMt4eYQJ0FpOzMUittwNUH4BpeL97eKvcsuYxhUdHLObEFdDa5KYupmBOLjFYRhHNWo5k3pjccj12uk8y/i3Oz5EmSsuMs/kQH/K9ecBju6nBTcoDeGjLxkD0/U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1777994541; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l7WdRzPLSsYlkSgl4QoN1jtwDNE49Fj78Tl83z4Bz5c=; 
	b=WqL1zyJA5UZ8Urmh5De0CnRBnj5Zutzy17R3nVlrIxyQPUE60MosQXON5ryHWo5BCabDP5s4BkNQXz/6QKkqXiHtJkmCBMkFW1BgtC9lpFrAJpue79Rk4bakRNhiWknqpqpHbIIQgCnum0Gn5AOpxF8fHOGdWOBXU2jfH7msm20=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=zohomail.in;
	spf=pass  smtp.mailfrom=shivamkalra98@zohomail.in;
	dmarc=pass header.from=<shivamkalra98@zohomail.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777994541;
	s=zoho; d=zohomail.in; i=shivamkalra98@zohomail.in;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=l7WdRzPLSsYlkSgl4QoN1jtwDNE49Fj78Tl83z4Bz5c=;
	b=MhduX7DCzOfUt2/wjuXiTp5J4j9w5m5qSa+1OKBw0jieCNBRy5WgxHKeJrZS6JpQ
	PCzlPoeJGVu7ig4yOqBqUSCQJ+EjvMf9+BP4siE4i/TcuhsK+EjmkKGm2M9Spd+Y6vF
	YvRUPxf2Xd8cty0vlw5Xd4osRKsIO6mDY5m9IVZ0=
Received: by mx.zoho.in with SMTPS id 1777994540387707.7762062356265;
	Tue, 5 May 2026 20:52:20 +0530 (IST)
Message-ID: <e6ca711b-e134-426b-8df0-94323ac0f806@zohomail.in>
Date: Tue, 5 May 2026 20:52:18 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: force native backlight on HP OMEN 16 (8A44)
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260426-omen-16-backlight-fix-v1-1-62364f268ea6@zohomail.in>
Content-Language: en-US
From: Shivam Kalra <shivamkalra98@zohomail.in>
In-Reply-To: <20260426-omen-16-backlight-fix-v1-1-62364f268ea6@zohomail.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 6D3454D0207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.in,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[zohomail.in:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244197-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivamkalra98@zohomail.in,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[zohomail.in:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,zohomail.in:email,zohomail.in:dkim,zohomail.in:mid]

On 26/04/26 19:38, Shivam Kalra via B4 Relay wrote:
> From: Shivam Kalra <shivamkalra98@zohomail.in>
> 
> The HP OMEN 16 Gaming Laptop (board name 8A44) has a mux-less hybrid
> GPU configuration with AMD Rembrandt (Radeon 680M) and NVIDIA GA104
> (RTX 3070 Ti). The internal eDP panel is wired to the AMD iGPU.
> 
> When Nouveau loads without GSP firmware, the ACPI video backlight
> device (acpi_video0) gets registered alongside the native AMD
> backlight (amdgpu_bl2). In this state, writes to amdgpu_bl2 update
> the software brightness value but fail to change the physical panel
> brightness.
> 
> Force native backlight to prevent acpi_video0 from registering.
> Confirmed that booting with acpi_backlight=native resolves the issue.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Shivam Kalra <shivamkalra98@zohomail.in>
> ---
> This patch adds a DMI quirk to force native backlight control on the
> HP OMEN 16 Gaming Laptop (board name 8A44), which has a mux-less
> hybrid GPU configuration with AMD Rembrandt (680M iGPU) and NVIDIA
> GA104 (RTX 3070 Ti).
> On this laptop the internal eDP panel is wired to the AMD iGPU. The
> amdgpu driver registers amdgpu_bl2 as the native backlight device.
> When the Nouveau driver is loaded without GSP firmware (as is the
> case on v6.17 where GSP is not the default for Ampere GPUs), writes
> to amdgpu_bl2 fail silently — the brightness sysfs value updates
> but the physical panel brightness does not change.
> Testing:
> - Tested on HP OMEN 16 with AMD Ryzen 9 6900HX + NVIDIA RTX 3070 Ti.
> - On v6.17, without this quirk, brightness control is broken.
> - On v6.17, booting with acpi_backlight=native restores correct
>    brightness control. This patch applies that workaround
>    automatically via DMI match.
> - On v6.18+, the issue does not reproduce because commit
>    e0ed674acbac ("drm/nouveau: Remove DRM_NOUVEAU_GSP_DEFAULT
>    config") made GSP firmware the default for Ampere, which avoids
>    the ACPI conflict entirely.
> I have only tested this on v6.17 and v7.0. I am leaving it to the
> stable/LTS maintainers to determine whether this quirk should be
> backported, as I have not verified the stability of the GSP firmware
> path on intermediate releases.
> 
> Thanks,
> Shivam Kalra
> ---
>   drivers/acpi/video_detect.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 0a3c8232d15d..458efa4fe9d4 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -916,6 +916,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>   		DMI_MATCH(DMI_PRODUCT_NAME, "82K8"),
>   		},
>   	},
> +	{
> +	 .callback = video_detect_force_native,
> +	 /* HP OMEN Gaming Laptop 16-n0xxx */
> +	 .matches = {
> +		DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16-n0xxx"),
> +		},
> +	},
>   
>   	/*
>   	 * x86 android tablets which directly control the backlight through
> 
> ---
> base-commit: 27d128c1cff64c3b8012cc56dd5a1391bb4f1821
> change-id: 20260425-omen-16-backlight-fix-73fb8bc4a2b9
> 
> Best regards,
> --
> Shivam Kalra <shivamkalra98@zohomail.in>
> 
> 
Hey,

A gentle thread bump. If you have any suggestions let me know.

Shivam

