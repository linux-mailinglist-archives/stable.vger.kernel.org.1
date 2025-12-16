Return-Path: <stable+bounces-202114-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC0DCC32F1
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BECD3048601
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5737035FF4E;
	Tue, 16 Dec 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nrc6Eg0Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177935F8D7;
	Tue, 16 Dec 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765886861; cv=none; b=Sm4ZI6KGi03NcGLSgVLRpXcS12DZM0Njx9/ycUgpmoce1GbWvhQaULhE+5nvArYqpmGLJsvMxnNvdrrp38lAd59kDKsCXLFh3Ch0dFv86dnmkzNkRLgHLnRibi75heF33VWGBbycMTIo7oJ2/SFdrC98xiCrWhUYVL++b8Ght5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765886861; c=relaxed/simple;
	bh=WGgA0mubF/9uhUrKed+pW1r6OepSzV7w5YLGkpMIOs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvx3H14SnmM5yyhV8u00QfPGCKqqbfUielcCDsdfnPLxKdYIZPni758m65FkXTwyueUAR6GEYnEy2UAYoNthzSHwiKu7mF8nFAi0j3roLm1ZrtTjgRi65iVP5DC1Wx7ef6WbcVJsLjA8BHUF1897WfZj0OXuCz5vtM3zjS13WVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nrc6Eg0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785FFC4CEF1;
	Tue, 16 Dec 2025 12:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765886860;
	bh=WGgA0mubF/9uhUrKed+pW1r6OepSzV7w5YLGkpMIOs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nrc6Eg0QAHtjk6Vz2kKdE2+seO1eJgYkcNC8d4kKnUF29M3UTbGgkOKZEtY+Ai/X2
	 NeaduSQ6kqFhNKb3/9SkDZEuSvLU1K3i7AVv1TwPidfM2wSl5Yg6Qr8LCo49oVDkMT
	 vijltvzT4DfOlMvisTxVLqKpe9qo8KvR6HHMlVh8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 027/614] pinctrl: renesas: rzg2l: Fix PMC restore
Date: Tue, 16 Dec 2025 12:06:34 +0100
Message-ID: <20251216111402.292825287@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit cea950101108b7bfffe26ec4007b8e263a4b56a8 ]

PMC restore needs unlocking the register using the PWPR register.

Fixes: ede014cd1ea6422d ("pinctrl: renesas: rzg2l: Add function pointer for PMC register write")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250921111557.103069-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index f524af6f586f4..94cb77949f595 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2993,7 +2993,11 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_pinctrl *pctrl, bool suspen
 		 * Now cache the registers or set them in the order suggested by
 		 * HW manual (section "Operation for GPIO Function").
 		 */
-		RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + PMC(off), cache->pmc[port]);
+		if (suspend)
+			RZG2L_PCTRL_REG_ACCESS8(suspend, pctrl->base + PMC(off), cache->pmc[port]);
+		else
+			pctrl->data->pmc_writeb(pctrl, cache->pmc[port], PMC(off));
+
 		if (has_iolh) {
 			RZG2L_PCTRL_REG_ACCESS32(suspend, pctrl->base + IOLH(off),
 						 cache->iolh[0][port]);
-- 
2.51.0




