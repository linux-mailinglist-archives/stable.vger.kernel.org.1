Return-Path: <stable+bounces-165761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC53B186EC
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 19:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E56E7A5E44
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F442701C2;
	Fri,  1 Aug 2025 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxsXGPtm"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA9D1AAA1B;
	Fri,  1 Aug 2025 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070913; cv=none; b=rbIyEYO3+unHEjN6zbYDqYbqxBbHzA71VituBa/hN9+8fn64WtTEmkjsnkU7xBKEPImJ2eGFRsa5ln+feceov8PujYF29QNEM7eeY/i00xJ/7r7NheUC0/etuRfBTCsafdiR1il1YyjRsOJY3bDs4NM+G4Mb3D6l70hHWoq3e3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070913; c=relaxed/simple;
	bh=cuDIV3MVaWyyXQhdCnbtbSd+YeLr+tVMk/Ak3uSelXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZ0UQn8H4YYQ9y5mzeY5laUGrAJfPyMiWhSBjjsg4ftH0sY4Xi2wjOIkCRVVdIPWxbBj1oLc7d32yCcdSI2IVdOl0oHFyf4sTBhDRsnoRn7E261JerIZfQhc9C8IhIkSh27g26VjB0gOQTltOyH3itxjM/gBGIrvGBvDj2ikIrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxsXGPtm; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8fd07da660so912185276.2;
        Fri, 01 Aug 2025 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754070910; x=1754675710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=edPMa6/3fdEemLQXnexU5fWTDsnM4Z3UrmN1UUk46ps=;
        b=VxsXGPtmILZ+wU8EePGrng2XZrWHilahCGqPzi0wYOHuyg2hgBCDlGkhw+xy1S6ChW
         clOZWpxVwHQgleRFZqkxLSOactLvpv7pOo3E3unlFQFutsGon3chF0I/Gb4/LZxUzBbM
         251Q/6jQXC6CzkuKyoS5R/reeRnIngcTm875p8I0CAZ279vkIIq0dq1m6MSJki79prlO
         zvBcFjBQhIMe3B1Ai6LUAKnjxjnliu6EigC6rTKdFQwB0Vn9RDi2HN5CW8ADa8++JQSN
         Zy1e7q2StA/+FLqkgety4S9xNEbF18ssJMwqvvTYRsGsXJf/hU2wUbyhMLiO5T661sb/
         5O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754070910; x=1754675710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edPMa6/3fdEemLQXnexU5fWTDsnM4Z3UrmN1UUk46ps=;
        b=BNHN/oPvZoax4FZ2KhGqI9RX9+CoreP+EJv3/9zTR2Rvn18D2DbZi9bRM6zVfPvG1I
         YvB3IF3hR2eIbur5KH4bqgp5OSOf4IH/DQgTcxwWxpPl33H4ZaGx4PKeSxb/J9LxCOfY
         0IFxzIUdzVudsja0sP9Hm1t4e8yyAZPIye5I9ZXIuI1wu1+Ttc5bYyqeTcX5bDPAqbt9
         85SbaSFZqw2Nsj9A9rdANjDjS6oZ0Y04VU4K19R5EHEEfC3dC/CDBOla9WpB4LbA5iB2
         EAp9J/ozsWCvqwMdX1mrH9gLVvFPusFa7LbpOm1+4CZIdAOSLoverm0RmaYENDWxJUgx
         pGXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH+lBiV141KdTXqgNnABuav4JG6ZzbY9xDrBE3Kf52eJxv48tzq/rH75vv42P5PSm/HcsoGU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWX/lvKfijFK09N+4YKPOxtzOZ25fV0LywCBaXql0CVEHk4XdG
	5pSVyjToWo6DKQDAnundTDCHnQefjMTyla1eYsqz+i2TR7leINShVfs0NcTwgg==
X-Gm-Gg: ASbGnctMgm2/k/muNnZo74cqHQPLsnlbHRe4qnX8aN84lTcwzJ+ROWQKfAcI4rT455g
	sVXdRqzY015sZoMWCKL2sQmVwcLo7v4K/sBhSDx4loYoC/1kSBPrPZdgJ+e3KLjtHKer+NFgqLU
	e9LleUfwUfhl1eYpNjfCuIdSOtb+oS+qRY1MxX5gX0ZG6pdUdljy0BBkSbOOVVm3xStYNOICoKf
	MvUQgZa5HEFjS/ygl0yei6M6WHxIPJNPkKFDcGCRzIsltqo+IscOIFw934LBh00IVVeWrUXv15q
	KOvs1XDD4H+ezpG/pUvTOxEeGEr0ID3TTkXO9qLekJaqYkXIBnENuCdZDsREYhL6jyKGCJ5tPTL
	2Yy9K6XfafZnbS3wCbORPdQGtVR/X2QZp1DAxpIhgPBolHOdQhvVervfsNMRmVke7ExD4xBfxKK
	C31YFBzFOIXNxneqbQ
X-Google-Smtp-Source: AGHT+IEztoJ90uCtq4qhNW0tj9/sZ8vP4pEtK5iaP3LDEyiFDGREMnfkS3YWf78DCd4SeGyhhiLmRA==
X-Received: by 2002:a05:6902:72d:b0:e8e:19fa:b3a7 with SMTP id 3f1490d57ef6-e8fee1d5c0emr821524276.35.1754070909663;
        Fri, 01 Aug 2025 10:55:09 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fd35a98eesm1648577276.0.2025.08.01.10.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 10:55:08 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Quang Le <quanglex97@gmail.com>,
	stable@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2] net/packet: fix a race in packet_set_ring() and packet_notifier()
Date: Fri,  1 Aug 2025 13:54:16 -0400
Message-ID: <20250801175423.2970334-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Quang Le <quanglex97@gmail.com>

When packet_set_ring() releases po->bind_lock, another thread can
run packet_notifier() and process an NETDEV_UP event.

This race and the fix are both similar to that of commit 15fe076edea7
("net/packet: fix a race in packet_bind() and packet_notifier()").

There too the packet_notifier NETDEV_UP event managed to run while a
po->bind_lock critical section had to be temporarily released. And
the fix was similarly to temporarily set po->num to zero to keep
the socket unhooked until the lock is retaken.

The po->bind_lock in packet_set_ring and packet_notifier precede the
introduction of git history.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Quang Le <quanglex97@gmail.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

v1->v2:
  - fix author attribution (From: at the top)

v1: https://lore.kernel.org/netdev/20250731175132.2592130-1-willemdebruijn.kernel@gmail.com/
---
 net/packet/af_packet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index bc438d0d96a7..a7017d7f0927 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4573,10 +4573,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	spin_lock(&po->bind_lock);
 	was_running = packet_sock_flag(po, PACKET_SOCK_RUNNING);
 	num = po->num;
-	if (was_running) {
-		WRITE_ONCE(po->num, 0);
+	WRITE_ONCE(po->num, 0);
+	if (was_running)
 		__unregister_prot_hook(sk, false);
-	}
+
 	spin_unlock(&po->bind_lock);
 
 	synchronize_net();
@@ -4608,10 +4608,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	mutex_unlock(&po->pg_vec_lock);
 
 	spin_lock(&po->bind_lock);
-	if (was_running) {
-		WRITE_ONCE(po->num, num);
+	WRITE_ONCE(po->num, num);
+	if (was_running)
 		register_prot_hook(sk);
-	}
+
 	spin_unlock(&po->bind_lock);
 	if (pg_vec && (po->tp_version > TPACKET_V2)) {
 		/* Because we don't support block-based V3 on tx-ring */
-- 
2.50.1.565.gc32cd1483b-goog


