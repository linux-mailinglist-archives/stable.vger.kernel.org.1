Return-Path: <stable+bounces-233534-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SC1eDo3T1Gm1xwcAu9opvQ
	(envelope-from <stable+bounces-233534-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:51:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADF53AC53B
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 11:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25362300A618
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 09:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF8B3A6F0C;
	Tue,  7 Apr 2026 09:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwV7kErf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37A026ED45;
	Tue,  7 Apr 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775555462; cv=none; b=ZyrrcP9pYo5Nt2r4c9gBWQVsci8UK2OyXwkhEedQ/0opAS3lsE2EtmEmsgK4U1U39kG8GZeaZA7fjNsgUQ+rUXdX5FCxhtpVCAq1iNw3vIcPHMfJpJvWD6pI77zaxKgt++5h8omEC5KYn1liNnPcvATFWHB0/2G4gD9Zlhl9Zp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775555462; c=relaxed/simple;
	bh=COBonQwgb/gK4C6C/EEwkyWeOJpDIt851YEdPsJchWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBHXX7X/PzqAErIOua7qbz98ltxkhOjvQDSCLvTCK9a4vARLX2McQh/p8nO9s+D853+uoZCxs4ea8ODdVOC3nq4lz8oSGCqDIA3kcUwaE47wDZuT3TPaYf+PU0e5Y4HmR00f7ZH1rKDl9m8XasVm0tezVIlGCgwpBQxBeLapjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwV7kErf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCACC116C6;
	Tue,  7 Apr 2026 09:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775555461;
	bh=COBonQwgb/gK4C6C/EEwkyWeOJpDIt851YEdPsJchWc=;
	h=From:To:Cc:Subject:Date:From;
	b=TwV7kErfDJv1Zx54hPQCCl3r1CrLafXRpfCHq4nBCekRi3zwBXDAdX2vFmFsuDJB3
	 pL+3LFskq5YALaaAUSBbIxGPOcj6lSYtU5Nu5oJF5aM+jN0+YYaQKnqwcaTjbHA57z
	 ZlcL56Rc/g278mnpV0tzZU3pxsc5tjvE4CpS8yhAjxYL4G1UWgaNFScM/K2atZ79+X
	 XisU2M6r+p4TcYDhVf/kp+5uSc3hLcwNGHxUxTpWSkOsMAEh3YJv79wU+euC4+76FX
	 PS+jBEh5h9Eks4y/l3z/hg3DB2yjmj5WfwVXnVcShraT3vwRgOYktteONgSMk6iNMe
	 OQxKCstbmeipA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wA35H-0000000B11r-1QAQ;
	Tue, 07 Apr 2026 11:50:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH] clk: rk808: fix OF node reference imbalance
Date: Tue,  7 Apr 2026 11:50:27 +0200
Message-ID: <20260407095027.2625516-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233534-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CADF53AC53B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 2dc51ca822e4 ("clk: RK808: Reduce 'struct rk808' usage")
Cc: stable@vger.kernel.org	# 6.5
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clk/clk-rk808.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index f7412b137e5e..5a75b5c91555 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -153,7 +153,7 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 	struct rk808_clkout *rk808_clkout;
 	int ret;
 
-	dev->of_node = pdev->dev.parent->of_node;
+	device_set_of_node_from_dev(dev, dev->parent);
 
 	rk808_clkout = devm_kzalloc(dev,
 				    sizeof(*rk808_clkout), GFP_KERNEL);
-- 
2.52.0


