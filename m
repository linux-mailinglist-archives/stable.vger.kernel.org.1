Return-Path: <stable+bounces-262019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id APvxCiumJmozagIAu9opvQ
	(envelope-from <stable+bounces-262019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:23:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF831655A47
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:23:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O+VM0nkq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262019-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262019-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9323C301FC8D
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA072367281;
	Mon,  8 Jun 2026 11:22:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B3B3655F1;
	Mon,  8 Jun 2026 11:22:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917774; cv=none; b=bsHR1qKsxlK0CCUUm+cNhYhKKFCU7HU8BAED9cwoBjhuZQBtZHQs06BoBFGKGmFpgRB04xVAMDV+bP+cveM7n/s7LyIs5rs3NZpUl6dxve2Sv+rViWrxw8VN0Xvuzu5fVwEKyaU9mcGIloojJPmukU/w6bDxh/C3W8gYF+eRv4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917774; c=relaxed/simple;
	bh=cRFaEJ/5Iat1+jLWb+IbSOmNq3l61t2uDtZUY5/upJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErTwgNhiXpCnltU/SoZwCSKD4YJ22DaLK0b8YJU9r0NAOL4JqPPJVQWY+ZkG0pa6WhhoKSZULGKReJYI9LsiMeF1m8plR7auJrKcL/RWs6pJoTSantcTFMco4xztdlnOtdPRQ14Re17QFcp3BBPCUXcIGtriLlLqfSrvmRuJpRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+VM0nkq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0001C1F00893;
	Mon,  8 Jun 2026 11:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917773;
	bh=3+kezBZgUKVtW+nUUSt8LFf1bfx/Hr/dwNlhCpbjRqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=O+VM0nkqwLTSedAjZkcXIns1S/unxHDiv1yWwmhHXRUVcflS5WDzpAOQc0EaKHoiD
	 i1I7aND7a6pkrhCbC2mTcWzxNtFKBGfRkQfWw7Ht48gSLn4MXW/UD2jKg1RPInqnoR
	 DFQU2NDs+iGeQvtAyBg0cri6U+INvOVoTs6mu/LeoaofxTjsmA8GleHiykDwnVy+IH
	 Qjcch1N9/S4ycyP1ym70j4LJjh92KNrpZA3n5gsoAuLWVuVlpmgCf2Rn+c1iZEfrbo
	 3o70iNN7OZS1QJBmjp9Zsl9ja4Fh1atffYeKMOXCHYLs0PiAj7HvYdPOeU45Fwd3B3
	 t5sElKYT35Izg==
Message-ID: <5aaf8759-048b-4550-becb-e8686137d3da@kernel.org>
Date: Mon, 8 Jun 2026 13:22:50 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] platform/x86/amd/pmc: Add delay_suspend module
 parameter
To: Daniel Gibson <daniel@gibson.sh>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org
References: <20260606044758.2213401-1-daniel@gibson.sh>
 <20260606044758.2213401-3-daniel@gibson.sh>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260606044758.2213401-3-daniel@gibson.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262019-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hansg@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:daniel@gibson.sh,m:Shyam-sundar.S-k@amd.com,m:ilpo.jarvinen@linux.intel.com,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:superm1@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gibson.sh:email,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BF831655A47

Hi,

On 6-Jun-26 6:47 AM, Daniel Gibson wrote:
> Enabling the new delay_suspend module parameter delays suspend for
> 2.5 seconds which is known to help for some AMD-based Lenovo Laptops
> that otherwise failed to send/receive events for key presses or the
> lid switch after s2idle. Apparently the EC needs to do some things
> in the background before suspend or it gets into a bad state.
> 
> There are many reports of AMD-based laptops (mostly but not exclusively
> IdeaPads) about similar issues on the web; this parameter gives
> affected users an easy way to try out if their issues have the same
> root cause and to work around them until their specific device is added
> to the quirks list.
> 
> The parameter description has a note encouraging users to report
> their device so it can be added to the quirks list, inspired by a
> similar request in parameter descriptions of the ideapad-laptop module.
> 
> The module parameter can be set to "1" to explicitly enable it,
> "0" to disable it even on devices that are assumed to be affected,
> or -1 (the default) to enable it if the device is assumed to be affected
> (according to fwbug_list[])
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=221383
> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
> Cc: stable@vger.kernel.org
> ---
>  drivers/platform/x86/amd/pmc/pmc.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index 6bafd8661d68..2d3d180c15d2 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -16,6 +16,7 @@
>  #include <linux/bits.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
> +#include <linux/dmi.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/limits.h>

This addition of including dmi.h seems unnecessary.

> @@ -89,6 +90,11 @@ static bool disable_workarounds;
>  module_param(disable_workarounds, bool, 0644);
>  MODULE_PARM_DESC(disable_workarounds, "Disable workarounds for platform bugs");
>  
> +static int delay_suspend = -1;
> +module_param(delay_suspend, int, 0644);
> +MODULE_PARM_DESC(delay_suspend,
> +		 "Delays s2idle by 2.5 seconds to work around buggy ECs, often causing keyboard issues after suspend. 0: don't delay, 1: do delay, -1 (default): let amd_pmc decide. If you need this please report this to: platform-driver-x86@vger.kernel.org");
> +
>  static struct amd_pmc_dev pmc;
>  
>  static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
> @@ -625,8 +631,23 @@ static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
>  	 *
>  	 * See https://bugzilla.kernel.org/show_bug.cgi?id=221383
>  	 */
> -	if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
> -		dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
> +	if (amd_pmc_quirk_need_suspend_delay(pdev)) {
> +		/*
> +		 * delay_suspend=1 force-enables this, otherwise it can be
> +		 * disabled with disable_workarounds or delay_suspend=0
> +		 */
> +		if (delay_suspend == 1 || (delay_suspend == -1 && !disable_workarounds)) {
> +			dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
> +			return true;
> +		}
> +		dev_info(pdev->dev, "Not delaying suspend because of module parameter, even though your device is assumed to need it!\n");
> +	} else if (delay_suspend == 1) {
> +		dev_info(pdev->dev, "Delaying suspend by 2.5s because delay_suspend=1. If this solves problems on your machine, please report this whole line to: platform-driver-x86@vger.kernel.org so it can be automatically detected as affected in the future. System Vendor: \"%s\" Product Name: \"%s\" Product Family: \"%s\" Board Vendor: \"%s\" Board Name: \"%s\"\n",
> +			 dmi_get_system_info(DMI_SYS_VENDOR),
> +			 dmi_get_system_info(DMI_PRODUCT_NAME),
> +			 dmi_get_system_info(DMI_PRODUCT_FAMILY),
> +			 dmi_get_system_info(DMI_BOARD_VENDOR),
> +			 dmi_get_system_info(DMI_BOARD_NAME));
>  		return true;
>  	}
>  	return false;

Otherwise this looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans




