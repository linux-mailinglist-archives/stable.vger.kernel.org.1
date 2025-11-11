Return-Path: <stable+bounces-194442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3775FC4BB8D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 07:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BDA1882B3E
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 06:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F5A315D49;
	Tue, 11 Nov 2025 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PghJRMm/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139152FC865
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843497; cv=none; b=hQ9adCmrhSN1KZa+2FPMhL5Vk/SqZ9dc0/qMDP2NKraXZt29bKf414I9agW/Muu1WxojnQmNxFEmOBd6q4MuMw9Bk/4w/EW2IRjgQmzEJWAUnn+2zLP1Q2AGYFWTGC/e4fFARuSg0qSByl+rxGg/V/e798G7C9eY9I7/IUZHuQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843497; c=relaxed/simple;
	bh=H45lOcTSAtMgo+EmX/n0VzDUtwq2OFEo3xSTYKVecVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DY437RSGuss04F+KEqhc4c93ATJYRCIhctKRcILxbJd83P30zD3hSgOL26YZm4TsqBegi2UYK53fpnHAukfirveed+ZPaDCBvSs+WmuhClEtryzX5JIX51Fn3CqKi49MIHuAw77SL7nwg3FTfqCxECrQY1BqzFxz+wY7NLcyo64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PghJRMm/; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-bbac8ed0614so744977a12.3
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 22:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762843495; x=1763448295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1zJFRsAiK3pdg0if+VvxTy8sqPxZLBPEDWV0WcU7gw=;
        b=PghJRMm/2+YFedsexSXIqdAp3zCkE9G77EdYVZpUndWCKzBQt07gSVVU8Js2k1PgnJ
         PnHz/C6YfX83m/6pLtW5hXqvpYWw52wu+VujRg8e2Q7AQov9r5e6af/YmmG7EU8hdRS/
         h5ekIcZFArGH/7PGmCnZG0ljq61y6kPYpyeTAjKqc8MoaEoiswp1QU/5xWI5+/SKptrr
         JSlOHSCSOimmdoYAIl8ZfSqUZCY2RPQibCv4yX7PU/UuOLu4KaCZFbjAj7FMipPzmBY5
         FpuJMPcYgEFW3D3j6oVGV0jvMaJ3MK4PbmKWpkr6SNnENNPZ9YZoXf5Bg/JbPQqrg38t
         HoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762843495; x=1763448295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1zJFRsAiK3pdg0if+VvxTy8sqPxZLBPEDWV0WcU7gw=;
        b=eKDsP8foorP82OeqrDWsiX0lGNYjKa+b4GWdquSc0+aiFsFTXaMA/9aGvOPwG68vCT
         nf0NdsLknf7aMs5XK/vX6x0TRnRARCCg79jo/tUkrvgXIPU6gxkIvHS+4or2P9jBJtkz
         Z14IsRvMMxkdxkrY34PbBcf8wrDh4mXIZYli8DuoKMnUIvoebS28Qrp67A2QAaiJ2QBh
         NMPpUo17+nQaKksmKBfavEBJjNhqJxXK79+3YBQTpza+TzUh1LDaqoJoB6r/rIpeUjk3
         1VsLGW98Xb2xn9R6mFENxAi8SH6hARZOuXYWRiXokcbv2SLH7NcTHGOy5NwCPSPaE7oX
         eV8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUKLKHM1n2f8NWkTyMXcjvkPibeRryo578F893hllWg+ugBs3e/LA24REsYv95hvxeRIS+8Rqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfyVMxdiXrZlbDz0yinv1D8X2yD9lACyk+Nq02Q20ZZ9r+/nwb
	lWXBvy/6bv29cgd1sJSG06+3dubpLLf502b4UZ4nyBMz+dn8UlVqNu+7
X-Gm-Gg: ASbGncucxpsCBstJG1MQClgLQ1WYw+L71t2aTOyX6EKtRRYvbZD3mW03zHGmUL/Xjd6
	P0bgbo+Y4KieS1jlLRtivhZoDV+8owZFBEPgMV+MhiN0dtc1rFxKNwpE/DCKAdzPa/XRRnMWd3+
	RpYj8B85+APDmoQ2FF0vu1FndtbDd/pKzUq0T2B8RrbAzVsqh4BwZ0n+zG+2vi+9w5g2g3l+swf
	WY0QFYhDnXxPX5yO9yXvQvuf1HYS0Ty7uI6+LKdteF1/pTr07NhWO9dtBEMGPNzu6r5EY6L7+Wo
	ANA8Ye+D5C2bpJlTnncuQvAXQ3brQ6qORcqTZuny8v9cF2f7iVxoO9qG2E1JKO+6ysfz2y+KlmN
	B0u9VcLZryVezh1GD44LQ/sKi3o4gdMLeRFJd0o2XzrtQnrvRN+3S5uSleaqnzbJqAs1u70sPSk
	nVhPjCNXxyyVZjJKnFudhXX8N1BV+hjc6soYaCpw==
