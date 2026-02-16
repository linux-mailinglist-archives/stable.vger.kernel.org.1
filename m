Return-Path: <stable+bounces-216685-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDPGDb7vkmkQ0QEAu9opvQ
	(envelope-from <stable+bounces-216685-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:21:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5731424CA
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75E4730138B1
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 10:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44142FFDD5;
	Mon, 16 Feb 2026 10:21:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA82FF669
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771237299; cv=none; b=GDQyu1tI2DEF43jqnlOow/kxNzpIF4s9qEgEYS54xZESWjWtzxOsqu6GzneMkbR8Mn/2esiXQuPb9o7HoOqro8Su+yg6DMYHPNEA87iUy8SzX3f8Qr8fd51JLwdjrgg8AaO8KUxKwsM7LcWhdvuXfOvfIvmwXSHLDcYm4ZCekb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771237299; c=relaxed/simple;
	bh=hPe8h0DtfhJgwDhL/MTo/0nn7WzS24db3TtnQR4WYgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gyix51MovK890FuWJ5T3auJG2gW3my2lyLKFWD96HCkJxNPYtj0rwKtxJ472ylh7oXasFfY79NRolyF9JWP5OIrFx8vAZQ0jnG9l/kN4hrTioZe8KO7mbE/6bsbLr/CfpnLIcu5hb0iPgd47xh4JzJRHrSCuB9WnbMUdRNxaw5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56706fd623fso1544233e0c.3
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 02:21:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771237297; x=1771842097;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9k16NacyBqRsPOeIOlYkH0Gj7wgknc1ckVejj7V1hU=;
        b=ZXzvtwc0E5FcOzFJI95lVTF1m9o9bH8UYIamo88KZZ/BfZQbCav8pLytDVzFIr1dGb
         Ag3UQxYfapAcUAz7B0R26j087Wa2iHh3lIrOP90AYi10hJmTMTVG/W3JSqoQFBAikBvO
         PdB1356PTMcnW4gGU7OAuVG4vf4ng7J990htfTHD7yOYWl59CldJNvvcBHm7hJpiU5NA
         UnjvFg41yXguA3vcqZ5hcaAdzaZ683VQNKYZaYH6wVdhPj/XJ5CYmDPsxsVZeAypj3SZ
         qpk2jic0Gg5wg8Roqe5N0BWlLogJrMjfuVoazZpJIOJ3NX5QJ/p8aOKilnewt6HvfqU7
         LzIA==
X-Forwarded-Encrypted: i=1; AJvYcCV8mWlBEKRozr4P/jZuKRwC2QxDONMPEurkAZTT/1v7k0TkcsWgOHKCdx83Qt7XNJQ4wHP6gC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWnT5fXTUf5nONXfLiGQHs+MnrcZPnNsPZgTFatCHC3jXodqH
	jn/ZZMeIYrI2UtNAhGriOgE6VJMYSEW0hpcrd4gP3LUps0cOO9/UV3sjaj38kydA
X-Gm-Gg: AZuq6aKOcpCzPtN3inv4dRzmKLGPgm0Xfqw0EgCB1w8vnKpP5Vr2Ix8cziDlyMMut+i
	DkKhjv23k/wEQDruz4A8ppcRghu10XEGUt40Y+7DPV6ZvkYXEGSE0tIzDJQS+MR9/YMcRFF3pyl
	rtg/+cTcrnB3mMgK2Rul0aFERqlfHdfPNw8pCSbIu/lOtmuvm3MI+zHbjc/cKNK+D+0jQ+CTSRI
	uxDOS3eY9h36AHIIKNukyFQAwDghUOaEAow2cPTR+OiIyxjyBVMCQUcCzIXGy9aBcbEfyPfoBXM
	97zbb0c3mVR5Bm3CgcJZ8METaw6IhrZAbZhObpHno29By6aX+pPb8DvG+RNbVubWXRoU3wc/DP0
	LHhY4LB94Pjpn59WG6E4VPmi+rpkuMlcBEGW+6X/BJ8aYfnisN9kXUnSSO1yavPR+VTKfuWAqk5
	yUoz8jxaOdz7h8X1q6N5FVln8Zii2pjvXr0LbA2iuXCmrgBVE+Zqk8SebTB8hm
X-Received: by 2002:a05:6122:430d:b0:55b:10d7:51a5 with SMTP id 71dfb90a1353d-56889bf96c3mr1477583e0c.10.1771237297142;
        Mon, 16 Feb 2026 02:21:37 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5674bc76b6asm7824657e0c.0.2026.02.16.02.21.36
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 02:21:36 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5fc4220b0acso569653137.1
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 02:21:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBN9tesgUbJ14PknvTBT0eAUtBUvCecjjNQCUMX2ZGowykhRsGtIUPcBFT1HkiWqnPiAD900g=@vger.kernel.org
X-Received: by 2002:a05:6102:4192:b0:5f5:35bd:6fb3 with SMTP id
 ada2fe7eead31-5fe2aceef00mr2011773137.5.1771237296107; Mon, 16 Feb 2026
 02:21:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214005825.3665084-1-sashal@kernel.org>
In-Reply-To: <20260214005825.3665084-1-sashal@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2026 11:21:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVeGv=f-Oo1=GQLghn_hwpe2YN5OS79fQsy2uccwyVUZg@mail.gmail.com>
X-Gm-Features: AaiRm50N-jUB71MK4eHWfadpGLVlD7JkxipNiaF9cDCx3KnVx3LWPVTtpfkjLnY
Message-ID: <CAMuHMdVeGv=f-Oo1=GQLghn_hwpe2YN5OS79fQsy2uccwyVUZg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.19-5.10] parisc: Prevent interrupts during reboot
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, guoren@kernel.org, neil.armstrong@linaro.org, 
	brauner@kernel.org, yelangyan@huaqin.corp-partner.google.com, 
	schuster.simon@siemens-energy.com, linux-csky@vger.kernel.org, 
	Parisc List <linux-parisc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmx.de,kernel.org,linaro.org,huaqin.corp-partner.google.com,siemens-energy.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216685-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: AC5731424CA
