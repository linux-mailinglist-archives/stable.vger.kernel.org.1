Return-Path: <stable+bounces-169179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4993B2389A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60117189BF2D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187F42FA0CD;
	Tue, 12 Aug 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iZbqzHxS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E4F2F8BC3;
	Tue, 12 Aug 2025 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026645; cv=none; b=ClBiGoldEkTkZcsVBG5N5ZrE/u6V7RCRO6S5kVbCx6DuTai8waWC/bz8z5MGiD/luMvhtNFSEx2NxyFFeOzjTY85HzNza9vKaG8jZe0EGtUpg3I8DfFoeOuorgP9g1tWdotcGRQG1ZpkoZ5Mkpa4PUU4vfcMA8ZsxW2MEXKEjts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026645; c=relaxed/simple;
	bh=N+wIUpTMrAwiqmdd/Rs6nqxpClB5rR/3rQvCs8EY7bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt7/C6hWKMisi8vjCVtXq5Aj1Bk6gnRpujBA8aN4WZqOF2A+pH641KgTg6rCgvrPkB1P4JA39yscj+2+lNjUKI3+NPewuw79z7Q7yhm+BEK5Ny7OIIGtThbubVkS0A2im6KqsPWQePH2QmB9vPP4KSlZMeWwdjdJuAe4pvm8CHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iZbqzHxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF20BC4CEF0;
	Tue, 12 Aug 2025 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026645;
	bh=N+wIUpTMrAwiqmdd/Rs6nqxpClB5rR/3rQvCs8EY7bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZbqzHxS03WdcFG6/e5A8B6RqNP6YRf/Tp38jhRV9Xuv8m+41vRzRD0LzZqAjHYrJ
	 JDbGJp48WnNCEU+CpFjqaSFUAGgm5BJf7hhigwKgHia4+bZ/z5uKAPAM2sKek3WVq5
	 iUkNhc28ZwQQ0MwDo3DcSu/fF2rlYbsYBgFu6bXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Trimmer <simont@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 397/480] spi: cs42l43: Property entry should be a null-terminated array
Date: Tue, 12 Aug 2025 19:50:05 +0200
Message-ID: <20250812174413.800957885@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit ffcfd071eec7973e58c4ffff7da4cb0e9ca7b667 ]

The software node does not specify a count of property entries, so the
array must be null-terminated.

When unterminated, this can lead to a fault in the downstream cs35l56
amplifier driver, because the node parse walks off the end of the
array into unknown memory.

Fixes: 0ca645ab5b15 ("spi: cs42l43: Add speaker id support to the bridge configuration")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220371
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Link: https://patch.msgid.link/20250731160109.1547131-1-simont@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cs42l43.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cs42l43.c b/drivers/spi/spi-cs42l43.c
index ceefc253c549..004801c2c925 100644
--- a/drivers/spi/spi-cs42l43.c
+++ b/drivers/spi/spi-cs42l43.c
@@ -293,7 +293,7 @@ static struct spi_board_info *cs42l43_create_bridge_amp(struct cs42l43_spi *priv
 	struct spi_board_info *info;
 
 	if (spkid >= 0) {
-		props = devm_kmalloc(priv->dev, sizeof(*props), GFP_KERNEL);
+		props = devm_kcalloc(priv->dev, 2, sizeof(*props), GFP_KERNEL);
 		if (!props)
 			return NULL;
 
-- 
2.39.5




