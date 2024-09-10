Return-Path: <stable+bounces-75763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF159744EB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 23:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B94D1C2581B
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 21:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5A81AB530;
	Tue, 10 Sep 2024 21:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFyuemhI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD51A7AC6;
	Tue, 10 Sep 2024 21:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726004159; cv=none; b=r/lD9bkNjgRh7smq/xoX1vEFn7tQbYJ+W8sdx5jahl6KZUknSPGciIC/lV5QAaYxGaR58NxwgyPSKmk8a21piOHFU6FO8bnoZuVJEeXpN+U5/ZJLI9jB6ffWe7dMXKKOI3/7vy+Tg/EFznbc3umg7Trql6PTuAa3en0vG5f2ygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726004159; c=relaxed/simple;
	bh=szFnczvHmBZ/pMniQwesxtxy7hfJ622efUkCBfeCJPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovnMO0E1xJLfFpls+RskSYSF4ndJ3u/iyOj9N56X1GdSdIkYdjoObvhdA4egafKWjDmHUlIMD1ljfxvPAsao/Lz30o9VUT1UXVH9GreCLlsYIyGCq/jTIMvJeXIe1VpFnyXo7Gd8znZW1aQ0wq1sHRDuB26aCUZf9FhSACSok0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFyuemhI; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4583209a17dso20961081cf.1;
        Tue, 10 Sep 2024 14:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726004157; x=1726608957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q37krJr137qr8WgC32YYtTAU5pG51Ymlb6eZufhZZno=;
        b=iFyuemhICKqHy0NHT9jE4qwLUksdw5El3TF00VfgUfkC1guo0XkPport3upLmZyKbT
         wzXKMTh38je0Ct32knejKBl4j4vFtfFbediqaYq6CSGHzhC8J1VHuIprRi3cBEu+xQ5X
         XnxdN6uNkobCRkIdy3eq688oEMaFhgJvVQLp+EGeJIVsmZo2MxiKmPpMeoO8tc5b/lOC
         A3BvPi6osLjJ/f+eDZFeZa+bQz8MzFx0Sjt7VJXmJvobYXGfNyNuDYl+BZK19rXIPa5R
         hfafaf3mOGCvycf8WvzlJUJ4P1+Cjn7+6uQBnAH+RmlM/5QqSUlYfP4SpB6bEpztfUAr
         aIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726004157; x=1726608957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q37krJr137qr8WgC32YYtTAU5pG51Ymlb6eZufhZZno=;
        b=AFMLgK4vnNUi2gnd4A0DyFm39gZN53YwcI1ptTXl36kGb66hI0++P5s/4HNSSw24yb
         ZZ4b7ZTsf0ohpmPY5FiOYwK9ekk/EyIGX4P4wWbE52YEWalfSkwB6I3yawhkr+dO5Bio
         GZx584TUyyh/IeuDNKs5ZbFNZ+KXSxt84L2mzmz/a8+//qTP80nXHri9gXOCZl5Y2tay
         PuoxjPqhNARp70iyBUv5n1/d3fOx9ILADyQ8pP8DXyDXkPfufCRwPlfIknUXF4cvnaJC
         SwKnyRYj+Y5OKl9S42VBo9eoPsPnNb5lo1IKe8YUwFnpeR8rev5/jy5l42A0ddJvlgAu
         1riw==
X-Forwarded-Encrypted: i=1; AJvYcCX2wmFKQLAEwDCcbmQm0rlqK+AVnEQ98cNvVPWmmJ91vdpKGidaqpwAUyduyjY+Yt8XBCwD5/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/TBdPMtZbeXMOUQn+HOkjC/EqBlDrUHqK9jrMuMmFph9JjHrC
	zNXrTLc6GXGj3mh2zVIsj7ryTe+D//MC0rx0ymbInDEG8JSuMZdQvxce8g==
X-Google-Smtp-Source: AGHT+IH/FKyl/I4H6T2TpJyVr4rSrA1KpyyI2nimgOPNLc0sR8fu4ipUU5lfEnKkHFCztcp2NluXkw==
X-Received: by 2002:ac8:588a:0:b0:44f:e905:e5f7 with SMTP id d75a77b69052e-4580c7a1cc4mr273993611cf.51.1726004156960;
        Tue, 10 Sep 2024 14:35:56 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f99490sm33190861cf.94.2024.09.10.14.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 14:35:56 -0700 (PDT)
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
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v2] net: tighten bad gso csum offset check in virtio_net_hdr
Date: Tue, 10 Sep 2024 17:35:35 -0400
Message-ID: <20240910213553.839926-1-willemdebruijn.kernel@gmail.com>
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
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Cc: stable@vger.kernel.org

---

Changes v1->v2:
- Fix Cc:
- Add Acks from v1
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


