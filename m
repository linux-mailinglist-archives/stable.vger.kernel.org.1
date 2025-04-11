Return-Path: <stable+bounces-132204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67369A854E2
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 09:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95BD21BA191D
	for <lists+stable@lfdr.de>; Fri, 11 Apr 2025 07:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C691E9B38;
	Fri, 11 Apr 2025 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0XaucI9"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E641372;
	Fri, 11 Apr 2025 07:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744354934; cv=none; b=USRjGLMFsgfOwiqThPXGhZfZcSz2djMyhERm4PJOETWpONFpVzlzQ++xa+HaWMlm5d83Dn1bUhZoGhSy+h2irpWyTQXRE66SYM/R7xspRCijgOTnyFkpIdiVpT6k6r7R7u59EyOoLqPa7G2VxbQN5e8AMz3JVF2gMlyxFe/BTJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744354934; c=relaxed/simple;
	bh=AGFFGmB9vBy6TsRyCyNlIMC/OHTiQ9NPOBxnBxibdTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RuMmBx7FY8Y9hs8s9pftl2QBuNlZp0Naa0frfLPyF03xy27BpZh5Iyj+4glfU2782IwqjzdSVC+3dy4+vlEmvuI2fZ6VFboAVCfRK4KeghGL0GnxYpws2VM7+088ZCykJMHp+ONyWbzYmiZ5piISrpOe7gdqccXTFG/n+bbBCqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0XaucI9; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913d129c1aso1130656f8f.0;
        Fri, 11 Apr 2025 00:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744354931; x=1744959731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e0fB4A0zqHMl0E93R7yWp+6DKpBbr/GksX5p6qlRsg4=;
        b=h0XaucI9JSWi9mmV+9WVlTKy3o4qX9Hn4sM3+be157u0lzr9ZsgAA/Ak8Db3PeZ31g
         puGXxdRfZGTZi+d4mW9iPgcy6WCTc+yJH3845O50IWOxp6xHh+WNXmIXBCK4hou1sPx9
         HVgSoeWNsvPo5utDK7jsvsJsn8nfofOYO3kp0K2lNT6oZdmkaouT1fwIbSK7l0RH+Tgf
         1mbFMb7ho5SwtCkBokbjhHtBkPXL8GmOmuFAg/2IfOa9up5g5syhgI/fqbnk9McuX687
         n8c8WgYXvA2c31gRJbA5YSwvefP3IVDjypbTYtn17NJVnn4QMxI8cs3bQ/TAOhWNiYd9
         jvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744354931; x=1744959731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0fB4A0zqHMl0E93R7yWp+6DKpBbr/GksX5p6qlRsg4=;
        b=rqIgymRH15pr+lmmLOb+Vlu1CneU2UoTT2zx5RTLKj5tanmh8gj9PLadsO0YHcsM7s
         LJV0fVsv2qW088SyvkeC5lx/+UXOviNWdaZEv9jvNcnjPYTumAf23FMmg14dAKyjnVrj
         VbQI7ADl2ovj27w7a60kjR2t+yeUYibaDg2XrywmLtWyYCpnb9ln38TaFYmiCyjNglTH
         iB/pXYq3ZXbuDmGGcSL3I6CknfzYiopibyG3tdKFelS7c5zuW1idMQ4PLiOI7k85aZ1a
         XprnAUR2XTRaKcjkAn622uM1tQ0vMz3jP7a1yBPD9cO3JLFUVh1WxTUmHw5m4OBm0fSQ
         oZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJhbmZNhHTpI44mqMfKbfyIcLcptnZvaxvw8IQ/xJJew8bd7vQwaB/HynJhdKnNOvjddxY0MrevKMN5hMO@vger.kernel.org, AJvYcCW78yqyCrzfTTnSh9jWHCUUdCNzsjjlwy+M9SeH9cFFXBhfnJoiHwi7GqzRpeShBko6VJt56jgDc3p6TYc=@vger.kernel.org, AJvYcCXES5ECVLNEFAQnwHbRdKNEfDkl6ss2Tz31e/dkL3CGEplHrRpgKHYR6rmSdPTNQZdVimlxSY/R@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfw8swseu86HoPgllh70qREBdsvUIES9gkc/xLqAXsVqdD1gDv
	ab4h4AOd+hPoECiy02rskQ0frg34whBMjkN6GJyiwq/SYBmOMVly
