Return-Path: <stable+bounces-262842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 39E/BGpwK2qN9gMAu9opvQ
	(envelope-from <stable+bounces-262842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 04:35:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0726764BA
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 04:35:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262842-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262842-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4D2C31B1EC5
	for <lists+stable@lfdr.de>; Fri, 12 Jun 2026 02:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21C8371CE3;
	Fri, 12 Jun 2026 02:35:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355E02FD68B;
	Fri, 12 Jun 2026 02:35:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781231714; cv=none; b=dPblzXrO7VqVJlqPXCrKUgxyyDFoYH0O2ann46E7EVsWpW73U/a+jp/HHyxwXxl8/2hMD3uzmyrbzny1XPTKwZkvD7Ixm7BHJboc82zW6bz4KSML/fkxbKozcbh3IS2Ttu/WHWkA3ktIbvVwJcFl/sWnyZ4VJnjhlXYRecdGOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781231714; c=relaxed/simple;
	bh=GnPvr0rx7or1VZhyigtQ8oJrbp4PIK7Rs2ZBvENVvdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZkDj1TzC00gvSC7/5P9TNXhI7S64aYXpUHlqRyZdgcoltxUm0J/XWvhcnfgDR01W6zEP8sEHfZmT3ulqDAU5GffuavN4Mree4gPMV8ctncRAYUYimsdpqM3XCOs/ffLnZnfGYX61LFXIjc6Z1e7sXiYSfScAJB/NVxoCbMzPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-01 (Coremail) with SMTP id qwCowAAHqtJZcCtqPihcAQ--.10794S2;
	Fri, 12 Jun 2026 10:35:06 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: vulab@iscas.ac.cn,
	broonie@kernel.org,
	kees@kernel.org,
	cezary.rojewski@intel.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: control: fix refcount leak in snd_ctl_ioctl()
Date: Fri, 12 Jun 2026 10:35:03 +0800
Message-ID: <20260612023503.16698-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHqtJZcCtqPihcAQ--.10794S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1kKF48CrWrtrWDZFy3XFb_yoW8XF4Dpr
	s5WrZrGayrJr4fta42ka109r1fu3Z7CFsrGw48Gw1Iyw1fXwnxAr1jkw10yF4YkrykW3yY
	qrs0vryfJF9xCFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5i
	ihUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwsQA2orL1C1ogAAs2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	TAGGED_FROM(0.00)[bounces-262842-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:perex@perex.cz,m:tiwai@suse.com,m:vulab@iscas.ac.cn,m:broonie@kernel.org,m:kees@kernel.org,m:cezary.rojewski@intel.com,m:linux-sound@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E0726764BA

In snd_ctl_ioctl(), the TLV ioctl handlers (SNDRV_CTL_IOCTL_TLV_READ,
_WRITE, _COMMAND) call snd_power_ref_and_wait() to obtain a power
reference. That function always increments the card's power_ref count
even on failure, so any error return from these handlers must call
snd_power_unref(card) to balance the count.

The current code handles the 'err < 0' case by just returning err,
leaking a power reference each time an error occurs (e.g., when the
device is shutting down). Over time this can prevent the card from
being released properly.

Fix this by adding the missing snd_power_unref(card) before returning
on error in all three TLV ioctl cases.

Cc: stable@vger.kernel.org
Fixes: fcc62b19104a ("ALSA: control: Take power_ref lock primarily")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/core/control.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/control.c b/sound/core/control.c
index 7b714b5f8d54..e358e7463794 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -2028,8 +2028,10 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		return err;
 	case SNDRV_CTL_IOCTL_TLV_WRITE:
 		err = snd_power_ref_and_wait(card);
-		if (err < 0)
+		if (err < 0) {
+			snd_power_unref(card);
 			return err;
+		}
 		scoped_guard(rwsem_write, &card->controls_rwsem)
 			err = snd_ctl_tlv_ioctl(ctl, argp, SNDRV_CTL_TLV_OP_WRITE);
 		snd_power_unref(card);
-- 
2.50.1 (Apple Git-155)


