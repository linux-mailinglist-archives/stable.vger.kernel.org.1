Return-Path: <stable+bounces-223648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJ4RIj3LrmnEIwIAu9opvQ
	(envelope-from <stable+bounces-223648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:29:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6926239BFA
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 14:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF58430421F6
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5B83A962D;
	Mon,  9 Mar 2026 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifGudzZl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6BC2C08D0
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773062861; cv=none; b=eSnuQxtZ7QepdPiZnhyzrVHaiRVbf0GKk4gKT+dG5sY6LfKQij6S/I1yUukEo13ekg753RCW2529aHhWNxts5Az+hBxZgqbvoLqSGag2lKsPOIE5V92HsXrL7gm3huIbzisP7KPjvbRaJOfKOOsCxyaG64YoffjaXX30MKhn558=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773062861; c=relaxed/simple;
	bh=378/2avhtLkyFLZi9lshJDpXYSvMSpxOriIkB1PzPaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwidcI7f03ybSuX0lyPFMhqTVvwCliNuVQJiDfETsiEOIA36kHFZLOuH4XL4o9QUQmgACTC52P1f/OqIbxed5QmAAZEJQqACAfeSmNiGNyIRfso/zbm/7vFSjR2sUkwgiplZrtndVSY+7O7a+5c83gEJEtyrD28234rf0Eyy0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifGudzZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742BBC4CEF7;
	Mon,  9 Mar 2026 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773062861;
	bh=378/2avhtLkyFLZi9lshJDpXYSvMSpxOriIkB1PzPaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifGudzZlFlRA1CfrVrKkxcuPZxooM70Kky45ljxHyLDw5rzZTal2hETOsD8MQeRGd
	 xetrYU1lUbzuhXflS9c8XM76tJRxHe7lbH6HqGoCc1vzA2NfI2mrNJEHIUtv4sEqc0
	 NaiQ97i/exABs4PTfKlubD7IyJ8uy1LjuEjANdnqP1hMsyEG7N68b3w9g9B+gTsbUW
	 EbH5LoEYegv3IA8ZBgB1zY4adEQu6TiT2D8+4h2qlKwCTp9wNGNz3N4rd3ERRkBgTp
	 knukQBUR1dFsSds0k1vHLdgt9HoHxAdjNRPYmScD/wzgnhBa7cf2qWPrM6hyNlXmSC
	 B9ZsqakuWYXcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()
Date: Mon,  9 Mar 2026 09:27:39 -0400
Message-ID: <20260309132739.944769-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030901-book-commodity-3938@gregkh>
References: <2026030901-book-commodity-3938@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6926239BFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223648-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:email,nvidia.com:email]
X-Rspamd-Action: no action

From: Jason Gunthorpe <jgg@ziepe.ca>

[ Upstream commit 74586c6da9ea222a61c98394f2fc0a604748438c ]

struct irdma_create_ah_resp {  // 8 bytes, no padding
    __u32 ah_id;               // offset 0 - SET (uresp.ah_id = ah->sc_ah.ah_info.ah_idx)
    __u8  rsvd[4];             // offset 4 - NEVER SET <- LEAK
};

rsvd[4]: 4 bytes of stack memory leaked unconditionally. Only ah_id is assigned before ib_respond_udata().

The reserved members of the structure were not zeroed.

Cc: stable@vger.kernel.org
Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://patch.msgid.link/3-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
[ adapted fix to combined irdma_create_ah() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index e62a825622834..40960f0803fbc 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -4170,7 +4170,7 @@ static int irdma_create_ah(struct ib_ah *ibah,
 	struct irdma_sc_ah *sc_ah;
 	u32 ah_id = 0;
 	struct irdma_ah_info *ah_info;
-	struct irdma_create_ah_resp uresp;
+	struct irdma_create_ah_resp uresp = {};
 	union {
 		struct sockaddr saddr;
 		struct sockaddr_in saddr_in;
-- 
2.51.0


