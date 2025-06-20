Return-Path: <stable+bounces-155167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1567CAE1F76
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA18D3B8809
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAA62DCBFC;
	Fri, 20 Jun 2025 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmrkZD/d"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB572DFF25
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434405; cv=none; b=NiHumI6OXR157Kd8l5gpT397YUP00T6evappRSv5y1z4At/Oz74oazALAspU1h2VMHD9TUE+DLqL/90sjhEJIjGHsn/ZDm4n2lFHWEVeduu1oZpQqA59s+Sa99soEpTwWegqYeTco9ra6W/v7gUttC+M48e4lKWW5hiVlSbwJIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434405; c=relaxed/simple;
	bh=WTFy9EXTASlwiWfm13iLN4rL4GR6xnmnB9GmhymDnRk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SF7LQsFzTPqzdimwrt5CvApBqi8KGRCtrhwTByXTHa+GdbwC8S+Q0rdjx1aKTaswsazmzuxZUduurSBQgd7BzBQHMZarGdzBb0Z0KoQQaTGhXXFysjsCRm6dVQriyGKNUai7CrFvrWxFnKOBmOIyG29PeG3egQEjTUHd8OejXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmrkZD/d; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-710e75f9229so26806697b3.2
        for <stable@vger.kernel.org>; Fri, 20 Jun 2025 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750434403; x=1751039203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eLU2SnNnwnTgKHWqN2DQe9/JoGiu8EAX/HqrA+Vk0lc=;
        b=qmrkZD/dLTSZPScDzt3bGOZUK0iV4upcLNKLWwVJOYqyKQLvDikwyjp0DgsKqaBj3y
         yidqk5YpVI8zBw6eoxaNFHcjKLA3Jdd1I59nn+Ln1FvKCkRG6y5hunKl3Asp1yP9XxPw
         whGCyA39iSCDYRzuap55J4vtlI6uwq1L+4TFykLN1DVb3kYibGqo0xkDcfEwrmjLg3GH
         KrbzB1Cempuw5ue0d5+D1VqwfhXv6MjKN7kOORFQhL0AflEMVK1bGrjCrq5dY8tn9tx0
         jyDG6FdHLUuv8MmgaaWh9jzewUtHR7ju+wAMiTE3WdREorooNsyMHvwnVOxhK0RG5Ss4
         Yozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434403; x=1751039203;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eLU2SnNnwnTgKHWqN2DQe9/JoGiu8EAX/HqrA+Vk0lc=;
        b=E6lPUldoDWa7YR0G0vTq/+xhF6j/MoDl9jnuV3rPBQajBXT/wzh6CYmDV4GMJDGOjv
         uXC4LB/bNIHTTeCrCrdRqFANDhkcUx8ZdiMzFPWnpbcPoZ5CAFngjwvwz+YZ5Iuf9mbY
         aWrX5vB8BUddpTHdavkSg3wC2SERDKvamUFHwFlmvfkK2KtgYDX1fCTK/otymRMOvdnH
         m+AvVE0oodPzKKd6WvawcMWDqRiZRcuO9Gm5SMKBj0MlBE3ND6Sh+/iX497ACxcXbASq
         WJj6tmeFElFw3IB9CYLFW6jJVCOGrcuyfqBPIpZckNt1XOpfy2tBkYVDlSBP63RmYW0/
         BrCA==
X-Gm-Message-State: AOJu0Yzpw2cBZCMxBNca/IGYev+fWUR4/RuQNsOKm34D7ceLvAN+Jr4J
	E+uhMikH6Qfh80ARGKY9ttGCsucI50ghjsMWYqko3xebBLa+Z8DJsE/k0Vrep+bU6ccRlU+dR0o
	yh+zkJZN5HIP5xOqQ4WgzkiCjUrCeC9ScpE6VIB2ihy4llsLGIxbGFpV9MOY1SIpN1dz0rk0Wa8
	IpP3Tm0TmrEShAZ0PNa/1pbZHVusZvLR7UacOXIEn42s1Eq5g=
X-Google-Smtp-Source: AGHT+IFZRsLCW5J3Ad9HtT1PE7K8mHIgrSFBkZ9MEYroL8rdEucV+dVy0AAwixfRsIi3yN68KbmV/GG4bAFf0A==
X-Received: from ybbdt19.prod.google.com ([2002:a05:6902:2513:b0:e81:b442:c1b0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:168b:b0:e7d:c87a:6264 with SMTP id 3f1490d57ef6-e842bc6d6b7mr4704188276.6.1750434402745;
 Fri, 20 Jun 2025 08:46:42 -0700 (PDT)
Date: Fri, 20 Jun 2025 15:46:22 +0000
In-Reply-To: <20250620154623.331294-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062025-unengaged-regroup-c3c7@gregkh> <20250620154623.331294-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250620154623.331294-6-edumazet@google.com>
Subject: [PATCH 5.15.y 6/7] net_sched: sch_sfq: fix a potential crash on
 gso_skb handling
From: Eric Dumazet <edumazet@google.com>
To: stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, 
	Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

commit 82ffbe7776d0ac084031f114167712269bf3d832 upstream.

SFQ has an assumption of always being able to queue at least one packet.

However, after the blamed commit, sch->q.len can be inflated by packets
in sch->gso_skb, and an enqueue() on an empty SFQ qdisc can be followed
by an immediate drop.

Fix sfq_drop() to properly clear q->tail in this situation.

Tested:

ip netns add lb
ip link add dev to-lb type veth peer name in-lb netns lb
ethtool -K to-lb tso off                 # force qdisc to requeue gso_skb
ip netns exec lb ethtool -K in-lb gro on # enable NAPI
ip link set dev to-lb up
ip -netns lb link set dev in-lb up
ip addr add dev to-lb 192.168.20.1/24
ip -netns lb addr add dev in-lb 192.168.20.2/24
tc qdisc replace dev to-lb root sfq limit 100

ip netns exec lb netserver

netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &
netperf -H 192.168.20.2 -l 100 &

Fixes: a53851e2c321 ("net: sched: explicit locking in gso_cpu fallback")
Reported-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Closes: https://lore.kernel.org/netdev/9da42688-bfaa-4364-8797-e9271f3bdaef=
@hetzner-cloud.de/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Link: https://patch.msgid.link/20250606165127.3629486-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/sched/sch_sfq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 04c3aa446ad3d69c014b06e66795b8dfbc369333..29e17809d1a70258ca268d45028=
9c63a272fbee4 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -310,7 +310,10 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct=
 sk_buff **to_free)
 		/* It is difficult to believe, but ALL THE SLOTS HAVE LENGTH 1. */
 		x =3D q->tail->next;
 		slot =3D &q->slots[x];
-		q->tail->next =3D slot->next;
+		if (slot->next =3D=3D x)
+			q->tail =3D NULL; /* no more active slots */
+		else
+			q->tail->next =3D slot->next;
 		q->ht[slot->hash] =3D SFQ_EMPTY_SLOT;
 		goto drop;
 	}
--=20
2.50.0.rc2.701.gf1e915cc24-goog


