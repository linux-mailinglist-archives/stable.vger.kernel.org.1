Return-Path: <stable+bounces-172726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C3EB32FFF
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6173C446CB9
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C05225A2B5;
	Sun, 24 Aug 2025 13:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoGFneR5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67E253944
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756040563; cv=none; b=ckXh0aW97T3cpfKWs12SE4EsIs0xjDU3RfWLbz1Eahqj+BCzvawoZlZwlfr63SdPT2uJF2FU6q/mC82Qgd7zSxBEUG+CJiR08tknKAsQGKydkfBIayrf4LV+ZJ68tdx390dwUbyzAVa0XbjPKKcgBrroN8HSslFLsNyNWFP3gmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756040563; c=relaxed/simple;
	bh=ql1J+QO5M9rGYZQNJAQ3FsVwO8lbT5JzHJpb24rF2UY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6OdHGOiJOXYaw12t7BU/I0WqOJiziKFrsjWZUV9Jop/od8D/GWBZYIBSjBDWZPeWFPIWgMHVMgCsE0TXw+3X3eCJBtGyJOaVDGT8mYpNkfO9onOIYrFi7J1rtGApLyldWA8m6khL9fCxYaAht19xUr/mLQtWj40JoNxlr5Qspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoGFneR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD68C4CEEB;
	Sun, 24 Aug 2025 13:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756040561;
	bh=ql1J+QO5M9rGYZQNJAQ3FsVwO8lbT5JzHJpb24rF2UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hoGFneR5R181YNV4RRgMkRcF3yiNduykQ9r43hI/FrDlLVY/08vO8oNZJeNP6pGdo
	 UsR4rgIh6QRkkA4+1S29z9ZBSWUjl54Nq98HBdQG1apgpmJE9LmciX/zFVPkbsRhYq
	 2LRBQnLhGYkqTVJpLls/YTFIAiNi14uNiW9RTz8ydtUR7wwmYAM9mYFmm36kPCNETP
	 odlOoyhzzNfUr9P3sQBbKA+eiu2zIajgKnNmBnQCpNYweA/PhSFuKn9pR21wsb6xLZ
	 r2wUAvQ770y4hzy3TFJmsYmlASrHLcbRriQwR2Et8GqQLGkz4ApWbQiHx1ESlQysXV
	 DY7zZsBMVojYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: light: as73211: Ensure buffer holes are zeroed
Date: Sun, 24 Aug 2025 09:02:38 -0400
Message-ID: <20250824130238.2749705-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082317-deprecate-tropics-e5fc@gregkh>
References: <2025082317-deprecate-tropics-e5fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 433b99e922943efdfd62b9a8e3ad1604838181f2 ]

Given that the buffer is copied to a kfifo that ultimately user space
can read, ensure we zero it.

Fixes: 403e5586b52e ("iio: light: as73211: New driver")
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Link: https://patch.msgid.link/20250802164436.515988-2-jic23@kernel.org
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/as73211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index c1f9604c2714..166874c68ff6 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -573,7 +573,7 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct {
 		__le16 chan[4];
 		s64 ts __aligned(8);
-	} scan;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);
-- 
2.50.1


