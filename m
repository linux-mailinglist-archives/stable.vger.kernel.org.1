Return-Path: <stable+bounces-217426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHSoL0HmlmkuqwIAu9opvQ
	(envelope-from <stable+bounces-217426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:30:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 536B615DC9A
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 11:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F23683018AF4
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 10:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD493329E61;
	Thu, 19 Feb 2026 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhaIsDPm"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC02F12CE
	for <stable@vger.kernel.org>; Thu, 19 Feb 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771497019; cv=pass; b=ra/oXn5JF9szzVrzqhf0MlErlZFLla0RCW5aX0tkTcJBs2UC7x7RgnNOXRDmH94xSe7ZD6VkHwvfSZrsgoIpGZgUZ8uMoAVMm+E2c84EnS9pZ/d4rLKnGw4vGzF6VtB/NpkSTiF1XltausnuMxfPI/2u4pMPX0dS3bdToPM2b7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771497019; c=relaxed/simple;
	bh=eWjMi9oPdjlnFDLhC1g6CgpEWpUV5f5UQwqPs/wjrlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cTfvbfbj2SouBpfEYhy7IUfIU3+g+CFs3YQ7gd5doBj916QINhI9BZna94CUeoyC5rlz061MUhFvkAPeCaaXL1E2JjPBkrmQOieaAqYfoHo3zg+7DFhempFhhQnf6NWxHb+wga2El6gGqs5I4nhsxpHR15ke5kg0yrnSd+uCZbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uhaIsDPm; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59e61e94e1bso1054911e87.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 02:30:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771497016; cv=none;
        d=google.com; s=arc-20240605;
        b=Lo07LOzIPmo0NthCIEytHZF3YDoBPgj7o3xeqIxBHRSY7B5qwvx0h0CFjfn7el8K9R
         16dk/WbaktvqGsO5pnY/hb9Pa8/aQx5eoU0ds/WJUP+2s83c69zdg87VCRalqivc80/A
         +fRKMi2kawe/8sFD/RcjxwhBM2Ht3Ee7kjlX/sYv318b/OtI3vLmJftM/E6VMBmgxNET
         l4P7S5tsUWSHJq7zGE3AJwYSQ69NnuRzp9ubNqY8yd6F3nEeaIrN3aBiOFM8iHIw4IOe
         ZOqLwYekGJ5GYFR5Js1L6EirYWH+KlP9tmlpZllQ2CWLZt+LqWOuQ4CRVLnq7E9TemCh
         Y4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X4t0aQn668iou6qj2IRqi89HzqoDCvFcIKaw6c4juHE=;
        fh=/tZGRFjDeYJjgBCWMSdv8WiDRXEAjhJm2GFByh/RBG0=;
        b=LAiufbk6HtGHDRg+OWG6MxXUJrk24JtnmezYLCwbqNhcqm3vQ0+Kg8Qzd722tqm5Do
         /w0SvwT10+7w5wzV2Lv5qrAyaXO3SWdvICoEBPqIM/l0oTHqvhBEDu05kHb40sJbhYoc
         U/fwbY+5IIVwGzD3RdoM31k01MGlsYW5BlC+zMp3eq+UeEHkBQ25cSyBDUXOYFADQBu/
         sYjWtwuBpW0HGjvUr6dmf2PnRoafH4uPiqti0O107nSbqeM3iUFKPf4M5FSdnhqqVeDP
         DrHz3BF/7wHAA9kCElXC0yOf5xJjGVd/dxDex9MlKLPj/FZR7tj889yqxxGhiqr7KOjz
         a67A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771497016; x=1772101816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4t0aQn668iou6qj2IRqi89HzqoDCvFcIKaw6c4juHE=;
        b=uhaIsDPmTTTKsIRyUDl482p9uAakDLmLNAvPbNU5bqKy8HdV9hwFVSGblhhHBh8kD1
         wE4vbW8ZAHMdM9fuH1zhyk6LHh6SNM4sHqSXaNKmEyVVxkniHoyUtVhWQxhGKzJlOqBo
         G4In/a1HkhnfAXrrVVQ1eLP4qQQq6flLHBiYr5HuQKIIK6To8XlcljIJezt1EaFry3Ai
         YbHxwPztJU9PeRZKslu7MWRXi1UZSZdSB1kiqfU04kAnC8uPINravVh106vqyLIKAykD
         Hd3WxA3B2urCSygi4WR79Df4TrwPovndAcHtM4py69RH5/SY+hOlB0Tr+ET9eHQb0Ygh
         hQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771497016; x=1772101816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4t0aQn668iou6qj2IRqi89HzqoDCvFcIKaw6c4juHE=;
        b=v7exuKFbwexrEMAm7/omiVIBBwIRFuSiiAjNtP/Sr7eZg7ugJ4dS2PFoE4TFFCg2FK
         mRQqtiJoy8I19maQqJtSKWo4CLkARGYl7fRzOQrDHcdTZtAaqb4u874UHlI56Sy5Ucnc
         X82VPPKSvT2eJJfAcAd2idY2/1PQFNhkdDO8PuxM0o5Es3xC2Ho2zrxmqUBs6dQQlKRb
         pdeF/p3WwqMdligz436cMcXnrIwFomX4zuBLZTKva2q/YMrKyHweQz4Q3Wn5i78zHgeS
         JwZSCRhCzozLa9qaG/R+pKTFfuazCd6cSlq7mtQzLkri43EphbLvJ9meQ/FEaXGHS1xo
         ZdPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUoU6NnyL5QhQM6+6HoTuAeJOrOuSQohbwxP/WOrg6rS36O4QTxTgdw+SjBIqgnAHXyxBk5xs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYdGeV5vXxA6VpJK7GjcXNyKVOKL8P9Be8Jh+XA0qVN9mLeaK
	48GyAZrXZRYaSE2Inou9UmiS2V4C0WgSBDtevt4zGVv43yhXjEqzzd7PBuxdEcuZ2aZhC6nlOPm
	Qi6DHAO/gMlF02kfjTTQlxq6KGa44+U30sb6V53mppw==
X-Gm-Gg: AZuq6aLiQ05aLnmPWjFsFCFmM2H5LoexLGiB+mhgvMta9dfpswfwEA3C80VCd/0y/Ak
	FfoR2ms+DQvPTj4K4Mm3fFkw1wvmnOdXA9JttF9PbnfU/xW6xrpyyzOalMIuLCINmd2zGKDgAz5
	4nX9KZzgeNIihEAz0d/rZAp7IuKuGa+Z1D1IFc1SYKo7WVGPE4F7YP8o3sLWyOmz/Ehy6MgLdp4
	ni9rcoFfj/0ucMRda9595gQ2XrZCz0XYyhIYOATKxqCbZrt96jHBbgeOa34FRGDnqFB5K3HweRT
	3oTWDZM4
X-Received: by 2002:a05:6512:3b8e:b0:59e:5a13:f66f with SMTP id
 2adb3069b0e04-59ef97f1918mr6303112e87.15.1771497015566; Thu, 19 Feb 2026
 02:30:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219020422.1539798-1-sashal@kernel.org> <20260219020422.1539798-7-sashal@kernel.org>
In-Reply-To: <20260219020422.1539798-7-sashal@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Feb 2026 11:29:38 +0100
X-Gm-Features: AaiRm52jeG2Yu2stc47ELqgLlKg0TMPFDoFFFEOyy4G5WPX8KGX8zE9V0OcybSA
Message-ID: <CAPDyKFpnyh0csWRZN5yNZ7+941bGRXF4=yONbQygdDEF3URE6A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.19-5.15] mmc: rtsx_pci: add quirk to disable
 MMC_CAP_AGGRESSIVE_PM for RTS525A
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Matthew Schwartz <matthew.schwartz@linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217426-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,msgid.link:url,mail.gmail.com:mid,linux.dev:email,linaro.org:dkim]
X-Rspamd-Queue-Id: 536B615DC9A
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 at 03:04, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Matthew Schwartz <matthew.schwartz@linux.dev>
>
> [ Upstream commit 5f0bf80cc5e04d31eeb201683e0b477c24bd18e7 ]
>
> Using MMC_CAP_AGGRESSIVE_PM on RTS525A card readers causes game
> performance issues when the card reader comes back from idle into active
> use. This can be observed in Hades II when loading new sections of the
> game or menu after the card reader puts itself into idle, and presents
> as a 1-2 second hang.
>
> Add EXTRA_CAPS_NO_AGGRESSIVE_PM quirk to allow cardreader drivers to
> opt-out of aggressive PM, and set it for RTS525A.
>
> Closes: https://lore.kernel.org/linux-mmc/ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev/
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Link: https://patch.msgid.link/20260103204226.71752-1-matthew.schwartz@linux.dev
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

