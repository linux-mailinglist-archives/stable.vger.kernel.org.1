Return-Path: <stable+bounces-103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F597F6DA1
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 09:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B1DD280FBF
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 08:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A5B7465;
	Fri, 24 Nov 2023 08:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRKY9BSt"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E001712
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 00:04:47 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-581fb6f53fcso894401eaf.2
        for <stable@vger.kernel.org>; Fri, 24 Nov 2023 00:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700813087; x=1701417887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+/gN1PQUkQb9vb1gAPBmNmOTUmkP5kfsKmcW1MZY49E=;
        b=RRKY9BStODkprSa8HA0O8K7PlhkxflrlLDbRqpYhlxfJnmAKavuBhjGZZQ5kOShlDg
         GtsWp18DhlW9RrSfCvzoPw6pWuV9dqCrBQwSiQFUr/m4Lb0oKYwaRarn/0+OPh7V9KvG
         PTDXHyaqpQ2sk3N5BEX5VQ8rKYSEz4Xz28M8PnpZnyDTRoHUoSy6jcmAY0FX1rEYeiu4
         Z1IJ2xzTgW4sDV+8cWdzd/PstDQkLVYVN6p40rJ548aQik6sDJIncaD/c+Q7NrFv190w
         X6AXAHvThFd+unMfqk1k+yMFpLwsnGyLNCn/m+sCYwjX6O0v0+I0RL9z6k1oUCcdBEgI
         VEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700813087; x=1701417887;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+/gN1PQUkQb9vb1gAPBmNmOTUmkP5kfsKmcW1MZY49E=;
        b=pqmQeRI1h6s4rJG6FT/6FFFs5PV6tu4i+76kBLalGusHrJBbuZcv0C5mLJGp+/nrgi
         IpL0dvvYKDJIGNfDpPwiP3CwFyJeYNuNNSe81xOW0ipDgipCDTNoQBD4kgBAApNYML9n
         rIxEeyFB1gNyYbCLHXKJD9cyZhGlHLdaAQpBvnotdoL4aRk8Hps6Htg5flUZUdubDl7B
         rnF3sb/CPYUHViLR50Ac+L7fbkfuroaswvGlRGVH3WexQCih1fdJdZYlUnwZcTqzcjIK
         5WJNgShVHvHtUE/5VQs/Wd7OIDwCFY1l4qa7/016qGEWP0FOgxPuM3dm1MMWzP3cQPf/
         +8nA==
X-Gm-Message-State: AOJu0Yz8nG2rCqi4MOfJTtTgNenILDyBtCmFo1gH/rvijICRSi0pCUY8
	rxWoVX6wOihLtZEIFiNIH+mR6bw8LrZi/tzW3re9o0aTY/Y0cw==
X-Google-Smtp-Source: AGHT+IFnm4qGoWlFtdJzKFxUxpMAXCsh7SsdWw95Q/hOjxUUGy0M7YkKuliNBnPgcGcP04Oge4/9FQ2DxWB0P8TRGrk=
X-Received: by 2002:a4a:925b:0:b0:58a:231d:750d with SMTP id
 g27-20020a4a925b000000b0058a231d750dmr1893542ooh.9.1700813086746; Fri, 24 Nov
 2023 00:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Caleb Jorden <cjorden@gmail.com>
Date: Fri, 24 Nov 2023 13:34:35 +0530
Message-ID: <CABD8wQkKEYULh1U1hm9BFft43rzvk5GQaV8D5-VQ3jkYdLa9DA@mail.gmail.com>
Subject: [Regression] Linux-6.6.2: SRSO kernel log messages incorrect
To: Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hello,

I have noticed on my zen3 and zen4 machines (Ryzen 9 5950x & Ryzen 9
7950x) that the kernel boot log regarding SRSO is suddenly incorrect
with the 6.6.2 kernel.

I have observed this on a completely mainline/stable kernel that I
compile regularly for my machines.  With the 6.6.1 and 6.7-rc2
kernels, I see correct boot messages like this:

[    0.161327] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.161329] Spectre V2 : Mitigation: Retpolines
[    0.161330] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    0.161331] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.161332] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.161333] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.161335] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.161336] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl
[    0.161338] Speculative Return Stack Overflow: Mitigation: safe RET

However, with the 6.6.2 kernel, I see this:

[    0.164266] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    0.164268] Spectre V2 : Mitigation: Retpolines
[    0.164269] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    0.164270] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.164272] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.164273] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    0.164275] Spectre V2 : User space: Mitigation: STIBP always-on protection
[    0.164276] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl
[    0.164278] Speculative Return Stack Overflow: IBPB-extending
microcode not applied!
[    0.164279] Speculative Return Stack Overflow: WARNING: See
https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for
mitigation options.
[    0.164280] Speculative Return Stack Overflow: Mitigation: Safe RET

Notice that in both cases the final SRSO message indicates (correctly)
that my system is protected with Safe RET (because my BIOS has the
updated microcode for SRSO).  However, in the 6.6.2 kernel I also get
the microcode warning.

I tracked this down to, what I believe is, the following commit from
the mainline kernel not being included in the 6.6.2 patch set:
351236947a45a512c517153bbe109fe868d05e6d x86/srso: Move retbleed IBPB
check into existing 'has_microcode' code block

When I cherry-pick this commit to the 6.6.2 release, the log messages
are correct.  Note that this patch does not obviously indicate there
is a functional change introduced by applying it.  However (at least
in the case of Zen3 and Zen4) when the updated microcode has been
applied, the flow is different (specifically the situation that falls
into the else statement that produces the pr-warn calls to indicate
that the microcode fix needs applied).  I believe this might be
because RETBLEED does not apply to Zen3 and Zen4.  Unfortunately I
don't have a Zen1 or Zen2 system readily available on which to test
this theory.

While this should only be a cosmetic change, I believe that there is
value in having the correct messages in the kernel logs for SRSO in
this LTS release.

Please feel free to correct my analysis above if it is incorrect.

Warm Regards,

Caleb Jorden