X-Google-Smtp-Source: AGHT+IGZjkzeenTM4AWU7s1CLf+GaRSSpWdmQcFkLH83i6KqyKtQqF5GhsLYfhlBk2XgbJ7fvxelGg==
X-Received: by 2002:a17:902:da4b:b0:265:47:a7bd with SMTP id d9443c01a7336-297e53e7ce6mr126106965ad.4.1762843495053;
        Mon, 10 Nov 2025 22:44:55 -0800 (PST)
Received: from localhost.localdomain ([116.232.109.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297e2484bfbsm104161735ad.26.2025.11.10.22.44.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Nov 2025 22:44:54 -0800 (PST)
From: Chuang Wang <nashuiliang@gmail.com>
To: 
Cc: Chuang Wang <nashuiliang@gmail.com>,
	stable@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v1] ipv4: route: Prevent rt_bind_exception() from rebinding stale fnhe
Date: Tue, 11 Nov 2025 14:43:24 +0800
Message-ID: <20251111064328.24440-1-nashuiliang@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sit driver's packet transmission path calls: sit_tunnel_xmit() ->
update_or_create_fnhe(), which lead to fnhe_remove_oldest() being called
to delete entries exceeding FNHE_RECLAIM_DEPTH+random.

The race window is between fnhe_remove_oldest() selecting fnheX for
deletion and the subsequent kfree_rcu(). During this time, the
concurrent path's __mkroute_output() -> find_exception() can fetch the
soon-to-be-deleted fnheX, and rt_bind_exception() then binds it with a
new dst using a dst_hold(). When the original fnheX is freed via RCU,
the dst reference remains permanently leaked.

CPU 0                             CPU 1
__mkroute_output()
  find_exception() [fnheX]
                                  update_or_create_fnhe()
                                    fnhe_remove_oldest() [fnheX]
  rt_bind_exception() [bind dst]
                                  RCU callback [fnheX freed, dst leak]

This issue manifests as a device reference count leak and a warning in
dmesg when unregistering the net device:

  unregister_netdevice: waiting for sitX to become free. Usage count = N

Ido Schimmel provided the simple test validation method [1].

The fix clears 'oldest->fnhe_daddr' before calling fnhe_flush_routes().
Since rt_bind_exception() checks this field, setting it to zero prevents
the stale fnhe from being reused and bound to a new dst just before it
is freed.

[1]
ip netns add ns1
ip -n ns1 link set dev lo up
ip -n ns1 address add 192.0.2.1/32 dev lo
ip -n ns1 link add name dummy1 up type dummy
ip -n ns1 route add 192.0.2.2/32 dev dummy1
ip -n ns1 link add name gretap1 up arp off type gretap \
    local 192.0.2.1 remote 192.0.2.2
ip -n ns1 route add 198.51.0.0/16 dev gretap1
taskset -c 0 ip netns exec ns1 mausezahn gretap1 \
    -A 198.51.100.1 -B 198.51.0.0/16 -t udp -p 1000 -c 0 -q &
taskset -c 2 ip netns exec ns1 mausezahn gretap1 \
    -A 198.51.100.1 -B 198.51.0.0/16 -t udp -p 1000 -c 0 -q &
sleep 10
ip netns pids ns1 | xargs kill
ip netns del ns1

Cc: stable@vger.kernel.org
Fixes: 67d6d681e15b ("ipv4: make exception cache less predictible")
Signed-off-by: Chuang Wang <nashuiliang@gmail.com>
---
v0 -> v1:
- Expanded commit description to fully document the race condition,
  including the sit driver's call chain and stack trace.
- Added Ido Schimmel's validation method.
---

 net/ipv4/route.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 6d27d3610c1c..b549d6a57307 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -607,6 +607,11 @@ static void fnhe_remove_oldest(struct fnhe_hash_bucket *hash)
 			oldest_p = fnhe_p;
 		}
 	}
+
+	/* Clear oldest->fnhe_daddr to prevent this fnhe from being
+	 * rebound with new dsts in rt_bind_exception().
+	 */
+	oldest->fnhe_daddr = 0;
 	fnhe_flush_routes(oldest);
 	*oldest_p = oldest->fnhe_next;
 	kfree_rcu(oldest, rcu);
-- 
2.47.3


