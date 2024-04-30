Return-Path: <stable+bounces-41819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393958B6CBB
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE681C2239C
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B767BB01;
	Tue, 30 Apr 2024 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPcOazMS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0081982881
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714465462; cv=none; b=CgVq8r11dDqJBFYzS8Q70lDsohpOo4ic9UxioppLTfo6ueddeZowHt8hut1B2DBzmghqTAK/16dHuA1N7qx8a3nEsGMDsGHj3/cBeaCQuVYRX5tu6RD1fzedPiVk/uaFJ1cXkqd3xyKkYEsUpAAyEFLB9rsRcIU1GQOvq6xb4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714465462; c=relaxed/simple;
	bh=izEKY8mbazwRET5cSOSq/UpC50dz4XlYBmOrjydPn18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PbuT3IvUPr+BcjngV8v87sLmBXwW+Gen5TQs9Vf7q+Hplsv83J6DhvkDlJAsaypghMN/OOU/JZIWz13qvgQvBF2jz1UqvV7E5VlJOMhpPfQ1+RmaSjqwdoP2jnaSL3YbMee2muA1WlBxBn8qrDFJPIVlcF1Kt34lu5jwTf2dEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPcOazMS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f30f69a958so4653478b3a.1
        for <stable@vger.kernel.org>; Tue, 30 Apr 2024 01:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714465459; x=1715070259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHyWy6mwRypv7w4zRcHYIk6uqA+8X+KzBmdACfpbfJ4=;
        b=QPcOazMSYAEwodg2DMWODWDbQxE4wKcG+T8+vHHhDAdbIUDM73g6yLHiryLOSq8P1P
         BqHij1G0QAp/HcBZxSt25tbSJdno/IvnAqR83UJ86R1gT+jvCBbnp/ivsCiu2iJR1vBR
         rkd3MOqyt1FrMoI8JagDxfYxk17IqYpa3GSghbsu4cwVMcB0HLnXeBP6RhCcjFSvBrJI
         swYChBM6XKJY7mocMfe5QW1sXdoaLFh90XEz+UaeqKQ47F9z3x1dM3ubTWDiDkN6OwYv
         OECjQ+eBR9LcoSAXcVzUoZj0m+vX1kNA5hxdzX2OhwY6Nh7eExldyoc/Ut86ZuiCKnxU
         WKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714465459; x=1715070259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHyWy6mwRypv7w4zRcHYIk6uqA+8X+KzBmdACfpbfJ4=;
        b=g4Z80OWPwmMawG+8lHAD6bVb+Bc6Wuc9TFKE2uWAFZ7LWwr3FWnl2m97WnOzMYKCB+
         kggMWMOSkkAXV07YpdlYcb81QZ0urgEqSS+9C0JyB8nZQotfjI7XUi61AOImXAKeKDQU
         HITe+xohuc2RXHIK6+gOgkGWUAM0WIyikU6DTAtv4BC6aCRUvNCZvW6ViG9m82VA8nhS
         oil8kxcGC5wUeE2hG007G39rhEhZJj6nVLhsgzmdVumUH7HvxCTynQvbFyAY5isxNcqJ
         JSxggr3WK3FHKcKYHQSnQmHeemoir8xOZBFGmuWBjI0XCvcQ5pG4d4LTdOOagVjOCa5y
         GYvQ==
X-Gm-Message-State: AOJu0YwBxVnVFJKNGunwAnVh32bMIX6+ynJH6K78DKdV4le64pzb2+QR
	XORMWnuSGajfi6DcFUwf0r/OqbkkDsiHvyIuaTVV/EqNtZ34apoF2ijrxdgB
X-Google-Smtp-Source: AGHT+IEYcUJ3smttmNZDOPV8+5A+nu+6H0bCpFAOuKPeTnsTUAs2soQm4eqIY45Tmti28OkFUT7onA==
X-Received: by 2002:a05:6a20:948f:b0:1ad:8ae:7430 with SMTP id hs15-20020a056a20948f00b001ad08ae7430mr1589001pzb.52.1714465459373;
        Tue, 30 Apr 2024 01:24:19 -0700 (PDT)
Received: from localhost.localdomain ([67.198.131.126])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001eb2f4648d3sm6660000plg.228.2024.04.30.01.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:24:18 -0700 (PDT)
From: Yick Xie <yick.xie@gmail.com>
To: stable@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4.y] udp: preserve the connected status if only UDP cmsg
Date: Tue, 30 Apr 2024 16:23:49 +0800
Message-Id: <20240430082349.3156610-1-yick.xie@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024042920-overcoat-cannot-efc1@gregkh>
References: <2024042920-overcoat-cannot-efc1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

If "udp_cmsg_send()" returned 0 (i.e. only UDP cmsg),
"connected" should not be set to 0. Otherwise it stops
the connected socket from using the cached route.

Fixes: 2e8de8576343 ("udp: add gso segment cmsg")
Signed-off-by: Yick Xie <yick.xie@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://lore.kernel.org/r/20240418170610.867084-1-yick.xie@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 680d11f6e5427b6af1321932286722d24a8b16c1)
Signed-off-by: Yick Xie <yick.xie@gmail.com>
---
 net/ipv4/udp.c | 5 +++--
 net/ipv6/udp.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 3b3f94479885..b17b63654812 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1054,16 +1054,17 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	if (msg->msg_controllen) {
 		err = udp_cmsg_send(sk, msg, &ipc.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip_cmsg_send(sk, msg, &ipc,
 					   sk->sk_family == AF_INET6);
+			connected = 0;
+		}
 		if (unlikely(err < 0)) {
 			kfree(ipc.opt);
 			return err;
 		}
 		if (ipc.opt)
 			free = 1;
-		connected = 0;
 	}
 	if (!ipc.opt) {
 		struct ip_options_rcu *inet_opt;
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 93eb62221975..e6fdb842e89d 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1387,9 +1387,11 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		ipc6.opt = opt;
 
 		err = udp_cmsg_send(sk, msg, &ipc6.gso_size);
-		if (err > 0)
+		if (err > 0) {
 			err = ip6_datagram_send_ctl(sock_net(sk), sk, msg, &fl6,
 						    &ipc6);
+			connected = false;
+		}
 		if (err < 0) {
 			fl6_sock_release(flowlabel);
 			return err;
@@ -1401,7 +1403,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 		if (!(opt->opt_nflen|opt->opt_flen))
 			opt = NULL;
-		connected = false;
 	}
 	if (!opt) {
 		opt = txopt_get(np);
-- 
2.34.1


