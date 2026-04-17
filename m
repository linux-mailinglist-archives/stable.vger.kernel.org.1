Return-Path: <stable+bounces-238409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPbCKRDL4WkhyQAAu9opvQ
	(envelope-from <stable+bounces-238409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:54:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF44541730F
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 07:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE4F6301A2D8
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 05:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099B1364E92;
	Fri, 17 Apr 2026 05:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU5p9g4y"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBC035DA52
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776405254; cv=none; b=tORIscCuDOc/0A9Qk8zlD42BJpkO0+dBmo41KowgacF3gKr0HtvXA4G/kBTshMwPsDxvECtPxD4ItYb4P6+Hhq9YtbCX9dVZjVBgFoP1BGyGbsTVzX+9YFb/dLN7VzPfxtiEXxJfM1B+7sBS1NEnQ0PN3sZl0WvTZR/4hmejCSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776405254; c=relaxed/simple;
	bh=ZPVoDRVg5qdPPlFaadv6E/ZkAG3Lq7FAW7jz2H11nco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=clzkzYGFLpgqnZ98/DGyzKkpo82tdKk3V4KN2ia/89VDYcKRL/IMtmosmk+Aiy62/DnLC26fKfXPFQFRFZjQ6rbZBSSM7rcAGaPPIoeOjLtmrcEZoVEdvthygUy+yzfuunZShkt0N71qCxmPje7sq5x5aQiIR9ebUQ4LmeJqttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU5p9g4y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so2078275e9.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 22:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776405252; x=1777010052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FI4aNMoH9LEGA5ZaunJU6TNqTpv8Ar0cTiNa6gwkLx0=;
        b=dU5p9g4yTLVz7u2/Exy32txOaWb7TyvQ8EPL3f3AyzSarc4YAcr/Q7M7JXKByXOglW
         cH3ZCi+PkwHJT/f0+gPqoZBWC6C+zez/XgSyKqHNP++hyXLIyvQjHWPatbfeBzgfUnOq
         14l5EBde5cFGnkieja5PxNXxjfaFIyw0Pr7tCOU4/q74YC37xYei1pwqJ8P2/uzFpxdY
         k8r3D/vuN2ydQbzJnfJgkzTc56e9hp79qJ5Q5oxefQA73isBmMHDv5FXyyQoN6LUBFi1
         DWoDtaHlVJfgEI2fdT5ujhJnwKlsphRWTENiX1wSH/iDgsqFpZiZJLCt84cWKVVGa0lw
         GYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776405252; x=1777010052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FI4aNMoH9LEGA5ZaunJU6TNqTpv8Ar0cTiNa6gwkLx0=;
        b=jVVtgOmViytIR5pfBTn5dhSckBuogDW2BMuXZHqiwD9Txz8gvIQtlq+MS0xlqY+rNK
         VJHwJLxKOL4sigeWN+osu/PbDTct02Uq4eo96ishdlcnqKlEqyyDIk0l7XST0PuZPhnk
         Hq7jRUzdz3LZg2ydwv5/bMQK2c0SeeajSMcMjfDhkODTB4jl7jmnhuQbsi2H9iMAgkBH
         xRuwVSIt2GJf+DI+iq4XMQNNKGE/aJJ/aRZlfJyWwDcgmo8keoIvY0WCy5rKyLob0nbH
         Ro2WNcJ/WXv4IWstQeDSXOo3MccaZZ0MLJsapmZnDRd76dYzSDsBHjjJbxWyxnMpMj2y
         pzuA==
X-Forwarded-Encrypted: i=1; AFNElJ8yh4NO2u8yTrziEaQQp94enQhW6ypQGKcA4TcRbbLiZ8toYUIOnlM54oRHXm6cH3raMsMLwUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIKyXc+5vE35R/5QzcEGj5BT9wXiB3rMWwyLxk1sTu01I7fcr
	/8xQ19WzBGdbT0pwBw+NEJ3tknj92ne+BXt5zXAJrtZXiBwHtUBiFV9G
X-Gm-Gg: AeBDievr2H7Xf1rU6DuiX5QNaa9MWU4rOJQ5XHj1zGvapGSJQpiZYyhzKE6h/gKqhLh
	iTjojMoMgBxgmmoVmlVwH6jRzpHk+4onYgZM+rAPPaBPtc6Gcuv+NOxWuQ9mAA1oeZbaxa3g1jg
	cDcT/09Ii1DYKccdZH2HlVv3jkMp5CmZy92sE7JGG1twBJA7v4VErob7Y632d5mQkVg7YHum7SH
	6ziZU9ur3qPNiuCNJ4KKLKd4KDJNjidYOmv5JGRti3vyDGBtlsWw1u8FodUMyiLReZMsSuvtVeN
	Yc02oFt20G6dpy8k7THkjGIsw8zObnt134tnYb+SbPSHZveX4xn3shCVhTutzqjYXKBYRRJKm7K
	2ZFtQWU+ETX1+bZFhq1W3WWsXTfK/uvmRYtkjBbnzO+S2cZ3w3MSK+UoxnNNlyLgev6GUj+ZmiE
	NnGTkfAZsn+unSMaQX3Z0cHwXJArD7dGoKB95UrXDvg/sxgS/C0XEYWpAPqsY4b1J6yUx6b+fAD
	MKNuqQtKPU7XbGT2egw3A==
X-Received: by 2002:a05:600c:8115:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-488fb77e27cmr16466985e9.22.1776405251618;
        Thu, 16 Apr 2026 22:54:11 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c96b4sm27246775e9.13.2026.04.16.22.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 22:54:11 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Weiming Shi <bestswngs@gmail.com>,
	osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
Date: Fri, 17 Apr 2026 06:54:08 +0100
Message-ID: <20260417055408.4667-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.osmocom.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238409-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF44541730F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

gtp_genl_send_echo_req() runs as a generic netlink doit handler in
process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
on softnet_data.xmit.recursion to track the tunnel xmit recursion level.

Without local_bh_disable(), the task may migrate between
dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
per-CPU counter pairing. The result is stale or negative recursion
levels that can later produce false-positive
SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.

The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
the data path runs under ndo_start_xmit and the echo response handlers
run from the UDP encap rx softirq, both with BH already disabled.

Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
commit 2cd7e6971fc2 ("sctp: disable BH before calling
udp_tunnel_xmit_skb()").

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/gtp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 70b9e58b9b78..5150f2e4f66b 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2400,6 +2400,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		return -ENODEV;
 	}
 
+	local_bh_disable();
 	udp_tunnel_xmit_skb(rt, sk, skb_to_send,
 			    fl4.saddr, fl4.daddr,
 			    inet_dscp_to_dsfield(fl4.flowi4_dscp),
@@ -2409,6 +2410,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
 			    false, 0);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.53.0


