Return-Path: <stable+bounces-222450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFt1IJUepGlkXgUAu9opvQ
	(envelope-from <stable+bounces-222450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 12:10:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D581CF472
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 12:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C05A301E95A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177E93002D1;
	Sun,  1 Mar 2026 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2T2em7j"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951D427442
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 10:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772362646; cv=none; b=N41A6DeKEa7GQu+nk5vtN/C73qwaskXf3y8p9UNYAWzJIcvMOYfcPIMojD913OdjsygDzqD90m546YrLsBOWSWp17oB9d6ggfxOhKOHA0tyAxtaQT8KgXSPpj3XxHsuV65dZufMw3SIazp7gbZwKGGh2iG/CjH49FMIM9nb5dYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772362646; c=relaxed/simple;
	bh=aXygDM+VTYBD+bNZSZXs02M9hT65PduMe8k6EMsjVeE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JMcyLfnhJIfEDEX7crLaiNDI3BVBEJF053PeNjL/wzp/PsZm6DwGna+Osa+XLXKQk/eWXkZMH/TPSVVFz4QG7MbbcoTCpyPm5QgPLdlX2ggfi/ZVxbfo1piaCAceEBuchflAuy9r4j7geWAeDoSdxoKBzlrOyGqOpkYciHIpJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2T2em7j; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c7103601c8cso1529162a12.2
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 02:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772362644; x=1772967444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/PUY/W2xLVyfoFf7iYt6HuXRzFvXPfeO6RS8rO/tLc=;
        b=P2T2em7juamaFKAu79SLRXws7f0BT9BU+VJrjcmK9C/16hBwg11/iim6yuTcRXqQZH
         RFKMeJTry06/yL0+F66jWWDeZ5IG923tztE/bxMlujWMmHd6pB1GiPOIiBvx5c/VPwht
         w/GgpuPTSRmuv/gdOKc93aWcuiZSvLaQgg8aaQ41DCxXPnO2t5g0AOHamjJMf0fr3wMV
         KswUPdiGcWH6e6Sb6666k87PmuGF3ZvWvrnpw4Q/KVOI+ukYQvINJEIz+MU99V53i6oG
         7ldegbG0NV1ektI/gKthJYKxbfQjJyhs/tgSqRY/nLrtFAseGihdeSSAUB+lnB1nxNpP
         htbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772362644; x=1772967444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/PUY/W2xLVyfoFf7iYt6HuXRzFvXPfeO6RS8rO/tLc=;
        b=bHMiYEqgt3+jMqQk7AuTda1YK2p/2EJbEKcbLfRWXr9naaK/f77X77qpXzVs6vCS/6
         XR9BuvCD+Av+8itj5QM80VOo3UA4mCa0S8Y3xqoHOCVpRRLz3T8eUHUo+VAgoNUML27D
         UVtYqTRM4fP9F+l6lYKuf6TrkutpxYS0rUPHmnR7om9zHItHdIByVkS8etdSRf4dt2a6
         Dw1iX5laTVYABvhGbQv3zD8gbchrQ76tBX644GdaqyA4AU+ZhDvjjswjRL6r621xM5GU
         eiPTAaQfZ5RkXL8oFx42X4SOmYqeujFjBuvR3WGHzxn4x4F1TUPK36z4DQXhFgQp3soF
         cPXA==
X-Forwarded-Encrypted: i=1; AJvYcCXVcP8z16F4ALzitYiqmwAqmM+Y7RRYhaIh04AMo9RAMfmfYbqLGuaiSzJGuHBF1ZfIM/d1aw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn5SzxeO+AFb0+LnluazH5OqpT5MvdNBJE/qqOgdOD3Rxc/nPo
	a9QMkzvT+X1FzEv+p7bLoggHQVSBy0XkT/3r6s3Gcgn/T93eFBG9xZfy
X-Gm-Gg: ATEYQzwv8W/UOUVZrpomo+Ev53hxSlwe3gHFPVwVG2LMhO6McNfuLArY7B9S9EvMc/S
	ce9ITdJF4aJMSb/5y+rZrJYSJJ5+CpovDuWD+Jk/vJUK7hQI/8w9pkoR0I0cynUYFnR8gVVVmgO
	uMaSLc6lRKBdMBUm86hCgkgyPUK7ne32bKNaNAqKXm3QlYIvJz7KHr/ROfE7ByfbquZBvXkztdD
	lub7AJxlybhw8L/BYoo7dnMPmxqWrNuB+N2MEBZJN3d+reDkX/vq/20cXHY6e8qmq6MPbGVa+eh
	E2wd4sMks2Un+O4bRhDWRR7SC2RBkZZv7LbPWUn7Fbqr88eW7VKgfY8s4YImvYR2L4tVqgHAHdh
	YsfPWRhTxP2Ir3yKRu/SgT90RKKM0DH1LwvzXudnAeJGFjQUne/s2K7WV3r9j+ZHUf/FUIrGZMw
	T6c0jr4UskkqsLx8g=
X-Received: by 2002:a17:90b:4fc6:b0:354:c3a4:397 with SMTP id 98e67ed59e1d1-35965d02b63mr6792314a91.32.1772362643916;
        Sun, 01 Mar 2026 02:57:23 -0800 (PST)
Received: from hope.. ([159.65.159.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359833ef647sm2220754a91.3.2026.03.01.02.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 02:57:23 -0800 (PST)
From: Roshan Kumar <roshaen09@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: chopps@labn.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Roshan Kumar <roshaen09@gmail.com>
Subject: [PATCH] xfrm: iptfs: validate inner IPv4 header length in IPTFS payload
Date: Sun,  1 Mar 2026 10:56:38 +0000
Message-ID: <20260301105638.11479-1-roshaen09@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.34 / 15.00];
	RECEIVED_BLOCKLISTDE(3.00)[159.65.159.133:received];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222450-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[labn.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[roshaen09@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.834];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9D581CF472
X-Rspamd-Action: no action

Add validation of the inner IPv4 packet tot_len and ihl fields parsed
from decrypted IPTFS payloads in __input_process_payload(). A crafted
ESP packet containing an inner IPv4 header with tot_len=0 causes an
infinite loop: iplen=0 leads to capturelen=min(0, remaining)=0, so the
data offset never advances and the while(data < tail) loop never
terminates, spinning forever in softirq context.

Reject inner IPv4 packets where tot_len < ihl*4 or ihl*4 < sizeof(struct
iphdr), which catches both the tot_len=0 case and malformed ihl values.
The normal IP stack performs this validation in ip_rcv_core(), but IPTFS
extracts and processes inner packets before they reach that layer.

Reported-by: Roshan Kumar <roshaen09@gmail.com>
Fixes: 6c82d2433671 ("xfrm: iptfs: add basic receive packet (tunnel egress) handling")
Cc: stable@vger.kernel.org
Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 050a82101ca5..4cd0747367bd 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -991,6 +991,11 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
 
 			iplen = be16_to_cpu(iph->tot_len);
 			iphlen = iph->ihl << 2;
+			if (iplen < iphlen || iphlen < sizeof(*iph)) {
+				XFRM_INC_STATS(net,
+					       LINUX_MIB_XFRMINHDRERROR);
+				goto done;
+			}
 			protocol = cpu_to_be16(ETH_P_IP);
 			XFRM_MODE_SKB_CB(skbseq->root_skb)->tos = iph->tos;
 		} else if (iph->version == 0x6) {
-- 
2.48.1


