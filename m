Return-Path: <stable+bounces-140354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3654EAAA7D2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30653189558C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8993412CE;
	Mon,  5 May 2025 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Slsmkli4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F933412C6;
	Mon,  5 May 2025 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484685; cv=none; b=WkseXzuSAbZZEicu8OWPznyLPVq0+M06rpxQbZ2T/83LXYbW7a1c00VvgOY3f1/Z7bxADoktvDIO9pkjFzU+/9yWHTGsEJ5FOsRLtacMPuV/unzQiT4oeQVm4vClduwe+unP1VnAxRij0i9E13gqT9LtQU5LacRbaE5iZ3FneCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484685; c=relaxed/simple;
	bh=fZ/k/sC8FQk0k0la1SgTsQ/eyOeJI4qHzs6b9tOGb04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmSGRfff2VvdYm+ZzL7cHL95Sp3yw598ksD36MZKyXdD9yPBOGYPjjog7Qf1nifBcLTpBIgZ2YgrN9VVD4DkqbuO6xWrS6C4l4vDWGTTO93/xxMo5pyRQQt5FznVkN9leVmMRxxvjVX3YP0A1c59VPaVNcZN7eHCM+6791ixtqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Slsmkli4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AA9C4CEEF;
	Mon,  5 May 2025 22:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484684;
	bh=fZ/k/sC8FQk0k0la1SgTsQ/eyOeJI4qHzs6b9tOGb04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Slsmkli4hZUISzOO/0b8T/hLx5xo+EFxWa01/ipoPtDjxne4NNRKHEGtWro5LNxlf
	 Lj3tG5RqASNiB65W8pTrGSbBqOXbMoT7vDoqvErPqhLq17wcNEUhdlry136nQAU/jG
	 ebsjRD8+Ir5TmlStfPzln+EDzNcQwnWP7Wh+Bdk/0dR0mSdMGuCvVq6u3vgZncKXBt
	 /0MJan+Sn3YI4IzIzD7ler7RWatTTICLjuGTRjzEfkkohmVGLOYHf7KwNYZ2s4exzE
	 vzra8BtgS0GJWEz/q2/7h0/wuzcivzVPaMAt6+aRBxNTe3xla8lGSXEW2jTbkIo469
	 x1W1QRiWOV0DQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	airlied@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 605/642] drm/ast: Hide Gens 1 to 3 TX detection in branch
Date: Mon,  5 May 2025 18:13:41 -0400
Message-Id: <20250505221419.2672473-605-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 87478ba50a05a1f44508316ae109622e8a85adc9 ]

Gen7 only supports ASTDP. Gens 4 to 6 support various TX chips,
except ASTDP. These boards detect the TX chips by reading the SoC
scratch register as VGACRD1.

Gens 1 to 3 only support SIL164. These boards read the DVO bit from
VGACRA3. Hence move this test behind a branch, so that it does not
run on later generations.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250117103450.28692-6-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ast/ast_main.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_main.c b/drivers/gpu/drm/ast/ast_main.c
index bc37c65305d48..96470fc8e6e53 100644
--- a/drivers/gpu/drm/ast/ast_main.c
+++ b/drivers/gpu/drm/ast/ast_main.c
@@ -96,21 +96,21 @@ static void ast_detect_tx_chip(struct ast_device *ast, bool need_post)
 	/* Check 3rd Tx option (digital output afaik) */
 	ast->tx_chip = AST_TX_NONE;
 
-	/*
-	 * VGACRA3 Enhanced Color Mode Register, check if DVO is already
-	 * enabled, in that case, assume we have a SIL164 TMDS transmitter
-	 *
-	 * Don't make that assumption if we the chip wasn't enabled and
-	 * is at power-on reset, otherwise we'll incorrectly "detect" a
-	 * SIL164 when there is none.
-	 */
-	if (!need_post) {
-		jreg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xff);
-		if (jreg & 0x80)
-			ast->tx_chip = AST_TX_SIL164;
-	}
-
-	if (IS_AST_GEN4(ast) || IS_AST_GEN5(ast) || IS_AST_GEN6(ast)) {
+	if (AST_GEN(ast) <= 3) {
+		/*
+		 * VGACRA3 Enhanced Color Mode Register, check if DVO is already
+		 * enabled, in that case, assume we have a SIL164 TMDS transmitter
+		 *
+		 * Don't make that assumption if we the chip wasn't enabled and
+		 * is at power-on reset, otherwise we'll incorrectly "detect" a
+		 * SIL164 when there is none.
+		 */
+		if (!need_post) {
+			jreg = ast_get_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xff);
+			if (jreg & 0x80)
+				ast->tx_chip = AST_TX_SIL164;
+		}
+	} else if (IS_AST_GEN4(ast) || IS_AST_GEN5(ast) || IS_AST_GEN6(ast)) {
 		/*
 		 * On AST GEN4+, look the configuration set by the SoC in
 		 * the SOC scratch register #1 bits 11:8 (interestingly marked
-- 
2.39.5


