Return-Path: <stable+bounces-239034-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEsiNRQ25mkmtgEAu9opvQ
	(envelope-from <stable+bounces-239034-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:20:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B363742CE78
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D526E328542B
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDFF40FD9A;
	Mon, 20 Apr 2026 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8iA4fz4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161BF40F8CF
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691639; cv=pass; b=G4tkjaLE3mFbf1W2MktkifKlPFo92sUrmh0pjFlDX2P0dfPsCrXhvAhiY15UN8liF6+cwSSe4bqwopyrfEqsWUM5/Mcrb43vWPpVBayPcREb2nVp9TcLy5Wwnb24EEr9b4LUdvShq+oKm9m4c6Uq+Pme4PmP+969T4lJzoGnNLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691639; c=relaxed/simple;
	bh=z72OJu1ICGO20+7SVQkQsmhZzsXcp+zcmuvQmlkkVD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EQs56ayq+Te0khMpBzwu2dkKm0CYyEl6gmmCi4RVQ8mQm1WNMy+Qnqzl2GsO4Nz/j6f0bPB+zev9NAhAApGcM69j/98C3SIjAWQNg9GT0p52/Qw6DS1Oo8c71aJxkbk1X+ukj5fX93Uqrk9gekbLt5aPlco/n88tNPv498kqcpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8iA4fz4; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso8128915e9.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 06:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776691635; cv=none;
        d=google.com; s=arc-20240605;
        b=TFCQtcSJij+o8hZ4oJj8BzbnaX6N7PjpF6fiBGNTqiybsdMdRAJxcepgnDFte+/wGI
         LG4rIlML03La3jo6pi5SBZ/sEY34+JKtVpd/VZD5VcqV3e9NiT2g7ZTNqHawddGkdSKr
         ylga8zCimp325JeIJVw5R6SGIttHANKjrB0ALmB24sURSONScVZvVb6JiJT64lSmywXS
         NDPGCJwm1KvV/dZ9JGVV3jx4KrA4l1ZrjeYuyybS26OsM51wtMz49Fy2uJvEBfC15VdL
         yEuVoc2/5uu1jTA4dC8ga1ft/qzkbR34P995mzS7B6e7ZO8zApqvASCr4dQsw4IHOdPd
         frSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bxr9mZ0JI6dmfr+6wmPRSmMMTv04eC8IEspfaLUSB6U=;
        fh=z+pXGhTrWq/O/yY1XA7aacJN7J2Kr07vxOv3bupQ1Dk=;
        b=SaH2scxC2aoVTnKvJLusfZtJmK7PhUqy/3wVGypvjqeiOxXgmNpMzI2zVjEUyzuIzA
         ndJ6bWhFK85GDkR3panw8WKwM953dKgv0H1L0ixmYDojcNvM9yPCPLmjB/pB1zYyHnFV
         Qj0RkTh3CDH9PsJYxgdYnhwD3O/YWX/cJD4FXoJTmBqkwyLFbAdUVaYi8Ab4vW772451
         em7MPYZaZHZh6dlEux75f1+Ex3DpTl0V2pL9BG+Qu8F+a9XU5REVtKxRQcF+UyCCZFyt
         T6ghFyUw1eN9uzf3OxKxrx0eKSbFwfGjo5yVEVsGWkF2moOf9YGPHHytT/CwMDyleJoP
         Hj0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776691635; x=1777296435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxr9mZ0JI6dmfr+6wmPRSmMMTv04eC8IEspfaLUSB6U=;
        b=g8iA4fz4Hpe6dNPmZmxBKLGRDg87k0+zewGyoN24lY4js6Dg3lJG4UpuIhXOWmUPn2
         bWC7oo+ZAzofBbtrQw3b1GE3L92bc4QS5a1BAm9wzNPdg55tYRtLObPpGIFGMmQSokAT
         AXh2+n64gQgrZcRctlUayTvzRcbPC+U4uWs19LO99B4plfn/eyEG5tunUbE01LGtJFbP
         AMxVRXrguN5T5eiaK63TFPXiuhvDRP3pTaVGJKbMLE0atISR/w4x3ayRfa+hpt8M0GCG
         gSEMIb/qPJDsyGm7ZEceLjWbqEWJH8W3wi6hwLQ3d7SsjjjV+yS96Q/1WF+DJkTsQr0U
         ddfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776691635; x=1777296435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bxr9mZ0JI6dmfr+6wmPRSmMMTv04eC8IEspfaLUSB6U=;
        b=TJ+33gz6zf7N2JJGgQI3dvRZvwA3MB3W1kstOxmsSiYZDDVCvv9jLU1zyBa56S2sjX
         eQBxZn8PcwrCQB9Uqsj5w91Pd1FkqJzs6j83PdamCYkMQCSEITOIsGNykZuZve1so+kc
         xkqKUhwsG57M07qakFdEXI1+AiEJNLnqjdf2drROxE/xMnRV9tgN5WrMw7TcSgIsU0+8
         SJobyCoPtNZqlnOrDiBz1dwKXBYnVWCnEywAt1m34seW/P5fHsSbbRaen7oYgRKlndN/
         KaAF4hdAYisWOoR1LtawszqY3LFYOgm7dd3XJDq34yLFpr0RdW89cdKfebKZ8LLOxXwu
         NveA==
X-Forwarded-Encrypted: i=1; AFNElJ+kr+Y8/gUj2XK2xpne8T2NtwwIilsPcAc7xzo+JIQlsJkYrEfuSq66+9sisv2uNeiA6EC3fzs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBCMyzXfBrhNZBsRfJOV9Ep4wEaeuOQd+SCfE1W0b+vMoS4bQ
	h2alyFZ9aK7CAeXu1rIBSDNmzhDt7WDa2Kb5+yHbxiLNDdesIoKnBl3+3wzygF+Tp+AWfJapoKp
	dLzmROyJ6L+DGFAp57QPiJbGA6k1nnXY=
X-Gm-Gg: AeBDietFDPJF3xHEftNwiXNKUDJ0qiapiAiNuDuH++6S68b9o+n/YmezHFIzUjC1Cte
	hoa5BNTw9w3oHTrm44hofaB7bzjvDWMFNz/KJ/4am5nmJXwtlD2ipWYtGI3o1Bczl+ifnACFmYZ
	Waw/pt9JtAJCvuUBocHIOwtkdROGFK3laMOYutyIgxX1tiCNI/knKHVifUhSSzx8bdifrKqAJ8w
	Rcj73cCKCdNaOQt8Jfifg7Trg6QecgxmxU+rVSgWFXOVThkqXxMUPuhzOYewwwzJdGhasZiz8Og
	fkmHOlTL4vs/yWs=
X-Received: by 2002:a05:600c:8284:b0:489:1f3e:5f69 with SMTP id
 5b1f17b1804b1-4891f3e629bmr39042745e9.18.1776691635116; Mon, 20 Apr 2026
 06:27:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420131539.986432-1-sashal@kernel.org> <20260420131539.986432-23-sashal@kernel.org>
In-Reply-To: <20260420131539.986432-23-sashal@kernel.org>
From: Philip Willoughby <willerz@gmail.com>
Date: Mon, 20 Apr 2026 14:27:03 +0100
X-Gm-Features: AQROBzCbFJ8mLSEdWqOwYQ1sOcejeNsW6LB3kLwFv1_SVAsvuVwAPFaLadRF4nM
Message-ID: <CAKSkzpuG8p37a56gB57Khw7hgXmRrgXR6A5Y6ynDy_F5CA=v1g@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 7.0-6.19] ALSA: usb-audio: Add quirks for Arturia AF16Rig
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Iwai <tiwai@suse.de>, 
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-239034-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willerz@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.com:email,suse.de:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,perex.cz:email]
X-Rspamd-Queue-Id: B363742CE78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AF16Rig support also needs the patch to increase the channel limit in
https://lore.kernel.org/linux-sound/87v7fjbsxm.wl-tiwai@suse.de/ I
have not tested what happens without that change also being present
but I suspect it would mean that the AF16Rig still would not function.

