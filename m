Return-Path: <stable+bounces-74079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A244E9721D1
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 20:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BD49B21D93
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 18:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5400D189531;
	Mon,  9 Sep 2024 18:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlBqXSvn"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFF188CDF;
	Mon,  9 Sep 2024 18:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725906316; cv=none; b=ewn+MWQyIJdqNwvje+fRPJ2DS+oq3FYP1Zys9oFqKbs16GjJsveZfx6CV/Ab3x2QajvYFPOdxGhBP4IEGYwwpZs+Bgq1oraFlu3KRAZwBAoyTmAUBo9RzN1X/vPQJBoOa0/G7VrqZeOaIIQTBFM7S0x1aNdL1YMBJsCFBwwOmwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725906316; c=relaxed/simple;
	bh=sqp3Jb7309g99lM2SaWG66wBurjC2CnfBdhzLNMbQIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNrr3KCKNrjC65RrW1bIG6C2rURMppYRX8bcbRP3tS3oybzEI+5vy/3EQjYwcqOhLw5jm9Afgr1ongwtZfvm5LRzbZy09clsgnfF7l/lGNrk/dEPgVZOJ6juo12sX9OrM+G57PqcAapU93/vnb/5uRTXBUf/3ZTzcB55SuRkgK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlBqXSvn; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-457cfc2106aso28964811cf.2;
        Mon, 09 Sep 2024 11:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725906313; x=1726511113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdqYkffSI1WpSWXJPkr0N2UKeKHDjtAb4mnO6w7K3G0=;
        b=AlBqXSvnVQCrhCvnQsrbwQbxJpDn/D3oWw2ernlR+TkRBIEprV0Z8ZxrFeQq4/oXg+
         CZBpxcSDyhwKpkLLfcesFtIeAVTdJAIyJLB/LhTo1bXgx+2GkJ/3tO8VWGzmUWxtMsiV
         mPPGwchSaVj1JIEKUDOeNWWlNmw9WNfnZfKqV7bAbSoJUlO62D4lpIFZqJ/D/kvYrKGn
         nrJuYtepoOdS6BQejpQURrt4DTehzFH+YWP56+1j4dTWDB9d/ApmFU+x4fLADb43R1fO
         C9fQ5R02WffQBqSSZ+Zh9NneswiTs4z0jGVRHkBopQALZXgWl3iwvNGnYdxZbZs8PRWt
         PhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725906313; x=1726511113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdqYkffSI1WpSWXJPkr0N2UKeKHDjtAb4mnO6w7K3G0=;
        b=oC8CbQ8NXXheLLzIPKCPAV/ElxMfEIXS9XnhhhIePEe7OvJlT4F4LB5g3Rqufg7EsP
         R3nG5N6ORPpgzBaVKQMTlL4G/3wjUIeAVkaQPJsDmMrccqcmvR73eOnyUB6tP/h+mul5
         aBH3S+mlg96zzTon12Gbod9KGVZW5vQDdk7lBQF0HRNC1EouQoCSzh7OQP3L8P5A36in
         ZtSLrMd2YKGX4UCDN//bqaSWkobJPOurXmM0zbuKz0wqJHqX49ChcN7vGrrMap+yskqo
         9fOf+QYvpYcnxxbIsmqjwysTne5V/UxLCPcbnfa8p0j74ZH/2ldVcqNwWFVKxKFxmL/r
         +s1w==
X-Gm-Message-State: AOJu0Yy8eWT6cd8OqaCyVTdL05PAru4usx7xa950TRAg37UGqVm7CR4u
	gxYClPB0uBumeaJq4cb8aG5CZ0KkHV2FGISTWie/0DjLLQrrfIg14QQTJA==
X-Google-Smtp-Source: AGHT+IEjdhwn4B/Dr3o0istglWgnYHr+lKlXlsDSBsRfe/14wykfq0QlbOwmgbXVQzBLwj8Jb2B9FQ==
X-Received: by 2002:a05:622a:38a:b0:458:3148:9a50 with SMTP id d75a77b69052e-45831489bacmr63595531cf.51.1725906313388;
        Mon, 09 Sep 2024 11:25:13 -0700 (PDT)
Received: from willemb.c.googlers.com.com (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e9b231sm22539071cf.47.2024.09.09.11.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 11:25:12 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: stable@vger.kernel.org
Cc: netdev@vger.kernel.org,
	gregkh@linuxfoundation.org,
	christian@theune.cc,
	mathieu.tortuyaux@gmail.com,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 2/4] net: change maximum number of UDP segments to 128
Date: Mon,  9 Sep 2024 14:22:46 -0400
Message-ID: <20240909182506.270136-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240909182506.270136-1-willemdebruijn.kernel@gmail.com>
References: <20240909182506.270136-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuri Benditovich <yuri.benditovich@daynix.com>

[ Upstream commit 1382e3b6a3500c245e5278c66d210c02926f804f ]

The commit fc8b2a619469
("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
adds check of potential number of UDP segments vs
UDP_MAX_SEGMENTS in linux/virtio_net.h.
After this change certification test of USO guest-to-guest
transmit on Windows driver for virtio-net device fails,
for example with packet size of ~64K and mss of 536 bytes.
In general the USO should not be more restrictive than TSO.
Indeed, in case of unreasonably small mss a lot of segments
can cause queue overflow and packet loss on the destination.
Limit of 128 segments is good for any practical purpose,
with minimal meaningful mss of 536 the maximal UDP packet will
be divided to ~120 segments.
The number of segments for UDP packets is validated vs
UDP_MAX_SEGMENTS also in udp.c (v4,v6), this does not affect
quest-to-guest path but does affect packets sent to host, for
example.
It is important to mention that UDP_MAX_SEGMENTS is kernel-only
define and not available to user mode socket applications.
In order to request MSS smaller than MTU the applications
just uses setsockopt with SOL_UDP and UDP_SEGMENT and there is
no limitations on socket API level.

Fixes: fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

[5.15-stable: fix conflict with neighboring but unrelated code from
              e2a4392b61f6 ("udp: introduce udp->udp_flags")
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/udp.h                  | 2 +-
 tools/testing/selftests/net/udpgso.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index fdf5afb393162..ca31f830b0110 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -94,7 +94,7 @@ struct udp_sock {
 	int		forward_deficit;
 };
 
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 7UL)
 
 static inline struct udp_sock *udp_sk(const struct sock *sk)
 {
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 7badaf215de28..b02080d09fbc0 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -34,7 +34,7 @@
 #endif
 
 #ifndef UDP_MAX_SEGMENTS
-#define UDP_MAX_SEGMENTS	(1 << 6UL)
+#define UDP_MAX_SEGMENTS	(1 << 7UL)
 #endif
 
 #define CONST_MTU_TEST	1500
-- 
2.46.0.598.g6f2099f65c-goog


