Return-Path: <stable+bounces-39504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDC68A51E5
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 15:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D08941C2260C
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 13:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A33762E0;
	Mon, 15 Apr 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euCUVKrZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89390757FC
	for <stable@vger.kernel.org>; Mon, 15 Apr 2024 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188322; cv=none; b=kbaAkgwupI+winB+lhdVx5gxCwzEaF6EWrX+9VuoRMotCFUlewYtbTyGxJq2hcprr7XdaQeXJbm7D/+lBPNpjXriGj8X240LSKyjPBj5zH6LcPMeiaFf4bwdf6QfqPBVGBdzLVueQ/nyxXOJf4v+ZJlDEEhApJkGVUaBVY4cA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188322; c=relaxed/simple;
	bh=D0Uaj9YhQ3xd9KnFbswYDXXzteBKnj8XeFA0kZkLljQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDpz3yKXUsl7agneSlAegDQ9Ov8DwSr0td+eCwtUjyWW+JbFW7B1Ct3VGtbmLn+/vQPYg4piQcPbpPV09XA8ob6fp06miaDPTW1t3w66L/QUCzYAcctrUJAvAlw0HaqGmuxxeq0oFdCBgMKWWnsTxa6o/W+zdTIfDawsR4yxs3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euCUVKrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7F8C2BD10;
	Mon, 15 Apr 2024 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713188322;
	bh=D0Uaj9YhQ3xd9KnFbswYDXXzteBKnj8XeFA0kZkLljQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=euCUVKrZYYEcPaAImQJ1T+Lqk4tyou1RLGp4M5WyS7DvL4aLf8sNWuFWpIq6iS+9U
	 xwhl0O7IPg0hp5IqJwbu9Iggzsia7TAYSj8H6t+4ZZYNa4O3cd8TPdNLYuZAM/5G4f
	 j0vgyTeYQR7JVgxwHRLaGeVme64oAOGIM4ZFlB7i0H7ChZSEsrm87X9hs12pKPLi6w
	 nUKWNhm5vHZS15CS9arzs5IRZBjti4J6jvEfu1MgKuV73Qx82fNytFS2cStG7RaqVo
	 xUr4q2DOdTGe33ceHn65wswEYmB5JGNk8f8U2XkyuXB3fjs6ImHE4ybQ7Ep2gejhT7
	 eh0pzX8Up4SzA==
From: Sasha Levin <sashal@kernel.org>
To: kernel-lts@openela.org
Cc: Helge Deller <deller@gmx.de>,
	stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14-openela 023/190] fbdev: stifb: Make the STI next font pointer a 32-bit signed offset
Date: Mon, 15 Apr 2024 06:49:13 -0400
Message-ID: <20240415105208.3137874-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415105208.3137874-1-sashal@kernel.org>
References: <20240415105208.3137874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

[ Upstream commit 8a32aa17c1cd48df1ddaa78e45abcb8c7a2220d6 ]

The pointer to the next STI font is actually a signed 32-bit
offset. With this change the 64-bit kernel will correctly subract
the (signed 32-bit) offset instead of adding a (unsigned 32-bit)
offset. It has no effect on 32-bit kernels.

This fixes the stifb driver with a 64-bit kernel on qemu.

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sticore.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sticore.h b/drivers/video/fbdev/sticore.h
index fb8f58f9867a7..0416e2bc27d85 100644
--- a/drivers/video/fbdev/sticore.h
+++ b/drivers/video/fbdev/sticore.h
@@ -237,7 +237,7 @@ struct sti_rom_font {
 	 u8 height;
 	 u8 font_type;		/* language type */
 	 u8 bytes_per_char;
-	u32 next_font;
+	s32 next_font;		/* note: signed int */
 	 u8 underline_height;
 	 u8 underline_pos;
 	 u8 res008[2];
-- 
2.43.0


