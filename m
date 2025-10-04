Return-Path: <stable+bounces-183345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA556BB8749
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 02:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4A93A81E9
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 00:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FACAEED8;
	Sat,  4 Oct 2025 00:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auHYXwjG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5C96FBF
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 00:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759538418; cv=none; b=a41Ikgiaw4P2h1kseDhBN6nu4O4GOElbucwP54rFNQF3LuH9US2q3Pr+agEmW0Ug/W9wrXLCIeVH77qRDNxH41qBISq917RYOSH2U3s/jp+wDTd1f4alH5EOONps+RldPvuurCNbMQuVSvlLXDuKht2A0XtzHHxC7ED/10E3B6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759538418; c=relaxed/simple;
	bh=JL9k4zPLWiGBeu12uUmzFPdAumpC82AaHQ3NYgb1Kzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc9j8pnrCqS/kCcOwusF4eWKjHDza/VDz8rsDCfGZQ1SBOQWSLyaO5+tZMHCbiAvEO58A0qudajQuYP0Nvlwx0Zbbx0wJyWj7Wub+pTR5ZLZjUP1kER4fPKy9RVT3FP2muQ3NEuV2tjJRrXX1bIgJR7pL4x33nPfx46mHXyRFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auHYXwjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB32DC4CEFB;
	Sat,  4 Oct 2025 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759538418;
	bh=JL9k4zPLWiGBeu12uUmzFPdAumpC82AaHQ3NYgb1Kzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=auHYXwjGILJLkE4nwz36bA1NgBfJvub/Ryc349YSow5GRsDuoPCUaesoHn384UWCO
	 id8lECvfhXEbkKOzuz3WWEbYCxI55w9ACxqFVlNXuOtGH/dLhVXzFkPoig4XW1J7z2
	 +7xaKqhSruMW8h1eKwSMNMN3wvLjSXRd6cbMlTQ5TwTWuziDxoTFXrOlr/D09DB5bL
	 7Ms8YAN+ieMcAACBFwoyF+eor4nK4Cqct8fWE+9lshulq+t4LvdETfPz1a3NcVYywv
	 8qvbHu/0iZ6LPBLZbnw4N7yE5ixnXi3YKFp6aL0JTzIOlcG2tn0G7gafqGLdmpCBKD
	 YnOglfi4+Jvsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y 2/2] media: tuner: xc5000: Fix use-after-free in xc5000_release
Date: Fri,  3 Oct 2025 20:40:15 -0400
Message-ID: <20251004004015.4039827-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004004015.4039827-1-sashal@kernel.org>
References: <2025100341-dime-left-e15f@gregkh>
 <20251004004015.4039827-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 40b7a19f321e65789612ebaca966472055dab48c ]

The original code uses cancel_delayed_work() in xc5000_release(), which
does not guarantee that the delayed work item timer_sleep has fully
completed if it was already running. This leads to use-after-free scenarios
where xc5000_release() may free the xc5000_priv while timer_sleep is still
active and attempts to dereference the xc5000_priv.

A typical race condition is illustrated below:

CPU 0 (release thread)                 | CPU 1 (delayed work callback)
xc5000_release()                       | xc5000_do_timer_sleep()
  cancel_delayed_work()                |
  hybrid_tuner_release_state(priv)     |
    kfree(priv)                        |
                                       |   priv = container_of() // UAF

Replace cancel_delayed_work() with cancel_delayed_work_sync() to ensure
that the timer_sleep is properly canceled before the xc5000_priv memory
is deallocated.

A deadlock concern was considered: xc5000_release() is called in a process
context and is not holding any locks that the timer_sleep work item might
also need. Therefore, the use of the _sync() variant is safe here.

This bug was initially identified through static analysis.

Fixes: f7a27ff1fb77 ("[media] xc5000: delay tuner sleep to 5 seconds")
Cc: stable@vger.kernel.org
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[hverkuil: fix typo in Subject: tunner -> tuner]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/tuners/xc5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/tuners/xc5000.c b/drivers/media/tuners/xc5000.c
index 8b939ab84ee77..ea4f1ae4d686e 100644
--- a/drivers/media/tuners/xc5000.c
+++ b/drivers/media/tuners/xc5000.c
@@ -1304,7 +1304,7 @@ static void xc5000_release(struct dvb_frontend *fe)
 	mutex_lock(&xc5000_list_mutex);
 
 	if (priv) {
-		cancel_delayed_work(&priv->timer_sleep);
+		cancel_delayed_work_sync(&priv->timer_sleep);
 		hybrid_tuner_release_state(priv);
 	}
 
-- 
2.51.0


