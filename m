Return-Path: <stable+bounces-165685-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C13B175CB
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 19:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52FB6626A51
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 17:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6241B23C51F;
	Thu, 31 Jul 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ3hx76s"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5504101EE;
	Thu, 31 Jul 2025 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753984301; cv=none; b=nmqiFrGtB8/stxkHiT5gfVVrIBU1ejap8muCsehHgf9mhvYGy6mORsPLZokNnKzr5i3mwd7w/GWuugf68EbdMBJs6NjeBvTxRjnVcYfTSBGzihb+nBwt/sJlfQt8D+ddO9PUE/m4qV2NIZsU5MntT9LOe59t2Rs9vWwJXrBpWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753984301; c=relaxed/simple;
	bh=MvMKRL/py/UYu9reV6xLkU4IhARBfecgqx3hs6eDej0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GkGisw5onwVwZpAhp4GgrxSSUVnldvKcKe10deBY94pCn5+pTiwVLq6KNREUGQ3sqUFkh5frUp6giNVX3UyBNpd62yycpGb9j2aeL7yS+BZePSwAkEDdEu1aGKoom0YBOhuxaA4c5/ikpmB8C4GvYLH9o9j0/RXoHflnva8SZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ3hx76s; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8bbb605530so2034468276.0;
        Thu, 31 Jul 2025 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753984299; x=1754589099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nIHQvnX6UNEO5bU8VFBoQ/Q+qNFvu+4LpDZCLqUC/A4=;
        b=hZ3hx76sykEmeoMre98qA4XB46/Pc7OysD7wFIOh5idDAxh+Xfwu6e9py4Brlf6tvw
         90WG1HRfZMWSChArJEq75IpbkQh619ajiEk7yuC5l/VZtYb1W9/ZQmzVYnsMEEBT/FnV
         jhaw49qxtfdqcmVXpqODCSryjO6L8PKNKIKHN7HWIN60xqyr3Gg8ZxFshjvFIrGKvchK
         geyTZyvhzJoKrZSYbeUZKZg+XMws7B1YS99vX46AxmYokyR2QGiq+dgE13LsrHuvX1n+
         4sSkavuY1DFkqbj67C4Ua8/HyHbxxpIPLOFdQAiF+sTm8gYM0cui3Kb+KllhAzxwvloS
         qVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753984299; x=1754589099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIHQvnX6UNEO5bU8VFBoQ/Q+qNFvu+4LpDZCLqUC/A4=;
        b=Nbdyokxx+IVyFACwtZYpgaPL5ChXmt5DxEVDk4n7Tx2xkOs1UgPErvrCKB93WZiVnK
         KWtdsHxpo7g81xJ2RxkBRpD19nNUMK8MFwKlzFM040XBvyaKIn3FAG0hnSPuwJswcwOM
         ymavFlaSXMZiHKixvNQAcm6+UJ1ic/MMJEqvrL6zLSmZxztYp67AiW5ExIPqcJj8QJUd
         nHWVNIZ+xGsyBVztqRRDmY4KxtdWMCIo1JwlGtk9AkCChQFwlxfpJ8Qe/xlrBxZcsHVl
         4mSWW4CeHU5BmKXMTbCvS9AEjpVWC1m8FNiGvLBaEV+8drG3iDhmZgBt+3vcgUZrFULp
         Drxg==
X-Forwarded-Encrypted: i=1; AJvYcCVvLDmo2I4N8kHfElj7o5RZzAcGCOWw12cQezL1LV4z+CyhoMb1zRI80985tzhCNKzHZd5hkuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRg6NzpHfdAxv5/lJTchrB22sMZ9U3EO9DUhvsi6THEYHXAxa
	LuveWMYeUEtwJHgYNsPAIiOstECX5blM1FJl8FmvztcFW7ntJkYnrL+YXaSv7g==
X-Gm-Gg: ASbGncsXtJGPmElaydpdhk/LXGt+zTdWnbRzCfXS0hmpGCS9dX0gmn9nviBqBWcOJtk
	ZuWGD63kDj/OQU7uF0mCJAtpVs8h+ARdRFt/mgfx3xA22cqubjdu34WgygoBQfClEqUQv79UDdo
	WLtiiRFoarXtY2VkukWl5IDpM18sJ0Jzx8aBVAXKZT+AN2oYEIg5BA+8KMDoGiyr15yLus8yCef
	01QjtO8yfWKw+s2sCwGbFBodWELZhNHEz4qDUimAeLXzlM5IIyyqxtPjMKMsL9GmRcfnTs86rJa
	gAjIIarT4Ey8atrDllTaB2+7fUXiKV+/3kREdAQK891onmkTNKDCjkv6IfL7OUANFpTFA8wFm1b
	gqxQ9TfKx5UN2vR8DKetGmzSgwHxQp1lHFjReIN1yjnMVFTEbTCWUBlignr7F9MEmQaY0eDmcwQ
	zVKNpPSHsiMoQxYoIe
X-Google-Smtp-Source: AGHT+IEUq8U2kdt/gh5b5Bn+ATUtvzheojlX3lIyaBt/7IZBzFAP9l/eqYZ5Hd4HR9ymr1WE01at+Q==
X-Received: by 2002:a05:690c:470e:b0:71a:21f9:572d with SMTP id 00721157ae682-71b5a86e31dmr31899447b3.19.1753984298483;
        Thu, 31 Jul 2025 10:51:38 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5f783csm4914407b3.80.2025.07.31.10.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 10:51:37 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org,
	Quang Le <quanglex97@gmail.com>
Subject: [PATCH net] net/packet: fix a race in packet_set_ring() and packet_notifier()
Date: Thu, 31 Jul 2025 13:51:09 -0400
Message-ID: <20250731175132.2592130-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

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


