Return-Path: <stable+bounces-268588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8deuC9JGPWqs0ggAu9opvQ
	(envelope-from <stable+bounces-268588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:18:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A476C7003
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 17:18:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268588-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268588-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F30C30879D9
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81DA3E8330;
	Thu, 25 Jun 2026 15:16:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289053A75B8;
	Thu, 25 Jun 2026 15:16:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400607; cv=none; b=uBQBJiqm5FK6nhx3t+WoHt9+heHyheiW+u8ofmf9VoU5RTAAYKmmv43BLKTiC+1IrbesBh0GWl81rzOkcdlNWuWWqXMv2nvT331c20ydaYlstM/Et6ipEZt66GZk11+vMGdYiICL+l1LMLLxOKUKL4mVPD/3IAMqpqt0Uoq8Uaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400607; c=relaxed/simple;
	bh=5tiUYLobpfAyf7PHa9U4KBOHa0KSi5lZCgKiQ+VdnLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+A4uUT2iKK9BGLgX4JqlHnjC0Y4h8c6+I1GpqUUys0+NCoGfqGyyCqGX0Onj2YMeCOIyijLJwCompyQlPH5HISvo+NhUHMEOiMswJ6EIardiuEin0sxG2d+y6BQsIs77rtDLHxcWI4YJ2yK3pemOFGiiB4TJeUr6bMjH9N2iSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-03 (Coremail) with SMTP id rQCowACHerFWRj1qsU7UFQ--.9911S2;
	Thu, 25 Jun 2026 23:16:39 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drbd: Fix local_cnt refcount leak on ascw allocation failure in _drbd_set_state
Date: Thu, 25 Jun 2026 23:16:36 +0800
Message-Id: <20260625151636.72599-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHerFWRj1qsU7UFQ--.9911S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47Cw1DKryxJryxtr15XFb_yoW8ZF4UpF
	sxGrW7KryUK3yfKFnrJw409Fs5Ka1kt34rKr92yw1a9wsxGr1fA3s0yFW7Xay5Ar93Jr4r
	Xa42yryv9rWYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU13ku3UUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAcJA2o9Q+oF3QAAsn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268588-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:philipp.reisner@linbit.com,m:lars.ellenberg@linbit.com,m:christoph.boehmwalder@linbit.com,m:axboe@kernel.dk,m:drbd-dev@lists.linbit.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86A476C7003

In _drbd_set_state(), when transitioning a device to D_FAILED or
D_DISKLESS, an extra reference on local_cnt is taken via
atomic_inc(&device->local_cnt) to prevent premature destruction of
the local disk. This reference is normally released by put_ldev()
in after_state_ch(), which is called asynchronously through the
after_state_chg_work (ascw) work item.

If the GFP_ATOMIC allocation of the ascw work item fails, the work
is never queued, after_state_ch() never runs, and the extra
local_cnt reference is permanently leaked. Additionally, the
state_change object allocated by remember_old_state() is also
leaked, along with the krefs it acquired on the resource,
connections, and devices.

Fix both leaks in the ascw allocation failure path:
 - Call put_ldev() to release the extra local_cnt reference when
   the transition matches the same conditions used for the
   atomic_inc.
 - Call forget_state_change() to free the state_change object and
   release the krefs it holds.

Cc: stable@vger.kernel.org
Fixes: d01801710265 ("drbd: Remove the terrible DEV hack")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/block/drbd/drbd_state.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index adcba7f1d8ea..68e273c6d5be 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1480,7 +1480,13 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 		drbd_queue_work(&connection->sender_work,
 				&ascw->w);
 	} else {
-		drbd_err(device, "Could not kmalloc an ascw\n");
+		if ((os.disk != D_FAILED && ns.disk == D_FAILED) ||
+		    (os.disk != D_DISKLESS && ns.disk == D_DISKLESS))
+			put_ldev(device);
+
+		forget_state_change(state_change);
+		drbd_err(device, "Could not kmalloc an ascw, state change %p -> %p leaked\n",
+			 &os, &ns);
 	}
 
 	return rv;
-- 
2.39.5 (Apple Git-154)


