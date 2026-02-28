Return-Path: <stable+bounces-220690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COnjETdTo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:42:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 460E41C87EB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 174283325103
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6BE3F831E;
	Sat, 28 Feb 2026 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwOWe8Oj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F03F8317;
	Sat, 28 Feb 2026 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300570; cv=none; b=Ic7U+nUeYlcIUHCPsl3a7qF+dZTGFBjuYf7G3gxn0Spm43Kx7bI3UAo7csBVDiT0oa1MfykIOHLA4k8zH6BU4i7ZoL9dY9FEKdbyW//T7VYWq9QWhfWBXu7qfNfWw4KTirI+exylbGMZf4gGj6fziic5ixT1g/W5slCU3lnkcVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300570; c=relaxed/simple;
	bh=l5zdJmYmZB3TFNe0r0xjIkhgAOkDij8IZ8SN5tJNwx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYXGYsI9d4vPIJ1a9sNdUbemns6GnZfSWbBkdQYy3hNyvAeDlpNthUrVhTTGQlvaL3tevvtKP1/Fnle1uHnmGb56xFWPr/aiAzr6kev0pEkYFL/pcQ5JScdgx6aBhmP/LPe798xYs+gsNPGiMY0Ue5x2heBCiZa1SGxqG00tiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwOWe8Oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DD5C19423;
	Sat, 28 Feb 2026 17:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300570;
	bh=l5zdJmYmZB3TFNe0r0xjIkhgAOkDij8IZ8SN5tJNwx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EwOWe8OjK9iYAhtNua9FTuSL8ptnEy65xRLgVBrgq7/vkhCy8fOHW24v2uSYwBHSt
	 FSXu8pme8S7u9om6yejdFY1F/tPea42hO0NV2QMSKhyQmbH72S7GNLt2DCR6Aabj6K
	 NL6x0ozAjJL6kfHBUNW+Nw6eOSMFKV4qhH35EaEY3YG5HfAprnDlTI+ff59zqKk6cf
	 m2k0DOngmceTXXBAVm7JXpI2wskAQfZnAxmX0f5wpAaQ2QByO7nZUf8jPt310YZQws
	 Wgc+KjP9kZGsdBrLBmP25H01qU8JYOOvfbj5YSPBGaRX6B6gsOe16tBvQPHhPdx7qE
	 zKq99z3qN9TFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Marco Schirrmeister <mschirrmeister@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 611/844] soc: rockchip: grf: Fix wrong RK3576_IOCGRF_MISC_CON definition
Date: Sat, 28 Feb 2026 12:28:44 -0500
Message-ID: <20260228173244.1509663-612-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[rock-chips.com,collabora.com,gmail.com,sntech.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220690-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,collabora.com:email,rock-chips.com:email,sntech.de:email]
X-Rspamd-Queue-Id: 460E41C87EB
X-Rspamd-Action: no action

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 3cdc30c42d4a87444f6c7afbefd6a9381c4caa27 ]

RK3576_IOCGRF_MISC_CON is IOC_GRF + 0x40F0, fix it.

Fixes: e1aaecacfa13 ("soc: rockchip: grf: Add rk3576 default GRF values")
Cc: stable@vger.kernel.org
Cc: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>
Link: https://patch.msgid.link/1768524932-163929-2-git-send-email-shawn.lin@rock-chips.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/rockchip/grf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 27bfa09ff2516..8974d1c6b35dc 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -146,7 +146,7 @@ static const struct rockchip_grf_info rk3576_sysgrf __initconst = {
 	.num_values = ARRAY_SIZE(rk3576_defaults_sys_grf),
 };
 
-#define RK3576_IOCGRF_MISC_CON		0x04F0
+#define RK3576_IOCGRF_MISC_CON		0x40F0
 
 static const struct rockchip_grf_value rk3576_defaults_ioc_grf[] __initconst = {
 	{ "jtag switching", RK3576_IOCGRF_MISC_CON, FIELD_PREP_WM16_CONST(BIT(1), 0) },
-- 
2.51.0


