Return-Path: <stable+bounces-236435-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOtDCO4Z3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236435-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:29:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B333EF151
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D81A130CF850
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A078127466A;
	Mon, 13 Apr 2026 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zvVn7sJF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633372472A2;
	Mon, 13 Apr 2026 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096898; cv=none; b=N6COwXFffeOD+q0ky6tjNljld9rSeFhbtlQPZ2RaqtZZ190auUvbCdKokH2ypn6a2iVcTRDEiPNv8bzkFRhBXVH27ZG7On2jtf5HQv7JCGlSGLUuneOWe5UEz2wCrJEnHLSSa6yHL8VL+8dLqWpllqHfBqokRvjHOPrw7BNyDq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096898; c=relaxed/simple;
	bh=mZqd0+emlz8rpXfNEwdZ8XweCs5YabxeFgJ59V7rV34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eo9NpPF2OIOBf3SNIWjROhpuB3IfDax9tD+kQgHKMoAI56H3VmLknntGtogOYRUGSAiiD003VKkDpQbL7X7HMu16PvE6ojaN5sXOAEBU+bxUzILYAI3y8rezIR72Qn9rwKTOIAcDxxT5Cw5a7rXf6vc/FW0uIMFpS5KWui+YRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zvVn7sJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F84C2BCAF;
	Mon, 13 Apr 2026 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096898;
	bh=mZqd0+emlz8rpXfNEwdZ8XweCs5YabxeFgJ59V7rV34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zvVn7sJF8pDA0UcE0jAJtVuFSAuukShBLGcCPwS7BsALgv12KOBYOMYJZg+bzJCj/
	 zVXDTTX4bXCtmRAopuEqkUi3AhIT86Hl8zePlfoHROS3aKhLhq/lvOJZhHthlaIAfA
	 bwRTi2eQOpbbQtlAJ3Ij4z3lxb7DeBu+pEbltkQA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.6 07/50] Input: uinput - take event lock when submitting FF request "event"
Date: Mon, 13 Apr 2026 18:00:34 +0200
Message-ID: <20260413155724.781244493@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155724.497323914@linuxfoundation.org>
References: <20260413155724.497323914@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-236435-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: B9B333EF151
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit ff14dafde15c11403fac61367a34fea08926e9ee upstream.

To avoid racing with FF playback events and corrupting device's event
queue take event_lock spinlock when calling uinput_dev_event() when
submitting a FF upload or erase "event".

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://patch.msgid.link/adXkf6MWzlB8LA_s@google.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/uinput.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -25,8 +25,10 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/lockdep.h>
 #include <linux/miscdevice.h>
 #include <linux/overflow.h>
+#include <linux/spinlock.h>
 #include <linux/input/mt.h>
 #include "../input-compat.h"
 
@@ -76,6 +78,8 @@ static int uinput_dev_event(struct input
 	struct uinput_device	*udev = input_get_drvdata(dev);
 	struct timespec64	ts;
 
+	lockdep_assert_held(&dev->event_lock);
+
 	ktime_get_ts64(&ts);
 
 	udev->buff[udev->head] = (struct input_event) {
@@ -147,6 +151,7 @@ static void uinput_request_release_slot(
 static int uinput_request_send(struct uinput_device *udev,
 			       struct uinput_request *request)
 {
+	unsigned long flags;
 	int retval = 0;
 
 	spin_lock(&udev->state_lock);
@@ -160,7 +165,9 @@ static int uinput_request_send(struct ui
 	 * Tell our userspace application about this new request
 	 * by queueing an input event.
 	 */
+	spin_lock_irqsave(&udev->dev->event_lock, flags);
 	uinput_dev_event(udev->dev, EV_UINPUT, request->code, request->id);
+	spin_unlock_irqrestore(&udev->dev->event_lock, flags);
 
  out:
 	spin_unlock(&udev->state_lock);



