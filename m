Return-Path: <stable+bounces-73100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D160196C840
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 22:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A468281538
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 20:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC901386A7;
	Wed,  4 Sep 2024 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ltJ3yTsM"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7605E13D532;
	Wed,  4 Sep 2024 20:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481142; cv=none; b=EzE9Fpu8JI1zvpNfE2dVHJdpNk22eig7LU05ZGkSmUntSU+Dd2iEE5VwqCOovMg/WVMKd77ZBd6a+ZirKvMeoQgfKHnxaWWkBH11WHk/FAu1x33YWLCY9VQwlPCoApt0NaTviQrQQCiyo+czQEStE+zWRaTQFR4Z33jkk0NF7Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481142; c=relaxed/simple;
	bh=MAXsiQtJ6WIl6u3XvM9qP/wKwbWvsT+xDAqv0LL9ov0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AvHdMN5R1oizYqjftZIMs5t5lnbbVmoDRRMy/ZJbl3KoR6Ju2RP92lnboaLlwKuQLTI8CN9r7piRY2HONR89KcRxAxB1RYAhCrUNZrGcFrMVziAy/1PrgsUL09lv5Xw+5q5e3Ldz4AxI92z10pr07eB6qgujeKcs0RmMPZnjNtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ltJ3yTsM; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WzYjb63Cnz6ClY8s;
	Wed,  4 Sep 2024 20:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1725481136; x=1728073137; bh=x+LXEvQo2gdj5yh0a6NeCfTwRObOEro4wzw
	PVHiV6LM=; b=ltJ3yTsMl4gmtEGn21e4mo6Jxztl0pklFFJGFlmV9tZBIM6kquC
	/zAh4qMx2YOf4GlXXJyDtCnQ/hUHe5eWE2BI8SgJX7ni9jfkuICK+XyqiXH9mJ/R
	FRJDg+mJEVzp3y8hqEJNCcopdCo+SDUj80/ELuFPz1c7ADw9Okrb1PrYcbi59Vbd
	CKoVHuN+G2oIYD4aqCxbbcUhAgdva650MCCwoW6xZJvIKTYUEMUfatOt9vRqjPqH
	3k7u404hk0UW9rkmaQbFmUXI6yM8GjbKF9mV3TQkufDavg2Silo9dfTe7tZ1wnNt
	in3umpm9zpbS77yQ1CJmGD4U5NtdDB1Oa0Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ytUEYCZNuGPI; Wed,  4 Sep 2024 20:18:56 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WzYjW02lVz6ClY8q;
	Wed,  4 Sep 2024 20:18:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: roles: Fix a false positive recursive locking complaint
Date: Wed,  4 Sep 2024 13:18:39 -0700
Message-ID: <20240904201839.2901330-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Suppress the following lockdep complaint:

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.

Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Fixes: fde0aa6c175a ("usb: common: Small class for USB role switches")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/usb/roles/class.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index d7aa913ceb8a..f648ce3dd9b5 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -21,6 +21,7 @@ static const struct class role_class =3D {
=20
 struct usb_role_switch {
 	struct device dev;
+	struct lock_class_key key;
 	struct mutex lock; /* device lock*/
 	struct module *module; /* the module this device depends on */
 	enum usb_role role;
@@ -326,6 +327,8 @@ static void usb_role_switch_release(struct device *de=
v)
 {
 	struct usb_role_switch *sw =3D to_role_switch(dev);
=20
+	mutex_destroy(&sw->lock);
+	lockdep_unregister_key(&sw->key);
 	kfree(sw);
 }
=20
@@ -364,7 +367,8 @@ usb_role_switch_register(struct device *parent,
 	if (!sw)
 		return ERR_PTR(-ENOMEM);
=20
-	mutex_init(&sw->lock);
+	lockdep_register_key(&sw->key);
+	__mutex_init(&sw->lock, "usb_role_switch_desc::lock", &sw->key);
=20
 	sw->allow_userspace_control =3D desc->allow_userspace_control;
 	sw->usb2_port =3D desc->usb2_port;

