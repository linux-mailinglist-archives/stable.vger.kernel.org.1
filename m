Return-Path: <stable+bounces-262018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e3enOemnJmq1agIAu9opvQ
	(envelope-from <stable+bounces-262018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:30:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF32B655B9C
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:30:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IXPdpZbn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262018-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262018-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBCD9306A761
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9335BDC2;
	Mon,  8 Jun 2026 11:19:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89705346E51;
	Mon,  8 Jun 2026 11:19:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917592; cv=none; b=qLSYDi2eC0AVYjL6ww/h/XMwETEz80qJqfBOxOTUVb9BXi9OFUogFQZmPOyWN5LhsFaCOwxelfCazK/O6K3xLuTzhUR42teW9wTUTNmfV1qoUq4FzMxmjRiOA+DkIHQFQfyf0OmwfR/PadC/g5966VTGneRmotezbF2OsWxRMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917592; c=relaxed/simple;
	bh=jVnTKTFy6/Q7vtUR0HUtyQ6QHGdZG2+obR7FSVrRiLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exfphFkvuiGh8NYLGCbbIEQi7fNy2EMEHlIL3MdvgDICiKnA9h+l8ScD2l5QqHxcGFmL9udKgZwHrNT9bgprWjC/oY5GsF14Fmkd29/nqLWICYJONeXvuVqd6IJzqPunh7bX4LpaHB5yFZYJpHSRh+mGgeLGFFWtoIq4m082NlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXPdpZbn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD2B1F00893;
	Mon,  8 Jun 2026 11:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917591;
	bh=LIIbO9x6jBaBTpwM/cTl+/ZHWVEKBTNSxZhpQqR5XRY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IXPdpZbnuyMuvzR/CI5yzTgSkDPrmFuECAUx//qbjGdQUsNoHejtUFzvWVx+6oR+k
	 zxD9gyPNuH1J1rz0sXx175p5JhEdTaOdMYkk/qHqnPHAa9X6QjygiXgHA2ZMm/UbeY
	 4h8m5A3sPrJk0bDMJkWeP+ufxG/Pdncw3twDMXb2F3RzStVDILLho8uJLOOVe/cLFU
	 r9DXFJclWaqKp24rt7htvWz/ypAkGWVDcRNBHTnvbOPooshOzYwci6FZMvP4DXh5qE
	 /AQUxCM67HBCe3kJPY7ArMHESNRjqqu39ysXyzWIe4FCl3/v4+MgiPet/VRMrpkN3k
	 mqCFzxuadWaGg==
Message-ID: <63cecb28-336d-47aa-9f47-7fc3f76e7cf6@kernel.org>
Date: Mon, 8 Jun 2026 13:19:46 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] platform/x86/amd/pmc: Delay suspend for some
 Lenovo Laptops
To: Daniel Gibson <daniel@gibson.sh>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <superm1@kernel.org>
Cc: Sindre Henriksen <sindrehenriksen93@gmail.com>, stable@vger.kernel.org
References: <20260606044758.2213401-1-daniel@gibson.sh>
 <20260606044758.2213401-2-daniel@gibson.sh>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260606044758.2213401-2-daniel@gibson.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262018-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hansg@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:daniel@gibson.sh,m:Shyam-sundar.S-k@amd.com,m:ilpo.jarvinen@linux.intel.com,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:superm1@kernel.org,m:sindrehenriksen93@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hansg@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,gibson.sh:email,intel.com:email,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF32B655B9C

Hi,

