Return-Path: <stable+bounces-115018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B153A320F3
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F227164E62
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 08:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D48205506;
	Wed, 12 Feb 2025 08:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mkim0CQx"
X-Original-To: stable@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC8204F73;
	Wed, 12 Feb 2025 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348642; cv=none; b=d9WdP1sO9Rl+gyCrlDgSeSQTKajC/xVmXQp2QXSFUsiZ6a4Lpz+1EqIxwyLHvvG6XDuRrf3FTAbQQdARUBUhl4Z8djEH1l8veZFWeVgWIj6hYogi+sR1KOQ7cwYi+kiIgj5x63I2mtPfSinX0Umy9RT3YLDDgeRlqvARA7FvrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348642; c=relaxed/simple;
	bh=LpaPWoiB+g2dZg4RH65TksDMWJxJR2hl7G8gp/2a+JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iSuu5/2B6yuuDs9afz0ALHvxCQvzi3zZMCA5b5Xl/pGoIaNPO4lA8/805AaNRt0sfj1pRkRBs+juRtNkErwDY8Hq8AaQFSwdWYMLZt9syVQqTADt9f85SFqQQgd5FqFQFO2Jn/P4R4vUyPsvf2RgXdD/+UVP/8GCjxEzPARhdeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mkim0CQx; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1D2543289;
	Wed, 12 Feb 2025 08:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739348631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tMNmo27RCKq+NidQSuiZLt0mDuPz+SlkNdNrtjuqQ1w=;
	b=Mkim0CQx1ffL8Tkbj0lZvahivBWaWVOicx/icr+g9hyjzNWg16sFjP+sticyJmDFkDHtZt
	YhdZY9tafwnZaR4Hkgblm/6eYDRejoht9+B2BpitWM7kH5nNQsYIMf41jlgHhF/3cc5vQm
	OXfxLykWydq+WTnXLAuNqzRssWgA/3ulCZLiL0w9/EGiMrL07D3DgdBpaK1md4UMoADK0W
	NDSvlvKozqse6xxWbrRqSqFCh2PABA0yf+yx6oEwL0w8hUC1Na5VLE9DNYdQB0wyQ55ooR
	JFBp5Gs5alewRIALE74+TDgygrIR/bIAoXr3CiiCJ4mwCdxdpuNAT5YnVqv1yw==
From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Date: Wed, 12 Feb 2025 09:23:47 +0100
Subject: [PATCH net 1/2] rtnetlink: Fix rtnl_net_cmp_locks() when DEBUG is
 off
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-rtnetlink_leak-v1-1-27bce9a3ac9a@bootlin.com>
References: <20250212-rtnetlink_leak-v1-0-27bce9a3ac9a@bootlin.com>
In-Reply-To: <20250212-rtnetlink_leak-v1-0-27bce9a3ac9a@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Alexis Lothore <alexis.lothore@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpedfuegrshhtihgvnhcuvehurhhuthgthhgvthculdgvuefrhfcuhfhouhhnuggrthhiohhnmddfuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefudfhuedttdeiffetffeljeffkeevveeiuddtgeejleeftdejgedtjedttdfhnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrgedvrdehgegnpdhmrghilhhfrhhomhepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudefpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhunhhihihusegrmhgriihonhdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhin
 hdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-GND-Sasl: bastien.curutchet@bootlin.com

rtnl_net_cmp_locks() always returns -1 if CONFIG_DEBUG_NET_SMALL_RTNL is
disabled. However, if CONFIG_DEBUG_NET_SMALL_RTNL is enabled, it returns 0
when both inputs are equal. It is then used by rtnl_nets_add() to call
put_net() if the net to be added is already present in the struct
rtnl_nets. As a result, when rtnl_nets_add() is called on an already
present net, put_net() is called only if DEBUG is on.

Add the input comparison in the DEBUG off case so that put_net() is always
called in this scenario.

Fixes: cbaaa6326bc5 ("rtnetlink: Introduce struct rtnl_nets and helpers.")
Cc: stable@vger.kernel.org
Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
---
 net/core/rtnetlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cb7fad8d1f95ff287810229c341de6a6d20a9c07..94111d3383788566f2296039e68549e2b40d5a4a 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -275,6 +275,9 @@ EXPORT_SYMBOL(lockdep_rtnl_net_is_held);
 #else
 static int rtnl_net_cmp_locks(const struct net *net_a, const struct net *net_b)
 {
+	if (net_eq(net_a, net_b))
+		return 0;
+
 	/* No need to swap */
 	return -1;
 }

-- 
2.48.1


