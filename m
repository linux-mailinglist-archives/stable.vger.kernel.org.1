Return-Path: <stable+bounces-76788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285FE97D195
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 09:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DDB61C22492
	for <lists+stable@lfdr.de>; Fri, 20 Sep 2024 07:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A174D8BC;
	Fri, 20 Sep 2024 07:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="m4Ky5MlS"
X-Original-To: stable@vger.kernel.org
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902047A5C;
	Fri, 20 Sep 2024 07:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726816453; cv=none; b=juN21+iRl7Peqqm54s5L8VokDkrPyFrzm2QJCMePIZpT7fONR8+RrGQYGfy6WuaOqVAg4uXyc9Tv4Cn7jBR2LmiDlqg8lq4rEX6qtrYqMh7tjW4XNK2Ny0O8pQJgjnMOKZUYehcu99Lh4yi6R14RqM0hAodwJ4KN1RIE8W+U0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726816453; c=relaxed/simple;
	bh=Ng1fd0X4c79Cmx1NfoQBHNzn/OWg1RNTNSNur7U8nPI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hxxKz6wODNtUTXB80sTAJA7OkFQEwizfWaj1pG/fugJULPZNWZBIMzobvxL237lvJ52tX0ZuspPjQ2MFEbcy4yLGmX6STmnBpNP7yoF3j6lMndU+Vr4pHcsuM4zFp/pPd29l9x71+paL2tmm4cb9zfEarFML4hUd7AU8QddiEAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=m4Ky5MlS; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 0B446108C193;
	Fri, 20 Sep 2024 10:08:11 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 0B446108C193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1726816091; bh=Al/1Tdd2zNa3NOqpripija2KtoWzvtAmlDr9SvF4i1o=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=m4Ky5MlSGy6XPxU/PI8CCMHa1CS41XdtamOH+rM88GVE5X5QSF4hcsynW8DHFiFeN
	 WgUEnAHjQN4VwHGy+PkkAX50j3GZVVfQ9A+I+XbNkqdKEjgvRkuwd6HdEEJemPQDrT
	 R4AgKSjOqwJ0c0wa0i0ys+722fFjF2hV3XPnI3Jo=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 0610930E9EF3;
	Fri, 20 Sep 2024 10:08:11 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Jiri Slaby <jirislaby@kernel.org>, Nicolas Pitre <nico@fluxnic.net>,
	"Sasha Levin" <sashal@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, Tetsuo Handa
	<penguin-kernel@i-love.sakura.ne.jp>, Andrew Morton
	<akpm@linux-foundation.org>, Daniel Starke <daniel.starke@siemens.com>,
	syzbot <syzbot+dbac96d8e73b61aa559c@syzkaller.appspotmail.com>, "Linus
 Torvalds" <torvalds@linux-foundation.org>
Subject: [PATCH 5.10/5.15 1/1] tty: add the option to have a tty reject a new
 ldisc
Thread-Topic: [PATCH 5.10/5.15 1/1] tty: add the option to have a tty reject a
 new ldisc
Thread-Index: AQHbCyvZbE9r/t6ykEiBblgd3NKiWw==
Date: Fri, 20 Sep 2024 07:08:10 +0000
Message-ID: <20240920070809.1145963-2-Ilia.Gavrilov@infotecs.ru>
References: <20240920070809.1145963-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20240920070809.1145963-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/09/20 05:26:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/09/20 04:11:00 #26640789
X-KLMS-AntiVirus-Status: Clean, skipped

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 6bd23e0c2bb6c65d4f5754d1456bc9a4427fc59b upstream.

... and use it to limit the virtual terminals to just N_TTY.  They are
kind of special, and in particular, the "con_write()" routine violates
the "writes cannot sleep" rule that some ldiscs rely on.

This avoids the

   BUG: sleeping function called from invalid context at kernel/printk/prin=
tk.c:2659

when N_GSM has been attached to a virtual console, and gsmld_write()
calls con_write() while holding a spinlock, and con_write() then tries
to get the console lock.

Tested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Daniel Starke <daniel.starke@siemens.com>
Reported-by: syzbot <syzbot+dbac96d8e73b61aa559c@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=3Ddbac96d8e73b61aa559c
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240423163339.59780-1-torvalds@linux-found=
ation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Ilia: In order to adapt this patch to branches 5.10 and 5.15,
the ldisc_ok() function description has been corrected in the old style.]
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 drivers/tty/tty_ldisc.c    |  6 ++++++
 drivers/tty/vt/vt.c        | 10 ++++++++++
 include/linux/tty_driver.h |  8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index c23938b8628d..dc5267ac9923 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -579,6 +579,12 @@ int tty_set_ldisc(struct tty_struct *tty, int disc)
 		goto out;
 	}
=20
+	if (tty->ops->ldisc_ok) {
+		retval =3D tty->ops->ldisc_ok(tty, disc);
+		if (retval)
+			goto out;
+	}
+
 	old_ldisc =3D tty->ldisc;
=20
 	/* Shutdown the old discipline. */
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index a070f2e7d960..d16b7bdbd442 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3448,6 +3448,15 @@ static void con_cleanup(struct tty_struct *tty)
 	tty_port_put(&vc->port);
 }
=20
+/*
+ * We can't deal with anything but the N_TTY ldisc,
+ * because we can sleep in our write() routine.
+ */
+static int con_ldisc_ok(struct tty_struct *tty, int ldisc)
+{
+	return ldisc =3D=3D N_TTY ? 0 : -EINVAL;
+}
+
 static int default_color           =3D 7; /* white */
 static int default_italic_color    =3D 2; // green (ASCII)
 static int default_underline_color =3D 3; // cyan (ASCII)
@@ -3576,6 +3585,7 @@ static const struct tty_operations con_ops =3D {
 	.resize =3D vt_resize,
 	.shutdown =3D con_shutdown,
 	.cleanup =3D con_cleanup,
+	.ldisc_ok =3D con_ldisc_ok,
 };
=20
 static struct cdev vc0_cdev;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
index 2f719b471d52..315e475e6a09 100644
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -123,6 +123,13 @@
  *	Optional: Called under the termios lock
  *
  *
+ * int (*ldisc_ok)(struct tty_struct *tty, int ldisc);
+ *
+ *	This routine allows the tty driver to decide if it can deal
+ *	with a particular ldisc.
+ *
+ *	Optional. Called under the tty->ldisc_sem and tty->termios_rwsem.
+ *
  * void (*set_ldisc)(struct tty_struct *tty);
  *
  * 	This routine allows the tty driver to be notified when the
@@ -270,6 +277,7 @@ struct tty_operations {
 	void (*hangup)(struct tty_struct *tty);
 	int (*break_ctl)(struct tty_struct *tty, int state);
 	void (*flush_buffer)(struct tty_struct *tty);
+	int (*ldisc_ok)(struct tty_struct *tty, int ldisc);
 	void (*set_ldisc)(struct tty_struct *tty);
 	void (*wait_until_sent)(struct tty_struct *tty, int timeout);
 	void (*send_xchar)(struct tty_struct *tty, char ch);
--=20
2.39.2

