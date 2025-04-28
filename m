Return-Path: <stable+bounces-136830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F14A9EB46
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBFD71890CEE
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3FC2248AE;
	Mon, 28 Apr 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ0xiWCE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02318CC15
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830673; cv=none; b=WEqt+UhK+RuqvwIVvg0UQaotsy+OnUMCKs6LBSS2gv2FXmWi9+XNMF/72ZUdY48dfm1+DBgrPOsSMfe5R91ZSItwkfYQVzU9HfwU2ByIhyj6t9F7IGp0vRGQ4I8m8aSzQ+fjOisrv+uhseWsxwpJ8VjlVOf+1dneslERGranqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830673; c=relaxed/simple;
	bh=vdJ3pJyzrSxjb0bS9iS8vaw9G0jSn8UULwPCfRFiopc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dwd8coni5eu8WbJP7r2GfXHCnTik70Mf86/4Cx574KegAv7U3ibgUteQR87Of3GGaEbOXdSxKumEFT9tH0V6RfoJOkB00DmWEyYtwxWHGekxji7HUaaf7VEnQT1YV9/b6Nkmgq3wtKLSqGw0L5WVkQq5mscJRle+enEf8SpC6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ0xiWCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FFEC4CEEE;
	Mon, 28 Apr 2025 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830672;
	bh=vdJ3pJyzrSxjb0bS9iS8vaw9G0jSn8UULwPCfRFiopc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZ0xiWCEgnU4Xny2ViWCDlR9NMiE/m6CeW4whCK0TeQ0U+BkJsCORKKhkcz0028nk
	 q+p11y0S3sVu43vDnul8M7cjG7YTTutHpEdUfr3kd1cvmOGqSFKJsfJwESSd1GOHc5
	 GJaGO/1eifFjSPmMIHNohauaoz7XRjYU20T4nZEph9cq3KQNtW22Wj1Ud5LMtvKwQW
	 dhPXQX5Mdm/oECIKB63XJrnKEV1zEy4EYHvOvQayApznGADoDwYWxUDckNtj1xm0J5
	 Qd+ltkR0xjFAjrhz89MTe1mA6jUdHMQMmnB5FxWwL3F408nLhfuA+UuEweyq0gdpW6
	 8zMUumUPFBzTw==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 2/3] net: dsa: mv88e6xxx: enable PVT for 6321 switch
Date: Mon, 28 Apr 2025 10:57:43 +0200
Message-ID: <20250428085744.19762-2-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428085744.19762-1-kabel@kernel.org>
References: <20250428085744.19762-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit f85c69369854a43af2c5d3b3896da0908d713133 upstream.

Commit f36456522168 ("net: dsa: mv88e6xxx: move PVT description in
info") did not enable PVT for 6321 switch. Fix it.

Fixes: f36456522168 ("net: dsa: mv88e6xxx: move PVT description in info")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-4-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index d583052af26c..819a03693412 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5064,6 +5064,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.g1_irqs = 8,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
+		.pvt = true,
 		.multi_chip = true,
 		.tag_protocol = DSA_TAG_PROTO_EDSA,
 		.ptp_support = true,
-- 
2.49.0


