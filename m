Return-Path: <stable+bounces-249442-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F5wEcbEC2qWMQUAu9opvQ
	(envelope-from <stable+bounces-249442-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 04:02:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E281B5763EB
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 04:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EEE13043FEA
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 02:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445AC305660;
	Tue, 19 May 2026 02:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBzepstn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A42FFF89;
	Tue, 19 May 2026 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779156012; cv=none; b=AUY1/WI3+uMcEPTcWzmYnw3qDY3uuFf/sh72PpsMAIonPvKwcmcOoUj4tWLJPO2xEqwI/FreEWKovdlTLJF7cm9BbK9LWnAhLKEWAju6vNkDqMOFroVfupMx3hKBYQRYcvz0xqqDcNCyKFm1qUlgXLFEeXlby+JCSDEBgFm+05c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779156012; c=relaxed/simple;
	bh=dMBn9Q5YwYpTQV65Unhm1gUR2/2iTLWElfEtxBIY02o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxTVtvTgwXWwxJ/AcU+scnRwTWDc7qkKC8BytUIQtPu+2I5Pl5N9fzBejJfpCJ1bL68plNER1+Q2d1cQAqcDQenXv0I90UWHP1gcOOCLrHTIrbKBTrgashIi9Cl73G5bu8/PZEMJvjZdIn4W2K4TLAdjx0r+tQme48rd4lCKyGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBzepstn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1550C2BCB7;
	Tue, 19 May 2026 02:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779156011;
	bh=dMBn9Q5YwYpTQV65Unhm1gUR2/2iTLWElfEtxBIY02o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBzepstnDm2aqkQ3d6bnQLnHOkbd1O04xlr3pXxMxtyDL1+nXO9bjsUjvA+sNCSS6
	 HY+BwVsLEbu74P6mdPHuxQcV30T8VEneRINMNLzNlBrW6HF3YRGUhuTgghEkFdwhgi
	 rU57pbibkGutFqef3ON68n3YLOXkWAurapuL6vxtEC8y+LVdwHeSHWtqIpZRh8Us4M
	 HPzxgVVcx0bAiLmjkCxi/qFGmYP2TXjDrlwJSEFg+hR+kY0kGOWILGcoGl0eKCQAZH
	 Bk4WutlVgZjqBwNyFYUB9AT7iqSGRJPfvtiVECQ0E8SO/SXwjHVep6c4HtlgOhbFOX
	 C6DPkiBwIQiAQ==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	kohei@enjuk.jp,
	dima.ruinskiy@intel.com,
	faizal.abdul.rahim@linux.intel.com,
	chwee.lin.choong@intel.com,
	kohei.enju@gmail.com,
	vladimir.oltean@nxp.com,
	stable@vger.kernel.org,
	horms@kernel.org,
	avigailx.dahan@intel.com
Subject: Re: [PATCH net 10/10] e1000e: correct TIMINCA on ADP/TGP systems with wrong XTAL frequency
Date: Mon, 18 May 2026 19:00:09 -0700
Message-ID: <20260519020009.3408105-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515182419.1597859-11-anthony.l.nguyen@intel.com>
References: <20260515182419.1597859-11-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249442-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,enjuk.jp,intel.com,linux.intel.com,gmail.com,nxp.com];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E281B5763EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
e1000e: correct TIMINCA on ADP/TGP systems with wrong XTAL frequency

This commit adds a runtime workaround for some Tiger Lake and Alder Lake
platforms where the XTAL clock is misreported as 24 MHz instead of the
actual 38.4 MHz. After e1000e_systim_reset() it samples PHC vs system
time over ~1 ms via cross-timestamps and, if the delta exceeds 100 us,
reprograms TIMINCA for the 38.4 MHz profile and reinitializes the
timecounter.

> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 7ce0cc8ab8f4..db2080541f19 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3902,6 +3902,81 @@ static void e1000_flush_desc_rings(struct e1000_adapter *adapter)
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

[Low]
The kernel-doc says "Adjust XTAL clock" and the body comment below says
"reconfigure the XTAL clock to 38.4 MHz", but nothing here reprograms a
crystal or PLL.  The function only writes TIMINCA and updates
adapter->cc.shift / adapter->tc to compensate in software for the
misreported XTAL frequency.  Could the comments be reworded to describe
what is actually being changed (TIMINCA / cyclecounter shift) so that
future readers do not look for an XTAL register write that does not
exist?

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

[Low]
Is a single ~1 ms sample with a one-directional threshold robust enough
to commit to a permanent (until-next-reset) clock-configuration change?

Scheduling jitter, virtualization steal time on a guest, or an SMI/NMI
that straddles either gettimex64 capture can skew sys_delta or phc_delta
in either direction.  There is no sanity bound on sys_delta (for example,
800 us..1.5 ms) and no median/min over multiple samples.

