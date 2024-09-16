Return-Path: <stable+bounces-76308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A88F97A125
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E7E1F24E87
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF5F15853A;
	Mon, 16 Sep 2024 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p9Rb4l4N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB6155322;
	Mon, 16 Sep 2024 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488222; cv=none; b=aN8xHdchtpzUMNvxC6oe5IphpY2smjDX0Pcs0LiwCgbhzpGQ/iVyawJzDpu5It1xSsK6HQnK5tiYqHQdrIw2eHW78XHnE1SLhFfXPQiQCd5hRj4DtY9RGnRqcLt7ouFou9VytlOiT3NbJEMBcd4nqGwhk7PauevD/iXXLCMAdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488222; c=relaxed/simple;
	bh=ZtIQAbL7ioczvqgCgSxsIwjiDy+E7zTEvqCnHpSl1Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SsKl7XXkmxbuDCsggnC2+zmKWNWKUHnTrFhdeCRh3/rT6zXfpCtZzp+6aPezdIx0uNrRIhuwm9EJuMbCu9qihimnh+wePMRywx92rsz++R3Si42i4LsAYJKl3OFPZu7/D6LXF/YOfZxpzyBxcVrpUhXmgKYazFvD7uhIaHsFr1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p9Rb4l4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E662AC4CEC4;
	Mon, 16 Sep 2024 12:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488222;
	bh=ZtIQAbL7ioczvqgCgSxsIwjiDy+E7zTEvqCnHpSl1Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p9Rb4l4NjjKhPF7ygO1ukU1PD4PidFEkdHN9nnPy9FY4xK5f50gr9NlKUI9Wm8ykh
	 tYfGKy+n47ofdaJVWzwOEcxYZmWHMb5LzuavfvV+ctf+KijDSP2ANG31ePpvZHhQkm
	 Aw1dv8kl5QaXeV9oCzDScmPTI2WyjpRMzZaTdAjg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Moon Yeounsu <yyyynoom@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 010/121] net: ethernet: use ip_hdrlen() instead of bit shift
Date: Mon, 16 Sep 2024 13:43:04 +0200
Message-ID: <20240916114229.267082838@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114228.914815055@linuxfoundation.org>
References: <20240916114228.914815055@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moon Yeounsu <yyyynoom@gmail.com>

[ Upstream commit 9a039eeb71a42c8b13408a1976e300f3898e1be0 ]

`ip_hdr(skb)->ihl << 2` is the same as `ip_hdrlen(skb)`
Therefore, we should use a well-defined function not a bit shift
to find the header length.

It also compresses two lines to a single line.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/jme.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/jme.c b/drivers/net/ethernet/jme.c
index b06e24562973..d8be0e4dcb07 100644
--- a/drivers/net/ethernet/jme.c
+++ b/drivers/net/ethernet/jme.c
@@ -946,15 +946,13 @@ jme_udpsum(struct sk_buff *skb)
 	if (skb->protocol != htons(ETH_P_IP))
 		return csum;
 	skb_set_network_header(skb, ETH_HLEN);
-	if ((ip_hdr(skb)->protocol != IPPROTO_UDP) ||
-	    (skb->len < (ETH_HLEN +
-			(ip_hdr(skb)->ihl << 2) +
-			sizeof(struct udphdr)))) {
+
+	if (ip_hdr(skb)->protocol != IPPROTO_UDP ||
+	    skb->len < (ETH_HLEN + ip_hdrlen(skb) + sizeof(struct udphdr))) {
 		skb_reset_network_header(skb);
 		return csum;
 	}
-	skb_set_transport_header(skb,
-			ETH_HLEN + (ip_hdr(skb)->ihl << 2));
+	skb_set_transport_header(skb, ETH_HLEN + ip_hdrlen(skb));
 	csum = udp_hdr(skb)->check;
 	skb_reset_transport_header(skb);
 	skb_reset_network_header(skb);
-- 
2.43.0




