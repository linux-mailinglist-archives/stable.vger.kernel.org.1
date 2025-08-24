Return-Path: <stable+bounces-172730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2956BB33020
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 15:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F583B0E79
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 13:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4373269806;
	Sun, 24 Aug 2025 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQzOONef"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A021BD01D
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756042009; cv=none; b=OEY+xy87ul6aSCV7R18OL4ATh4aZnMymIV/z/y1K3vGanSEZEeglvzyrpH287Hs7a3Ur3JXlLb+HTMKyc9dgkrVfA+zhA5iOt1Bdx5HuBiaZ7Bumh5DvWIKPTbXTCXnMaiuk6Mk6QXfXs0NjaMITcyQX/rojz4CUgpVndTuWp4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756042009; c=relaxed/simple;
	bh=JGmgM1UD/SzQZkaQNcCHeT8XdOmb4H6VhC2RrG1BH8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OL+s/7fEB2f293qz2SAjZwSgSlHc9hDr1Dgf6zGJUaxA3mQypRxxqonxGSVAIUkSnSZMPTNBeLXp0EPdNSXFWpldzD35Z6REgkgFmHrfB5RjcpMRdfW5p+UO1V58XvyhjOG2FOfc5lEXAqNmR3LUzVhntpF2KEkYCNC1JwwdUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQzOONef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EA6C4CEEB;
	Sun, 24 Aug 2025 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756042008;
	bh=JGmgM1UD/SzQZkaQNcCHeT8XdOmb4H6VhC2RrG1BH8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQzOONefPp1mRQrabujQBFtDp7ixO9WHp68WCMh0WUHc05YAHIzY0xKxOWAwhsiAz
	 Sryj8n7q8mA1RiYOP+ZBSDTe4yYMapzBPQLAoYSejrN7VdlGq+bU7sxIzd+WJ6GhHF
	 3a5Et5m+VDhfWD59n91BB3o2CkXAs/WhHa+xRWyWzY+vyQMJzOknPkQKBVQS/ca8RR
	 MNTotjobiPD1m1KMmB16e5s/PmdK6yJPsmpGT/KFOiXSOpIW7O6+ziFEtdLqwnDszR
	 1UO8wlofosdDxmfbYzKy7hGh/b4AjLy5w2REX44lTuQtvFnqKn5Naj1LgaJAyv1kcx
	 D0zfWNEqvnt/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: light: as73211: Ensure buffer holes are zeroed
Date: Sun, 24 Aug 2025 09:26:44 -0400
Message-ID: <20250824132644.2870643-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082317-bogged-placate-a67b@gregkh>
References: <2025082317-bogged-placate-a67b@gregkh>
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
index 744432b87497..7706553affa9 100644
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


