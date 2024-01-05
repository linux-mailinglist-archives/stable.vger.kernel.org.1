Return-Path: <stable+bounces-9842-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BAA8255AC
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 15:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4196282ACE
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1462E3F5;
	Fri,  5 Jan 2024 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AFTzEBgL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501428DDA;
	Fri,  5 Jan 2024 14:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A28C433C7;
	Fri,  5 Jan 2024 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704465681;
	bh=Nn6qQrCH3PZcIBfXiL+ar0UUxpaU307tKAkI6a1lKG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFTzEBgLuySbREjOcFZyrWin0PymyQNIXUQKV6Mobjzo71xaIsN6HMXiRxtCx+qqI
	 7nu+GNUzOnLIh5vkrDxiJs3UeiVxFmHFIbNKeUCbpYuEPXNgF77vT7LBdM3EeCp27A
	 TMCjdwIuQUmIpO0U6Ff5sX9brX7XRapGwYgVQD44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 07/41] reset: Fix crash when freeing non-existent optional resets
Date: Fri,  5 Jan 2024 15:38:47 +0100
Message-ID: <20240105143814.255762119@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240105143813.957669139@linuxfoundation.org>
References: <20240105143813.957669139@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/reset/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index ccb97f4e31c38..1680d27040c9b 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -459,6 +459,9 @@ static void __reset_control_put_internal(struct reset_control *rstc)
 {
 	lockdep_assert_held(&reset_list_mutex);
 
+	if (IS_ERR_OR_NULL(rstc))
+		return;
+
 	kref_put(&rstc->refcnt, __reset_control_release);
 }
 
-- 
2.43.0




