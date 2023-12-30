Return-Path: <stable+bounces-8918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9F082056D
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913151C2108A
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2A8473;
	Sat, 30 Dec 2023 12:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gPtS/hck"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831F79EE;
	Sat, 30 Dec 2023 12:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20519C433C8;
	Sat, 30 Dec 2023 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703938100;
	bh=z2XN07YbiYQCD9Nwd0KEScLuZhGtPranLz+psukX+ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gPtS/hckCPxeTZ/3/0hFhHfE/Vp9c08JfI8UAW8IxrdkvmW5aqj3nNuxRHIS+FLSG
	 R3Vvm+0WB7zFICbx5BNsTbt5GmZg/1uVOyKvEtRzSrbrQuCOYWk8nwzLE0rjmr/2zW
	 tejFLfm2iPzqQP85+lYe4kZ1gqCWpwHlyqe/qUjI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 008/112] reset: Fix crash when freeing non-existent optional resets
Date: Sat, 30 Dec 2023 11:58:41 +0000
Message-ID: <20231230115807.011043679@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115806.714618407@linuxfoundation.org>
References: <20231230115806.714618407@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 4a6756f56bcf8e64c87144a626ce53aea4899c0e ]

When obtaining one or more optional resets, non-existent resets are
stored as NULL pointers, and all related error and cleanup paths need to
take this into account.

Currently only reset_control_put() and reset_control_bulk_put()
get this right.  All of __reset_control_bulk_get(),
of_reset_control_array_get(), and reset_control_array_put() lack the
proper checking, causing NULL pointer dereferences on failure or
release.

Fix this by moving the existing check from reset_control_bulk_put() to
__reset_control_put_internal(), so it applies to all callers.
The double check in reset_control_put() doesn't hurt.

Fixes: 17c82e206d2a3cd8 ("reset: Add APIs to manage array of resets")
Fixes: 48d71395896d54ee ("reset: Add reset_control_bulk API")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/2440edae7ca8534628cdbaf559ded288f2998178.1701276806.git.geert+renesas@glider.be
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/reset/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index f0a076e94118f..92cc13ef3e566 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -807,6 +807,9 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 {
 	lockdep_assert_held(&reset_list_mutex);
 
+	if (IS_ERR_OR_NULL(rstc))
+		return;
+
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
@@ -1017,11 +1020,8 @@ EXPORT_SYMBOL_GPL(reset_control_put);
 void reset_control_bulk_put(int num_rstcs, struct reset_control_bulk_data *rstcs)
 {
 	mutex_lock(&reset_list_mutex);
-	while (num_rstcs--) {
-		if (IS_ERR_OR_NULL(rstcs[num_rstcs].rstc))
-			continue;
+	while (num_rstcs--)
 		__reset_control_put_internal(rstcs[num_rstcs].rstc);
-	}
 	mutex_unlock(&reset_list_mutex);
 }
 EXPORT_SYMBOL_GPL(reset_control_bulk_put);
-- 
2.43.0