On Mon, 20 Apr 2026 at 14:16, Sasha Levin <sashal@kernel.org> wrote:
>
> From: Phil Willoughby <willerz@gmail.com>
>
> [ Upstream commit 0da18c2dd1cc2a026416222ed206e2f269edf055 ]
>
> The AF16Rig supports 34 channels at 44.1k/48k, 18 channels at 88.2k/96k
> and 10 channels at 176.4k/192k.
>
> This quirks is necessary because the automatic probing process we would
> otherwise use fails. The root cause of that is that the AF16Rig clock is
> not readable (its descriptor says that it is but the reads fail).
>
> Except as described below, the values in the audio format quirks were
> copied from the USB descriptors of the device. The rate information is
> from the datasheet of the device. The clock is the internal clock of the
> AF16Rig.
>
> Tested-By: Phil Willoughby <willerz@gmail.com>
> I have tested all the configurations enabled by this patch.
>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Signed-off-by: Phil Willoughby <willerz@gmail.com>
> Link: https://patch.msgid.link/20260328112426.14816-1-willerz@gmail.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>
> LLM Generated explanations, may be completely bogus:
>
> Now I have all the information needed for a thorough analysis. Let me
> compile the findings.
>
> ---
>
> ## PHASE 1: COMMIT MESSAGE FORENSICS
>
> ### Step 1.1: Subject Line
> - **Subsystem:** ALSA: usb-audio
> - **Action verb:** "Add" (quirks)
> - **Summary:** Adds USB audio quirks for the Arturia AF16Rig device
>
> ### Step 1.2: Tags
> - **Tested-By:** Phil Willoughby <willerz@gmail.com> =E2=80=94 the author=
 tested
