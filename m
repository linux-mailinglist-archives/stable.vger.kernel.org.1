Return-Path: <stable+bounces-223446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCtENb0/rWmN0AEAu9opvQ
	(envelope-from <stable+bounces-223446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 10:22:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A4D22F26C
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 10:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7D52330095DB
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BF535F171;
	Sun,  8 Mar 2026 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp6jcEUr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA13727F732;
	Sun,  8 Mar 2026 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772961717; cv=none; b=n6XdWajRpP/8/z4LCPcIL0HBaAdjKNGCwz7u5OwUNKRaL04dhvQKGGtEhAinnAOIxq0ZMiZNHMXlIwx7AIVkWw+UU1Q+eNYXfbIJkOoYqqfQRxyJ8GeJj6uiwjbJxd4beYhUt3uM8IF3pTtiCvvlCvsYv9ZrS0imLqn5Lg2oJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772961717; c=relaxed/simple;
	bh=MJJg1U6ugjDsNAglWwPOIRpYHhnfFmyzI4DPevXkZT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/ksy9nLaV6KKkuIW/If1f8KbAEguS2cuQl94c0we4uTMkl1GBn47Zjq/Dblix4calIn3AE/RAeSeZp7gk4xIJPUaq9uok52IQnVl+dmymYetlcGNr0Cmgkoo6ZkbB7AtYevkXrpuBnrm5isoV/i1i8ZWlPz8FMZZW3cNVEMpu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp6jcEUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961ADC116C6;
	Sun,  8 Mar 2026 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772961717;
	bh=MJJg1U6ugjDsNAglWwPOIRpYHhnfFmyzI4DPevXkZT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mp6jcEUrK5rqtvVUGKENgP6f2t9MOM1AFMdmd1ZpxxwanKePxNKZjbyi/w5edhrNp
	 UC09/Bv+YsYmssAyvjWXXgzF5sqwgR+4M6pNzCEZcsNmew0FTzbuK3UEYhx2EpEAWT
	 2TbAO2DNUq40E5x99UDBrggBq5NccT1Y5YjaVjHb0MjgXwaJDyQvuPUD2j6kUzsJLc
	 V+gQdTdJ23gHFuxDueJpo5g+LbNVlX2pt3Jtx3koNkhiGWXMvfxeYz2MJ7kZyuO6z4
	 Dy89D3OBT4ND2QbckEnDXM3LdvyrveE76CcXE4dGwGFt+iPvlqkWv90Plg3hsG4oFf
	 pp6z84vYpJQ5A==
From: Thomas Gleixner <tglx@kernel.org>
To: Shashank Balaji <shashank.mahadasyam@sony.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, Jan Kiszka
 <jan.kiszka@siemens.com>, Sohil Mehta <sohil.mehta@intel.com>, Andrew
 Cooper <andrew.cooper3@citrix.com>, Shashank Balaji
 <shashank.mahadasyam@sony.com>, Rahul Bukte <rahul.bukte@sony.com>, Daniel
 Palmer <daniel.palmer@sony.com>, Tim Bird <tim.bird@sony.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/x2apic: Disable x2apic on resume if the
 kernel expects so
In-Reply-To: <20260306-x2apic-fix-v2-1-bee99c12efa3@sony.com>
References: <20260306-x2apic-fix-v2-0-bee99c12efa3@sony.com>
 <20260306-x2apic-fix-v2-1-bee99c12efa3@sony.com>
Date: Sun, 08 Mar 2026 10:21:53 +0100
Message-ID: <87a4wi3ccu.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: C7A4D22F26C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223446-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.307];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sony.com:email,uefi.org:url]
X-Rspamd-Action: no action

On Fri, Mar 06 2026 at 14:46, Shashank Balaji wrote:

> When resuming from s2ram, firmware may re-enable x2apic mode, which may have
> been disabled by the kernel during boot either because it doesn't support
> irq remapping or for other reasons. This causes the kernel to continue using
> the xapic interface, while the hardware is in x2apic mode, which causes hangs.
> This happens on defconfig + bare metal + s2ram.
>
> Fix this in lapic_resume() by disabling x2apic if the kernel expects it to be
> disabled, i.e. when x2apic_mode = 0.
>
> The ACPI v6.6 spec, Section 16.3 [1] says firmware restores either the pre-sleep
> configuration or initial boot configuration for each CPU, including MSR state:
>
> 	When executing from the power-on reset vector as a result of waking
> 	from an S2 or S3 sleep state, the platform firmware performs only the
> 	hardware initialization required to restore the system to either the
> 	state the platform was in prior to the initial operating system boot,
> 	or to the pre-sleep configuration state. In multiprocessor systems,
> 	non-boot processors should be placed in the same state as prior to the
> 	initial operating system boot.
>
> 	(further ahead)
>
> 	 If this is an S2 or S3 wake, then the platform runtime firmware
> 	 restores minimum context of the system before jumping to the waking
> 	 vector. This includes:
>
> 	 	CPU configuration. Platform runtime firmware restores the
> 		pre-sleep configuration or initial boot configuration of each
> 		CPU (MSR, MTRR, firmware update, SMBase, and so on). Interrupts
> 		must be disabled (for IA-32 processors, disabled by CLI
> 		instruction).
>
> 		(and other things)
>
> So at least as per the spec, re-enablement of x2apic by the firmware is allowed
> if "x2apic on" is a part of the initial boot configuration.
>
> [1] https://uefi.org/specs/ACPI/6.6/16_Waking_and_Sleeping.html#initialization
>
> Fixes: 6e1cb38a2aef ("x64, x2apic/intr-remap: add x2apic support, including enabling interrupt-remapping")
> Cc: stable@vger.kernel.org
> Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

