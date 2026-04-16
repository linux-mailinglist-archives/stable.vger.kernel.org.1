Return-Path: <stable+bounces-238261-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHfrNRyE4GmmiwAAu9opvQ
	(envelope-from <stable+bounces-238261-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:39:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D0740AB51
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23A203004DBD
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 06:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2FF37A4B7;
	Thu, 16 Apr 2026 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20251104.gappssmtp.com header.i=@u-northwestern-edu.20251104.gappssmtp.com header.b="EqpUhvgr"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B66157487
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 06:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776321556; cv=none; b=KYQ5ihbC13Q9ZBEe59b89YTuR569VJ+OT+foxWe58a4OhS2vdhq5IHr+WjB+YIRT8LV4HzVR7jjnt01CvGEntdtwwW4fQPXM4sQ2Et6ZK8HUvacCIoe3QGReUZ+a1nf+D+rKTIbgqNbp2C7ZhQHgANDa12J8EcMZxJrGz21SSPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776321556; c=relaxed/simple;
	bh=pkzHPnNuPhA6EqBM0QseJ2/dNM7kLr0Gfr+l5KcBAYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVUrDUZiWKInyCBvaxq+ZqFKgKfVbE8YKZJRGSul1RJBDoNl05N1hRBi6LJxuEjUG6k7VASYuuuzNf9WXdesBv23/VD2ENf69+97+clDeqwQ3vG0nSxyiHA6qEnRv3bb7sToOgkXfrxKVJy/cyeKjuXHe6OBFeYTGOGAPBRSl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20251104.gappssmtp.com header.i=@u-northwestern-edu.20251104.gappssmtp.com header.b=EqpUhvgr; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a154cc6a48so89441036d6.0
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 23:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20251104.gappssmtp.com; s=20251104; t=1776321553; x=1776926353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=viXqyzZFw1W1aAOEHYeiP5B42zNaaNA+fCgvUMU1wTg=;
        b=EqpUhvgrO9zzoGECBTlHhTyB5hK7mcNpbsPh7Tw7gF6M8VV9zMDYFYSaY3ZYD1nNV2
         TnC/bEmNeQ+S0pcDe+NwlJxVK7EBvBsZzGTf8nTbnL+kW8zoy97P4awX2njcvu9HTpVc
         2t6UVrFM2H6F3QBV6Kk0f+lLUoeDc+1nOZ2sKiK7g7vyn0yBrLgU74Jg6HE2wncx3oBE
         Kd3t0+Kyvvst+lmrx6vf8+apBe9scV/zva6VCfsfi/R9fvS0SggN48en5d7KORc8s3yE
         QIYbAkjsW37E3vcUlDDogkc4w9+5fcP5/SLF8bnsqDZFZEj2kGdjKv65kU9rq/PW3ATB
         cP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776321553; x=1776926353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viXqyzZFw1W1aAOEHYeiP5B42zNaaNA+fCgvUMU1wTg=;
        b=q0Aa8pwcmYPPIpMN7eqFrmcRPyMG3dgf9Pw/Ee5atL8e2bKhIIk9U4fXw0lmZhoGL/
         6uYRnPBUBjB41oDOfEvZXADy1Pu9mTWwa2poegO2+8WmjBF8eb0s8AjDlQueg23HtE85
         0i58UDqpaSSrDozqrpk6u5GuWMbHXKVyPk89DBu0vWmzc8TW8S2rpmDZ/DFpKiVovY3Q
         78rVpWZ6nk2CA4NsaFLa00zoi+tTjDxFQWBqoyS133EFVeSLWjL3ax/PD+yP2jdvvvsl
         yxuTkXfeNtd5RqpGul86KR08vxQfmDeTmuoGiqm68shY6Y+T16oDw4fK7DwNRpLVC/ZI
         Px5A==
X-Forwarded-Encrypted: i=1; AFNElJ+qI7PUFp2rTStGq4TpflmO11OggMP+gBPkjDM3RQUpr6YRId+rw6ms45EeIO22RK9HCErImlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBzikivBMQEmb9PdKaGVAXxdLTasGI1yUbY9/jbM8rp8e/lFa
	GP3DOMvcRVhbv0El0k5Go/k+IKiIDfVkkA6jGos6XADnOeiTc8boN3oJlvzzjRWf3dw=
X-Gm-Gg: AeBDieu9wHh8jFry8ptT183CGaw26AzGxZSfTSfHaSCptAQ/J32AlSh2jOVUsGR3y2v
	80f5//XVhldO4XO68HBJcKmEIUVOnu82kDB4CVjvyBz1bzqbJAOPKdzhegEP+0t+4IYqAQDJ8Ij
	VB3KVT8JgI5jhdrjdMu3l8XQhtE2h56SBw6gt/2VDV0zr+z0xdkdgqX9aRtuF/z+EkZbBDVH4n/
	klkq2BPZmNc7hlKhh3Ii7VYhQp9lD3moUxRnJVZzv6fmo34JYcUrac6cTjp1JSJDCnBt9lXMIhV
	RZ4aWmSN/Vnfo8eZvRDavGb1khNsOXwtYO0nZskDahqmE61aoIwS6i6t1LaBQfyOWn36XuA+kgB
	BtBbbzvSgr2OojMX9Y8LDWCq/dJME3eHEJ9qL7uPvLbAowDk+br1sXFNTDpMHXxlBSyzg69JKeD
	qF/16Bv1lGM9IAMGVM+eLGdTqLL6NU6TuuBztfk2XmNfq/TI6/YwgdEnI3G7FYgPPNKdaj/HoYh
	fFNaOA5YDWbt10XMSGkZZI=
X-Received: by 2002:a05:6214:5702:b0:89c:cfb1:b59c with SMTP id 6a1803df08f44-8ac861c986fmr393355936d6.23.1776321553608;
        Wed, 15 Apr 2026 23:39:13 -0700 (PDT)
Received: from conor-Inspiron-3020-S.mynetworksettings.com ([2600:4040:44b8:3600:d171:db71:e260:ff8d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cb9eb92sm29882466d6.24.2026.04.15.23.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:39:13 -0700 (PDT)
From: Conor Kotwasinski <conorkotwasinski2024@u.northwestern.edu>
To: ckotwasinski@gmail.com
Cc: Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/3] wireguard: device: use exit_rtnl callback instead of manual rtnl_lock in pre_exit
Date: Thu, 16 Apr 2026 02:39:07 -0400
Message-ID: <20260416063909.964045-1-conorkotwasinski2024@u.northwestern.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238261-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conorkotwasinski2024@u.northwestern.edu,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[u-northwestern-edu.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,f2fbf7478a35a94c8b7c];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,msgid.link:url,u-northwestern-edu.20251104.gappssmtp.com:dkim,zx2c4.com:email,u.northwestern.edu:mid]
X-Rspamd-Queue-Id: 29D0740AB51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

wg_netns_pre_exit() manually acquires rtnl_lock() inside the
pernet .pre_exit callback.  This causes a hung task when another
thread holds rtnl_mutex - the cleanup_net workqueue (or the
setup_net failure rollback path) blocks indefinitely in
wg_netns_pre_exit() waiting to acquire the lock.

Convert to .exit_rtnl, introduced in commit 7a60d91c690b ("net:
Add ->exit_rtnl() hook to struct pernet_operations."), where the
framework already holds RTNL and batches all callbacks under a
single rtnl_lock()/rtnl_unlock() pair, eliminating the contention
window.

The rcu_assign_pointer(wg->creating_net, NULL) is safe to move
from .pre_exit to .exit_rtnl (which runs after synchronize_rcu())
because all RCU readers of creating_net either use maybe_get_net()
- which returns NULL for a dying namespace with zero refcount - or
access net->user_ns which remains valid throughout the entire
ops_undo_list sequence.

Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=cb64c22a492202ca929e18262fdb8cb89e635c70
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
[ Jason: added __net_exit and __read_mostly annotations that were missing. ]
Fixes: 900575aa33a3 ("wireguard: device: avoid circular netns references")
Cc: stable@vger.kernel.org
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Link: https://patch.msgid.link/20260414153944.2742252-5-Jason@zx2c4.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/wireguard/device.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index 46a71ec36af8..67b07ee2d660 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -411,12 +411,11 @@ static struct rtnl_link_ops link_ops __read_mostly = {
 	.newlink		= wg_newlink,
 };
 
-static void wg_netns_pre_exit(struct net *net)
+static void __net_exit wg_netns_exit_rtnl(struct net *net, struct list_head *dev_kill_list)
 {
 	struct wg_device *wg;
 	struct wg_peer *peer;
 
-	rtnl_lock();
 	list_for_each_entry(wg, &device_list, device_list) {
 		if (rcu_access_pointer(wg->creating_net) == net) {
 			pr_debug("%s: Creating namespace exiting\n", wg->dev->name);
@@ -429,11 +428,10 @@ static void wg_netns_pre_exit(struct net *net)
 			mutex_unlock(&wg->device_update_lock);
 		}
 	}
-	rtnl_unlock();
 }
 
-static struct pernet_operations pernet_ops = {
-	.pre_exit = wg_netns_pre_exit
+static struct pernet_operations pernet_ops __read_mostly = {
+	.exit_rtnl = wg_netns_exit_rtnl
 };
 
 int __init wg_device_init(void)
-- 
2.53.0


