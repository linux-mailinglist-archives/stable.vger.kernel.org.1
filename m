Return-Path: <stable+bounces-118691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A890A411BF
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 21:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20DD4170AFD
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 20:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE151FDA6F;
	Sun, 23 Feb 2025 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcS9Jo3H"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001351E491B
	for <stable@vger.kernel.org>; Sun, 23 Feb 2025 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740344157; cv=none; b=RrY9sxgsIVX31BNzb4aSbmU4wYQUP8iZGmk1ePSB5x2TwI3Gd/DvM5rPuNZOq2qUWBKLc3Cnop2FzRzrwL3jiS9pWAx/QxaOwMl5fCiQ/jwgwbXMkVF+KF82FffB75MjQzpEX4vbJNREYpw8P7CMrdGIiVKfFniP8O/wGBtO2II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740344157; c=relaxed/simple;
	bh=AGFFGmB9vBy6TsRyCyNlIMC/OHTiQ9NPOBxnBxibdTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6eYfqWgMGT+zKaJxC2rvdeWVuMOlb6iNa1oiQar3v/MLdeRVq5WlOQcoAtiSRVzkop/0MXFyVTekzlTyEcgHVlcde6ZSMOWFo+SspUSjjMUoTXWlXwQHTZRuqFlsLh8sPR60pf8SeJLgiVKGbxitMU8UVOWnXztxJDkU1DBpkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcS9Jo3H; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so2128945f8f.0
        for <stable@vger.kernel.org>; Sun, 23 Feb 2025 12:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740344154; x=1740948954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0fB4A0zqHMl0E93R7yWp+6DKpBbr/GksX5p6qlRsg4=;
        b=fcS9Jo3HUlMHlQlJaQ9cSTiJUeUfW2oqkhY1x1PV/2tsjkYse0iZ2keKhlJ//JH++T
         Zb3hhzRCc0uVxoD3Vfmja+qKqwi4IGQ2iC5KT0qb8zuRIYt1IvC5BFNMnR7bU8eRDwcy
         pO/HMMnnvI7KSAFvKAU7hBg5ft9ShRUxxGOIpV+L/Ma7IgTU00Z8rfM/MMXm+WVI0yGJ
         p+oO8m51LbYfeRQlNTZSncuPhdXvs3wGD3ihmVG+UKMpzwN8bmSHB9k1UkIS/2VjIw6F
         b+fMoA8RJAK4qHEj021+HU+u29TLuo537hSPPnRvM2cWLG+tqJ68IFQudiapDUXhSs9F
         Ey1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740344154; x=1740948954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0fB4A0zqHMl0E93R7yWp+6DKpBbr/GksX5p6qlRsg4=;
        b=fhgdHDup2b3OU9ugUxoUcZBea2ohSQjgFxWeLbaonpXefEgC6kK5snXkP6Z+7wMppw
         T9rBw6R5I263F/L8A45tOJ+6eoh0WsR41J2gs977Ke2O+rGRaNoPrOoKZ5awJmpi0iSp
         Z/K827hxbHhM0OMlOIDWQ8YtjL50tG60IjxDxRQyQg+Va+sOaAuFowrA9ofjgc6jAP0i
         aTquuAXe9fsZSS0MkSFR7kN9pCkxCUclbdCq2wL0Nb7L8d5RXNgsFQOenTRc2r7CINbX
         J9lQMHX/2FiOdKyTfSoZBDjtiNb/VpkmreRSXhNJbao53YRhD4D/rdtFuTplUYqv2MI5
         KBgw==
X-Gm-Message-State: AOJu0Ywxkw1/iGgfKPXCymJ6KQvS4lBbTHUHeCV9bQ89tf9OOO8lKuv8
	O7jwYxavNYxnI3OjWu4wXLtnP9/cO0IQinKl3IO2hQjwwBJxn3LCLn4I8w==
X-Gm-Gg: ASbGncvpjMsEhQhRQLUZQMEm/xrpqTxgmP+f2UcCz/ghpKKKffamMVx8W19hYnTNxpg
	q930j5CUubymVRWBwyGtNc1Ab2u7wOJe3e63bHQ9AVuzym5iap3uVTICbNpCk8I9Le1B8jAVbPo
	zSGHaFdlGZQaWn4W7PPEgOLlblZx9VPHqcEfQQPM08Yk1QrhMNnDJOLqR5jZ3OuQlsOJcMjRz2W
	aHSqX6I6nZG5E1GId0qj2rANWhbUOs1vNz/XZg7hChHEcdXVO6HNmTjeSTIrAMLn/XO4Y29unFo
	7j5NJlkdwSkMChWm6+ozaYo=
X-Google-Smtp-Source: AGHT+IGvFAlBc7LwYhyYf/mlg323rLjw5rBU/IPo0gxt2D6/duE+fIEp5OJXVKuKqyXRxIPOFaqIhg==
X-Received: by 2002:a05:6000:1f8d:b0:38d:e401:fd61 with SMTP id ffacd0b85a97d-38f6f0bf18bmr7795562f8f.49.1740344153960;
        Sun, 23 Feb 2025 12:55:53 -0800 (PST)
Received: from localhost ([2a02:168:59f0:1:b0ab:dd5e:5c82:86b0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259d58f3sm29693266f8f.73.2025.02.23.12.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 12:55:53 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jared Finder <jared@finder.org>
Cc: stable@vger.kernel.org,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	Jann Horn <jannh@google.com>,
	=?UTF-8?q?Hanno=20B=C3=B6ck?= <hanno@hboeck.de>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH] tty: Require CAP_SYS_ADMIN for all usages of TIOCL_SELMOUSEREPORT
Date: Sun, 23 Feb 2025 21:54:50 +0100
Message-ID: <20250223205449.7432-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <491f3df9de6593df8e70dbe77614b026@finder.org>
References: <491f3df9de6593df8e70dbe77614b026@finder.org>
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


