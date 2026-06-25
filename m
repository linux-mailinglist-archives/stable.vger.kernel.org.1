Return-Path: <stable+bounces-268303-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wnsgIBLnPGqCuAgAu9opvQ
	(envelope-from <stable+bounces-268303-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:30:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4DC6C3CED
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 10:30:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BM9QD2FS;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268303-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268303-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AC5D310C47D
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD155380FFB;
	Thu, 25 Jun 2026 08:25:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6423806D5
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 08:25:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375921; cv=none; b=U733erxu4hYEgapuqZvyDh3TGT438J+L13Q8S8fqPZTweRXoF0kDhTTouyXpGQDBVG3BRU0UWKjJxrg66yA6YcIHSwYrQvm9c1jW1flk33kSvJT6wbCXGmsGGE2urqPSRJqtIeEJKAq5Auxpo8PVB888ZhqpKvaeKBUaA9YUw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375921; c=relaxed/simple;
	bh=N5soKUtSuwwQrMT2T7V6ESS7YgqojhHhVowe5dyJBfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHHk8b/2wB4gupGAanV8bfwl1yoIATD7RJ+wC6pXJ3NzCrzMZxjciV4Y2bijlS0MVtL7BbmX7n5nR38uilFTKO3b3uMVHA9slRjyhNE88gQUn1EH0joVqmmowHyof6Tr/Q3LA+R09aoOtZOmLFViqO+z8qKoQ7K9yC/FzsWLOvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM9QD2FS; arc=none smtp.client-ip=209.85.208.174
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3967726bc47so17614501fa.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375917; x=1782980717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDCoYVBjQzZ+2LVFbZQGc2v/ECMbMCzgWa8ygBvGziA=;
        b=BM9QD2FS0fNbB+1yZP0H7rtV4vPiPh462laUpaxOcOK+VwgG3s3e7XmeeHZp+nljhk
         nCytwEuSQYb1FinforY0l4H9tbCTRIy+vk2wkqPCqXWqCIRGu2RfmphGaFGZpcfGwFej
         w7rqMhV1z4xxpDFRn93baKBhXAQvnCMTogM9ekBcv3tnrjuJDvb7DAGMffDdjJtDvS4A
         18zKTFQ9cW8Wes44aCTyFnPphoSnv4b4/YwV0EUMz+1VXhpXkBfnvdWKG0b/mK5iuqCp
         d4yx1oGxXU6qD1TrC02cha5OCc8/vvOp353Bygu7TmZMlZ09KX+MPlXvfxd1ZCR/N9f0
         93ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375917; x=1782980717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HDCoYVBjQzZ+2LVFbZQGc2v/ECMbMCzgWa8ygBvGziA=;
        b=Qgp6TkmQZRb0VueASkn+rV7o8C0RQE/Zj9KL2FtAWW7Kt3XK3wy4kQGWFJ9ifnSL8J
         EGKwWL/UxLHiRCNPDuTTWLzhOj+cWBpu5ag96gw6xza3HYnzRElg+ol66ggLg0kZy+J+
         pZ9YCoyEfabyqpzH7VmAzNvloI/5o1rbn0GjhwZvP/5X29PRBYbWipLatft9tHcSnv21
         wRTKa79KCBlnWv2Y8LC7vLh9Ocyjz7bekM9mq8Q6ylfeiKyzv/SLoRodr+2I/tFAMCtp
         dNqs3vX105GR0AALqwMm6bm20SJqq1OgPjB9Qw2vlX/0ZGYiCUvXEnpD2TvSblStmrc5
         3n9Q==
X-Gm-Message-State: AOJu0Yw2TOWLyB9j7YjNSLDZina0s87TsAsWq7Jiz+D8ZhwrEK+ZhKmP
	I8gCvobECD6B2yL/sDdIUHJshrZhON5Ka6FcyAOVM5VBmIGgfEaqucasj+IegCMtdkA=
X-Gm-Gg: AfdE7cl4Ydfe5AR+Bq2DoVtRyjS1Byxe5n+qbbBbBNqYw+G+eP4+5qWzTr39PnZRES7
	DBVKzim61H46pYaMC7QL3D3DgL+M1lIZqVnT/Sn9kYsE1RLYHyyOQpTEJ8tzLdWgGc0jyRUHhaQ
	+s3dE8dZuNsgDnfT3CWGtjXh7i4x7nnUvvCa9aGkXkPQsyhgf1x5KN6bKDRyZf7A44e4LYszV2l
	32vofnpLwmSpKORbWLQ8bRNRwl4GVobDDpxslHZr5TeslesZLVwnTzi8kGilEI2BHzN1HROq9os
	gC4akEppfn2vtO3h71rTRkTJilUi5rGgcl7DdjKVAQ5KZQlU8cGaLydZ7BV7n85CIkXcYdlHCjA
	PtsYVqy+41glS4zkD1Rda/UaRyl/JXlnunD7zPepbfqos7rVaV4ItqhrS8uVAP0L4H5c52grffC
	6Xl60Df+2/+1DXog6ShS6kpHGRtukuVWJUEzwFaM8=
X-Received: by 2002:a2e:a547:0:b0:399:876b:3a9c with SMTP id 38308e7fff4ca-39acb69d932mr3596731fa.16.1782375916764;
        Thu, 25 Jun 2026 01:25:16 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ad31a81adsm566391fa.28.2026.06.25.01.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:25:16 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12 2/2] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Thu, 25 Jun 2026 11:24:42 +0300
