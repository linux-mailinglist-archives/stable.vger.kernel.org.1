Return-Path: <stable+bounces-221366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBnjBBWWo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:27:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ECA1CAAA0
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1480F305ACBE
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FCA26E710;
	Sun,  1 Mar 2026 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmkvoRZM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844B2BD0B
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328083; cv=none; b=U7lgowzBUIlMhesFns5KwW5ER4x1gRtflKMryJ8fYe9pU6QGvFeydbQk2/kv3CTvBqGORIZ+a5VDyKdMEtmrTIpNrwHr/VjZ340yTkMGzsdhcACQvKxlf0A3E+GA7OV8hJENPeU/mKGNOzkkc6Gvy7L8M7Gs64xgYEAEDhcqKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328083; c=relaxed/simple;
	bh=EpmKOr3GTt2LrSszN/TlpfKNunThgbrd5fPU0E/rf5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sz5PAPTPWWBnnfU8zZ9yKUl9RqUP+6hNH/0hL1Qm0XIIOTe4jf9belE3DijIaOMcpNAICMII0XxfVsgoWRyyJWjBEVIKXAmcuX2yCgwR8dXBFrE8ywUpwnRtaD7xJ8Jp9oboeWV7Q3Su0+hSGOGo6duKtIk/eYH17SLS3SMhU68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmkvoRZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3BBC2BC87;
	Sun,  1 Mar 2026 01:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328083;
	bh=EpmKOr3GTt2LrSszN/TlpfKNunThgbrd5fPU0E/rf5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=YmkvoRZM63zyPw68t9gHnBvLGR5Qxxg4et9oyQBAj3E8HCm5irOLoX3H6hBXXQivb
	 ZrlNPFG8Ax5FE6IbThuAr1RQ7c3c75JtqZiL0qCapPl5pb1npakkyH9S53Q4ZphgUK
	 KFfv0oM7faSxb8tpSQDVXe3iy5rpoq2wEjcPALCKkbPlBptKRxgVuyLphnHp3E294C
	 31LHER3lnXMfnpuIDYJ94BkrPmd631Ysex4gbA5DnL7QO8sLE+zvQa2aE464zkrKb8
	 pcHwTU/HC4NS/fxHi4isRT7hkBofMzK+QRI2i9CkhwBSRSTmZKaqyDYbZ/sauBFlz1
	 bd1v2+OQ0I1vA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shawn.lin@rock-chips.com
Cc: Detlev Casanova <detlev.casanova@collabora.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Marco Schirrmeister <mschirrmeister@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: FAILED: Patch "soc: rockchip: grf: Fix wrong RK3576_IOCGRF_MISC_CON definition" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:21:20 -0500
Message-ID: <20260301012121.1677247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[collabora.com,rock-chips.com,gmail.com,sntech.de,lists.infradead.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221366-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,msgid.link:url,sntech.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rock-chips.com:email]
X-Rspamd-Queue-Id: 32ECA1CAAA0
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3cdc30c42d4a87444f6c7afbefd6a9381c4caa27 Mon Sep 17 00:00:00 2001
From: Shawn Lin <shawn.lin@rock-chips.com>
Date: Fri, 16 Jan 2026 08:55:28 +0800
Subject: [PATCH] soc: rockchip: grf: Fix wrong RK3576_IOCGRF_MISC_CON
 definition

RK3576_IOCGRF_MISC_CON is IOC_GRF + 0x40F0, fix it.

Fixes: e1aaecacfa13 ("soc: rockchip: grf: Add rk3576 default GRF values")
Cc: stable@vger.kernel.org
Cc: Detlev Casanova <detlev.casanova@collabora.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Tested-by: Marco Schirrmeister <mschirrmeister@gmail.com>
Link: https://patch.msgid.link/1768524932-163929-2-git-send-email-shawn.lin@rock-chips.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
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





