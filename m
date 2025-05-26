Return-Path: <stable+bounces-146319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F73AC384D
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 05:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A6827A9364
	for <lists+stable@lfdr.de>; Mon, 26 May 2025 03:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DED1991B6;
	Mon, 26 May 2025 03:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="Zv8br4FS"
X-Original-To: stable@vger.kernel.org
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B867E110;
	Mon, 26 May 2025 03:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748231610; cv=none; b=P6R7cuViRdc9rwfuJkrLgxnpWzEcBgWo3uCe8hUbQlwuOeKWkx4y7TfPRGeS0Oqn8C3lkcS2rKLjYDVqRuPRKAhfLkxBbQu1MP6iDyh71cw5PzVbEvIw5A9lT0THYy/Fe0io58xEqov9Kgq/6lUhYWNQSgYhuN4XI9Ian3NU+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748231610; c=relaxed/simple;
	bh=ITsjG0dWsnMGW3i6jL6ZmrcLdIcJyFzXYsV7yW/0Asg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EorWGcxzugO4+Aym578VDy7OIOKBithrOECa+t7Ij1+H1HBktTvLIpPEl3YupHmBjSULQWv+3dlstAoPxckjHHGpFmO3RhBduT0eqGnnfRz2S6eoTaF7Bmb8W6t1LG4YpQFYas20XBl72+2bPoNA8nQ3B5uWO8xWSFhShLyfDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=Zv8br4FS; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id B3CE520276;
	Mon, 26 May 2025 03:43:46 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.156])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 81A47261DE;
	Mon, 26 May 2025 03:43:37 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 0A81F20312;
	Mon, 26 May 2025 03:43:29 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 4499440093;
	Mon, 26 May 2025 03:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1748231007; bh=ITsjG0dWsnMGW3i6jL6ZmrcLdIcJyFzXYsV7yW/0Asg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zv8br4FSCCtzCbnIYIFAKDYXUPoA4iWvA8kAK1tmMEU023p/NChCG1U4MV7OpqRUv
	 Z0dOHgg2xTLBMutKUGuQq2Nl65DX1w7r/HnvMpCQGrTgz5jea5oC/4NV+EzFuzTZig
	 /9noWHf/aWg7FPS2gAPvg1l5RWz+FsYZ3+vhQJj4=
Received: from [19.191.1.9] (unknown [223.76.243.206])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 7C97140CC8;
	Mon, 26 May 2025 03:43:24 +0000 (UTC)
Message-ID: <5c7537a3-4a23-44e9-860a-9c12203577f0@aosc.io>
Date: Mon, 26 May 2025 11:43:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: ideapad-laptop: use usleep_range() for EC
 polling
To: Rong Zhang <i@rong.moe>, Ike Panhc <ikepanhc@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Eric Long <i@hack3r.moe>,
 Kexy Biscuit <kexybiscuit@aosc.io>
References: <20250525201833.37939-1-i@rong.moe>
Content-Language: en-US
From: Mingcong Bai <jeffbai@aosc.io>
In-Reply-To: <20250525201833.37939-1-i@rong.moe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: 4499440093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[rong.moe,gmail.com,redhat.com,linux.intel.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[jeffbai.aosc.io:server fail,stable.vger.kernel.org:server fail,i.hack3r.moe:server fail,i.rong.moe:server fail];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]

Hi Rong,

