Return-Path: <stable+bounces-176186-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA1B36C03
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCADC8E51AF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB563570A6;
	Tue, 26 Aug 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rj+FMx71"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527B3570A9;
	Tue, 26 Aug 2025 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219003; cv=none; b=O7LrSihx8OMTt435GWq8fJtDm+thvShur5T/eOz01/5VHfi24qq0PkqXTjXikbvNbv1twzYiJyCUAuNSeh01Es61i209AVnb9qJW+AFdXO9Yv32gLeclFJNptrH3HfzNPrMoNKqCbeU695Du3UU4/SFSaiUCF7F8YLanUY1iOAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219003; c=relaxed/simple;
	bh=a8zTM5ZzBOSAf2q885aqj6sspZ7M/Lw9eY6ahkjX1jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdRbXMLYzHWJ7p2ORn6O140NqH4GyQBM2VwBZSedAY09XG1XZ6NutKRv0eTPL3EsSaZQqPKYR3o06GMf5/8E86qjHSDMoDuVQ7EE7E1fuaVNKzEZ2SBPN/6QjM28TxolbWqLgvjQoXgAZWfcEsoWT4h+y4QBFq6S0ZZVm7w3XLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rj+FMx71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B6EC4CEF1;
	Tue, 26 Aug 2025 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219003;
	bh=a8zTM5ZzBOSAf2q885aqj6sspZ7M/Lw9eY6ahkjX1jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rj+FMx71/PjooTc1OOxXTJ6zsXSCRw8Mmt3+sKK4iKEM5bxRZM1LdOSYcW9fn4+Vq
	 sXJTZGirjLXSfjs13/LtDfURGGTIIvcvc6BJ/uvhAMhyfzpboA5WIY2fnsrYgBCErk
	 KEnQ4Lmt8JKAhPb5nlieL/xBENt6twU5W3QxtSGY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oscar Maes <oscmaes92@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 214/403] net: ipv4: fix incorrect MTU in broadcast routes
Date: Tue, 26 Aug 2025 13:09:00 +0200
Message-ID: <20250826110912.752449203@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oscar Maes <oscmaes92@gmail.com>

[ Upstream commit 9e30ecf23b1b8f091f7d08b27968dea83aae7908 ]

Currently, __mkroute_output overrules the MTU value configured for
broadcast routes.

This buggy behaviour can be reproduced with:

ip link set dev eth1 mtu 9000
ip route del broadcast 192.168.0.255 dev eth1 proto kernel scope link src 192.168.0.2
ip route add broadcast 192.168.0.255 dev eth1 proto kernel scope link src 192.168.0.2 mtu 1500

The maximum packet size should be 1500, but it is actually 8000:

ping -b 192.168.0.255 -s 8000

Fix __mkroute_output to allow MTU values to be configured for
for broadcast routes (to support a mixed-MTU local-area-network).

Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
Link: https://patch.msgid.link/20250710142714.12986-1-oscmaes92@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/route.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d173234503f9..80612f73ff53 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2378,7 +2378,6 @@ static struct rtable *__mkroute_output(const struct fib_result *res,
 	do_cache = true;
 	if (type == RTN_BROADCAST) {
 		flags |= RTCF_BROADCAST | RTCF_LOCAL;
-		fi = NULL;
 	} else if (type == RTN_MULTICAST) {
 		flags |= RTCF_MULTICAST | RTCF_LOCAL;
 		if (!ip_check_mc_rcu(in_dev, fl4->daddr, fl4->saddr,
-- 
2.39.5




