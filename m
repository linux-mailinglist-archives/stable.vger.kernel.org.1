Return-Path: <stable+bounces-253813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP7ZKjd5EGrdXwYAu9opvQ
	(envelope-from <stable+bounces-253813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 17:41:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1D75B70EF
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 17:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA4C9301D333
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43D9400E1B;
	Fri, 22 May 2026 15:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU5A9joZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DEC25B092
	for <stable@vger.kernel.org>; Fri, 22 May 2026 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464223; cv=none; b=JS0vG1+OavaFPfbLu5O+0dwWidSftU5T1VeRC94LINpEF/bT0t5+eTGC46gJnE5Bls/w+4isQ0xSJXUGmUAMgxTlrxXoajtobjPw6qxL8akdHeYttjyX0Umqa52BXVUy7sRCiESlXphidZOzvB66xSU9dszsxJlDGbdx3mjbiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464223; c=relaxed/simple;
	bh=blIuKFRRZ/S9hllh14+ij0KgbBT9ffoG3ne56sPhK4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ba2qCqRIZHxagfsdUXLk+Jp46XZG7KeNih40OxJJw3zoX4xfGwkhovFdNaVbpc94ZNqkR46FVVoItHpZjMqCcwkcoOBH+cGO5STX3n6dWMFgKzv/YTnph+Vx+x5yRAYS5w8rVUnG3Hi/lnpvSlEUdGrIZyG5/iWgY1BEs5bOHwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU5A9joZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4AE1F00A3F
	for <stable@vger.kernel.org>; Fri, 22 May 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464221;
	bh=fSEYojMIkK+mhSE0dEiQW354SP1JJUcLILA8KCWkd/g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EU5A9joZJsFi8kKGr8QpLspqgCgCb2r/7H5Gf/ZzVEw/W3/MUWy0QZBqh89CGogSR
	 J80MrJBvgayzOgeSg4ojSXNXyZvHLcomL4XoWel1QHbDfbBxTXoD+qdJwDsXKKVDBO
	 qKH+3Po1EdXOajcGFMvzFJanN6sHA9cop8MSNXiRD+zIBchaakobIb+9NpVtqR7Zxi
	 uhBCK/e3kukaQT+x7PvitzEojLauqs99v07fBeYQwiEj/Hs3Gtp1yOgAxUm6ZixWJY
	 cYf3bXKRHz9lyhChPDQtpo1V7GVhcDRg6B6gYgHsStWCosnpvOQQOrYiD+vQZJeoSL
	 dZORhCpfuOV3g==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso2119668e87.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 08:37:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9ivkAdQkn0fmscp8slItjmnE2LGtPAFaRxRBlR3ZtL5AvtJ5kfoCdLvB01AmYuMWi2KAX3WOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCdOla8AWFmY+U2HgSEGJ1eP4gSkULBK1i/LyFZQHbJ24EedRn
	AEsTEs4RdZErlnicwjl1DQrBlMk7169alUuPqseRTM62jb7qsWFlrEl4mdXjHAoybN7YJPJLsox
	ANOaoeeCoAtIj8atoF4A2nxt59oV3NW8=
X-Received: by 2002:a05:6512:6cf:b0:5a4:52d:4abc with SMTP id
 2adb3069b0e04-5aa32369e9dmr1294375e87.8.1779464219911; Fri, 22 May 2026
 08:36:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520032119.30615-1-fushuai.wang@linux.dev>
In-Reply-To: <20260520032119.30615-1-fushuai.wang@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 May 2026 17:36:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gsSF6Pm6Okpn_PhoQBhuUgixdQ7x5P3LNyMZOaNw91PA@mail.gmail.com>
X-Gm-Features: AVHnY4J90RT3PhOA0pL979XaxWsKq14VNBxXEt8ZkS8nTZHz126tBIYUsWEZnGs
Message-ID: <CAJZ5v0gsSF6Pm6Okpn_PhoQBhuUgixdQ7x5P3LNyMZOaNw91PA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Sync policy->cur when setting
 min pstate during CPU offline
To: Fushuai Wang <fushuai.wang@linux.dev>
Cc: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rafael@kernel.org, 
	viresh.kumar@linaro.org, currojerez@riseup.net, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wangfushuai@baidu.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253813-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 5D1D75B70EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 5:22=E2=80=AFAM Fushuai Wang <fushuai.wang@linux.de=
v> wrote:
>
> From: Fushuai Wang <wangfushuai@baidu.com>
>
> When a CPU goes offline with HWP disabled, intel_pstate_set_min_pstate()
> sets the MSR_IA32_PERF_CTL to minimum frequency to prevent SMT siblings
> from being restricted. However, the policy->cur value was not updated,
> leaving it at the previous value.
>
> When the CPU comes back online, governor->limits() checks if target_freq
> equals policy->cur and skips the frequency adjustment if they match. Sinc=
e
> policy->cur still holds the previous value, the governor does not call
> cpufreq_driver->target to update MSR_IA32_PERF_CTL.
>
> Fix this by synchronizing policy->cur with the hardware state when settin=
g
> minimum pstate during CPU offline.
>
> Fixes: bb18008f8086 ("intel_pstate: Set core to min P state during core o=
ffline")
> Cc: stable@vger.kernel.org # 3.15+
> Suggested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 1292da53e5fc..11db1c887c80 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2984,10 +2984,12 @@ static int intel_cpufreq_cpu_offline(struct cpufr=
eq_policy *policy)
>          * from getting to lower performance levels, so force the minimum
>          * performance on CPU offline to prevent that from happening.
>          */
> -       if (hwp_active)
> +       if (hwp_active) {
>                 intel_pstate_hwp_offline(cpu);
> -       else
> +       } else {
>                 intel_pstate_set_min_pstate(cpu);
> +               policy->cur =3D cpu->pstate.min_freq;
> +       }
>
>         intel_pstate_exit_perf_limits(policy);
>
> --

Applied as 7.1-rc material, thanks!