X-Rspamd-Action: no action

Hi Sasha

Cc linux-parisc

How did you (or the LLM?) came up with that CC list?!?

On Sat, 14 Feb 2026 at 01:58, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> [ Upstream commit 35ac5a728c878594f2ea6c43b57652a16be3c968 ]
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> LLM Generated explanations, may be completely bogus:
>
> Now I have all the information I need for a thorough analysis. Here is
> my complete assessment:
>
> ---
>
> ## Detailed Analysis: "parisc: Prevent interrupts during reboot"
>
> ### 1. COMMIT MESSAGE ANALYSIS
>
> The commit message is minimal: "parisc: Prevent interrupts during
> reboot". It clearly states the problem it's fixing -- interrupts are not
> properly disabled during the reboot path on PA-RISC systems. The author
> is **Helge Deller**, the long-time parisc maintainer and the most
> authoritative developer for this architecture. The commit has no
> `Fixes:` tag or `Cc: stable` (as expected for autosel candidates).
>
> ### 2. CODE CHANGE ANALYSIS
>
> The change is **one single effective line of code** plus a comment:
>
> ```c
> /* prevent interrupts during reboot */
> set_eiem(0);
> ```
>
> This is inserted into `machine_restart()` in
> `arch/parisc/kernel/process.c` immediately after
> `pdc_chassis_send_status(PDC_CHASSIS_DIRECT_SHUTDOWN)` and before
> `pdc_do_reset()`.
>
> **What `set_eiem(0)` does:** On PA-RISC, the EIEM (External Interrupt
> Enable Mask, Control Register 15) controls which external interrupts can
> fire. Setting it to 0 **masks all external interrupts at the hardware
> level**, preventing any interrupt from being delivered to the CPU. This
> is defined as:
>
> ```82:82:arch/parisc/include/asm/special_insns.h
> #define set_eiem(val)   mtctl(val, CR_EIEM)
> ```
>
> **The bug:** Without this line, external interrupts remain enabled
> during the entire reboot sequence. This means:
>
> a) **Deadlock risk in `pdc_do_reset()`**: The `pdc_do_reset()` function
> acquires `pdc_lock` via `spin_lock_irqsave()`:
>
> ```1236:1246:arch/parisc/kernel/firmware.c
> int pdc_do_reset(void)
> {
>         int retval;
>         unsigned long flags;
>
>         spin_lock_irqsave(&pdc_lock, flags);
>         retval = mem_pdc_call(PDC_BROADCAST_RESET, PDC_DO_RESET);
>         spin_unlock_irqrestore(&pdc_lock, flags);
>
>         return retval;
> }
> ```
>
> While `spin_lock_irqsave` disables local interrupts, the PA-RISC EIEM
> hardware mask is a separate mechanism. On PA-RISC, the external
> interrupt delivery path goes through the EIEM -- an interrupt fires only
> if the corresponding EIEM bit is set AND the EIRR (External Interrupt
> Request Register) bit is set. If a hardware interrupt fires between
> `pdc_chassis_send_status()` (which also uses `pdc_lock`) and
> `pdc_do_reset()`, or during the firmware calls themselves, it could
> interfere with the reset process.
>
> b) **Interference with firmware reset**: `pdc_do_reset()` calls into PDC
> firmware (`mem_pdc_call(PDC_BROADCAST_RESET, PDC_DO_RESET)`). Firmware
> calls on PA-RISC are sensitive to the processor state. An interrupt
> arriving during or between firmware calls can corrupt the reset
> sequence, potentially causing the machine to **hang instead of
> rebooting**.
>
> c) **The `gsc_writel(CMD_RESET, COMMAND_GLOBAL)` fallback**: If
> `pdc_do_reset()` returns (on machines that don't implement
> `PDC_BROADCAST_RESET`), the code tries a hardware reset via
> `gsc_writel`. Interrupts during this path are equally problematic.
>
> ### 3. ESTABLISHED PATTERN IN PARISC AND OTHER ARCHITECTURES
>
> **PA-RISC internal precedent:**
> - `parisc_terminate()` in `traps.c` uses the exact same pattern:
>   `set_eiem(0)` followed by `local_irq_disable()` before critical
>   shutdown operations (line 428-429)
> - The SMP CPU hotplug code (`smp.c:481`) uses `set_eiem(0)` to disable
>   all external interrupts when taking a CPU offline
>
> **Other architectures ALL disable interrupts before reset:**
> - ARM: `local_irq_disable()` at line 136 of `arch/arm/kernel/reboot.c`
> - ARM64: `local_irq_disable()` at line 141 of
>   `arch/arm64/kernel/process.c`
> - x86: `local_irq_disable()` at line 100 of `arch/x86/kernel/reboot.c`
> - xtensa: `local_irq_disable()` at line 524 of
>   `arch/xtensa/kernel/setup.c`
> - nios2: `local_irq_disable()` at line 49 of
>   `arch/nios2/kernel/process.c`
> - csky: `local_irq_disable()` at line 25 of `arch/csky/kernel/power.c`
> - MIPS falcon: `local_irq_disable()` at line 37 of
>   `arch/mips/lantiq/falcon/reset.c`
>
> PA-RISC was the **outlier** in not disabling interrupts before reboot.
> This commit fixes that deficiency.
>
> ### 4. CLASSIFICATION
>
> This is a **bug fix** -- specifically fixing a potential hang/crash
> during reboot caused by unmasked interrupts during firmware calls. It is
> NOT a new feature, optimization, or cleanup.
>
> ### 5. SCOPE AND RISK ASSESSMENT
>
> - **Lines changed**: 3 (1 blank line, 1 comment, 1 functional line)
> - **Files touched**: 1 (`arch/parisc/kernel/process.c`)
> - **Subsystem**: parisc architecture, reboot path
> - **Risk**: **Extremely low**. Disabling interrupts before a system
>   reset is universally accepted as correct and necessary. The
>   `set_eiem(0)` pattern is already used in the same codebase for similar
>   critical paths.
>
> ### 6. USER IMPACT
>
> - **Who is affected**: All PA-RISC Linux users who reboot their machines
> - **What happens without the fix**: Potential hang during reboot,
>   requiring a hard power cycle. This could be intermittent and timing-
>   dependent, making it hard to reproduce but very real.
> - **Severity if triggered**: System hang requiring manual intervention
>   (power cycle)
>
> ### 7. STABILITY INDICATORS
>
> - Author is the subsystem maintainer (highest trust level)
> - Pattern is well-established across all other architectures
> - The exact same `set_eiem(0)` call is used in the parisc
>   `parisc_terminate()` function already
> - The change is trivially small and obviously correct
>
> ### 8. DEPENDENCY CHECK
>
> - No dependencies on other commits
> - The `set_eiem()` macro has existed since the earliest parisc code
> - The `machine_restart()` function is largely unchanged across all
>   stable trees
> - This will apply cleanly to any kernel version that has parisc support
>
> ### Summary
>
> This is a trivially small, obviously correct fix that prevents
> interrupts during the reboot sequence on PA-RISC systems. Without it, an
> untimely interrupt can interfere with PDC firmware calls during reset,
> potentially causing the machine to hang instead of rebooting. Every
> other Linux architecture disables interrupts before reboot; parisc was
> the outlier. The fix uses the same `set_eiem(0)` pattern already used in
> `parisc_terminate()` and SMP CPU offline code. The risk is essentially
> zero -- there is no conceivable way that disabling interrupts right
> before a hardware reset could cause a regression.
>
> **YES**
>
>  arch/parisc/kernel/process.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
> index e64ab5d2a40d6..703644e5bfc4a 100644
> --- a/arch/parisc/kernel/process.c
> +++ b/arch/parisc/kernel/process.c
> @@ -85,6 +85,9 @@ void machine_restart(char *cmd)
>  #endif
>         /* set up a new led state on systems shipped with a LED State panel */
>         pdc_chassis_send_status(PDC_CHASSIS_DIRECT_SHUTDOWN);
> +
> +       /* prevent interrupts during reboot */
> +       set_eiem(0);
>
>         /* "Normal" system reset */
>         pdc_do_reset();
> --
> 2.51.0
>