On 6-Jun-26 6:47 AM, Daniel Gibson wrote:
> Some IdeaPad Slim 3 devices and similar with AMD CPUs have a
> nonfunctional keyboard and lid switch after s2idle.
> 
> It helps to delay suspend by 2.5 seconds so the EC has some time
> to do whatever it needs to get done before suspend - unfortunately
> at least on my 16ABR8 waking it with a timer (wakealarm) still
> triggers the issue, but at least normal resume via keypress or
> lid works fine. On the 14ARP10 wakealarm has been reported to also
> work fine with this patch.
> 
> This issue has been reported for many different devices, this patch
> has been tested with the Zen3-based IdeaPad Slim 3 16ABR8 (82XR)
> and the Zen3+-based IdeaPad Slim 3 14ARP10 (83K6) and IdeaPad Slim 3
> 15ARP10 (83MM).
> 
> Reported-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221383
> Tested-by: Sindre Henriksen <sindrehenriksen93@gmail.com>
> Suggested-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Daniel Gibson <daniel@gibson.sh>
> Cc: stable@vger.kernel.org

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/platform/x86/amd/pmc/pmc-quirks.c | 39 +++++++++++++++++++++++
>  drivers/platform/x86/amd/pmc/pmc.c        | 24 +++++++++++++-
>  drivers/platform/x86/amd/pmc/pmc.h        |  1 +
>  3 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> index 24506e342943..74ddf1d8289a 100644
> --- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
> +++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
> @@ -18,6 +18,7 @@
>  struct quirk_entry {
>  	u32 s2idle_bug_mmio;
>  	bool spurious_8042;
> +	bool need_suspend_delay;
>  };
>  
>  static struct quirk_entry quirk_s2idle_bug = {
> @@ -33,6 +34,10 @@ static struct quirk_entry quirk_s2idle_spurious_8042 = {
>  	.spurious_8042 = true,
>  };
>  
> +static struct quirk_entry quirk_s2idle_need_suspend_delay = {
> +	.need_suspend_delay = true,
> +};
> +
>  static const struct dmi_system_id fwbug_list[] = {
>  	{
>  		.ident = "L14 Gen2 AMD",
> @@ -203,6 +208,35 @@ static const struct dmi_system_id fwbug_list[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
>  		}
>  	},
> +	/* https://bugzilla.kernel.org/show_bug.cgi?id=221383 */
> +	{
> +		.ident = "Zen3-based IdeaPad Slim and similar",
> +		.driver_data = &quirk_s2idle_need_suspend_delay,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			/*
> +			 * Note: there are also some Zen2-based 82X* devices that
> +			 * need different quirks, they're already handled above
> +			 */
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82X"),
> +		}
> +	},
> +	{
> +		.ident = "Zen3+-based IdeaPad Slim and similar",
> +		.driver_data = &quirk_s2idle_need_suspend_delay,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83K"),
> +		}
> +	},
> +	{
> +		.ident = "IdeaPad Slim 3 15ARP10 (83MM)",
> +		.driver_data = &quirk_s2idle_need_suspend_delay,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "83MM"),
> +		}
> +	},
>  	/* https://bugzilla.kernel.org/show_bug.cgi?id=221273 */
>  	{
>  		.ident = "Thinkpad L14 Gen3",
> @@ -356,6 +390,11 @@ void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev)
>  		amd_pmc_skip_nvme_smi_handler(dev->quirks->s2idle_bug_mmio);
>  }
>  
> +bool amd_pmc_quirk_need_suspend_delay(struct amd_pmc_dev *dev)
> +{
> +	return dev->quirks && dev->quirks->need_suspend_delay;
> +}
> +
>  void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
>  {
>  	const struct dmi_system_id *dmi_id;
> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
> index 2b9e5730170a..6bafd8661d68 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.c
> +++ b/drivers/platform/x86/amd/pmc/pmc.c
> @@ -611,6 +611,27 @@ static bool amd_pmc_intermediate_wakeup_need_delay(struct amd_pmc_dev *pdev)
>  	return get_metrics_table(pdev, &table) == 0 && table.s0i3_last_entry_status;
>  }
>  
> +static bool amd_pmc_want_suspend_delay(struct amd_pmc_dev *pdev)
> +{
> +	/*
> +	 * Some Lenovo Laptops (like different IdeaPad 3 Slims) need some
> +	 * me-time before sleeping or they get uncooperative after waking
> +	 * up and don't send events for keyboard and lid switch anymore.
> +	 *
> +	 * Unfortunately this doesn't entirely fix the problem: It can still
> +	 * happen when resuming with a timer (wakealarm), but at least the
> +	 * more common usecases (wakeup by opening lid or pressing a key)
> +	 * work fine with this workaround.
> +	 *
> +	 * See https://bugzilla.kernel.org/show_bug.cgi?id=221383
> +	 */
> +	if (!disable_workarounds && amd_pmc_quirk_need_suspend_delay(pdev)) {
> +		dev_info(pdev->dev, "Delaying suspend by 2.5s to avoid platform bug\n");
> +		return true;
> +	}
> +	return false;
> +}
> +
>  static void amd_pmc_s2idle_prepare(void)
>  {
>  	struct amd_pmc_dev *pdev = &pmc;
> @@ -647,7 +668,8 @@ static void amd_pmc_s2idle_check(void)
>  	struct amd_pmc_dev *pdev = &pmc;
>  	int rc;
>  
> -	if (amd_pmc_intermediate_wakeup_need_delay(pdev))
> +	if (amd_pmc_intermediate_wakeup_need_delay(pdev) ||
> +	    amd_pmc_want_suspend_delay(pdev))
>  		msleep(2500);
>  
>  	/* Dump the IdleMask before we add to the STB */
> diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
> index fe3f53eb5955..f5257e47b8c4 100644
> --- a/drivers/platform/x86/amd/pmc/pmc.h
> +++ b/drivers/platform/x86/amd/pmc/pmc.h
> @@ -147,6 +147,7 @@ enum amd_pmc_def {
>  };
>  
>  void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev);
> +bool amd_pmc_quirk_need_suspend_delay(struct amd_pmc_dev *dev);
>  void amd_pmc_quirks_init(struct amd_pmc_dev *dev);
>  void amd_mp2_stb_init(struct amd_pmc_dev *dev);
>  void amd_mp2_stb_deinit(struct amd_pmc_dev *dev);


