Return-Path: <stable+bounces-187991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0188BEFE7A
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 10:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA6E3E6647
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 08:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8E72EB862;
	Mon, 20 Oct 2025 08:24:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A96178372
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 08:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948654; cv=none; b=IKxuYLIQsYa4ICyOWLxG55VY/nZ7iXo2NIaTmR11Caw0Ck/dMBYsYRsN3Xrlu+OCxwrkuQf/xu3FVeMuXOCn2IJUkAZRvDHjCggyxJdhpQ4TSKdA4ZJ85XpjqD0U6ewyJrGYMNOHCmvH1gGqcWaWhSkROKeMSuGQB6XzXV5+l5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948654; c=relaxed/simple;
	bh=gKo0VtgLEkiYb2IxpSxPZ5r+SaVtq6PsGphBvXQ4M1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmQSVtbs9GALr56gk89TD/AEqYTePEu0rHgRQEwAu62U87Ow3tUkawKBTm21o5quVCP2o3JEWhNj9brhO2hp/B/CT7O5/IYoGDgqXlbcbFla99NwiYQqCXcPlMo8xei6tYLze9XGLU2wPptftzlAR+dD7b5qOoM7bxQuADSqMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9765EC113D0;
	Mon, 20 Oct 2025 08:24:13 +0000 (UTC)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: stable@vger.kernel.org
Cc: Jisheng Zhang <jszhang@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 5.10.y + 5.4.y] pwm: berlin: Fix wrong register in suspend/resume
Date: Mon, 20 Oct 2025 10:24:03 +0200
Message-ID: <20251020082402.2785693-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101613-nullify-embolism-0853@gregkh>
References: <2025101613-nullify-embolism-0853@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=jWANkc03qCwWczJ4OBcA41VlWWfB8Lz62Hb5GGvJ9Y8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBo9fGiegLu7YnSnH6YpG3l9c1YG0c1BrzXHPse7 QwsQZbzgOCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaPXxogAKCRCPgPtYfRL+ TlWxB/4iv2RBKJgZdvGWt7+J7l8n0ht54XynqnypFN0ivlcYy9lyU+atGE5mhr3u/KT/P7qthJN ZUTrVf3GNsIbkl1K2uWYoJe/ok7JTaH9ddXHcdBFVExDyp7rrAlVcQryO/KIcFOwWYl6gj1awdC xUmlNKBjbBO5cyAzUlFB5A3fjkW4lM34p6jbdJtoWlMLbKQNGigEJgcg8i2/EuZXxmM+IKYl26T Nd/VsRaR8nO7CD1oUH67TTDW/Kt8yntNzr9d1hknLJXvI+4s9VwpzA0sF+3DF+oYm3Bi8LkrPDw kljHDvQQhH8hQ8+myARGd7juTt2Oc/5iujWw1fn2Bn3tKTdQ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

From: Jisheng Zhang <jszhang@kernel.org>

[ Upstream commit 3a4b9d027e4061766f618292df91760ea64a1fcc ]

The 'enable' register should be BERLIN_PWM_EN rather than
BERLIN_PWM_ENABLE, otherwise, the driver accesses wrong address, there
will be cpu exception then kernel panic during suspend/resume.

Fixes: bbf0722c1c66 ("pwm: berlin: Add suspend/resume support")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Link: https://lore.kernel.org/r/20250819114224.31825-1-jszhang@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
[ukleinek: backport to 5.10]
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

this patch applies fine to both 5.4.y and 5.10.y. The 5.4 failure thread
is at
https://lore.kernel.org/stable/2025101613-candle-babble-137f@gregkh
.

Best regards
Uwe

 drivers/pwm/pwm-berlin.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index b91c477cc84b..c9d11486f2c1 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -249,7 +249,7 @@ static int berlin_pwm_suspend(struct device *dev)
 		if (!channel)
 			continue;
 
-		channel->enable = berlin_pwm_readl(pwm, i, BERLIN_PWM_ENABLE);
+		channel->enable = berlin_pwm_readl(pwm, i, BERLIN_PWM_EN);
 		channel->ctrl = berlin_pwm_readl(pwm, i, BERLIN_PWM_CONTROL);
 		channel->duty = berlin_pwm_readl(pwm, i, BERLIN_PWM_DUTY);
 		channel->tcnt = berlin_pwm_readl(pwm, i, BERLIN_PWM_TCNT);
@@ -280,7 +280,7 @@ static int berlin_pwm_resume(struct device *dev)
 		berlin_pwm_writel(pwm, i, channel->ctrl, BERLIN_PWM_CONTROL);
 		berlin_pwm_writel(pwm, i, channel->duty, BERLIN_PWM_DUTY);
 		berlin_pwm_writel(pwm, i, channel->tcnt, BERLIN_PWM_TCNT);
-		berlin_pwm_writel(pwm, i, channel->enable, BERLIN_PWM_ENABLE);
+		berlin_pwm_writel(pwm, i, channel->enable, BERLIN_PWM_EN);
 	}
 
 	return 0;

base-commit: d3d0b4e274d20103634bc7100cfb6d05ea3ec4d2
-- 
2.51.0


