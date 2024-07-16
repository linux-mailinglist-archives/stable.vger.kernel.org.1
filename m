Return-Path: <stable+bounces-59712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC5E932B64
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BE81F210B4
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C627195B27;
	Tue, 16 Jul 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VB4Iyy8F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A3F9E8;
	Tue, 16 Jul 2024 15:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144678; cv=none; b=W5DVn4IFCR6vHxosbAxqxUtfIz5kfXAU0y8sN6XvBERiMdRCV23WD4ZHtr/QNsA0Fr5P98TImh9OPvhZUVacOemqMmLknqLYXxlsQpf5KVCnwGCVPH0OxVZToVPmPGYTj8ye5f1VE38y7nIXPT2ftNeTqK0kmD2eEOm8iK3MJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144678; c=relaxed/simple;
	bh=vtK1dVywseekplm/5yzQDfowVWc+eQEhcfCCzvzB5Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOOHgrHsk/5InXbUfxY4g21ibMjlTzipjY8Hw5+yk8rK3Ze8feTW46JKlaBFhc2fndSz5bPeOWHcn9yM2B+UHwFpjvPp3gAPe0Yog8KSwZAIAbZBJZBR6xmiOvtvh8832uhTW82TexdbulUBFql1FpYp892ylpBd6qY/9hmcjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VB4Iyy8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEBDC4AF0D;
	Tue, 16 Jul 2024 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144678;
	bh=vtK1dVywseekplm/5yzQDfowVWc+eQEhcfCCzvzB5Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VB4Iyy8FIO4X3qJi/0i2TJZQfb7hGtGhKi1bVxP5ZbiKWFctSolbFX7c9yeXGcFCE
	 ogd2s8m4PsfacnUwo9mGCVFrmK12GCrEAfV+nyKgdjoqMxtybLyxjXyJSu65o2NK8O
	 eEexakTjMky4hPDPZnI/XaID7nX4sqJ7eF5+zXEk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jozef Hopko <jozef.hopko@altana.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Ajay Singh <ajay.kathat@microchip.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 029/108] wifi: wilc1000: fix ies_len type in connect path
Date: Tue, 16 Jul 2024 17:30:44 +0200
Message-ID: <20240716152747.118825509@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152745.988603303@linuxfoundation.org>
References: <20240716152745.988603303@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jozef Hopko <jozef.hopko@altana.com>

[ Upstream commit 39ab8fff623053a50951b659e5f6b72343d7d78c ]

Commit 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
made sure that the IEs data was manipulated under the relevant RCU section.
Unfortunately, while doing so, the commit brought a faulty implicit cast
from int to u8 on the ies_len variable, making the parsing fail to be
performed correctly if the IEs block is larger than 255 bytes. This failure
can be observed with Access Points appending a lot of IEs TLVs in their
beacon frames (reproduced with a Pixel phone acting as an Access Point,
which brough 273 bytes of IE data in my testing environment).

Fix IEs parsing by removing this undesired implicit cast.

Fixes: 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
Signed-off-by: Jozef Hopko <jozef.hopko@altana.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Acked-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20240701-wilc_fix_ies_data-v1-1-7486cbacf98a@bootlin.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index 457386f9de990..3f167bf4eef35 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -364,7 +364,8 @@ void *wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 	struct ieee80211_p2p_noa_attr noa_attr;
 	const struct cfg80211_bss_ies *ies;
 	struct wilc_join_bss_param *param;
-	u8 rates_len = 0, ies_len;
+	u8 rates_len = 0;
+	int ies_len;
 	int ret;
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);
-- 
2.43.0




