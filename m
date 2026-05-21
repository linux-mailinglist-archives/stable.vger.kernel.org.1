Return-Path: <stable+bounces-253479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ9gLf3LDmpoCQYAu9opvQ
	(envelope-from <stable+bounces-253479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:10:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 355975A1F51
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE3C3189402
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 08:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8C93CE4B9;
	Thu, 21 May 2026 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDso3xmV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2EA3A59B5
	for <stable@vger.kernel.org>; Thu, 21 May 2026 08:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352684; cv=none; b=BCpY/nUxFOg0eLBHiOReQRjOly0AV2G49fED1j9rJtS7hoCIRJduAyeyyB9UDz/SFmKqIZZwMQ7IemZfo00XsdQTY+PKLJCR0ccjNenB7tZSVNkGj/dU2Jw6AVZZpuUGOWvnXjoCksO23k5PR2Z7Co5TUW3wOr37ImOdUoqWoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352684; c=relaxed/simple;
	bh=uClwDwQ9aMBOn1j7vC5jSbaTUBkTAZEZk5MPWjNbpow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LtTntQWbn9vZwhmOk8U3iA2mdOTtt3lddjV/xqxLCFC5WON5bkqrdh+b2T6WaURaKJORoa4qj7VZMiNjS8E7H4xExhxvP1YmA9EKt/AaLMy+/Vv9bzkWaOJVc+Ze3RFxntUmNXpad4UmGiaK42qaJsvEJZDHHfygMwgOlX4b6jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDso3xmV; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-369c4bb4baeso691863a91.2
        for <stable@vger.kernel.org>; Thu, 21 May 2026 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779352675; x=1779957475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sC1dlVSEJRn8MI2VFuxLlRNe963Fh6GRPhQWJKMRLww=;
        b=JDso3xmVZrl0P9qvnwAaH02BRgcD6UwMXoMED+ER7opASli1xVwWalfIBxsp7I3yg6
         oeaLxe7mhIOn+Pq4KO3S83nVDTgMWWMAAao3DwTtuX7Vj0vCFYk/6eOpkGZo9pKS2Ybc
         bAV56+l5wxX9b7gyAOFjEIaYSy/8hg4MbYZMjxmPWKbQEcabHdYojJKGEe/UJrVoiOby
         wQjhCTo9XaY8NiSuchnEAVbrwYcbInsH54xVOGhksvV5t8ZHFIZwmieIBS375TXLQ6Zd
         87xMQnJ1VrpqotuhIdNPEY4yp0a0jIWTcaoyj73EFLTjbUPUvMRxDKJxHdyC+4nvL2/e
         HyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352675; x=1779957475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sC1dlVSEJRn8MI2VFuxLlRNe963Fh6GRPhQWJKMRLww=;
        b=lk5kI8k45LG+hpzFoBcKLh1+8pcq+G/vDbAV53WRHiInoo4q+NIsuZvfgDrjg4c02M
         zZF3rm/dEWdz80fCSxgGSdKBVD5SFvOYcoMzZ6bfDd0DWBorlg7szB8N4ERkyIeVW0QX
         0ivRuP68876Lw+48rAes6SbrrZ1yckmi+FxgZJz7UM/8YIBniHbYsabnNMTzHct3RMRm
         1DxHVddGqTrAf6y3aRN6QyTvkxBHA5vyT2KVTeC/hBPt/MLNfVVISoEJ7xI1he43xxkw
         Bt+O3/Cmx63d3HM7DxTgrXv/zxRNf3n4RO+p7itqYmmZcNVVDi3YFBJ8LssreCVu8Lip
         xt/Q==
X-Forwarded-Encrypted: i=1; AFNElJ/Jf61SvgmsJu0XJdR3YkzNMIDfHL0aVEyFjCI0N18m/YCKUCRIAB8+Zehuvazit9TksryXkIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhwYPoKzN39Iafniu5MkNDm4W5eoyvku+co2bMVeI1tuNt6ah
	UGgXdYPkOtbdfnCdQk30hwJWzeBuXVDO9EZjScKzTycirN5dkPhHzRl/UOY2uz1E
X-Gm-Gg: Acq92OHP/iKUgV/uOXm8VDCvF9Jg+Of7L93PYIBKmixYEh5B66zc3OHGF94BB2JjKAg
	pVyfKGGWt5fcsJv6nv2lDxE1LXRhgUJQBeLsWQxdbB6EblUx+rjt54cRdDHY2bz6svs9crrlVtq
	KjVCMEigzy6SBW5p6FM6CZFZFr8Gb2u7eADTPuR011nwu3bfwSIfhpZtziWZgJcBdxuOfFnqY28
	GA/IMCA2hJebp65GjKe6MLymazUP8YL4Z6RJqmZIfyQ/uhOUAEX58pUpD5qr0EzRfxoe9D5OzKv
	sEfcZPNW/+VoVZxhOAkGXJjMRKEPTYNWEwH5evt/+Hf/OKvSmRJ6mT2OCTGw/YdDiMYd/shH614
	149qwR0wUk53ou9votEpL4pJNccdWfvRFO6wRnv21jFW10nTa/UzMqL+bqxyM364NTg9+qZN5ez
	OCuYC4xitUZ0OX/hi5EFoFqENff69M
X-Received: by 2002:a17:90b:2551:b0:369:224d:8beb with SMTP id 98e67ed59e1d1-36a45c526d0mr1156488a91.7.1779352674862;
        Thu, 21 May 2026 01:37:54 -0700 (PDT)
Received: from kali ([2402:e280:3d7c:a2:536a:b505:93f5:9d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb0626b2sm28046326a12.6.2026.05.21.01.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:54 -0700 (PDT)
From: Pavitra Jha <jhapavitra98@gmail.com>
To: antonio@openvpn.net
Cc: sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pavitra Jha <jhapavitra98@gmail.com>
Subject: [PATCH] ovpn: fix peer refcount leak in TCP error paths
Date: Thu, 21 May 2026 04:37:39 -0400
Message-ID: <20260521083739.65061-1-jhapavitra98@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[queasysnail.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253479-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhapavitra98@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 355975A1F51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When either the TCP RX or TX error path calls ovpn_peer_hold() followed
by schedule_work(&peer->tcp.defer_del_work), and the work item is already
pending from the other path, schedule_work() returns false and the work
runs only once. Since ovpn_tcp_peer_del_work() calls ovpn_peer_put()
exactly once, the extra reference taken by the losing path is never
dropped, leaking the peer object.

The race window:

  CPU0 (strparser/RX error):       CPU1 (tcp_tx_work/TX error):
  ovpn_peer_hold()   <- refcnt+1   ovpn_peer_hold()   <- refcnt+2
  schedule_work()    <- queued      schedule_work()    <- NO-OP
                                    (work already pending)
  ovpn_tcp_peer_del_work runs:
    ovpn_peer_del()
    ovpn_peer_put()  <- refcnt+1
                                   <- peer never freed

Fix by checking the return value of schedule_work() in both paths and
calling ovpn_peer_put() to drop the extra reference if the work was
already pending.

Fixes: a6a5e87b3ee4 ("ovpn: avoid sleep in atomic context in TCP RX error path")
Cc: stable@vger.kernel.org
Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
---
 drivers/net/ovpn/tcp.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
index 5499c1572..d651ce85c 100644
--- a/drivers/net/ovpn/tcp.c
+++ b/drivers/net/ovpn/tcp.c
@@ -151,7 +151,8 @@ static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
 	/* take reference for deferred peer deletion. should never fail */
 	if (WARN_ON(!ovpn_peer_hold(peer)))
 		goto err_nopeer;
-	schedule_work(&peer->tcp.defer_del_work);
+	if (!schedule_work(&peer->tcp.defer_del_work))
+		ovpn_peer_put(peer);
 	dev_dstats_rx_dropped(peer->ovpn->dev);
 err_nopeer:
 	kfree_skb(skb);
@@ -282,8 +283,9 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
 			/* in case of TCP error we can't recover the VPN
 			 * stream therefore we abort the connection
 			 */
-			ovpn_peer_hold(peer);
-			schedule_work(&peer->tcp.defer_del_work);
+			if (ovpn_peer_hold(peer))
+				if (!schedule_work(&peer->tcp.defer_del_work))
+					ovpn_peer_put(peer);
 
 			/* we bail out immediately and keep tx_in_progress set
 			 * to true. This way we prevent more TX attempts
-- 
2.53.0


