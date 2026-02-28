Return-Path: <stable+bounces-220440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IrhG/o2o2lh+gQAu9opvQ
	(envelope-from <stable+bounces-220440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8FC1C6245
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBAD031BE707
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF763B5C1F;
	Sat, 28 Feb 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJfXNcBB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AAB3B5C15;
	Sat, 28 Feb 2026 17:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300329; cv=none; b=Ah/uAYUPKWhBz7Au5lFO7iLN65qONsC7Valnw00uHpmXhK/CUBzd+X/DVqLR2W3j2OmOxiXx0JcPfXU3MbEgWdEB/dL8FAI0A/9edfbe7AoxTNpx4j22yrOer2dELV/BqDMKIEuHywckbxK5yyK42XGjqoBxem0oWJMtdFHYiqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300329; c=relaxed/simple;
	bh=XRTZj9O6e/ypbjfemxfPAAtPh7yD7YZZLwpmdZQF97s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8SydJF1O2WmBNHEEtU9V/OitOb7zZ/0dq/n9oklO909AhJ7rvcyECba7Ndf639thRUpsg8L1mcBgO7ksBP320vhSEwutWE0Gym+yYk9akT5cR8RXtkwZB9xT8CyK6GkJUOxmc/VsaPfi0/yubTTZDGK21CVE+IUpTyySct2hjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJfXNcBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72543C19423;
	Sat, 28 Feb 2026 17:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300329;
	bh=XRTZj9O6e/ypbjfemxfPAAtPh7yD7YZZLwpmdZQF97s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJfXNcBBJyovk+aHpX2Od2MCNMiBa2PaAIWHKZC1a/lscP7tBXsFqgtWursCndRQS
	 mlZkC1o/aadXQyKuplJ4arobS2Mn5Zreh100F7DGBKgX/j6STHWqnbfUnpvw8TBMiD
	 4mEVeIbWdGuRUbg1CzkbRsXIxWWWA5eEBtA3BpzyBqMyLJhCGbn6ZQH87z6j6798Tl
	 JvANADN0LW/LJ2hkbATna5qicMHphOv/ZU0iHEbT1k0K2huog2ZlaztYoLqqjsG67X
	 5DNObf9NhosoTM0TASAinmASykevB9/CCl9C8ftlZatWsOaJZrx229p5GrCXErgPiw
	 Vvcb09vbyUwcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brian Masney <bmasney@redhat.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 361/844] clk: microchip: core: correct return value on *_get_parent()
Date: Sat, 28 Feb 2026 12:24:34 -0500
Message-ID: <20260228173244.1509663-362-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220440-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BA8FC1C6245
X-Rspamd-Action: no action

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit 5df96d141cccb37f0c3112a22fc1112ea48e9246 ]

roclk_get_parent() and sclk_get_parent() has the possibility of
returning -EINVAL, however the framework expects this call to always
succeed since the return value is unsigned.

If there is no parent map defined, then the current value programmed in
the hardware is used. Let's use that same value in the case where
-EINVAL is currently returned.

This index is only used by clk_core_get_parent_by_index(), and it
validates that it doesn't overflow the number of available parents.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202512050233.R9hAWsJN-lkp@intel.com/
Signed-off-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Link: https://lore.kernel.org/r/20251205-clk-microchip-fixes-v3-2-a02190705e47@redhat.com
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/microchip/clk-core.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/microchip/clk-core.c b/drivers/clk/microchip/clk-core.c
index a0163441dfe5c..82f62731fc0ed 100644
--- a/drivers/clk/microchip/clk-core.c
+++ b/drivers/clk/microchip/clk-core.c
@@ -283,14 +283,13 @@ static u8 roclk_get_parent(struct clk_hw *hw)
 
 	v = (readl(refo->ctrl_reg) >> REFO_SEL_SHIFT) & REFO_SEL_MASK;
 
-	if (!refo->parent_map)
-		return v;
-
-	for (i = 0; i < clk_hw_get_num_parents(hw); i++)
-		if (refo->parent_map[i] == v)
-			return i;
+	if (refo->parent_map) {
+		for (i = 0; i < clk_hw_get_num_parents(hw); i++)
+			if (refo->parent_map[i] == v)
+				return i;
+	}
 
-	return -EINVAL;
+	return v;
 }
 
 static unsigned long roclk_calc_rate(unsigned long parent_rate,
@@ -817,13 +816,13 @@ static u8 sclk_get_parent(struct clk_hw *hw)
 
 	v = (readl(sclk->mux_reg) >> OSC_CUR_SHIFT) & OSC_CUR_MASK;
 
-	if (!sclk->parent_map)
-		return v;
+	if (sclk->parent_map) {
+		for (i = 0; i < clk_hw_get_num_parents(hw); i++)
+			if (sclk->parent_map[i] == v)
+				return i;
+	}
 
-	for (i = 0; i < clk_hw_get_num_parents(hw); i++)
-		if (sclk->parent_map[i] == v)
-			return i;
-	return -EINVAL;
+	return v;
 }
 
 static int sclk_set_parent(struct clk_hw *hw, u8 index)
-- 
2.51.0


