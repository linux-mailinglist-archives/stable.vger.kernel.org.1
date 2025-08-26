Return-Path: <stable+bounces-175133-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E9B366E2
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B97C56320A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E22345726;
	Tue, 26 Aug 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q5T+o5+E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6434DCE8;
	Tue, 26 Aug 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216229; cv=none; b=uM5G1BI7FFFMhkHeDhsL+Wy/DWZ4A7lpVZZRDxZ4RaOML5YJMxVv08P1tPj7rwIx14s/9e9AIIkZL+nmyuebzGR/76lGAsIWFKm1UrTxcJo/jW65xiyeFBWTjteS9gIywoTf5rmuKUgzBogwyPE2OXBHqLKrmXGy10FL9S2ACgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216229; c=relaxed/simple;
	bh=jyz2Jl0vx/UXNhjWvu7xIMiFbZpAkUbZm9Gm3uCQvjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psuNg9wSTiUF9QhGTikd4X4yNxN/F3njPhqX2T8ih6P2qgzddH5LriNVpVMLAqv5JmobzYFnaU7C2mljQNfVauYZxuiuxDVJHyusiOyqmx141otFoguG0oOpS8pxcTxBmjZZeNx5RCnvpdSXp5+iuZGKYEKzkbSDoR99gfMxOrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q5T+o5+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738EBC4CEF1;
	Tue, 26 Aug 2025 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216228;
	bh=jyz2Jl0vx/UXNhjWvu7xIMiFbZpAkUbZm9Gm3uCQvjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5T+o5+EZWrsW3YhuDcKTXPABoV5YZixDtFEn5WpM72XbyXtMX1RG0KCLbCqhECC7
	 bhBVYuV/JPjS9muUOpw440L4Jo5I8yJFNijTg76YBsTEbTl3psCZIhDS2KbFfv5+cc
	 V3Qacms0F+38shjIwUjBh/kaWCfdRXqW1V8Tly9A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomasz Michalec <tmichalec@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 331/644] platform/chrome: cros_ec_typec: Defer probe on missing EC parent
Date: Tue, 26 Aug 2025 13:07:02 +0200
Message-ID: <20250826110954.588985768@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomasz Michalec <tmichalec@google.com>

[ Upstream commit 8866f4e557eba43e991f99711515217a95f62d2e ]

If cros_typec_probe is called before EC device is registered,
cros_typec_probe will fail. It may happen when cros-ec-typec.ko is
loaded before EC bus layer module (e.g. cros_ec_lpcs.ko,
cros_ec_spi.ko).

Return -EPROBE_DEFER when cros_typec_probe doesn't get EC device, so
the probe function can be called again after EC device is registered.

Signed-off-by: Tomasz Michalec <tmichalec@google.com>
Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Link: https://lore.kernel.org/r/20250610153748.1858519-1-tmichalec@google.com
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index c065963b9a42..6f3fdd38c393 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -1110,8 +1110,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 
 	typec->ec = dev_get_drvdata(pdev->dev.parent);
 	if (!typec->ec) {
-		dev_err(dev, "couldn't find parent EC device\n");
-		return -ENODEV;
+		dev_warn(dev, "couldn't find parent EC device\n");
+		return -EPROBE_DEFER;
 	}
 
 	platform_set_drvdata(pdev, typec);
-- 
2.39.5