>   all configurations
> - **Cc:** Jaroslav Kysela (ALSA maintainer), Takashi Iwai (ALSA/USB-
>   audio maintainer)
> - **Signed-off-by:** Phil Willoughby (author), Takashi Iwai (maintainer,
>   applied the patch)
> - **Link:**
>   https://patch.msgid.link/20260328112426.14816-1-willerz@gmail.com
> - No Fixes: tag (expected for quirk additions)
> - No Cc: stable (expected =E2=80=94 that's why we're reviewing)
>
> ### Step 1.3: Commit Body
> The commit explains that the AF16Rig supports multiple channel/rate
> configurations (34ch@44.1k/48k, 18ch@88.2k/96k, 10ch@176.4k/192k). The
> **root cause is that the AF16Rig clock is broken** =E2=80=94 its USB desc=
riptor
> claims the clock is readable but reads fail, which causes the automatic
> probing process to fail entirely. Without this quirk, the device simply
> does not work.
>
> ### Step 1.4: Hidden Bug Fix Detection
> This IS a hardware workaround for a broken device. The device's USB
> descriptors are incorrect (clock readability is falsely advertised),
> causing the standard enumeration path to fail. This is the textbook
> definition of a USB audio device quirk.
>
> ## PHASE 2: DIFF ANALYSIS
>
> ### Step 2.1: Inventory
> - **Files changed:** 1 file (`sound/usb/quirks-table.h`)
> - **Lines added:** ~165 lines (purely data =E2=80=94 struct initializers =
in the
>   quirk table)
> - **Lines removed:** 0
> - **Scope:** Single-file, data-only addition to an existing quirk table
>
> ### Step 2.2: Code Flow Change
> The patch adds a new entry to the USB audio quirks table for USB VID:PID
> `0x1c75:0xaf20`. It defines:
> - 1 standard mixer interface (interface 0)
> - 3 playback audio format configurations (interface 1) for different
>   sample rates
> - 3 capture audio format configurations (interface 2) for the same rates
> - 1 ignored interface (interface 3, firmware update)
>
> The entry is inserted between the last `QUIRK_RME_DIGIFACE` entry and
> the `#undef` lines at the end of the file.
>
> ### Step 2.3: Bug Mechanism
> Category: **Hardware workaround (h)**. The device has a broken clock
> descriptor =E2=80=94 it claims the clock is readable but reads fail. This
> prevents the standard UAC2 enumeration from working. The quirk bypasses
> automatic probing by providing the correct audio format information
> directly.
>
> ### Step 2.4: Fix Quality
> - All macros used (`QUIRK_DATA_AUDIOFORMAT`, `QUIRK_DATA_COMPOSITE`,
>   `QUIRK_DRIVER_INFO`, `QUIRK_DATA_STANDARD_MIXER`, `QUIRK_DATA_IGNORE`,
>   `QUIRK_COMPOSITE_END`) are already defined in the same file (verified
>   at lines 41, 49, 58, 72, 78, 87)
> - Pure data =E2=80=94 no logic changes, no control flow changes
> - Only affects the specific USB device `0x1c75:0xaf20`
> - Zero regression risk for any other device or code path
> - Author tested all configurations enabled by the patch
>
> ## PHASE 3: GIT HISTORY INVESTIGATION
>
> ### Step 3.1: Blame
> The insertion point is at the end of the quirks table after the RME
> Digiface entries. The macros were introduced by `0c3ad39b791c2` ("Define
> macros for quirk table entries") and `d79e13f8e8abb` ("Replace complex
> quirk lines with macros"), both of which are present in this tree.
>
> ### Step 3.2: Fixes Tag
> No Fixes: tag =E2=80=94 this is a new device quirk, not a fix for a speci=
fic
> regression.
>
> ### Step 3.3: File History
> The file has a long history of similar quirk additions: Pioneer DJ
> DJM-V10, RME Digiface USB, Pioneer DDJ-800, Mythware XA001AU, Mbox3,
> etc. This is a well-established pattern.
>
> ### Step 3.4: Author
> Phil Willoughby also contributed `bc5b4e5ae1a67` ("Fix quirk flags for
> NeuralDSP Quad Cortex") around the same date, showing familiarity with
> the USB audio quirk system.
>
> ### Step 3.5: Dependencies
> The patch uses macros already present in the stable tree. No
> prerequisite commits are needed. The insertion point
> (`QUIRK_RME_DIGIFACE(0x3fa0)` followed by `#undef`) exists at lines
> 3901-3903, confirming clean applicability.
>
> ## PHASE 4: MAILING LIST RESEARCH
>
> ### Step 4.1-4.5
> b4 dig could not find the commit (it's not yet in the tree we're on).
> Lore was blocked by anti-bot protection. However, the commit message
> includes a Link to the patch submission, and Takashi Iwai (the USB audio
> maintainer) signed off on it, confirming maintainer review and
> acceptance.
>
> ## PHASE 5: CODE SEMANTIC ANALYSIS
>
> ### Step 5.1-5.5
> This is purely a data table addition. There are no new functions, no
> logic changes, no callers/callees to trace. The quirk table is consumed
> by the existing USB audio driver infrastructure which already handles
> all the macros and format types used.
>
> ## PHASE 6: STABLE TREE ANALYSIS
>
> ### Step 6.1: Code Existence in Stable
> The quirks table and all macros used exist in this 7.0 stable tree.
> Verified: `QUIRK_DATA_AUDIOFORMAT` at line 87, `QUIRK_DATA_COMPOSITE` at
> line 78, `QUIRK_DRIVER_INFO` at line 41, etc.
>
> ### Step 6.2: Backport Complications
> The patch should apply cleanly. The insertion point (between
> `QUIRK_RME_DIGIFACE(0x3fa0),` at line 3901 and `#undef
> USB_DEVICE_VENDOR_SPEC` at line 3903) is present and matches the diff
> context exactly.
>
> ### Step 6.3: Related Fixes
> No prior fixes for AF16Rig exist =E2=80=94 this is the first support entr=
y.
>
> ## PHASE 7: SUBSYSTEM CONTEXT
>
> ### Step 7.1
> - **Subsystem:** sound/usb (USB audio drivers)
> - **Criticality:** IMPORTANT =E2=80=94 USB audio is used by musicians, co=
ntent
>   creators, and professionals who rely on specific hardware
>
> ### Step 7.2
> Active subsystem with regular quirk additions (verified: 10+ recent
> commits adding device quirks).
>
> ## PHASE 8: IMPACT AND RISK ASSESSMENT
>
> ### Step 8.1: Who is Affected
> Users of the Arturia AF16Rig USB audio interface. Without this quirk,
> the device is **completely non-functional** under Linux.
>
> ### Step 8.2: Trigger Conditions
> Every time the device is plugged in. The broken clock descriptor causes
> enumeration failure immediately.
>
> ### Step 8.3: Failure Mode
> Without quirk: Device probing fails, no audio functionality at all.
> **Severity: HIGH** (total device failure).
>
> ### Step 8.4: Risk-Benefit
> - **Benefit:** HIGH =E2=80=94 enables a professional audio device that is
>   otherwise non-functional
> - **Risk:** VERY LOW =E2=80=94 pure data addition to a quirk table, devic=
e-
>   specific, affects no other hardware, uses existing macros, tested by
>   the author
> - **Ratio:** Strongly favorable
>
> ## PHASE 9: FINAL SYNTHESIS
>
> ### Step 9.1: Evidence Summary
> **FOR backporting:**
> - Hardware quirk/workaround for a broken device (clock descriptor lie)
> - Pure data addition, no logic changes
> - Zero regression risk for any other device
> - Uses macros already present in stable
> - Tested by the author on all configurations
> - Accepted by subsystem maintainer (Takashi Iwai)
> - Well-established pattern (dozens of similar entries in the same file)
> - Falls squarely into the "QUIRKS and WORKAROUNDS" exception category
>
> **AGAINST backporting:**
> - Large (~165 lines), though entirely data
> - New device support rather than fixing a regression in existing support
>
> ### Step 9.2: Stable Rules Checklist
> 1. Obviously correct and tested? **YES** =E2=80=94 data copied from USB
>    descriptors, tested by author
> 2. Fixes a real bug? **YES** =E2=80=94 device completely non-functional w=
ithout
>    it (broken clock descriptor)
> 3. Important issue? **YES** =E2=80=94 total hardware failure for users of=
 this
>    device
> 4. Small and contained? **YES** =E2=80=94 single file, data-only, device-
>    specific
> 5. No new features or APIs? **YES** =E2=80=94 no new APIs, just quirk dat=
a
> 6. Can apply to stable? **YES** =E2=80=94 insertion point and all macros =
exist
>
> ### Step 9.3: Exception Category
> **Hardware quirk/workaround** =E2=80=94 this is explicitly listed as a YE=
S-by-
> default category in the stable kernel rules analysis.
>
> ## Verification
>
> - [Phase 1] Parsed tags: Tested-by from author, Signed-off-by from
>   maintainer Takashi Iwai
> - [Phase 2] Diff analysis: ~165 lines of struct initializer data added
>   to quirks-table.h; zero logic changes
> - [Phase 2] Verified all macros used: QUIRK_DATA_AUDIOFORMAT (line 87),
>   QUIRK_DATA_COMPOSITE (line 78), QUIRK_DRIVER_INFO (line 41),
>   QUIRK_DATA_STANDARD_MIXER (line 58), QUIRK_DATA_IGNORE (line 49),
>   QUIRK_COMPOSITE_END (line 72)
> - [Phase 3] git log --oneline -20 -- sound/usb/quirks-table.h: confirmed
>   long history of similar quirk additions
> - [Phase 3] git show bc5b4e5ae1a67: confirmed author has other USB audio
>   work (NeuralDSP fix)
> - [Phase 4] b4 dig failed to find match (commit not in tree); lore
>   blocked by anti-bot; maintainer sign-off confirmed from commit
>   metadata
> - [Phase 5] No functions to trace =E2=80=94 pure data table entry
> - [Phase 6] Verified insertion point exists at lines 3901-3903
>   (QUIRK_RME_DIGIFACE followed by #undef); patch should apply cleanly
> - [Phase 6] Verified Arturia VID 0x1c75 has no existing entries (grep
>   returned no matches)
> - [Phase 7] Subsystem is actively maintained with regular quirk
>   additions
> - [Phase 8] Failure mode: complete device non-functionality; severity
>   HIGH; risk VERY LOW (data-only, device-specific)
> - UNVERIFIED: Could not access mailing list discussion due to anti-bot
>   protection; relying on maintainer sign-off as evidence of review
>
> This is a textbook USB audio device quirk addition. The Arturia AF16Rig
> has a broken clock descriptor that prevents standard enumeration, making
> the device completely non-functional without this quirk. The patch is
> pure data, uses existing macros, and affects only the specific device.
> It carries essentially zero regression risk.
>
> **YES**
>
>  sound/usb/quirks-table.h | 165 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
>
> diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
> index eafc0d73cca1f..8f79a15055a6a 100644
> --- a/sound/usb/quirks-table.h
> +++ b/sound/usb/quirks-table.h
> @@ -3900,5 +3900,170 @@ YAMAHA_DEVICE(0x7010, "UB99"),
>  QUIRK_RME_DIGIFACE(0x3f8c),
>  QUIRK_RME_DIGIFACE(0x3fa0),
>
> +/* Arturia AudioFuse 16Rig Audio */
> +/* AF16Rig MIDI has USB PID 0xaf21 and appears to work OK without quirks=
 */
> +{
> +       USB_DEVICE(0x1c75, 0xaf20),
> +       QUIRK_DRIVER_INFO {
> +               .vendor_name =3D "Arturia",
> +               .product_name =3D "AF16Rig",
> +               QUIRK_DATA_COMPOSITE {
> +                       { QUIRK_DATA_STANDARD_MIXER(0) },
> +                       {
> +                               QUIRK_DATA_AUDIOFORMAT(1) { /* Playback *=
/
> +                                       .formats =3D SNDRV_PCM_FMTBIT_S32=
_LE,
> +                                       .channels =3D 34,
> +                                       .fmt_type =3D UAC_FORMAT_TYPE_I_P=
CM,
> +                                       .fmt_bits =3D 24,
> +                                       .fmt_sz =3D 4,
> +                                       .iface =3D 1,
> +                                       .altsetting =3D 1,
> +                                       .altset_idx =3D 1,
> +                                       .endpoint =3D 0x01,
> +                                       .ep_attr =3D USB_ENDPOINT_XFER_IS=
OC|
> +                                                  USB_ENDPOINT_SYNC_ASYN=
C,
> +                                       .datainterval =3D 1,
> +                                       .protocol =3D UAC_VERSION_2,
> +                                       .maxpacksize =3D 0x03b8,
> +                                       .rates =3D SNDRV_PCM_RATE_44100|
> +                                                SNDRV_PCM_RATE_48000,
> +                                       .rate_min =3D 44100,
> +                                       .rate_max =3D 48000,
> +                                       .nr_rates =3D 2,
> +                                       .rate_table =3D (unsigned int[]) =
{ 44100, 48000 },
> +                                       .clock =3D 41,
> +                               }
> +                       },
> +                       {
> +                               QUIRK_DATA_AUDIOFORMAT(1) { /* Playback *=
/
> +                                       .formats =3D SNDRV_PCM_FMTBIT_S32=
_LE,
> +                                       .channels =3D 18,
> +                                       .fmt_type =3D UAC_FORMAT_TYPE_I_P=
CM,
> +                                       .fmt_bits =3D 24,
> +                                       .fmt_sz =3D 4,
> +                                       .iface =3D 1,
> +                                       .altsetting =3D 1,
> +                                       .altset_idx =3D 1,
> +                                       .endpoint =3D 0x01,
> +                                       .ep_attr =3D USB_ENDPOINT_XFER_IS=
OC|
> +                                                  USB_ENDPOINT_SYNC_ASYN=
C,
> +                                       .datainterval =3D 1,
> +                                       .protocol =3D UAC_VERSION_2,
> +                                       .maxpacksize =3D 0x03a8,
> +                                       .rates =3D SNDRV_PCM_RATE_88200|
> +                                                SNDRV_PCM_RATE_96000,
> +                                       .rate_min =3D 88200,
> +                                       .rate_max =3D 96000,
> +                                       .nr_rates =3D 2,
> +                                       .rate_table =3D (unsigned int[]) =
{ 88200, 96000 },
> +                                       .clock =3D 41,
> +                               }
> +                       },
> +                       {
> +                               QUIRK_DATA_AUDIOFORMAT(1) { /* Playback *=
/
> +                                       .formats =3D SNDRV_PCM_FMTBIT_S32=
_LE,
> +                                       .channels =3D 10,
> +                                       .fmt_type =3D UAC_FORMAT_TYPE_I_P=
CM,
> +                                       .fmt_bits =3D 24,
> +                                       .fmt_sz =3D 4,
> +                                       .iface =3D 1,
> +                                       .altsetting =3D 3,
> +                                       .altset_idx =3D 3,
> +                                       .endpoint =3D 0x01,
> +                                       .ep_attr =3D USB_ENDPOINT_XFER_IS=
OC|
> +                                                  USB_ENDPOINT_SYNC_ASYN=
C,
> +                                       .datainterval =3D 1,
> +                                       .protocol =3D UAC_VERSION_2,
> +                                       .maxpacksize =3D 0x03e8,
> +                                       .rates =3D SNDRV_PCM_RATE_176400|
> +                                                SNDRV_PCM_RATE_192000,
> +                                       .rate_min =3D 176400,
> +                                       .rate_max =3D 192000,
> +                                       .nr_rates =3D 2,
> +                                       .rate_table =3D (unsigned int[]) =
{ 176400, 192000 },
> +                                       .clock =3D 41,
> +                               }
> +                       },
> +                       {
> +                               QUIRK_DATA_AUDIOFORMAT(2) { /* Capture */
> +                                       .formats =3D SNDRV_PCM_FMTBIT_S32=
_LE,
> +                                       .channels =3D 34,
> +                                       .fmt_type =3D UAC_FORMAT_TYPE_I_P=
CM,
> +                                       .fmt_bits =3D 24,
> +                                       .fmt_sz =3D 4,
> +                                       .iface =3D 2,
> +                                       .altsetting =3D 1,
> +                                       .altset_idx =3D 1,
> +                                       .endpoint =3D 0x81,
> +                                       .ep_attr =3D USB_ENDPOINT_XFER_IS=
OC|
> +                                                  USB_ENDPOINT_SYNC_ASYN=
C,
> +                                       .datainterval =3D 1,
> +                                       .protocol =3D UAC_VERSION_2,
> +                                       .maxpacksize =3D 0x03b8,
> +                                       .rates =3D SNDRV_PCM_RATE_44100|
> +                                                SNDRV_PCM_RATE_48000,
> +                                       .rate_min =3D 44100,
> +                                       .rate_max =3D 48000,
> +                                       .nr_rates =3D 2,
> +                                       .rate_table =3D (unsigned int[]) =
{ 44100, 48000 },
> +                                       .clock =3D 41,
> +                               }
> +                       },
> +                       {
> +                               QUIRK_DATA_AUDIOFORMAT(2) { /* Capture */
> +                                       .formats =3D SNDRV_PCM_FMTBIT_S32=
_LE,
> +                                       .channels =3D 18,
> +                                       .fmt_type =3D UAC_FORMAT_TYPE_I_P=
CM,
> +                                       .fmt_bits =3D 24,
> +                                       .fmt_sz =3D 4,
> +                                       .iface =3D 2,
> +                                       .altsetting =3D 2,
> +                                       .altset_idx =3D 2,
> +                                       .endpoint =3D 0x81,
> +                                       .ep_attr =3D USB_ENDPOINT_XFER_IS=
OC|
> +                                                  USB_ENDPOINT_SYNC_ASYN=
C,
> +                                       .datainterval =3D 1,
> +                                       .protocol =3D UAC_VERSION_2,
> +                                       .maxpacksize =3D 0x03a8,
> +                                       .rates =3D SNDRV_PCM_RATE_88200|
> +                                                SNDRV_PCM_RATE_96000,
> +                                       .rate_min =3D 88200,
> +                                       .rate_max =3D 96000,
> +                                       .nr_rates =3D 2,
> +                                       .rate_table =3D (unsigned int[]) =
{ 88200, 96000 },
> +                                       .clock =3D 41,
> +                               }
> +                       },
> +                       {
> +                               QUIRK_DATA_AUDIOFORMAT(2) { /* Capture */
> +                                       .formats =3D SNDRV_PCM_FMTBIT_S32=
_LE,
> +                                       .channels =3D 10,
> +                                       .fmt_type =3D UAC_FORMAT_TYPE_I_P=
CM,
> +                                       .fmt_bits =3D 24,
> +                                       .fmt_sz =3D 4,
> +                                       .iface =3D 2,
> +                                       .altsetting =3D 3,
> +                                       .altset_idx =3D 3,
> +                                       .endpoint =3D 0x81,
> +                                       .ep_attr =3D USB_ENDPOINT_XFER_IS=
OC|
> +                                                  USB_ENDPOINT_SYNC_ASYN=
C,
> +                                       .datainterval =3D 1,
> +                                       .protocol =3D UAC_VERSION_2,
> +                                       .maxpacksize =3D 0x03e8,
> +                                       .rates =3D SNDRV_PCM_RATE_176400|
> +                                                SNDRV_PCM_RATE_192000,
> +                                       .rate_min =3D 176400,
> +                                       .rate_max =3D 192000,
> +                                       .nr_rates =3D 2,
> +                                       .rate_table =3D (unsigned int[]) =
{ 176400, 192000 },
> +                                       .clock =3D 41,
> +                               }
> +                       },
> +                       { QUIRK_DATA_IGNORE(3) }, /* Firmware update */
> +                       QUIRK_COMPOSITE_END
> +               }
> +       }
> +},
> +
>  #undef USB_DEVICE_VENDOR_SPEC
>  #undef USB_AUDIO_DEVICE
> --
> 2.53.0
>

