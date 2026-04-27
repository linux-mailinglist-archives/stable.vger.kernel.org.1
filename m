Return-Path: <stable+bounces-241360-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L10NBOG72lPCAEAu9opvQ
	(envelope-from <stable+bounces-241360-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:51:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81436475939
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 17:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B24343255539
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C780351C30;
	Mon, 27 Apr 2026 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FZpTr2Kx"
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FAA3382C8
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303906; cv=none; b=fR3GZJA9Fz0fjjKz7iJKgx0ISk6QN4jT/YaNBVb0N+rKA8WD+s1aBPC2+vYqlcQorB6LirPgm1KMM6tQGHn1IYuML7gcWnOAgsfdw92E4eoydFJ1BxZBuSQqX9p59ahN4d6Il8t4m8ezBxTQrxA7CXA8e98p/olHzYBuVITMoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303906; c=relaxed/simple;
	bh=f0Wiy+TGct6uE/9Igrbb6fvX2X++EbFqcLIALxPFAYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1jCXqPYSFwxhCHTOffbKfGdmFRvQQ4MywZhNB7LxIsCJJiBkTcYey75TDo2BVN5MD17ves8Tc2lCK6vzETshVrRm4FkSJQ9KBVAQ3oTQtdRukGs6oBs+ka4QpYHFceLxmmYA8IIb3GziuHlhav7k0PI17Ow34yAm8Ot3XZvQs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FZpTr2Kx; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-61006c9dbbeso363782137.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777303903; x=1777908703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vik7X9JGccLkKKz3/pSkLmm87Qrp4z5SxtaHa4HWROw=;
        b=AR2P6FVea2Sg9svuyf/KhfjXYohhcJr53AUDX3+3YSiiwVdDPdKOBumgxMDxDgwk8d
         eIlp7KU0DnoeCD89Fnps2t8UojPcSXpeDmmxS2HPfMns66VB854MMLoQg2xsTIy6sUt0
         p6Xp8gQPFpiDqzoQ/5knU4OrHRbtz81BIFGUTFZnkPAXIfCzMMRLouW5y9tPZ498KKyW
         vGmm+2d9BFqhWZrWTYw7vFXKsR2m+sBto+Mlezgtm6h4ruAakAvN9WN2OPJYwSlJB+ZO
         9sBvpHqJ+nt7M8BkqhGAVv9T3gowdsVJTHVdmETiKZHHgLVDBd+S5ldet5t4SgQJdHi6
         R+xQ==
X-Forwarded-Encrypted: i=1; AFNElJ+KJXnEb+vNMM4UTbGd6sMl2hk+4IJaTSMqbTTUDLt9O9aR7NC1AJAlZo10mk57/DUPGmk69OY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe7d4t1XACQXmc1UtcjhOFLwUJIXqo5RnuyPSSR7HLld1yLrqj
	0qDk3Jl6URjJL4mQRQIp7dpgQPW8rF7WPuY+y/RXcER0Z0fnP4IqoDkPq89NgxNOFxZD0/qPs2Z
	67GLD3QVlOZLdZvBN3yWQMwaAC6XHgtJSS3nDfpBTmy7+NYRoFOFJAPtElYstiT9VEOxVHdn2m7
	y3zYCyIDMjbWQfIsI0ZAkgpFi17CEBL2zN5/BHrjCQbolWJG0LwuwaqVsL9hId2DO0xn9+5AEBy
	UU851C9NeRLEMU=
X-Gm-Gg: AeBDievwyC4LHbeFpdH6GPFu+xc4u6/q5DuBwikJXJjrXBsEmN/oF69cCi3bplZDF/n
	/+HLNB77mt6ExIT0mOV/up6YIqnzCUFz4S3Nl9allXgkBC3Cj55p5vQzAbNeYILr11yXvcwUtYM
	cV51aCgiVWBjWCw0aHUcenNj+YKr9wVjdAKNWePbevvMtXoDShI9P+v4Do74hkPpetNFhIkONo2
	9CYoF58j2dnn5z77DzBNa0Mhdfj8VaRG2GU5GMK9sx4gq8FlMQXAZPE7G4V5BksnSTO7dke5AE0
	3r1W54qphS/5uMQrz5av3kYbNMa2AF2lnWorlzc7WYlnxMMfn2r5zQRX04qC0oqzAZV/dfra9oG
	45Uihi67FwJmGeAicUVhu412n3Q3ndhfbQYNEau1cMUTetAHOMkPEjYc88KriRFN2NyMHUH/iBW
	/c0/jmWsFKZp1FTvbx3HFrSDXP+cn4THPyb2jXpmZmWt8k9KKYO1TKrur7UrE8LuE/Ynom
X-Received: by 2002:a05:6102:21a8:b0:606:2f5:7b49 with SMTP id ada2fe7eead31-616f80647f1mr6057644137.7.1777303903366;
        Mon, 27 Apr 2026 08:31:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-617455b6eb0sm2458883137.2.2026.04.27.08.31.43
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2026 08:31:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7a4f0e4ab6aso11696847b3.2
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 08:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777303903; x=1777908703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vik7X9JGccLkKKz3/pSkLmm87Qrp4z5SxtaHa4HWROw=;
        b=FZpTr2KxurxE7WVv/B4QY5ybNsJZ6LkBcRmnZAc0H4ijEHj44t53+W0q5y6dh1IDfB
         pgSlBSffIXsML6bTFXrupJULteN1FXOkhVapzbml8clERPA4BPdTQGq5YGTy40cnB0IV
         U/2zq/iYdkIoEnhRUqLNJuBFCIod4A7JABE68=
X-Forwarded-Encrypted: i=1; AFNElJ97wnWf4NBIsypcQD5V+NWE5APyiK7JhcMS7XIeEiTJG7CYtILAvEbfF3t+nj1CrLdtJu5VXTg=@vger.kernel.org
X-Received: by 2002:a05:690c:6c91:b0:79e:631e:67b with SMTP id 00721157ae682-7b9ecfc22a0mr275661317b3.4.1777303902363;
        Mon, 27 Apr 2026 08:31:42 -0700 (PDT)
X-Received: by 2002:a05:690c:6c91:b0:79e:631e:67b with SMTP id 00721157ae682-7b9ecfc22a0mr275660897b3.4.1777303901665;
        Mon, 27 Apr 2026 08:31:41 -0700 (PDT)
Received: from photon-d7fac424c0d3 ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d69abee3sm2590486585a.17.2026.04.27.08.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 08:31:41 -0700 (PDT)
From: Ankit Jain <ankit-aj.jain@broadcom.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	quic_stranche@quicinc.com,
	quic_subashab@quicinc.com
Cc: linux-kernel@vger.kernel.org,
	karen.badiryan@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com,
	Ankit Jain <ankit-aj.jain@broadcom.com>,
	stable@vger.kernel.org
Subject: [PATCH net] tcp: do not shrink window clamp when SO_RCVBUF is locked
Date: Mon, 27 Apr 2026 15:27:55 +0000
Message-ID: <20260427152756.1205-1-ankit-aj.jain@broadcom.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 81436475939
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241360-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

When an application explicitly sets SO_RCVBUF, the window clamp should
not be dynamically recalculated based on the memory scaling_ratio.

Currently, tcp_measure_rcv_mss() aggressively crushes the window clamp
down when it sees a poor skb->len to skb->truesize ratio. If the
application explicitly locked the buffer via SO_RCVBUF, this
recalculation causes the advertised window to drop severely.

If the window drops below the interface MSS, it triggers Silly Window
Syndrome (SWS) avoidance on the sender. The sender defers transmission
and drops the connection into a perpetual 200ms PROBE0 timer loop,
drastically reducing throughput.

This is highly reproducible on loopback interfaces (MTU 65536) using
Java-based workloads (like Tomcat/GemFire) where the JVM sets SO_RCVBUF
to 32K or 64K. The bloated loopback truesize forces the scaling ratio
to drop, crushing the window clamp to ~26K, instantly triggering SWS
stalls and causing gigabyte transfers to take minutes instead of
milliseconds.

Since the application locked the buffer, the kernel should respect the
clamp boundary and not dynamically crush it based on runtime ratios.

Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
Cc: stable@vger.kernel.org
Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
---
Note to reviewers:

Testing Context:
- The SWS deadlock was successfully reproduced on the latest netdev/net 
  tree (v7.1-rc1) using the actual enterprise Java workload.
- Applying this patch completely resolves the 504 Timeouts and restores 
  loopback throughput.
- Baseline iperf3 auto-tuning remains unaffected by this patch.

For context, here is the exact sequence of events that triggers the 
recalculation flaw, illustrated in a packetdrill-style flow. 
Unpatched kernels aggressively crush the window at step 3, triggering SWS.

// 1. Tomcat creates socket and hardcodes the buffer to 32K
0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+0 setsockopt(3, SOL_SOCKET, SO_RCVBUF, [32768]) = 0
+0 bind(3, ..., ...) = 0
+0 listen(3, 1) = 0

// 2. GemFire connects over loopback (simulating Jumbo MSS of 65496)
+0 < S 0:0(0) win 65535 <mss 65496, sackOK, TS val 100 ecr 0, nop, wscale 8>
+0 > S. 0:0(0) ack 1 <...>
+0 < . 1:1(0) ack 1 win 65535 <TS val 200 ecr 1>
+0 accept(3, ..., ...) = 4

// 3. GemFire sends a 20KB packet, dropping the scaling_ratio.
// Without the patch, tcp_measure_rcv_mss() crushes the window_clamp here.
+0.1 < . 1:20001(20000) ack 1 win 65535 <TS val 300 ecr 1>
+0.1 read(4, ..., 20000) = 20000

// 4. Assert window did not crush
// WITH the patch, the kernel respects the SOCK_RCVBUF_LOCK.
+0 > . 1:1(0) ack 20001 win 65535
---
 net/ipv4/tcp_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index d5c9e65d9..c1cb9d3ed 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -248,7 +248,8 @@ static void tcp_measure_rcv_mss(struct sock *sk, const struct sk_buff *skb)
 			do_div(val, skb->truesize);
 			tcp_sk(sk)->scaling_ratio = val ? val : 1;
 
-			if (old_ratio != tcp_sk(sk)->scaling_ratio) {
+			if (old_ratio != tcp_sk(sk)->scaling_ratio &&
+			    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
 				struct tcp_sock *tp = tcp_sk(sk);
 
 				val = tcp_win_from_space(sk, sk->sk_rcvbuf);
-- 
2.53.0