X-Gm-Gg: ASbGnctpFaKgzozCq7iE4wOj0ttq0ISxEypAnoAJ2wzl708nAHMZ+kTkfZvztdF5J5B
	br4LrTVZwyQppjzFNL4gsq5A1RFDNAhGqh6LaZRIElMEGjZNk5iQ9y+2pah0RwwMNj4sZr8BpKP
	T6oOBbFJ3wWwqjm7GkHM0gdacj3oge4SfZ+7Wj6xKg0QA6Bo4Pre0vT4SFJM9iQSUqeSngndYjN
	6YDtWVmNDkAgdJfxYejSZ+7wq6LgR9/65v3WgtLVgNmEqU41Zf9CJsM8c3F4A6n7o4f00IkxkMo
	Ln1nzdWRYSJUNgULS06XWOOHscrmJP0nhF3g2jUEMAe4f5IrtWaQ3g0SYyU41bPlw08=
X-Google-Smtp-Source: AGHT+IH8LCzHUSZqtfBQFlJkR7MqXFEh62hFWVQl5PF1/8RaLCtx+2Lw6/EeRGjCvjbReYcDJv6wgQ==
X-Received: by 2002:a05:6000:1887:b0:38a:4184:14ec with SMTP id ffacd0b85a97d-39e6e45d52fmr1187829f8f.1.1744354930629;
        Fri, 11 Apr 2025 00:02:10 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39eae964073sm1109117f8f.9.2025.04.11.00.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 00:02:10 -0700 (PDT)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Jared Finder <jared@finder.org>,
	Jann Horn <jannh@google.com>,
	=?UTF-8?q?Hanno=20B=C3=B6ck?= <hanno@hboeck.de>,
	Kees Cook <kees@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH RESEND] tty: Require CAP_SYS_ADMIN for all usages of TIOCL_SELMOUSEREPORT
Date: Fri, 11 Apr 2025 09:01:45 +0200
Message-ID: <20250411070144.3959-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This requirement was overeagerly loosened in commit 2f83e38a095f
("tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN"), but as
it turns out,

  (1) the logic I implemented there was inconsistent (apologies!),

  (2) TIOCL_SELMOUSEREPORT might actually be a small security risk
      after all, and

  (3) TIOCL_SELMOUSEREPORT is only meant to be used by the mouse
      daemon (GPM or Consolation), which runs as CAP_SYS_ADMIN
      already.

In more detail:

