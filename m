Return-Path: <stable+bounces-73666-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC0D96E45C
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 22:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDEA288B8D
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 20:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDF41A4E70;
	Thu,  5 Sep 2024 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NoR3MkiV"
X-Original-To: stable@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB2F1A76AF;
	Thu,  5 Sep 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725569261; cv=none; b=MV+wrSGCGr2WUW/6yQYFfZPhupQZg51Hvwv7TszViUAWQnOrI30G2Xa6Kn3/8KmUJ16xsaN7Cnp8MlrP6R9IFdCrRO75ygh1hIIvKopwp1znhPNdn/cq64NDsY/6NBYSuUkTw+5QJk+5C65/23+hMrAWJcfo94hFgmOVdOLHFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725569261; c=relaxed/simple;
	bh=qsJw1HcUe7Gj/mQM1O3YLvKuT9ECBKUAznlArU8F344=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhqMWOCJy6xq85pEypcHZy1t2m2n9URX4HlsKwTUGDXJPbP1WjUsrjwBNhDMhuvflNVV9nYIuppM5NufyS6SuP5xyGnG10oukp38q94FkPe77Nl3bHTSZyl3wRTu2fgjvbuCLyOX39Rh7HnQRJVGROotIWJfogqs5wsn5CUKQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NoR3MkiV; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4X0BJC2GHgzlgMVN;
	Thu,  5 Sep 2024 20:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1725569254; x=1728161255; bh=DQspN
	xAEnqiT6HWVkGfG0pG8H7Ac6GOoJnrw0mezREg=; b=NoR3MkiVPNYIIYRr3Sdyv
	IABUNEiuaVoLBj8rJuIsEToPFWCAOndvXZ/kLiqb4eRoUFn+H+zhYgxVZSRfXI15
	c3HknjPW0k/hccUIWZqGTpwOFCegyzbai8SDjzCuu6vAkFpwlAw5nKQ4zPUqrgLT
	2ugpEYshUlb86F/ibUxswhtNzSuZzwUpMgy6yrX3dIfN0wqGcmC5D7/z5ZqRQXJr
	rNOewFuH0WEwWr87hyKfncCBkGujTMo7+20U39d/Do1DlYRQP/i741xTuO7MoZy0
	zptETRiOAMSKBk6bDpqbyTk2vnjb6R4lOs6rJG/6JHW7jkgu3jfUKKLtTLP3x7rt
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 75uldK_sVijw; Thu,  5 Sep 2024 20:47:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4X0BJ53FM1zlgMVP;
	Thu,  5 Sep 2024 20:47:33 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Amit Sunil Dhamne <amitsd@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Badhri Jagan Sridharan <badhri@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] usb: roles: Fix a false positive recursive locking complaint
Date: Thu,  5 Sep 2024 13:47:09 -0700
Message-ID: <20240905204709.556577-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240905204709.556577-1-bvanassche@acm.org>
References: <20240905204709.556577-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Suppress the following lockdep complaint by giving each sw->lock
a unique lockdep key instead of using the same lockdep key for all
sw->lock instances:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Badhri Jagan Sridharan <badhri@google.com>
Cc: stable@vger.kernel.org
Fixes: fde0aa6c175a ("usb: common: Small class for USB role switches")
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/usb/roles/class.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index 7aca1ef7f44c..37556aa0eeee 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -22,6 +22,7 @@ static const struct class role_class =3D {
=20
 struct usb_role_switch {
 	struct device dev;
+	struct lock_class_key key;
 	struct mutex lock; /* device lock*/
 	struct module *module; /* the module this device depends on */
 	enum usb_role role;
@@ -329,6 +330,8 @@ static void usb_role_switch_release(struct device *de=
v)
 {
 	struct usb_role_switch *sw =3D to_role_switch(dev);
=20
+	mutex_destroy(&sw->lock);
+	lockdep_unregister_key(&sw->key);
 	kfree(sw);
 }
=20
@@ -367,7 +370,8 @@ usb_role_switch_register(struct device *parent,
 	if (!sw)
 		return ERR_PTR(-ENOMEM);
=20
-	mutex_init(&sw->lock);
+	lockdep_register_key(&sw->key);
+	mutex_init_with_key(&sw->lock, &sw->key);
=20
 	sw->allow_userspace_control =3D desc->allow_userspace_control;
 	sw->usb2_port =3D desc->usb2_port;

