Return-Path: <stable+bounces-261621-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I3WxNYNOJWqnGgIAu9opvQ
	(envelope-from <stable+bounces-261621-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:57:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3430B65027E
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:57:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=HZs+c1+8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261621-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261621-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2CE93046FE9
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5752E7376;
	Sun,  7 Jun 2026 10:47:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E11A6822;
	Sun,  7 Jun 2026 10:47:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829246; cv=none; b=XYiytxt5xqK0Sk7ZY+FKVGYyggJxiHWBsuwRDckGzHGzwFQQSjFLpD3L8OpJlt59XNNR7WhH2fnhnQWAzbmBBrrD08Fkqymv+5IOf6TrT+x1updJoTFZrMP1GrmpJfRtyEgFESKIB9nvqMvqK2BP+fQYSsWVNUAyP1NNSFWhlpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829246; c=relaxed/simple;
	bh=DDDLn6tjg+ZfBpwdQ7ZY6k9jC2Dgyc19ZEHh90VaCMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gaO6o6wkqvKT/Gb4bpn0E4J8tNH+r4cuKDnwohP9SGyt8rc3e6MTepPB1XNN91Hv9DNF7wADB5WrctLZZBrUXHo9EkQMYR5f/Ei0avLLXOj71g5c0nU+mT3Fi+ysqEqih1YzyOrbhHwjUnKUDokvzbv68NAzrkpkB39J8lDEpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZs+c1+8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F5F1F00893;
	Sun,  7 Jun 2026 10:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829244;
	bh=IW3quQQNkKU4hjs80JuXdz2iXeN039rlN8LjFfr5e/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZs+c1+866gkKKsEUF7sVHcuVZ/78rEScl2GAYKiFQT62LGpjbnX3YnE0L4Dyy8Qp
	 bGn/IV3wGNmI5C7SVM8QTBC64RO2VNkWZJhG/Iht6lurz9QMg/5B5Rf4p2Kvr1CbqR
	 e8klsMD7oFXHwbW0ZmQBSh042K8fs3IR6pFbJH0I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Zheng Wang <zyytlz.wz@163.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 7.0 257/332] usbip: vudc: Fix use after free bug in vudc_remove due to race condition
Date: Sun,  7 Jun 2026 12:00:26 +0200
Message-ID: <20260607095737.480779020@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,163.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-261621-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:zyytlz.wz@163.com,m:michael.bommarito@gmail.com,m:skhan@linuxfoundation.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3430B65027E

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit d96209626a29ea64666be98c30b30ac82e5f1be6 upstream.

This patch follows up Zheng Wang's 2023 report of a use-after-free in
vudc_remove(). The original thread stalled on Shuah Khan's request for
runtime testing of the unplug/unbind path. This patch supplies that
testing and keeps Zheng's original fix shape.

In vudc_probe(), v_init_timer() binds udc->tr_timer.timer to v_timer().
usbip_sockfd_store() starts the timer via v_start_timer()/v_kick_timer().
vudc_remove() can then free the containing struct vudc while the timer is
still pending or executing.

KASAN confirms the race on an unpatched x86_64 QEMU guest with
CONFIG_KASAN=y, CONFIG_USBIP_VUDC=y, CONFIG_USB_ZERO=y, and a tight loop
that repeatedly writes a socket fd to usbip_sockfd, closes the socket
pair, and unbinds/rebinds usbip-vudc.0:

  BUG: KASAN: slab-use-after-free in __run_timer_base.part.0+0x8ba/0x8e0
  Write of size 8 at addr ffff888001b80740 by task trigger_and_unb/239
  Allocated by task 239:
    vudc_probe+0x4d/0xaa0
  Freed by task 239:
    kfree+0x18f/0x520
    device_release_driver_internal+0x388/0x540
    unbind_store+0xd9/0x100

This lands in the timer core rather than v_timer() itself because the
embedded timer_list is being walked after its containing struct vudc has
already been freed. The underlying lifetime bug is the same one Zheng
reported.

With v_stop_timer() called from vudc_remove() and the timer deleted
synchronously, the same harness completed 5000 bind/unbind iterations
with no KASAN report.

Fixes: b6a0ca111867 ("usbip: vudc: Add UDC specific ops")
Cc: stable <stable@kernel.org>
Reported-by: Zheng Wang <zyytlz.wz@163.com>
Closes: https://lore.kernel.org/linux-usb/20230317100954.2626573-1-zyytlz.wz@163.com/
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://patch.msgid.link/20260417163552.807548-1-michael.bommarito@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/usbip/vudc_dev.c      |    1 +
 drivers/usb/usbip/vudc_transfer.c |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -632,6 +632,7 @@ void vudc_remove(struct platform_device
 {
 	struct vudc *udc = platform_get_drvdata(pdev);
 
+	v_stop_timer(udc);
 	usb_del_gadget_udc(&udc->gadget);
 	cleanup_vudc_hw(udc);
 	kfree(udc);
--- a/drivers/usb/usbip/vudc_transfer.c
+++ b/drivers/usb/usbip/vudc_transfer.c
@@ -490,7 +490,8 @@ void v_stop_timer(struct vudc *udc)
 {
 	struct transfer_timer *t = &udc->tr_timer;
 
-	/* timer itself will take care of stopping */
+	/* Delete the timer synchronously before teardown frees udc. */
 	dev_dbg(&udc->pdev->dev, "timer stop");
+	timer_delete_sync(&t->timer);
 	t->state = VUDC_TR_STOPPED;
 }



