Return-Path: <stable+bounces-74101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C0972643
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 02:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3171C236B6
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 00:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7BA381DF;
	Tue, 10 Sep 2024 00:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxGv57Mp"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8F38DEE;
	Tue, 10 Sep 2024 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928840; cv=none; b=Try0jVpRzRAGgAZgMnWigASJt44nmr6SUb31o5lz3oj9H7mA6XMomlso+9LG4bDkFAbgW9FKa3+ZeAGjumNf8I2LYygbfBk+NGGp6oppRBH3eMYZEd29hDlGcfYxmEQ56Crcf2tPRuWqL6qsdtQYRe990PfjuZ8/b4vNkQW/O/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928840; c=relaxed/simple;
	bh=W9Ec/4M5Hqdwnm0ZX2FsSlLSgDNUAHxUswXwuicKcpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZ8RqxK3cJeds2+RacKh98hwT1yDMRz3+Jv/Q1ozlGUEAGq0HWi1abGYan5cBrUNAHq1PE3WNu2wkx4p+V8XJ66Kq0AbmVgNM+0Q9XTstBOQpt7i1GzC3lO0kimIgvgUiGyyHPMLprMuZK22bnI3293YE3npvGlxRMTXK0AZHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxGv57Mp; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c3603292abso30176746d6.1;
        Mon, 09 Sep 2024 17:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725928837; x=1726533637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9qE2wcDsDoLR4dqMsET0ntxC7CBRgYz+XLE+Vql4O9k=;
        b=OxGv57Mpe+F7zYlvnN8e0Dr+Lpku3Ub+/7bvhsygqodI59cKWONTtMJGIqirYUVe3g
         5LVT+msPV8mF4n78fogML1BkMWUjMd2ICXNMWlOocl6q+dvZ007qdf/pVePW6lpU7PkJ
         /UPbUv5JRtIBKr6PwpojaKm8QDpvBv2EdV6ov7YWDaUU3D+0++Nfoh+3DWjdj9wnFPpy
         dfu3R2TrEJ8qHueVRKZkPYvbs/hf1dUEU7lwr7CfWnti6Avb/QrqeEFHvUuhJ0n594wZ
         mAeg0T4l12mU552r5y6/QeFTXpYM8rB9ibegIfHVT26RdhSRppsAf1QVibrQq8abF0LF
         If5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725928837; x=1726533637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9qE2wcDsDoLR4dqMsET0ntxC7CBRgYz+XLE+Vql4O9k=;
        b=hWP1B1NlXE3u1/Z/Cj+5Oinvoww0jZgZqLxonG8WmbUHXVlf7ljOSU4M5yi0WWKF0C
         RDf7puNKfltT2Zn38u3TWu+EbrhGjne4lERzgZnqATMvJkRfXtEpps56pIIC7IhgW8q2
         CjtfJwgEbwk3OV4t9hKdVNnLUY94FWzWOPN52+R6Yew8mOVOBKeJ5pmN+kKPwsm0v6bB
         D2QhzbDwS8vJ3PtszO5bBf4QUkKuVOKhsaMYuUF48u6bAw7AcyPzD+FbvjPs5ZItBeNP
         ED7ZYv+NLjKdsS0YnoX2nBfOB7FQ+ggfNyFTfZaqGgyUHuZvaXZHg9LHqffYf2fF4/W+
         cTgA==
X-Forwarded-Encrypted: i=1; AJvYcCXGYw4poFWO/nRmTdaSmnNUcU3mrENyZUC1zgAu9xMKr7cyeUDJm2KqJFsviYOSv8NCpXf8WQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFrTHDvrSsyMJg3ffC7iaR39UDTzcCpVHw2vwhU+LYMQOTR75T
	X/DQb8AtLhKqaP7L+0ySCAL0KKSTfpCff4GWPJtAbVL7XRlBHf5sHJcQhw==
X-Google-Smtp-Source: AGHT+IG3Tpi3qYI/5NE3NQH7zbsqBCkaT+IVmZyBW6utpRfULhL9uAwcbU4hxY4QdnX35JV7SSeLHg==
X-Received: by 2002:a05:620a:c46:b0:7a2:bb:2cc8 with SMTP id af79cd13be357-7a997336875mr1572628685a.18.1725928837185;
        Mon, 09 Sep 2024 17:40:37 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a796adfesm261606085a.53.2024.09.09.17.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 17:40:36 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	nsz@port70.net,
	mst@redhat.com,
	jasowang@redhat.com,
	yury.khrustalev@arm.com,
	broonie@kernel.org,
	sudeep.holla@arm.com,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.net
Subject: [PATCH net] net: tighten bad gso csum offset check in virtio_net_hdr
Date: Mon,  9 Sep 2024 20:38:52 -0400
Message-ID: <20240910004033.530313-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

The referenced commit drops bad input, but has false positives.
Tighten the check to avoid these.

The check detects illegal checksum offload requests, which produce
csum_start/csum_off beyond end of packet after segmentation.

But it is based on two incorrect assumptions:

1. virtio_net_hdr_to_skb with VIRTIO_NET_HDR_GSO_TCP[46] implies GSO.
True in callers that inject into the tx path, such as tap.
But false in callers that inject into rx, like virtio-net.
Here, the flags indicate GRO, and CHECKSUM_UNNECESSARY or
CHECKSUM_NONE without VIRTIO_NET_HDR_F_NEEDS_CSUM is normal.

2. TSO requires checksum offload, i.e., ip_summed == CHECKSUM_PARTIAL.
False, as tcp[46]_gso_segment will fix up csum_start and offset for
all other ip_summed by calling __tcp_v4_send_check.

Because of 2, we can limit the scope of the fix to virtio_net_hdr
that do try to set these fields, with a bogus value.

Link: https://lore.kernel.org/netdev/20240909094527.GA3048202@port70.net/
Fixes: 89add40066f9 ("net: drop bad gso csum_start and offset in virtio_net_hdr")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: <stable@vger.kernel.net>

---

Verified that the syzbot repro is still caught.

An equivalent alternative would be to move the check for csum_offset
to where the csum_start check is in segmentation:

-    if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb)))
+    if (unlikely(skb_checksum_start(skb) != skb_transport_header(skb) ||
+                 skb->csum_offset != offsetof(struct tcphdr, check)))

Cleaner, but messier stable backport.

We'll need an equivalent patch to this for VIRTIO_NET_HDR_GSO_UDP_L4.
But that csum_offset test was in a different commit, so different
Fixes tag.
---
 include/linux/virtio_net.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 6c395a2600e8d..276ca543ef44d 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -173,7 +173,8 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 			break;
 		case SKB_GSO_TCPV4:
 		case SKB_GSO_TCPV6:
-			if (skb->csum_offset != offsetof(struct tcphdr, check))
+			if (skb->ip_summed == CHECKSUM_PARTIAL &&
+			    skb->csum_offset != offsetof(struct tcphdr, check))
 				return -EINVAL;
 			break;
 		}
-- 
2.46.0.598.g6f2099f65c-goog


