Return-Path: <stable+bounces-108201-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB57A0935B
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 15:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177A51667C5
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5825920FA99;
	Fri, 10 Jan 2025 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4OD9GaIK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4195720FA88
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 14:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518889; cv=none; b=kjbwF+TRWvn0OHhb6MrxRupHkKDOpBbznSUfHYXgYX6LmgjwM4cORlegAnRRSUztGriTk8rhjx0BPG7LF/9EKNfFb5uppREMbMZBix7xlyTsw0y/i4xmgN1tGWdFkqfdTZYNAhr0rypiIaXDxTJZ/HiJYTJWEP4S3CqtJubgJug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518889; c=relaxed/simple;
	bh=eZLl37fOSbYQYDLGS5Y/QLTa91exobFept6c4ErWMTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u+R/1b4/h1aF3Cw/SbeKNw4rjreADlZi4kKXsmbvevDefrqy0eYt8pcCHHYhckeX9AaK5NNnix7TDpQNh+6BcOwVMLkmsObMQrBx4sN7agSL8BKKr5LvH9KIWZkybFqAg07kv0lmUqrXiMEdqui7VY93vu34J765b9dXDJil9s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4OD9GaIK; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d40c0c728aso1688963a12.2
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 06:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736518885; x=1737123685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9umdn33M+pmVRz+NuzpgduvU4xJDCFruejcIKVHUmT0=;
        b=4OD9GaIKd+6iSucTKlTyfl17+CPR4JKN3DmLRP3AUTAfRoepDmROEZmKNwVQPsf59F
         jGwpFAhYuqMW+JJrB+8aStyGvse22OMIJZ/5FIcwYDKdqvEca+OKsD44dSI1JaGmnGUF
         vur9y9vV2z7ZBAtts+cIXE8mEDeh0N/wZoTUprpFIQm/9g0OI69Wg7faXUjPa+6nZXT/
         fl59+8GCwxuN7uR4MBmD4wZWXtiUO56DL+WBtX83cLfx8z9OEv72GZ7dzb+9lVnCGpT6
         dkKZcc7/w4H437GPd5GIJpRnIzbL9DKm6psGEU4O1HJa8F/eobaGxs0WQSrPcY/Orni4
         4SBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736518885; x=1737123685;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9umdn33M+pmVRz+NuzpgduvU4xJDCFruejcIKVHUmT0=;
        b=Dkta4VDstxAwIO8GToUunXE46mRujt9mqeOkIP1W/biga3qayhkPxatGcVtrr2HA7B
         fco7p7lgE4p5mhCASPQqECpnQXe+pdw55ASOlb/tPpymdyGSrDLMPvGlTi1DSCitGjrE
         KuhyZTo1iEvd1SkrVVF4l/blgU78JjBGIHbNTI9GrAX2vsHsOgQn9/jgFKUNvgpVSoFS
         TWkgcA1yTEkUd0AruM+ABUSNFUIkEjdaM9junKe/fptD6L+CJnNlHxG4YnTJe3LLxPJU
         LksJZMdM8MZDOqir+pvhDMBPD7fC925QrketuTA1P5sJjAC2qWDD88LuB2v4hVCSJuQA
         6LUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTFohrmoAY/Apk0Wl/uPiNhrILYzRjibJl46bMfyrAUpxIlNm5OlC4nr1DnJfN7mOpm0vwFkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMXJRZwtxxRDWnas0vGyNrnlJnSegy7+ZFiMFVnJHvsUici0R
	Y5kzW66P4iDdasRonF+HhNQdORQuhsEh4Ya5vV1AVb/iI/ShFLPdGRs73uCZ70eKfoaPmddT++S
	+0g==
X-Google-Smtp-Source: AGHT+IHRHNispYW5vs1jXOBSVq75OKtYcFcYRuAEh4jZLhpJkXnr4emt/EvlkNg20gd/mcSFGW2ts8m0Ozk=
X-Received: from edqg23.prod.google.com ([2002:aa7:c597:0:b0:5d9:1530:45a7])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:278f:b0:5d0:ed92:cdf6
 with SMTP id 4fb4d7f45d1cf-5d972e1c66bmr22388062a12.19.1736518885687; Fri, 10
 Jan 2025 06:21:25 -0800 (PST)
Date: Fri, 10 Jan 2025 14:21:22 +0000
In-Reply-To: <Z2ahOy7XaflrfCMw@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z2ahOy7XaflrfCMw@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250110142122.1013222-1-gnoack@google.com>
Subject: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without CAP_SYS_ADMIN
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jann Horn <jannh@google.com>, "=?UTF-8?q?Hanno=20B=C3=B6ck?=" <hanno@hboeck.de>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-hardening@vger.kernel.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With this, processes without CAP_SYS_ADMIN are able to use TIOCLINUX with
subcode TIOCL_SETSEL, in the selection modes TIOCL_SETPOINTER,
TIOCL_SELCLEAR and TIOCL_SELMOUSEREPORT.

TIOCL_SETSEL was previously changed to require CAP_SYS_ADMIN, as this IOCTL
let callers change the selection buffer and could be used to simulate
keypresses.  These three TIOCL_SETSEL selection modes, however, are safe to
use, as they do not modify the selection buffer.

This fixes a mouse support regression that affected Emacs (invisible mouse
cursor).

Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/ee3ec63269b43b34e1c90dd8c9743bf8@finder.org
Fixes: 8d1b43f6a6df ("tty: Restrict access to TIOCLINUX' copy-and-paste sub=
commands")
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
Changes in V2:

 * Removed comment in vt.c (per Greg's suggestion)

 * CC'd stable@

 * I *kept* the CAP_SYS_ADMIN check *after* copy_from_user(),
   with the reasoning that:

   1. I do not see a good alternative to reorder the code here.
      We need the data from copy_from_user() in order to know whether
      the CAP_SYS_ADMIN check even needs to be performed.
   2. A previous get_user() from an adjacent memory region already worked
      (making this a very unlikely failure)

I would still appreciate a more formal Tested-by from Hanno (hint, hint) :)

---
 drivers/tty/vt/selection.c | 14 ++++++++++++++
 drivers/tty/vt/vt.c        |  2 --
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 564341f1a74f..0bd6544e30a6 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -192,6 +192,20 @@ int set_selection_user(const struct tiocl_selection __=
user *sel,
 	if (copy_from_user(&v, sel, sizeof(*sel)))
 		return -EFAULT;
=20
+	/*
+	 * TIOCL_SELCLEAR, TIOCL_SELPOINTER and TIOCL_SELMOUSEREPORT are OK to
+	 * use without CAP_SYS_ADMIN as they do not modify the selection.
+	 */
+	switch (v.sel_mode) {
+	case TIOCL_SELCLEAR:
+	case TIOCL_SELPOINTER:
+	case TIOCL_SELMOUSEREPORT:
+		break;
+	default:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+	}
+
 	return set_selection_kernel(&v, tty);
 }
=20
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 96842ce817af..be5564ed8c01 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3345,8 +3345,6 @@ int tioclinux(struct tty_struct *tty, unsigned long a=
rg)
=20
 	switch (type) {
 	case TIOCL_SETSEL:
-		if (!capable(CAP_SYS_ADMIN))
-			return -EPERM;
 		return set_selection_user(param, tty);
 	case TIOCL_PASTESEL:
 		if (!capable(CAP_SYS_ADMIN))
--=20
2.47.1.613.gc27f4b7a9f-goog