1. The previous patch has inconsistent logic:

   In commit 2f83e38a095f ("tty: Permit some TIOCL_SETSEL modes
   without CAP_SYS_ADMIN"), we checked for sel_mode ==
   TIOCL_SELMOUSEREPORT, but overlooked that the lower four bits of
   this "mode" parameter were actually used as an additional way to
   pass an argument.  So the patch did actually still require
   CAP_SYS_ADMIN, if any of the mouse button bits are set, but did not
   require it if none of the mouse buttons bits are set.

   This logic is inconsistent and was not intentional.  We should have
   the same policies for using TIOCL_SELMOUSEREPORT independent of the
   value of the "hidden" mouse button argument.

   I sent a separate documentation patch to the man page list with
   more details on TIOCL_SELMOUSEREPORT:
   https://lore.kernel.org/all/20250223091342.35523-2-gnoack3000@gmail.com/

2. TIOCL_SELMOUSEREPORT is indeed a potential security risk which can
   let an attacker simulate "keyboard" input to command line
   applications on the same terminal, like TIOCSTI and some other
   TIOCLINUX "selection mode" IOCTLs.

   By enabling mouse reporting on a terminal and then injecting mouse
   reports through TIOCL_SELMOUSEREPORT, an attacker can simulate
   mouse movements on the same terminal, similar to the TIOCSTI
   keystroke injection attacks that were previously possible with
   TIOCSTI and other TIOCL_SETSEL selection modes.

   Many programs (including libreadline/bash) are then prone to
   misinterpret these mouse reports as normal keyboard input because
   they do not expect input in the X11 mouse protocol form.  The
   attacker does not have complete control over the escape sequence,
   but they can at least control the values of two consecutive bytes
   in the binary mouse reporting escape sequence.

   I went into more detail on that in the discussion at
   https://lore.kernel.org/all/20250221.0a947528d8f3@gnoack.org/

   It is not equally trivial to simulate arbitrary keystrokes as it
   was with TIOCSTI (commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be
   disabled")), but the general mechanism is there, and together with
   the small number of existing legit use cases (see below), it would
   be better to revert back to requiring CAP_SYS_ADMIN for
   TIOCL_SELMOUSEREPORT, as it was already the case before
   commit 2f83e38a095f ("tty: Permit some TIOCL_SETSEL modes without
   CAP_SYS_ADMIN").

3. TIOCL_SELMOUSEREPORT is only used by the mouse daemons (GPM or
   Consolation), and they are the only legit use case:

   To quote console_codes(4):

     The mouse tracking facility is intended to return
     xterm(1)-compatible mouse status reports.  Because the console
     driver has no way to know the device or type of the mouse, these
     reports are returned in the console input stream only when the
     virtual terminal driver receives a mouse update ioctl.  These
     ioctls must be generated by a mouse-aware user-mode application
     such as the gpm(8) daemon.

   Jared Finder has also confirmed in
   https://lore.kernel.org/all/491f3df9de6593df8e70dbe77614b026@finder.org/
   that Emacs does not call TIOCL_SELMOUSEREPORT directly, and it
   would be difficult to find good reasons for doing that, given that
   it would interfere with the reports that GPM is sending.

   More information on the interaction between GPM, terminals and the
   kernel with additional pointers is also available in this patch:
   https://lore.kernel.org/all/a773e48920aa104a65073671effbdee665c105fc.1603963593.git.tammo.block@gmail.com/

   For background on who else uses TIOCL_SELMOUSEREPORT: Debian Code
   search finds one page of results, the only two known callers are
   the two mouse daemons GPM and Consolation.  (GPM does not show up
   in the search results because it uses literal numbers to refer to
   TIOCLINUX-related enums.  I looked through GPM by hand instead.
   TIOCL_SELMOUSEREPORT is also not used from libgpm.)
   https://codesearch.debian.net/search?q=TIOCL_SELMOUSEREPORT

Cc: Jared Finder <jared@finder.org>
Cc: Jann Horn <jannh@google.com>
Cc: Hanno Böck <hanno@hboeck.de>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 2f83e38a095f ("tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN")
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 drivers/tty/vt/selection.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 0bd6544e30a6b..791e2f1f7c0b6 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -193,13 +193,12 @@ int set_selection_user(const struct tiocl_selection __user *sel,
 		return -EFAULT;
 
 	/*
-	 * TIOCL_SELCLEAR, TIOCL_SELPOINTER and TIOCL_SELMOUSEREPORT are OK to
-	 * use without CAP_SYS_ADMIN as they do not modify the selection.
+	 * TIOCL_SELCLEAR and TIOCL_SELPOINTER are OK to use without
+	 * CAP_SYS_ADMIN as they do not modify the selection.
 	 */
 	switch (v.sel_mode) {
 	case TIOCL_SELCLEAR:
 	case TIOCL_SELPOINTER:
-	case TIOCL_SELMOUSEREPORT:
 		break;
 	default:
 		if (!capable(CAP_SYS_ADMIN))

base-commit: 27102b38b8ca7ffb1622f27bcb41475d121fb67f
-- 
2.48.1


