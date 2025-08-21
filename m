Return-Path: <stable+bounces-172188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B59B2FFD4
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52A805A2522
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 16:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951352D877D;
	Thu, 21 Aug 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ie21Uz6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542572D8387
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792882; cv=none; b=c8GRyQq1XkdnTJyGVqehE33uR7hTM/c3FNyxMId3eQATAt9A45+WJu7vm2fPyFaFPbn+ksAFZrVw0GrkpafuwoCngggzoP/tmM3BshUZo2BTzhgofOBItfB+UgiKFaqs3Ww/nuoInUw4hE0NRX6L1XbKht9kzWdfKyCXlESHF2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792882; c=relaxed/simple;
	bh=7szevNYHBjLIRe+gc+ZSIIzbJ4snyRxy6f+5o0WqKy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN58KJvhpIQVCYPz/8uShq3XJSHigr0XwKUnNPx+tjx4WwKecPTsmkT/1Ki2GluEVu+8zNFaC0mJQtZWsQ9r7ZCGxmpne2tfdUNTp94JTDV7s2XrMJ/PL2kfM4EQdiIf9AubsGoy5cBBRRzfJEZZ1ZpY5tWPlNXo8hsFSENBP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ie21Uz6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73316C16AAE;
	Thu, 21 Aug 2025 16:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755792881;
	bh=7szevNYHBjLIRe+gc+ZSIIzbJ4snyRxy6f+5o0WqKy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ie21Uz6pY8qm6a14L1YKMBmQRHRiAqiVvfgQeJ2oWD7BPqWX17b5Od7pRuhbg5tE8
	 dVVLyEGUi0MMkCz70Q2PuZD5QWlrw9ECO7Xw0UhwMgLIVBa0Yx0EZ3M65ebZAsfsnu
	 ogdju1lJo8hfTUk3/5nGHTaKZc1dBNUj413kaibmchIwLzteAK56fn2SRviwBrVBS6
	 5plj0xhdakQfOOVwMdl9CdjbSRQcob+fQVYSJdjNE4H9uo6oas58eMRubR97tuz+oG
	 vOcrGAwjFT/5ED7UmA6yBe9kxrOA7ZYY5AD5FeRdvVGlY84zFvi7TciDgxpL9Gdkqp
	 ao3uYKz1AB3kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()
Date: Thu, 21 Aug 2025 12:14:37 -0400
Message-ID: <20250821161437.775522-4-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821161437.775522-1-sashal@kernel.org>
References: <2025082112-segment-delta-e613@gregkh>
 <20250821161437.775522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

[ Upstream commit e2374953461947eee49f69b3e3204ff080ef31b1 ]

The blocking notifier is registered in cros_ec_register(); however, it
isn't unregistered in cros_ec_unregister().

Fix it.

Fixes: 42cd0ab476e2 ("platform/chrome: cros_ec: Query EC protocol version if EC transitions between RO/RW")
Cc: stable@vger.kernel.org
Reviewed-by: Benson Leung <bleung@chromium.org>
Link: https://lore.kernel.org/r/20250722120513.234031-1-tzungbi@kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index ec6ebb250ba3..a0b6cec9bfee 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -292,6 +292,9 @@ EXPORT_SYMBOL(cros_ec_register);
  */
 void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
+	if (ec_dev->mkbp_event_supported)
+		blocking_notifier_chain_unregister(&ec_dev->event_notifier,
+						   &ec_dev->notifier_ready);
 	platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
 	mutex_destroy(&ec_dev->lock);
-- 
2.50.1


