Return-Path: <stable+bounces-163696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92653B0D8EF
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C796189E130
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0321E32D3;
	Tue, 22 Jul 2025 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMLX5o1H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF522D786;
	Tue, 22 Jul 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185944; cv=none; b=OpPZROZfgWSSkxLyfLvf3vzTFaaYkqJshijemAoscKyv+n4ClxC11+PshUVYabgUi+QaK+aVZKfoOSlm/GiU01KamKvpibi/N0J5/hv7voFDjOOIssfTcBo9yR04dNajOPOnzcRibK7mphlHtQhpYjn1bfw4FpbLqGUcmifJJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185944; c=relaxed/simple;
	bh=WOXF/xJkKnwjqYSkGaByd+W5fwkF3TFkg37atWq1MFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yy+eLWCcm7rq4Eq+fSX+t9KKkARKLm+ivmFRThPkH40NRMLoOfkszJojH7e/5SjfiVZvLNbTfH6EI1cmBa6eqenOZvuPxxmgL9va7fLu0SeRXaJ41dFOCTxLPl1dgcKl879smGvZ5nWaChv8/iXrO8ZKlDX/R3kijQCWsyJjp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMLX5o1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEEE3C4CEF4;
	Tue, 22 Jul 2025 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753185943;
	bh=WOXF/xJkKnwjqYSkGaByd+W5fwkF3TFkg37atWq1MFQ=;
	h=From:To:Cc:Subject:Date:From;
	b=XMLX5o1H3iVkTCOY2CQjhqf9zgHytB8P/lq2rcxBrEQIkt7jEbhy+eGwXcbFHp3ar
	 FObe90p4TE2Z8akWXs7f9bZ3cqjiiVc2N+hI2zmUvJBxT4sCw5/C/BN28DPf85czt2
	 VJe0x9mHNgJbe3OA1B59lj1uLZOOPGZV/ge6/4QiAoAxT3CI82/vjRd02rK8Lnwwkl
	 8KkhheRRtJDpX0z+Ytf38BAKTQ38f+yGB34UGatmivrPINawPYuNB4aplt5BjQL6Ro
	 SJW6VELquadlI/Obpb7IV3jlr/EA2g3UPUzXc3u4NrBRTwK0Ia2oiewA54NtsD8KO6
	 hPL5T18fVD8fg==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org
Cc: tzungbi@kernel.org,
	gregkh@linuxfoundation.org,
	chrome-platform@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()
Date: Tue, 22 Jul 2025 12:05:13 +0000
Message-ID: <20250722120513.234031-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The blocking notifier is registered in cros_ec_register(); however, it
isn't unregistered in cros_ec_unregister().

Fix it.

Fixes: 42cd0ab476e2 ("platform/chrome: cros_ec: Query EC protocol version if EC transitions between RO/RW")
Cc: stable@vger.kernel.org
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
This is separated from a series (https://lore.kernel.org/chrome-platform/20250721044456.2736300-3-tzungbi@kernel.org/).

While I'm still figuring out/testing the series, it'd be better to send the
fix earlier (to catch up the upcoming merge window for example).

 drivers/platform/chrome/cros_ec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 110771a8645e..fd58781a2fb7 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -318,6 +318,9 @@ EXPORT_SYMBOL(cros_ec_register);
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
2.50.0.727.gbf7dc18ff4-goog


