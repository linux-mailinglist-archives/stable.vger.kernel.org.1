Return-Path: <stable+bounces-217672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFG7NxAvm2lluwMAu9opvQ
	(envelope-from <stable+bounces-217672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 17:30:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F016FA1D
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 17:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78E7E300CC3F
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EB2354AF8;
	Sun, 22 Feb 2026 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D64R3jrn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B53357716;
	Sun, 22 Feb 2026 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771777803; cv=none; b=sD0famZsPgDm5Q5oeV0b0ZF4UDxvO2NsKC32bV8TNtKSbeqdwzNkQ2jeMMgwanismC+Q24spw/ov4InQCYEb1foYF7erBnfmwuagIB6cQwSraKtrygKBR6LyOAOsEcJ3NK7H3YVpUms6mL4ua+GbqxazTX91wjbMoVS4BSza0xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771777803; c=relaxed/simple;
	bh=r8blr4lUK/hyGtCcj6d0ju2YO+6PPYpgeQ+iODPCV2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8TpIYyoUzlOgMkI2wNo9qgfuqdqPq040XJ/lKWgmLJ5TVLm5ws+xhqXFaCDBOlcxG0mGdR2m8oipRciZziZAraXoIhTpFtxm1+oHx/vp39/Ruhluuq+paBPYG6vAV95TLnd+cMayWX1bx+C/4ZUS7IRkUPr3pF3GaQVLZ7iuTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D64R3jrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108C9C116D0;
	Sun, 22 Feb 2026 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771777802;
	bh=r8blr4lUK/hyGtCcj6d0ju2YO+6PPYpgeQ+iODPCV2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D64R3jrn2VIvuTjEvCQJYfO0SMH8ZC/bkcq3qDt1pNiXD33gHEhHIZtCRpMUsPicw
	 d2yk83fh2WRM/g0u6LvlOc8ACkTGd6vjrp9D/BeivT87IAV5syryMaBD726L3IzM08
	 stESZxL+ruOqFuGlbKC7U4L52EqUDvOYJTJiStcHg0RqKKis25WEI1PEwntVG7eX/U
	 Gogbgcuc5WDFTIhTOaLlQ5VhfIwkJjWsQgwvcZefkcn1JAe3GEu3SAtib9DWUuWMhn
	 rdr+KpLnk+2rXGxeXifjS1VJ57tW9Vp7R8K2rGkdzcst8od9oRzUC07Ic8rNzJXtSu
	 ztuIiDzwmKITw==
From: Simon Horman <horms@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Simon Horman <horms@kernel.org>,
	joshua.a.hay@intel.com,
	aaron.ma@canonical.com,
	przemyslaw.kitszel@intel.com,
	Samuel.salin@intel.com,
	jacob.e.keller@intel.com,
	pmenzel@molgen.mpg.de,
	sridhar.samudrala@intel.com,
	brett.creeley@amd.com,
	decot@google.com,
	david.m.ertman@intel.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	sreedevi.joshi@intel.com,
	rafal.romanowski@intel.com,
	en-wei.wu@canonical.com,
	dima.ruinskiy@intel.com,
	michal.kubiak@intel.com,
	tglx@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	avigailx.dahan@intel.com,
	davem@davemloft.net,
	aleksandr.loktionov@intel.com,
	edumazet@google.com,
	piotr.kwapulinski@intel.com,
	sx.rinitha@intel.com,
	emil.s.tantilov@intel.com,
	brianvv@google.com,
	vitaly.lifshits@intel.com,
	jedrzej.jagielski@intel.com,
	stable@vger.kernel.org,
	kuba@kernel.org,
	richardcochran@gmail.com,
	joe@dama.to,
	mschmidt@redhat.com,
	boolli@google.com
Subject: Re: [net,13/13] e1000e: correct TIMINCA on ADP/TGP systems with wrong XTAL frequency
Date: Sun, 22 Feb 2026 16:28:35 +0000
Message-ID: <20260222162835.23954-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260220004027.729384-14-anthony.l.nguyen@intel.com>
References: <20260220004027.729384-14-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,intel.com,canonical.com,molgen.mpg.de,amd.com,google.com,lunn.ch,vger.kernel.org,lists.osuosl.org,redhat.com,davemloft.net,gmail.com,dama.to];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[39];
	TAGGED_FROM(0.00)[bounces-217672-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A7F016FA1D
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
e1000e: correct TIMINCA on ADP/TGP systems with wrong XTAL frequency

On some Tiger Lake (TGP) and Alder Lake (ADP) platforms, the hardware
XTAL clock is incorrectly interpreted as 24 MHz instead of the actual
38.4 MHz. The commit measures PHC vs system time over 1 ms and if the
delta exceeds 100 microseconds, reprograms TIMINCA for the 38.4 MHz
profile and reinitializes the timecounter.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 814698807f3d..ae35ac479026 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c

[ ... ]

> @@ -3905,6 +3905,80 @@ static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
>  		e1000_flush_rx_ring(adapter);
>  }
>
> +/**
> + * e1000e_xtal_tgp_workaround - Adjust XTAL clock based on PHC and system
> + * clock delta.
> + * @adapter: Pointer to the private adapter structure
> + *
> + * Measures the time difference between the PHC (Precision Hardware Clock)
> + * and the system clock over a 1 millisecond interval. If the delta
> + * exceeds 100 microseconds, reconfigure the XTAL clock to 38.4 MHz.
> + */
> +static void e1000e_xtal_tgp_workaround(struct e1000_adapter *adapter)
> +{
> +	s64 phc_delta, sys_delta, sys_start_ns, sys_end_ns, delta_ns;
> +	struct ptp_system_timestamp sys_start = {}, sys_end = {};
> +	struct ptp_clock_info *info = &adapter->ptp_clock_info;
> +	struct timespec64 phc_start, phc_end;
> +	struct e1000_hw *hw = &adapter->hw;
> +	struct netlink_ext_ack extack = {};
> +	unsigned long flags;
> +	u32 timinca;
> +	s32 ret_val;
> +
> +	/* Capture start */
> +	if (info->gettimex64(info, &phc_start, &sys_start)) {
> +		e_dbg("PHC gettimex(start) failed\n");
> +		return;
> +	}
> +
> +	/* Small interval to measure increment */
> +	usleep_range(1000, 1100);
> +
> +	/* Capture end */
> +	if (info->gettimex64(info, &phc_end, &sys_end)) {
> +		e_dbg("PHC gettimex(end) failed\n");
> +		return;
> +	}
> +
> +	/* Compute deltas */
> +	phc_delta = timespec64_to_ns(&phc_end) -
> +		    timespec64_to_ns(&phc_start);
> +
> +	sys_start_ns = (timespec64_to_ns(&sys_start.pre_ts) +
> +			timespec64_to_ns(&sys_start.post_ts)) >> 1;
> +
> +	sys_end_ns = (timespec64_to_ns(&sys_end.pre_ts) +
> +		      timespec64_to_ns(&sys_end.post_ts)) >> 1;
> +
> +	sys_delta = sys_end_ns - sys_start_ns;
> +
> +	delta_ns = phc_delta - sys_delta;
> +	if (delta_ns > 100000) {
> +		e_dbg("Corrected PHC frequency: TIMINCA set for 38.4 MHz\n");
> +		/* Program TIMINCA for 38.4 MHz */
> +		timinca = (INCPERIOD_38400KHZ <<
> +			   E1000_TIMINCA_INCPERIOD_SHIFT) |
> +			  (((INCVALUE_38400KHZ <<
> +			     adapter->cc.shift) &
> +			   E1000_TIMINCA_INCVALUE_MASK));

Is adapter->cc.shift correct here? When e1000e_xtal_tgp_workaround runs,
the earlier call to e1000e_get_base_timinca (via e1000e_phc_adjfine in
e1000e_systim_reset) has already set adapter->cc.shift based on the
incorrectly reported 24 MHz XTAL frequency.

On affected hardware where SYSCFI reports 24 MHz:

e1000e_systim_reset()
 -> e1000e_phc_adjfine(0)
    -> e1000e_get_base_timinca() sets:
       adapter->cc.shift = INCVALUE_SHIFT_24MHZ (14)
 -> e1000e_xtal_tgp_workaround()

So when computing TIMINCA for 38.4 MHz, the code uses shift=14:

  INCVALUE_38400KHZ << 14 = 26 << 14 = 425984

But the 38.4 MHz profile needs shift=19:

  INCVALUE_38400KHZ << 19 = 26 << 19 = 13631488

This produces timinca = 17203200 instead of the correct 30408704.

Additionally, the subsequent timecounter_init call uses adapter->cc which
still has shift=14. This computes tc->mask = (1ULL << 14) - 1 = 16383
instead of the correct (1ULL << 19) - 1 = 524287.

Should the function update adapter->cc.shift = INCVALUE_SHIFT_38400KHZ
before computing timinca and calling timecounter_init, matching the
pattern in e1000e_get_base_timinca for the 38.4 MHz profile?

> +		ew32(TIMINCA, timinca);
> +
> +		/* reset the systim ns time counter */
> +		spin_lock_irqsave(&adapter->systim_lock, flags);
> +		timecounter_init(&adapter->tc, &adapter->cc,
> +				 ktime_to_ns(ktime_get_real()));
> +		spin_unlock_irqrestore(&adapter->systim_lock, flags);
> +
> +		/* restore the previous hwtstamp configuration settings */
> +		ret_val = e1000e_config_hwtstamp(adapter,
> +						 &adapter->hwtstamp_config,
> +						 &extack);
> +		if (ret_val && extack._msg)
> +			e_err("%s\n", extack._msg);
> +	}
> +}

[ ... ]