NAK.

This patch is reverted in mainline, as it's not the proper fix.

See commit eb89b17f283b233ba721fce358fa0d15223ae69d

Kind regards
Uffe




> ---
>
> LLM Generated explanations, may be completely bogus:
>
> ### Summary Analysis
>
> **What the commit does:**
> This commit adds a device-specific quirk for the Realtek RTS525A card
> reader to disable `MMC_CAP_AGGRESSIVE_PM`. When aggressive PM is enabled
> on this device, it powers down the card reader after 10 seconds of idle,
> and re-tuning when waking up causes 1-2 second hangs that are user-
> visible and impact performance.
>
> **Does it fix a real bug?**
> Yes. The aggressive PM behavior on RTS525A causes real, user-observable
> 1-2 second hangs during normal use. This was reported by a real user
> with concrete reproduction steps (playing a game that loads data from a
> micro SD card). The "Closes:" tag links to a real mailing list report.
>
> **Stable kernel criteria assessment:**
>
> 1. **Obviously correct and tested**: The change follows an existing
>    pattern (`EXTRA_CAPS_NO_MMC` is the exact same kind of quirk flag).
>    The author tested it on affected hardware.
>
> 2. **Fixes a real bug**: Yes - user-visible performance degradation (1-2
>    second hangs) on specific hardware.
>
> 3. **Important issue**: It's a usability issue rather than a
>    crash/security issue. However, hardware quirks for broken behavior
>    are explicitly allowed in stable.
>
> 4. **Small and contained**: The change is minimal - 3 new lines of code
>    plus a new flag definition. It only affects RTS525A devices and
>    doesn't change behavior for any other hardware.
>
> 5. **No new features**: This is a hardware quirk/workaround, which is an
>    explicitly allowed exception to the "no new features" rule.
>
> 6. **Clean application**: The change builds on existing infrastructure
>    (`extra_caps` flags) that exists in all stable trees since v5.11.
>
> **Risk assessment:**
> - **Very low risk**: The quirk only affects RTS525A devices
>   (`PID_525A`). All other devices are completely unaffected.
> - The code pattern is identical to existing quirks
>   (`EXTRA_CAPS_NO_MMC`).
> - The worst case if the quirk is wrong is slightly higher power
>   consumption on RTS525A (no aggressive PM = card reader stays powered).
>
> **Dependencies:**
> None. The change uses existing infrastructure (`extra_caps`,
> `CHK_PCI_PID`, `PID_525A`) that has been present since before v5.11.
>
> ### Verification
>
> - **git log** showed `rtd3_en` / `MMC_CAP_AGGRESSIVE_PM` was introduced
>   in commit `5b4258f6721f4` (v5.11), confirming all current stable trees
>   have the affected code.
> - **git tag --contains** confirmed the runtime PM commit is in stable
>   trees (p-5.15, p-6.1, p-6.12).
> - **Grep for EXTRA_CAPS_** confirmed the existing quirk flag pattern
>   (NO_MMC at bit 7, SD_EXPRESS at bit 8, new flag at bit 9 - clean
>   progression).
> - **lore.kernel.org fetch** confirmed the bug report describes real
>   user-reported 1-2 second hangs on RTS525A with concrete reproduction
>   steps.
> - **Code review** verified the change only adds a condition check and
>   flag - no behavioral change for non-RTS525A devices.
> - The commit was signed off by Greg Kroah-Hartman, the stable tree
>   maintainer, indicating it went through proper review.
> - Could NOT verify whether any stable tree has already picked this up
>   (unverified, but not relevant to the YES/NO decision).
>
> ### Conclusion
>
> This is a textbook hardware quirk for a specific device with a real,
> user-reported issue. It follows existing patterns in the codebase, is
> minimal in scope, and has zero risk to other devices. Hardware quirks
> are explicitly listed as appropriate for stable backporting. The
> affected code exists in all current stable trees (5.15+).
>
> **YES**
>
>  drivers/misc/cardreader/rts5249.c | 3 +++
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 4 ++--
>  include/linux/rtsx_pci.h          | 1 +
>  3 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
> index 38aefd8db452a..87d576a03e68e 100644
> --- a/drivers/misc/cardreader/rts5249.c
> +++ b/drivers/misc/cardreader/rts5249.c
> @@ -78,6 +78,9 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
>         if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A))
>                 pcr->rtd3_en = rtsx_reg_to_rtd3_uhsii(reg);
>
> +       if (CHK_PCI_PID(pcr, PID_525A))
> +               pcr->extra_caps |= EXTRA_CAPS_NO_AGGRESSIVE_PM;
> +
>         if (rtsx_check_mmc_support(reg))
>                 pcr->extra_caps |= EXTRA_CAPS_NO_MMC;
>         pcr->sd30_drive_sel_3v3 = rtsx_reg_to_sd30_drive_sel_3v3(reg);
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 4db3328f46dfb..8df60000b5b41 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1497,8 +1497,8 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
>         mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
>                 MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
>                 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
> -       if (pcr->rtd3_en)
> -               mmc->caps = mmc->caps | MMC_CAP_AGGRESSIVE_PM;
> +       if (pcr->rtd3_en && !(pcr->extra_caps & EXTRA_CAPS_NO_AGGRESSIVE_PM))
> +               mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
>         mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
>                 MMC_CAP2_NO_SDIO;
>         mmc->max_current_330 = 400;
> diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
> index 3c5689356004e..f6122349c00ec 100644
> --- a/include/linux/rtsx_pci.h
> +++ b/include/linux/rtsx_pci.h
> @@ -1230,6 +1230,7 @@ struct rtsx_pcr {
>  #define EXTRA_CAPS_MMC_8BIT            (1 << 5)
>  #define EXTRA_CAPS_NO_MMC              (1 << 7)
>  #define EXTRA_CAPS_SD_EXPRESS          (1 << 8)
> +#define EXTRA_CAPS_NO_AGGRESSIVE_PM    (1 << 9)
>         u32                             extra_caps;
>
>  #define IC_VER_A                       0
> --
> 2.51.0
>

