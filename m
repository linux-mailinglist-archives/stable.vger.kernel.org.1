Return-Path: <stable+bounces-230714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ML22M9vbxmkoPQUAu9opvQ
	(envelope-from <stable+bounces-230714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:34:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBC934A36F
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 20:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 67C79301BA53
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC8C2F12C6;
	Fri, 27 Mar 2026 19:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXwjAzVB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA172E8882
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639461; cv=none; b=f5GsKCUq3Up6bbRDWkCyNw/NpYFisZQQbRQpYjWDMTubaCocFJdlX8+eEF970zocHVy7pLfwHEWAwIBgciooPph6OfKXADDVZIp/pS9i5nuKcFdiTGAv6jnuSJOOnOyIrvv56L6tlpEyv98B63j/jDWSCktQWdIF6g7jgWG/7w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639461; c=relaxed/simple;
	bh=rluKZ4GNgHw5m1UevyUUuL0azCAMdHmPw2X6TkYJiKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBhstPy6K/RX1bHo6oeFrXqgVtGaKIqrjhQ1jvu87JeLcdJsSZv7qq/Va+JnDEPNpJO4rOFOR6XPTXU5ttFtJaLvlmxk4WieED414D0L/UAKRbJcPRlKnw5ivEAnUwyuZj9wWgrDiEc4v69+82v46IxVx84DsdJ5TFWzCbaArrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXwjAzVB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43b7481f9d3so1438311f8f.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 12:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774639458; x=1775244258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFbXTjy4NMbpj8pvI5YlNDL7NdTaJ2uAwsFcgGj2Y3A=;
        b=cXwjAzVBBFnI1hzS9QareltxaMVVXhvIlDFlfX3Y/RbrRoXzr4wjMGf7SlHU4ONaCb
         euG4sIOnECMSeQaMlwbpZUHbho80OGD/DC3iz5FfShMsjPgXSjnucLffxuAA0KHFD8sM
         ojzpmmASL7+s2K9p+yhkse5RFT4PTA9IBqQImfuXUSK3vnlSwl5uQdNm1PAbHFxS7J6N
         jJI4HMkEySWUjEZYnWhDuSOiZHxKbw9/0dJO2hxcbg5gKteVoW+WHSmMr7N2Eoq2dEUq
         79hgEeK6cYlPb6uFPGT2JGeI8SWBL6LYOPWnTbUxMBhdqTCcacazWsfjno7bSNRRKUFz
         /j5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774639458; x=1775244258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFbXTjy4NMbpj8pvI5YlNDL7NdTaJ2uAwsFcgGj2Y3A=;
        b=Si7vII04ELU7oMh5BOxqHJtVBFSowxwZYc26VUAbTC3fpTINfnW59yQGS5z/KLV+ee
         19AC8SX++u4a0Ezd6Ou9doBVm3OKj9YqP22pjJeffzgyy6mhjCcH5PeljBEL+1A+CTJj
         Z914OWYKQZ/jxn39557gHntHu9KiJB+3/e0h1CdrtMVtnBaQ/3Ea1DuwozAjnJuqdIkB
         ur3QvzJzmcs5XPurSxWjR09krNXkNnZVXzq/Y9SFJps9rn33E96whmbv/2fn2FSi7Pbl
         4uVLo1r5gJHzvAkNNDsKdsFHcQ5pHoxSFKxnpEiy/MAZc0E7V876MAf9auNe5Ofh2kcN
         pWSg==
X-Forwarded-Encrypted: i=1; AJvYcCVbtw7aM0K3wE2AVaeXjIG+tTP3n7tTWE7huLSDGbr9N6OzWrfy7QPMXynWz3N/FkS8U13/16U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7mVi46eDaqGegJZUmCXdDosgZqlaoTFbOh227VEyEE35jDiu
	NLx/3Bepf+f9E2sFsc4Dy0MKjQVmvz7iuXbh7D2aBtZAM68LG5nU7Z/iQhJ4Yb3RHKE=
X-Gm-Gg: ATEYQzzcjt8Wq20+KQSBpmvTCK5RCtebTHBMXfmp92bnRBVaDPFcPtgnz/ZdPiuEPcc
	jfZyPtYVnZiu16F2X6ZqxJXn5CoIi+3a4al7J2qCZrTFDtiXYLt2YqLSZanW2XnN5HBNwfPf/M9
	KVKTcjmPiWDEAGfoqroHcl1bgGxlTPZKv8BIWmzG0RsiqOwipMr72cQKTniBg47jtnqEeN2KnyF
	xS6ZuPHK05JdbZg1/s++RZtYLS72Hhx7JqW7FD6v7nIMfaMBFZ1gaiNHuqOEdw8xs6TmbvzbUMN
	Jw6wOrmnVCD3IXKiqYEOL8eMotEgYDxi5kUQqCaH6scd1ys6dyIoPeqllzKOOJxs8XYeXwQm7Ns
	zVkNu2ZSALWDTQ4FO+mKRnaZd+nOIsjLrjbknFSb1UKBA7lXvzn3IQAzUbYQLgncdCCR38Ivray
	vGxoPBHTQF2mIoG7A/6ZggdEW1s1r++Qj/y5hQ61EOaa2JVOVwqTLwgPXX3byHfZGIhKUielwrg
	dosLD20Mej/8+U=
X-Received: by 2002:a05:6000:3105:b0:439:c799:dbfa with SMTP id ffacd0b85a97d-43b9e9d97d5mr5819506f8f.9.1774639458215;
        Fri, 27 Mar 2026 12:24:18 -0700 (PDT)
Received: from toolbox ([2a00:1e:8743:9700:a5c1:58f4:f0a9:10cd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2463dc2sm171956f8f.23.2026.03.27.12.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 12:24:17 -0700 (PDT)
From: Michael Zimmermann <sigmaepsilon92@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Michael Zimmermann <sigmaepsilon92@gmail.com>
Subject: [PATCH] usb: gadget: f_hid: don't call cdev_init while cdev in use
Date: Fri, 27 Mar 2026 20:22:09 +0100
Message-ID: <20260327192209.59945-1-sigmaepsilon92@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-230714-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigmaepsilon92@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBBC934A36F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When calling unbind, then bind again, cdev_init reinitialized the cdev,
even though there may still be references to it. That's the case when
the /dev/hidg* device is still opened. This obviously unsafe behavior
like oopes.

This fixes this by using cdev_alloc to put the cdev on the heap. That
way, we can simply allocate a new one in hidg_bind.

Closes: https://lore.kernel.org/linux-usb/CAN9vWDKZn0Ts5JyV2_xcAmbnBEi0znMLg_USMFrShRryXrgWGQ@mail.gmail.com/T/#m2cb0dba3633b67b2a679c98499508267d1508881
Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
---
 drivers/usb/gadget/function/f_hid.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 8812ebf33d14..66be2e1282c1 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -106,7 +106,7 @@ struct f_hidg {
 	struct list_head		report_list;
 
 	struct device			dev;
-	struct cdev			cdev;
+	struct cdev			*cdev;
 	struct usb_function		func;
 
 	struct usb_ep			*in_ep;
@@ -749,8 +749,9 @@ static int f_hidg_release(struct inode *inode, struct file *fd)
 
 static int f_hidg_open(struct inode *inode, struct file *fd)
 {
+	struct kobject *parent = inode->i_cdev->kobj.parent;
 	struct f_hidg *hidg =
-		container_of(inode->i_cdev, struct f_hidg, cdev);
+		container_of(parent, struct f_hidg, dev.kobj);
 
 	fd->private_data = hidg;
 
@@ -1285,8 +1286,12 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	}
 
 	/* create char device */
-	cdev_init(&hidg->cdev, &f_hidg_fops);
-	status = cdev_device_add(&hidg->cdev, &hidg->dev);
+	hidg->cdev = cdev_alloc();
+	if (!hidg->cdev)
+		goto fail_free_all;
+	hidg->cdev->ops = &f_hidg_fops;
+
+	status = cdev_device_add(hidg->cdev, &hidg->dev);
 	if (status)
 		goto fail_free_all;
 
@@ -1588,7 +1593,7 @@ static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_hidg *hidg = func_to_hidg(f);
 
-	cdev_device_del(&hidg->cdev, &hidg->dev);
+	cdev_device_del(hidg->cdev, &hidg->dev);
 	destroy_workqueue(hidg->workqueue);
 	usb_free_all_descriptors(f);
 }
-- 
2.53.0


