Return-Path: <stable+bounces-77995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F5798848E
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 14:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A20BB22874
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 12:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F918BC1D;
	Fri, 27 Sep 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JqdwuUPY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAED17B515;
	Fri, 27 Sep 2024 12:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440131; cv=none; b=b3xAtZthvnd7I/1VMot5jEqIO2ICQiwH7+XPsMFYPTjZqeuj+U4xIEu3TOzqRwowlbEQvxYjQ41tpyl1cMlaq5usoWcOD4rv1XtHgaa7C6A6DuXJtEqmr7Ewpe1bq2iwC1DJs3bT80Mzk7j9BNWzZA85DC8JD6zJoj98sLYSu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440131; c=relaxed/simple;
	bh=cr6/K5W3yTFs07cfLNXiql7lb4G6sheLYZ6Q3R4YPFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEzR9PAvfrQhspegra3GHQ5uiVGg2ImOg6hvaECTXvDYIRCVWoJ944ixOo/tq8q5IbA+jgAg9RpvfJ16shneAMN9GnGfKPBs2qGXT3IDPsSdBx0NsQ8ouanqBdUJi6YcLm9QAzwlS1xxPkMVsQdzGmDudXpzBaLJJq0Bc+2rfDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JqdwuUPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2037C4CEC4;
	Fri, 27 Sep 2024 12:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727440131;
	bh=cr6/K5W3yTFs07cfLNXiql7lb4G6sheLYZ6Q3R4YPFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JqdwuUPYNK6L4+tvsXux8zvvH8lG9lvx+1j6ArWIiKAf9X9KLxpsI8A/ppeWkSxNn
	 aCmVStvLlnKag/HkPJlluK4hpiYMDzwbNYLFq0Nl74oRX9YGpMKk2RJBO++RGou5Ke
	 MevINptMO6jP7gokpS2ZU+bpcaQxzjFVsAohsn1I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 43/58] spi: spidev: Add missing spi_device_id for jg10309-01
Date: Fri, 27 Sep 2024 14:23:45 +0200
Message-ID: <20240927121720.525891249@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
References: <20240927121718.789211866@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 5478a4f7b94414def7b56d2f18bc2ed9b0f3f1f2 ]

When the of_device_id entry for "elgin,jg10309-01" was added, the
corresponding spi_device_id was forgotten, causing a warning message
during boot-up:

    SPI driver spidev has no spi_device_id for elgin,jg10309-01

Fix module autoloading and shut up the warning by adding the missing
entry.

Fixes: 5f3eee1eef5d0edd ("spi: spidev: Add an entry for elgin,jg10309-01")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/54bbb9d8a8db7e52d13e266f2d4a9bcd8b42a98a.1725366625.git.geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 14bf0fa65befe..face93a9cf203 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -702,6 +702,7 @@ static const struct class spidev_class = {
 static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "bh2228fv" },
 	{ .name = "dh2228fv" },
+	{ .name = "jg10309-01" },
 	{ .name = "ltc2488" },
 	{ .name = "sx1301" },
 	{ .name = "bk4" },
-- 
2.43.0