The commit message phrasing "differs from system time beyond the
expected tolerance" reads as a tolerance check, but the code only catches
the positive direction, so a hardware that runs slow than reference
time would not be flagged.  Would a multi-sample median, a sys_delta
sanity range, or an abs() comparison make detection less fragile?

> +		e_dbg("Corrected PHC frequency: TIMINCA set for 38.4 MHz\n");
> +		/* Program TIMINCA for 38.4 MHz */
> +		spin_lock_irqsave(&adapter->systim_lock, flags);
> +		adapter->cc.shift = INCVALUE_SHIFT_38400KHZ;
> +		timinca = (INCPERIOD_38400KHZ <<
> +			   E1000_TIMINCA_INCPERIOD_SHIFT) |
> +			  (((INCVALUE_38400KHZ <<
> +			     adapter->cc.shift) &
> +			   E1000_TIMINCA_INCVALUE_MASK));
> +		ew32(TIMINCA, timinca);

[High]
Is this correction durable against the next ptp4l/phc2sys adjfine call?

After this branch sets adapter->cc.shift = INCVALUE_SHIFT_38400KHZ and
writes the 38.4 MHz TIMINCA, e1000e_phc_adjfine() in
drivers/net/ethernet/intel/e1000e/ptp.c calls e1000e_get_base_timinca()
on every adjfine, which on these parts hits:

    case e1000_pch_cnp:
    case e1000_pch_tgp:
    case e1000_pch_adp:
    case e1000_pch_nvp:
        if (er32(TSYNCRXCTL) & E1000_TSYNCRXCTL_SYSCFI) {
            /* Stable 24MHz frequency */
            incperiod = INCPERIOD_24MHZ;
            incvalue  = INCVALUE_24MHZ;
            shift     = INCVALUE_SHIFT_24MHZ;
            adapter->cc.shift = shift;
        } else {
            ...
        }

On the affected systems the SYSCFI bit is the very thing that is
mis-reported, so e1000e_get_base_timinca() takes the 24 MHz branch
again, overwrites adapter->cc.shift back to INCVALUE_SHIFT_24MHZ, and
e1000e_phc_adjfine() programs a 24 MHz-based TIMINCA back into the
register.  ptp4l/phc2sys issue adjfine continuously, so the correction
appears to last only until the first adjfine after each systim_reset.

Could the detection set a per-adapter "force 38.4 MHz" flag on first
trip, and have e1000e_get_base_timinca() honor that flag so the 38.4 MHz
selection becomes durable across adjfine and any future reset?

[Medium]
Does this path drop the user-space-applied frequency adjustment from
hardware?

e1000e_systim_reset() first calls info->adjfine(info,
adapter->ptp_delta), which goes through e1000e_phc_adjfine() and
programs TIMINCA with the per-ppm-scaled INCVALUE via
adjust_by_scaled_ppm():

    incvalue = timinca & E1000_TIMINCA_INCVALUE_MASK;
    incvalue = adjust_by_scaled_ppm(incvalue, delta);
    timinca &= ~E1000_TIMINCA_INCVALUE_MASK;
    timinca |= incvalue;
    ew32(TIMINCA, timinca);

Immediately after, this hunk unconditionally writes a clean 38.4 MHz
baseline:

    timinca = (INCPERIOD_38400KHZ << E1000_TIMINCA_INCPERIOD_SHIFT) |
              (((INCVALUE_38400KHZ << adapter->cc.shift) &
                E1000_TIMINCA_INCVALUE_MASK));
    ew32(TIMINCA, timinca);

adapter->ptp_delta is left in software but is no longer reflected in
hardware, so any frequency calibration the PTP daemon had previously
servoed onto is discarded until it re-converges.  Should the workaround
re-apply the saved delta (for example via info->adjfine(info,
adapter->ptp_delta), or by feeding the new incvalue through
adjust_by_scaled_ppm()) before re-initializing the timecounter?

> +
> +		/* reset the systim ns time counter */
> +		timecounter_init(&adapter->tc, &adapter->cc,
> +				 ktime_get_real_ns());
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
> +
>  /**
>   * e1000e_systim_reset - reset the timesync registers after a hardware reset
>   * @adapter: board private structure
> @@ -3953,6 +4028,9 @@ static void e1000e_systim_reset(struct e1000_adapter *adapter)
>  		if (extack._msg)
>  			e_err("%s\n", extack._msg);
>  	}
> +
> +	if (hw->mac.type == e1000_pch_adp || hw->mac.type == e1000_pch_tgp)
> +		e1000e_xtal_tgp_workaround(adapter);
>  }

Because this hook runs on every systim_reset (ifup, suspend/resume,
error recovery), and e1000e_get_base_timinca() picks 24 MHz first,
there is also a window between the 24 MHz programming above and the
1 ms sleep + rewrite inside e1000e_xtal_tgp_workaround() during which
TIMINCA is wrong.  Hardware timestamps captured during that window
would use the 24 MHz cyclecounter conversion.  Is that intentional?

