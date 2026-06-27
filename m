Return-Path: <stable+bounces-269348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b3UFIvZMP2pARQkAu9opvQ
	(envelope-from <stable+bounces-269348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 06:09:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F76D118F
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 06:09:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269348-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-269348-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BECB9300B538
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 04:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AB3388394;
	Sat, 27 Jun 2026 04:09:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA42459D1;
	Sat, 27 Jun 2026 04:09:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782533359; cv=none; b=l/uhINk961jFUL9J8vAnoHCT+38wOdrecBgdxYlrdlJw0sgOGsQHsgRhWmACzYcxk2jHHfPi7rI2DhaIjMJTiJupCSU6GfNUq/E83DOoThgesPCVm/qijQoKKw2e/ZvCSrJ/AY1t347GhSXbXQSRokfVzmrF96mSC+FtvDXaZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782533359; c=relaxed/simple;
	bh=GtPUSB1RFjwFZZyr7jWp0vtOCYMSfjvAaMpplHyl8sg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F0sltiDR37Ov8f0MFSe2UI9c2dhNNxjQq5PbdbPNDDe6LvY9KI98l9+6pDtiBjkYuQoX4tfA0yS4StJ9E9b2fieUBLNi5EYnETnoENTP5CeXd6EpT+FCyhbLXaFUnzUjgCbOTjzauZLW3BVWJ+lg5L8wkArSm07FSk11JGd1ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowABnB9DlTD9qoSeCAw--.6498S2;
	Sat, 27 Jun 2026 12:09:11 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: kees@kernel.org,
	vulab@iscas.ac.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fix: sound/usb: snd_media_device_create: incorrect media_device_delete on borrowed reference
Date: Sat, 27 Jun 2026 12:09:07 +0800
Message-Id: <20260627040907.60784-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnB9DlTD9qoSeCAw--.6498S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4Dtw1fAw4fZrykGw13CFg_yoW8ur4DpF
	48KFyUJrWUXw4Dtw4UWw1kWF1Y9wn8ta1fCw4xXwsIgr4fJasaq34qg3WSv3y7CrWkKa4j
	qr47Wry8uryrGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbVOJ7
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMLA2o-DxB2sQAEsb
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-269348-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:perex@perex.cz,m:tiwai@suse.com,m:kees@kernel.org,m:vulab@iscas.ac.cn,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A9F76D118F

In snd_media_device_create(), when chip->media_dev is already set, mdev
borrows the reference without incrementing the refcount. On error paths
through create_fail, media_device_delete() is called which releases the
borrowed reference, corrupting the reference count. Additionally,
chip->media_dev is set to NULL, losing the original reference.

Introduce an 'allocated' flag to distinguish between borrowed and
self-allocated references, and only call media_device_delete() when the
reference was actually acquired by this function invocation.

Cc: stable@vger.kernel.org
Fixes: 66354f18fe5f ("media: sound/usb: Use Media Controller API to share media resources")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/usb/media.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/usb/media.c b/sound/usb/media.c
index b7497d18ee3f..290bd24bf301 100644
--- a/sound/usb/media.c
+++ b/sound/usb/media.c
@@ -255,6 +255,7 @@ int snd_media_device_create(struct snd_usb_audio *chip,
 	struct media_device *mdev;
 	struct usb_device *usbdev = interface_to_usbdev(iface);
 	int ret = 0;
+	bool allocated = false;
 
 	/* usb-audio driver is probed for each usb interface, and
 	 * there are multiple interfaces per device. Avoid calling
@@ -272,6 +273,7 @@ int snd_media_device_create(struct snd_usb_audio *chip,
 
 	/* save media device - avoid lookups */
 	chip->media_dev = mdev;
+	allocated = true;
 
 snd_mixer_init:
 	/* Create media entities for mixer and control dev */
@@ -292,9 +294,11 @@ int snd_media_device_create(struct snd_usb_audio *chip,
 create_fail:
 		if (ret) {
 			snd_media_mixer_delete(chip);
-			media_device_delete(mdev, KBUILD_MODNAME, THIS_MODULE);
-			/* clear saved media_dev */
-			chip->media_dev = NULL;
+			if (allocated) {
+				media_device_delete(mdev, KBUILD_MODNAME, THIS_MODULE);
+				/* clear saved media_dev */
+				chip->media_dev = NULL;
+			}
 			dev_err(&usbdev->dev,
 				"Couldn't register media device. Error: %d\n",
 				ret);
-- 
2.39.5 (Apple Git-154)


