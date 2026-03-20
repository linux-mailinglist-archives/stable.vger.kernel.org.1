Return-Path: <stable+bounces-227559-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAEaJJ5ivWlF9gIAu9opvQ
	(envelope-from <stable+bounces-227559-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:07:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF222DC4E3
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 16:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9E3FF3026B47
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8023A9001;
	Fri, 20 Mar 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XuWTZ63f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44556284896
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774018671; cv=none; b=as0zpre6ym0ROTA7Aed947SV1XMRbWPLggOIHjjhQGg4IvapQU+EvJoV24BL/w36KI/0/vDdo9ye/5NndfVaD5Bbqb95lw4GKHNR58wYne3kcCNwW/H5T79jwXw5S3475Yz/SfFAtJuyTbAVHCdox8dRLwc+68TpbAF5KDZnuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774018671; c=relaxed/simple;
	bh=WYTHIaIReKaxPZlMBRdB79V6pGaS1TcFf7jAqJvVIvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dADV/ftMyQMV882ufnQuUiXg94OwHz2Uv4/kc9aAtALpMohjKdWNpMlTVwp2HedIF9rWFw0SeWN8cSbCUvdsqAIyVd6USHrKhfDhHehtodn0h81BCGY8diTC0OtUzt82/GRMyVb4dFfxDh04JdOozRWHw6rTxSpmwi/903QNU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XuWTZ63f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508EAC4CEF7;
	Fri, 20 Mar 2026 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774018671;
	bh=WYTHIaIReKaxPZlMBRdB79V6pGaS1TcFf7jAqJvVIvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XuWTZ63fQMcnZBGUzIbCHjomSqej+iLafx2sht79FymZE3mygh9kuT8ATyFoXpwRU
	 VCwepGHMrcFGZkQVTmfzJwWvaRCGS3vm7DziDCXOw+0/eV1skxhWccuVCk0/prQXbx
	 YNfSfGJeillzW+OAD1bcVurURxC9KmDxblDF4IqgkePSwO/HgRuU/hnyE+Ig2O7BlT
	 T9J/7982u9WZ3m0GyAzyJHFL0+bv/p1V8z53WQ6WdDYEyYRIRla1RLe9Z7ZDoEow0C
	 0HLgZkvKhwNW9p24aqMWJSknjBgPs1h38K0y4DN1ejqYB0xOWraOK7+8DBXkD2mv4x
	 Ev/d5Hhgt/+xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Hao <haokexin@gmail.com>,
	Quanyang Wang <quanyang.wang@windriver.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume
Date: Fri, 20 Mar 2026 10:57:46 -0400
Message-ID: <20260320145746.4187361-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320145746.4187361-1-sashal@kernel.org>
References: <2026032001-degrease-handcuff-81e4@gregkh>
 <20260320145746.4187361-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,windriver.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227559-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CF222DC4E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kevin Hao <haokexin@gmail.com>

[ Upstream commit 718d0766ce4c7634ce62fa78b526ea7263487edd ]

On certain platforms, such as AMD Versal boards, the tx/rx queue pointer
registers are cleared after suspend, and the rx queue pointer register
is also disabled during suspend if WOL is enabled. Previously, we assumed
that these registers would be restored by macb_mac_link_up(). However,
in commit bf9cf80cab81, macb_init_buffers() was moved from
macb_mac_link_up() to macb_open(). Therefore, we should call
macb_init_buffers() to reinitialize the tx/rx queue pointer registers
during resume.

Due to the reset of these two registers, we also need to adjust the
tx/rx rings accordingly. The tx ring will be handled by
gem_shuffle_tx_rings() in macb_mac_link_up(), so we only need to
initialize the rx ring here.

Fixes: bf9cf80cab81 ("net: macb: Fix tx/rx malfunction after phy link down and up")
Reported-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Tested-by: Quanyang Wang <quanyang.wang@windriver.com>
Cc: stable@vger.kernel.org
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260312-macb-versal-v1-2-467647173fa4@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cadence/macb_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ffd39103dd860..98970266165e9 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -5408,8 +5408,18 @@ static int __maybe_unused macb_resume(struct device *dev)
 		rtnl_unlock();
 	}
 
+	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
+		macb_init_buffers(bp);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues;
 	     ++q, ++queue) {
+		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
+			if (macb_is_gem(bp))
+				gem_init_rx_ring(queue);
+			else
+				macb_init_rx_ring(queue);
+		}
+
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
 	}
-- 
2.51.0