Message-ID: <20260625082442.96390-3-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625082442.96390-1-alexevgmart@gmail.com>
References: <20260625082442.96390-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268303-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC4DC6C3CED

From: Xin Long <lucien.xin@gmail.com>

commit 2cd7e6971fc2787408ceef17906ea152791448cf upstream.

udp_tunnel_xmit_skb() / udp_tunnel6_xmit_skb() are expected to run with
BH disabled.  After commit 6f1a9140ecda ("add xmit recursion limit to
tunnel xmit functions"), on the path:

  udp(6)_tunnel_xmit_skb() -> ip(6)tunnel_xmit()

dev_xmit_recursion_inc()/dec() must stay balanced on the same CPU.

Without local_bh_disable(), the context may move between CPUs, which can
break the inc/dec pairing. This may lead to incorrect recursion level
detection and cause packets to be dropped in ip(6)_tunnel_xmit() or
__dev_queue_xmit().

Fix it by disabling BH around both IPv4 and IPv6 SCTP UDP xmit paths.

In my testing, after enabling the SCTP over UDP:

  # ip net exec ha sysctl -w net.sctp.udp_port=9899
  # ip net exec ha sysctl -w net.sctp.encap_port=9899
  # ip net exec hb sysctl -w net.sctp.udp_port=9899
  # ip net exec hb sysctl -w net.sctp.encap_port=9899

  # ip net exec ha iperf3 -s

- without this patch:

  # ip net exec hb iperf3 -c 192.168.0.1 --sctp
  [  5]   0.00-10.00  sec  37.2 MBytes  31.2 Mbits/sec  sender
  [  5]   0.00-10.00  sec  37.1 MBytes  31.1 Mbits/sec  receiver

- with this patch:

  # ip net exec hb iperf3 -c 192.168.0.1 --sctp
  [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  sender
  [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  receiver

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Link: https://patch.msgid.link/c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 net/sctp/ipv6.c     | 2 ++
 net/sctp/protocol.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index b4c321bad033..b45cc51dfc35 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,9 +261,11 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
+	local_bh_disable();
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false);
+	local_bh_enable();
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 39ca5403d4d7..6ea15361088b 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1086,9 +1086,11 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
+	local_bh_disable();
 	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.43.0


