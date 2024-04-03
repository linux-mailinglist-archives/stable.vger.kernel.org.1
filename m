Return-Path: <stable+bounces-35826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A130897728
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8E21C2914D
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 17:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3329116F0EC;
	Wed,  3 Apr 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPwC6ZbI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53416F0DF;
	Wed,  3 Apr 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164833; cv=none; b=AdH9drkNLRqzE7FVu7KgTKoYxc/Dhd20/9fa6cNJArPCpMuNBbxDKJfgNIz5m0ixpKLPeT32STHrqw2Kj6jM5blOopNQUNenuf1rBe55KFis4I9tncCTWrpNhybaGjg6xFR18Nb2WteNL3EyIeX6+ZDcO5zLHiqhrVOL9wliN7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164833; c=relaxed/simple;
	bh=dRwY8HYdqT7o3WvvpYcqMk1yH1fOKmhm6ji/WNm0als=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAvvaNVSNXZRiY3SwOI4LA48cRzf3Ottwg6DUsnuChdAG16LNhGbX/XIrSXM456cs1BBPvvoWwK4SxjwRbZjVXRu2jZGEKop45/cAtVkQNtNhcQdrF36C4XC47CGz/ygci4rN12EoAIYfbuIo6kvCxzLwyvTlA0704828OCECc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPwC6ZbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92D3C43390;
	Wed,  3 Apr 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164832;
	bh=dRwY8HYdqT7o3WvvpYcqMk1yH1fOKmhm6ji/WNm0als=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FPwC6ZbI9qd3XOEAxhgfpg4K/jLYKbWosB1hy4fJ51JLp9WL7brzF2Oc2+SKT9/OE
	 7EHConxC0Hv1ceSf30bFTt7ATem4St4Glukr90E+z7O+ESIjpznw8XK6ZUGfdxHcEw
	 7EbBUprhMa0b6TOWsIhVnHOvuihSSbGN7m4sdoko6FMz+ss1nMIAIp7m7WwJGDw5G2
	 oIJzlxhKTa5qjcJ2HLR8PgjVixXYWDDwhb6k0y1FRjo0JzNoNoYXoN4x5mvfiZn8dh
	 ua6DYnbZB1nbzeqRNKzeE5r+MAB9GAUEvnF2QuMQzSTF1bmo1ncKHMFACADqz6JN0h
	 qlrJukXIbVwRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	u.kleine-koenig@pengutronix.de,
	linux-usb@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 4/6] usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined
Date: Wed,  3 Apr 2024 13:20:20 -0400
Message-ID: <20240403172026.353926-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172026.353926-1-sashal@kernel.org>
References: <20240403172026.353926-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

[ Upstream commit 12f371e2b6cb4b79c788f1f073992e115f4ca918 ]

Function checkdone is only required if QUIRK2 is defined, so add
appropriate #if / #endif around the function.

Cleans up clang scan build warning:
drivers/usb/host/sl811-hcd.c:588:18: warning: unused function
'checkdone' [-Wunused-function]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Link: https://lore.kernel.org/r/20240307111351.1982382-1-colin.i.king@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/sl811-hcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index 936fddc6d8207..3cf8fce40c9dc 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -585,6 +585,7 @@ done(struct sl811 *sl811, struct sl811h_ep *ep, u8 bank)
 		finish_request(sl811, ep, urb, urbstat);
 }
 
+#ifdef QUIRK2
 static inline u8 checkdone(struct sl811 *sl811)
 {
 	u8	ctl;
@@ -616,6 +617,7 @@ static inline u8 checkdone(struct sl811 *sl811)
 #endif
 	return irqstat;
 }
+#endif
 
 static irqreturn_t sl811h_irq(struct usb_hcd *hcd)
 {
-- 
2.43.0