在 2025/5/26 04:18, Rong Zhang 写道:
> It was reported that ideapad-laptop sometimes causes some recent (since
> 2024) Lenovo ThinkBook models shut down when:
>   - suspending/resuming
>   - closing/opening the lid
>   - (dis)connecting a charger
>   - reading/writing some sysfs properties, e.g., fan_mode, touchpad
>   - pressing down some Fn keys, e.g., Brightness Up/Down (Fn+F5/F6)
>   - (seldom) loading the kmod
> 
> The issue has existed since the launch day of such models, and there
> have been some out-of-tree workarounds (see Link:) for the issue. One
> disables some functionalities, while another one simply shortens
> IDEAPAD_EC_TIMEOUT. The disabled functionalities have read_ec_data() in
> their call chains, which calls schedule() between each poll.
> 
> It turns out that these models suffer from the indeterminacy of
> schedule() because of their low tolerance for being polled too
> frequently. Sometimes schedule() returns too soon due to the lack of
> ready tasks, causing the margin between two polls to be too short.
> In this case, the command is somehow aborted, and too many subsequent
> polls (they poll for "nothing!") may eventually break the state machine
> in the EC, resulting in a hard shutdown. This explains why shortening
> IDEAPAD_EC_TIMEOUT works around the issue - it reduces the total number
> of polls sent to the EC.
> 
> Even when it doesn't lead to a shutdown, frequent polls may also disturb
> the ongoing operation and notably delay (+ 10-20ms) the availability of
> EC response. This phenomenon is unlikely to be exclusive to the models
> mentioned above, so dropping the schedule() manner should also slightly
> improve the responsiveness of various models.
> 
> Fix these issues by migrating to usleep_range(150, 300). The interval is
> chosen to add some margin to the minimal 50us and considering EC
> responses are usually available after 150-2500us based on my test. It
> should be enough to fix these issues on all models subject to the EC bug
> without introducing latency on other models.
> 
> Tested on ThinkBook 14 G7+ ASP and solved both issues. No regression was
> introduced in the test on a model without the EC bug (ThinkBook X IMH,
> thanks Eric).
> 
> Link: https://github.com/ty2/ideapad-laptop-tb2024g6plus/commit/6c5db18c9e8109873c2c90a7d2d7f552148f7ad4
> Link: https://github.com/ferstar/ideapad-laptop-tb/commit/42d1e68e5009529d31bd23f978f636f79c023e80
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218771
> Fixes: 6a09f21dd1e2 ("ideapad: add ACPI helpers")
> Cc: stable@vger.kernel.org
> Tested-by: Eric Long <i@hack3r.moe>
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>   drivers/platform/x86/ideapad-laptop.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)

Tested good on my Lenovo ThinkBook 14 G6+ (AHP) with the following:

- Frequent Fn+F5/F6 inputs
- Lid opening/closing to suspend: 20 times each whilst (1) plugged in 
and (2) using battery power
- Plugging in and unplugging USB-C power: 20 times while running

Tested-by: Mingcong Bai <jeffbai@aosc.io>

> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
> index ede483573fe0..b5e4da6a6779 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -15,6 +15,7 @@
>   #include <linux/bug.h>
>   #include <linux/cleanup.h>
>   #include <linux/debugfs.h>
> +#include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/dmi.h>
>   #include <linux/i8042.h>
> @@ -267,6 +268,20 @@ static void ideapad_shared_exit(struct ideapad_private *priv)
>    */
>   #define IDEAPAD_EC_TIMEOUT 200 /* in ms */
>   
> +/*
> + * Some models (e.g., ThinkBook since 2024) have a low tolerance for being
> + * polled too frequently. Doing so may break the state machine in the EC,
> + * resulting in a hard shutdown.
> + *
> + * It is also observed that frequent polls may disturb the ongoing operation
> + * and notably delay the availability of EC response.
> + *
> + * These values are used as the delay before the first poll and the interval
> + * between subsequent polls to solve the above issues.
> + */
> +#define IDEAPAD_EC_POLL_MIN_US 150
> +#define IDEAPAD_EC_POLL_MAX_US 300
> +
>   static int eval_int(acpi_handle handle, const char *name, unsigned long *res)
>   {
>   	unsigned long long result;
> @@ -383,7 +398,7 @@ static int read_ec_data(acpi_handle handle, unsigned long cmd, unsigned long *da
>   	end_jiffies = jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
>   
>   	while (time_before(jiffies, end_jiffies)) {
> -		schedule();
> +		usleep_range(IDEAPAD_EC_POLL_MIN_US, IDEAPAD_EC_POLL_MAX_US);
>   
>   		err = eval_vpcr(handle, 1, &val);
>   		if (err)
> @@ -414,7 +429,7 @@ static int write_ec_cmd(acpi_handle handle, unsigned long cmd, unsigned long dat
>   	end_jiffies = jiffies + msecs_to_jiffies(IDEAPAD_EC_TIMEOUT) + 1;
>   
>   	while (time_before(jiffies, end_jiffies)) {
> -		schedule();
> +		usleep_range(IDEAPAD_EC_POLL_MIN_US, IDEAPAD_EC_POLL_MAX_US);
>   
>   		err = eval_vpcr(handle, 1, &val);
>   		if (err)
> 
> base-commit: a5806cd506af5a7c19bcd596e4708b5c464bfd21


