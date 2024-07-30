Return-Path: <stable+bounces-62780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03FC94123B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7763CB29C19
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2401A01A7;
	Tue, 30 Jul 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkfBD+sI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC791A00FE;
	Tue, 30 Jul 2024 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343527; cv=none; b=Wm+CRlJy8o4svGz5JGlD4cMVutnA5RwNvpanVG5ziFJeq1Zv+9Acs2bPn5TR53m/PV2NPjbOJpEhV7kthEBYErjxhNWak6SXJLr8aKeTd5n1vdg0FobjAHwAaxqKDohWuJIiLgM5w6fTht2+z8F+QTTV7ONRvaHw0DW0j9KaBIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343527; c=relaxed/simple;
	bh=Qqmh63C0FCi2NXUE4nzDcfPZG/1Qv2LjyvEEOCQSEuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=riBrhG9beWsUBQnuK81MB+bmp6Bw3TWUe+dFjwwxqGOB9xme/ACzkitMLwgXD4IGh9FwZgiy8bA1fAfL96e/XEU688+/bOk18WsCFPylpEI4IBeU9d88DWj9nGOhUTi1RtbWCC46Ms+MTs6tpm7jslBesr0TXa6RwotfQIv9FlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkfBD+sI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29858C4AF0F;
	Tue, 30 Jul 2024 12:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722343527;
	bh=Qqmh63C0FCi2NXUE4nzDcfPZG/1Qv2LjyvEEOCQSEuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZkfBD+sI70qqgGDz9iQiHns8VoqLTJXWr6ry/AqqREx03xEY7bmSDWtitF3UXFA+N
	 C1WMSvnfrVBgUxwSCYieXw+tPFPme/IHOQo2+lDbuKzpa54vVGVPtiCNyViqgyXDlY
	 SusE2uQlxCaj1+JOQ/8X6am25Hv6RYKF/fIr1Q37m3xHVzYvkQS2pWZ3YD6P7fbCxM
	 9b2PcuxsY2WnT/hvdG3u7M3jbQNsuiwoxQ59BNDu04LZZ6mDbab+UiMs/W+xLJ7bDY
	 jPl5FWC5MtVOddTdp/nvdMZFMPVmVFCJwPtEkAEjPG2tynYjoWWkzFtL1B0ImzZo00
	 1La2vKNezAeDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.10 4/7] driver core: Make dev_err_probe() silent for -ENOMEM
Date: Tue, 30 Jul 2024 08:45:10 -0400
Message-ID: <20240730124519.3093607-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730124519.3093607-1-sashal@kernel.org>
References: <20240730124519.3093607-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

[ Upstream commit 2f3cfd2f4b7cf3026fe6b9b2a5320cc18f4c184e ]

For an out-of-memory error there should be no additional output. Adapt
dev_err_probe() to not emit the error message when err is -ENOMEM.
This simplifies handling errors that might among others be -ENOMEM.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/3d1e308d45cddf67749522ca42d83f5b4f0b9634.1718311756.git.u.kleine-koenig@baylibre.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/core.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2b4c0624b7043..730cae66607c0 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -5021,11 +5021,22 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (err != -EPROBE_DEFER) {
-		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
-	} else {
+	switch (err) {
+	case -EPROBE_DEFER:
 		device_set_deferred_probe_reason(dev, &vaf);
 		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
+
+	case -ENOMEM:
+		/*
+		 * We don't print anything on -ENOMEM, there is already enough
+		 * output.
+		 */
+		break;
+
+	default:
+		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
+		break;
 	}
 
 	va_end(args);
-- 
2.43.0


