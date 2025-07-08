Return-Path: <stable+bounces-161247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94FCAFD3D1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD5D7B48F1
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6676B2DECBD;
	Tue,  8 Jul 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hYqlSu9b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B81548C;
	Tue,  8 Jul 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994022; cv=none; b=M0jw8txV9aQbNjHJZvlYD0koSTdCpZ44Q86QyrpbNKlSRo3pn+wekYdaPjGM+SIp+GIlcc5uFZN4HDszvYtf0gt66UYFgaYeCB3RfsKI6P/GXQNXBG1toptHNwyfuvOqUSRH5jd+qi2eSsb+FvPbGmdzx5uQLDwT1mXkb8bjMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994022; c=relaxed/simple;
	bh=BIIFjrsnEQQlh8vQFw64KLpK0G11w+VQGhq7kZNUMvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L38SnjL4A2vcDZ0bjBZysi9irqql6kdy+NEJqk0K2iey6dDWvKEAhnQ+Kmdc8ol8UlRNpH7GX0XwS5mpj7ciFIS7a16C0CLeblReFf64iggoFx3MF4cruEPEb+qA8JRxjA3ETycLwGIArqjAEOTV19Qc2PO3QwdTnZ48Ckk+hM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hYqlSu9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A241AC4CEED;
	Tue,  8 Jul 2025 17:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751994022;
	bh=BIIFjrsnEQQlh8vQFw64KLpK0G11w+VQGhq7kZNUMvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hYqlSu9bB2DcxPhKjygjVU3mo7uC8Ko7Ty+SE4hr//Q4CAQLWorJpQ4PyiutQpPxb
	 62ZQn6gnFpLZvSCbYuBrzV1rOXM6IR6K8as8wi5SFFyF1GqLSTK4LjaET+LjkWWAwL
	 n5bLjt2JgUyPR1wKoKGpbO9+/mTs9bCA6MgJariY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 071/160] net: selftests: fix TCP packet checksum
Date: Tue,  8 Jul 2025 18:21:48 +0200
Message-ID: <20250708162233.521589082@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 8d89661a36dd3bb8c9902cff36dc0c144dce3faf ]

The length in the pseudo header should be the length of the L3 payload
AKA the L4 header+payload. The selftest code builds the packet from
the lower layers up, so all the headers are pushed already when it
constructs L4. We need to subtract the lower layer headers from skb->len.

Fixes: 3e1e58d64c3d ("net: add generic selftest support")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>
Reported-by: Oleksij Rempel <o.rempel@pengutronix.de>
Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/20250624183258.3377740-1-kuba@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/selftests.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/selftests.c b/net/core/selftests.c
index 29ca19ec82bb4..63938efd5b55f 100644
--- a/net/core/selftests.c
+++ b/net/core/selftests.c
@@ -160,8 +160,9 @@ static struct sk_buff *net_test_get_skb(struct net_device *ndev,
 	skb->csum = 0;
 	skb->ip_summed = CHECKSUM_PARTIAL;
 	if (attr->tcp) {
-		thdr->check = ~tcp_v4_check(skb->len, ihdr->saddr,
-					    ihdr->daddr, 0);
+		int l4len = skb->len - skb_transport_offset(skb);
+
+		thdr->check = ~tcp_v4_check(l4len, ihdr->saddr, ihdr->daddr, 0);
 		skb->csum_start = skb_transport_header(skb) - skb->head;
 		skb->csum_offset = offsetof(struct tcphdr, check);
 	} else {
-- 
2.39.5




