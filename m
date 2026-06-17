Return-Path: <stable+bounces-266645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T/xsCJo6MmqDxAUAu9opvQ
	(envelope-from <stable+bounces-266645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:11:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC8B696C7B
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 08:11:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=canonical.com header.s=20251003 header.b=L1dNSXLd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266645-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266645-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=canonical.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55A2030640B4
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 06:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B73B27CD;
	Wed, 17 Jun 2026 06:11:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072D63B2FED
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 06:10:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676659; cv=none; b=sPK9mZR6Iy0NAmWzsb20Gnya83Sb0yd3dcmAQxpCUT9cqn57l+oA9TUgDXgwtmOAP7epLoPpobkX84U+hXQlpA+/5BTbKtTRqtBBkk5dAQoRVvUlXoHW8Z+tVWqk9QhNEWxhcJw0fSHWYMjz3+xRkvZD4yf9CfNWAoY71PV/V9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676659; c=relaxed/simple;
	bh=oJAtrOLVtF+GBmtQGqaY9bBzbr0/iVZWQUsi/oY1hhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AG3N+sRqBWdmrSM/IHDOXd3pR8pIiL3oSArIe+28+DQDs0mVeZUm8or9H8gEzyxl13CDKy2wHdscsiU6CG4P3ElVwO6fqu/NwE5MNx4xiB+hA7lpN4UZb/Yot4ZlxslaWIqi1gj76gIL60qfGB0QTGnXBfdgzLZCu3ELJBhTy7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=L1dNSXLd; arc=none smtp.client-ip=185.125.188.123
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 73A8D3F60E
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 06:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1781676656;
	bh=yYyjbUwTbz5kYjrY+YDLT8Sq9O45djIje08c44tj+s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=L1dNSXLdhygcRMn7A9AblErsG9ZIB//1tFzNasW3PyXsr0MPvoj0xX4nPdaK88C0U
	 OCU35XLLR1R3HJ0CKUZfxDVrHdhEPjaAz4q1qPmE452CfLdLwIVY7pXukPGErtaQ+p
	 ihzRghRE32xA3GBkr6Kedhbzvh+6du8iwEvWLvl44pEog9ldySC+PC73Dq/hFzpVHy
	 3xVDZs3qA9uIQ8uX5Og4h3wSNb+14RKAf5qhI0Y/UNtZTrGLOZAOPSfeNxhlzuR36q
	 zx2W/C2jezx5x0YfYH102h2hulc8mjKuPTnXTU3QLguxzG4UzR1bFNsz+WPyjxgSQH
	 /iHf2WZnA9rPTRVU2f2al3UVoi2TomeiZZ+hk17FdOIz60LWfRfQ9EKPW0dAy3dMzg
	 E40wueYTxcU7KjhX3pgBhTuYpsCXq3Sg8I6NoJrKJIFLLLndPoBffluPvJMaQa9qrI
	 p8WuU0PY8Fk6JyXYQpAoPrq+dY5axMOavoDgrPBJrm8usvyPq711WVoViHgAgi9AHE
	 dhX44iTr+HVmJ05GhQZyYhBfwq/ZK+Jv+uQBPc+JodgSNgRxuGw0f2CagNlvTpxJAl
	 YDi0sumNWriNVVZMHk7uU7rHmQcMpssKkGHfC56SmvGWTHlFw/UQZ6D/TQnbK1yvda
	 3yPwtNmhk/t8EIAONgLCC8Ao=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a060eb84so37761825e9.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 23:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781676656; x=1782281456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYyjbUwTbz5kYjrY+YDLT8Sq9O45djIje08c44tj+s0=;
        b=KW7Rardtcl8HJ7un2MoSf8iWb1zQIfkPvx8xcMfBuuIjwQRn0mFx2kffub/XHNGyE2
         vA4l332+8r8umiti8Vtu9kwfUpHogKbzT8F7epVv+fP8KLXve2/I5HomHP3zwk8Njltj
         +8oXqmOIh+Z7+otrzPnYS1YRrWpSZpIHYBBOAmz/2uSpnT9VKYFKqMImuVUKtUKrmnNS
         kKdJUBxOjUVidipsLsnMy/TZHsgXxCNWVN/KJW1ukgs66n7RcMu/zuF5qJsYyjFQpORE
         wO9tF5LkqPGlfPuODKWQL4sf8JqPryI0H+K2OmFCAqEnfjyYOBkajNBlQHR+PQlCpcGA
         IeMw==
X-Forwarded-Encrypted: i=1; AFNElJ+3ZlFwH+/xaWXvye3V2H9bvd09vydte4FYeoUQ0bma9O8+VG9nRGZ01myDWRhlbLjltOPt7ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK06LQHmf9+XeZuaZFV5b5IH5BnckrlrohEa+6+cFW8/OhHK9t
	MlORhY9P158L8arDZpVxuLqpq4eAqPeGj38Tzh3W1IU44QgfNTT4Kaby5WXenI1KBMI+kAbZ/yl
	8/Z+gKJdMfuYDgGBssyuGDUsoXUCWT5ja406Ib7TiiVtqanIGJWiHG0u+BEfwjcfGRXP4BqmtjQ
	==
X-Gm-Gg: Acq92OF0ByfrO+N3Sdr5vM39dbbhtP7qjTyssZ3fIbigjoNGE+HoXtO+NGxHP4rW8Sf
	ewuKRoY+EQH2rBTYTrzFLYuE1Fnb1TyCxLiiECON6Cyf4DTgzmiSbzQArLHymSdW9v6bGPw542B
	id9vvzYzu0Z1z2195+RvLJlHunrTh2hINlLne4YVP6kmOUUp0y488iawqfvRPTfmFzUun6mitWp
	dbXb2UKuTEL4vghukDdw2e7JW97LZxOlzCYnDJwpdmedYElP2KtxF2ty8dIpXIeF5Zn1Ggqs3hd
	7ZDVGh50g77qgEcP2ESkSIoUwfD29MBuJwhcMTQsFYE3Pqylf3LIRXWzrZeWsotBc3WsaH4S6oV
	w8QxGEEMRaI0=
X-Received: by 2002:a05:600c:5644:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-49234141d98mr16811905e9.33.1781676656071;
        Tue, 16 Jun 2026 23:10:56 -0700 (PDT)
X-Received: by 2002:a05:600c:5644:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-49234141d98mr16811665e9.33.1781676655730;
        Tue, 16 Jun 2026 23:10:55 -0700 (PDT)
Received: from ross-pc.local ([2001:67c:1562:8007::aac:41a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f309sm46674988f8f.14.2026.06.16.23.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 23:10:55 -0700 (PDT)
From: Ross Porter <ross.porter@canonical.com>
To: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ross.porter@canonical.com,
	stable@vger.kernel.org,
	Edoardo Canepa <edoardo.canepa@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Brett A C Sheffield <bacs@librecast.net>,
	Oscar Maes <oscmaes92@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] selftests: net: fix file owner for broadcast_ether_dst test
Date: Wed, 17 Jun 2026 18:10:39 +1200
Message-ID: <20260617061039.79717-2-ross.porter@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617061039.79717-1-ross.porter@canonical.com>
References: <20260617061039.79717-1-ross.porter@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266645-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[canonical.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,librecast.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ross.porter@canonical.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:ross.porter@canonical.com,m:stable@vger.kernel.org,m:edoardo.canepa@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:bacs@librecast.net,m:oscmaes92@gmail.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ross.porter@canonical.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,canonical.com:from_mime,vger.kernel.org:from_smtp,launchpad.net:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BC8B696C7B

Ensure the output file is always owned by root (even if tcpdump was 
compiled with `--with-user`), by passing the `-Z root` argument when 
invoking it.

Cc: stable@vger.kernel.org
Reported-by: Edoardo Canepa <edoardo.canepa@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/2129815
Fixes: bf59028ea8d4 ("selftests: net: add test for destination in broadcast packets")
Suggested-by: Edoardo Canepa <edoardo.canepa@canonical.com>
Tested-by: Ross Porter <ross.porter@canonical.com>
Signed-off-by: Ross Porter <ross.porter@canonical.com>
---
 tools/testing/selftests/net/broadcast_ether_dst.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/broadcast_ether_dst.sh b/tools/testing/selftests/net/broadcast_ether_dst.sh
index 334a7eca8a80..5e7a8fe23c7a 100755
--- a/tools/testing/selftests/net/broadcast_ether_dst.sh
+++ b/tools/testing/selftests/net/broadcast_ether_dst.sh
@@ -44,7 +44,7 @@ test_broadcast_ether_dst() {
 	# tcpdump will exit after receiving a single packet
 	# timeout will kill tcpdump if it is still running after 2s
 	timeout 2s ip netns exec "${CLIENT_NS}" \
-		tcpdump -i link0 -c 1 -w "${CAPFILE}" icmp &> "${OUTPUT}" &
+		tcpdump -i link0 -c 1 -w "${CAPFILE}" -Z root icmp &> "${OUTPUT}" &
 	pid=$!
 	slowwait 1 grep -qs "listening" "${OUTPUT}"
 
-- 
2.53.0


