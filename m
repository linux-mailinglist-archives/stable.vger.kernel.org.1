Return-Path: <stable+bounces-246452-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BfuFNBuA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246452-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:17:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D51B85273F5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FC1630DFD8E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E1C2DE6E3;
	Tue, 12 May 2026 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V+NUnBc7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9C23E356;
	Tue, 12 May 2026 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609264; cv=none; b=LOyd90Gos09SB1WzNVWVPoXs1x+cn4SrmyAhuj/HEN7Rk4ctjg5CxHe8Zc1UmmjenF3QwvtlbaZYe55jlurKfd33QHnOTBVJLfd7gKtVDiYkP9iSNq5OeJ/bDYff6A67GXUB8Ghbqpk7lqF56ts/6pcl8XtfV/bSduE/UOAZ3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609264; c=relaxed/simple;
	bh=umW03VSlaCEZtXFiTvZixUY+Y9UC/oiNg0U9eTSONbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqJZaZgK9Keb4GuI4hOZLFIQN/81Vg0L0Sb6W0PRQNHxxSDZMmtogB5un7oZpBLT4jHdoVIieth/ezz26LPX/RUqCvzX/L7USEOmhy0+4yreAKYGhX9m1fsENpoPFVUr440qD4GLTd0DvFpQS4fmWpZUrcWH9FfhCD1Xr68V/A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V+NUnBc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050F8C2BCB0;
	Tue, 12 May 2026 18:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609264;
	bh=umW03VSlaCEZtXFiTvZixUY+Y9UC/oiNg0U9eTSONbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V+NUnBc7yOZXLf27ur+5717LC3TF3zDCE1ii4qcYe72h978vwUFMWuwoLwimWeLhi
	 aY3LWtgxRmjc3vCdwiIyYMObMveKAiUo8lT1jSZVov9rflBNYnfyA33ZiQvElpW25H
	 vAI1q1wMSrb0JRYYuueCdg30XTcF/D6PZMPjzicg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Johan Hovold <johan@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 7.0 129/307] clk: rk808: fix OF node reference imbalance
Date: Tue, 12 May 2026 19:38:44 +0200
Message-ID: <20260512173942.850745298@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D51B85273F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246452-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sntech.de:email,collabora.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit de019f203b0d472c98ead4081ad4f05d92c9b826 upstream.

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 2dc51ca822e4 ("clk: RK808: Reduce 'struct rk808' usage")
Cc: stable@vger.kernel.org	# 6.5
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-rk808.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -153,7 +153,7 @@ static int rk808_clkout_probe(struct pla
 	struct rk808_clkout *rk808_clkout;
 	int ret;
 
-	dev->of_node = pdev->dev.parent->of_node;
+	device_set_of_node_from_dev(dev, dev->parent);
 
 	rk808_clkout = devm_kzalloc(dev,
 				    sizeof(*rk808_clkout), GFP_KERNEL);



