Return-Path: <stable+bounces-23942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5DA8691EF
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97E4293536
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B004145339;
	Tue, 27 Feb 2024 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BtWRlVJe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4884D13B79F;
	Tue, 27 Feb 2024 13:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040592; cv=none; b=CGOSkh024BQrpR6FZsE7EEy7Grg3YE/c/UhwUWssRkSz4Bnz/sDZHF9KZEaAvgUajDa2ya6GnLsn/Q8Pj1Rj66q9Ep9KvQVtfxwN6d/3pm5aCL5tRzyjVICx2Jf62ZYvjjAolHOFneO/fkr8k2AYCFXqRT8WmkE9pNvNr96enT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040592; c=relaxed/simple;
	bh=sx0QXexfYMUBpXyHLDC/zpN/cL5IRJk2FbiOaZqx1Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhD1+YjwTtXzJKIFmcV9+uQYrpjvCc1vzrMur3fCt9MU+emrTIbmy8tsd236lAOxFYUUfjvhvYKnxIY3B82I7jMcNdEu0SayIW2VASrx3SRSvTgRBQzgNzfoDYsK4PNyD1zFtzado1S1sVXZr8jLQfPK1tbfvBZv+WiOJGzuJ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BtWRlVJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA152C43394;
	Tue, 27 Feb 2024 13:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040592;
	bh=sx0QXexfYMUBpXyHLDC/zpN/cL5IRJk2FbiOaZqx1Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtWRlVJezR3ChSHZBBzUq5gMoOsBNo+SzvgrnAIKB+HcqzFPGPuNxnTqblP6ZmfGC
	 WQhSprWWH3h9IJBFc4AFavpwsuV8DfcZBUyKamjsR8b60c+KDSDQlntYzTmGppp/nW
	 ulPgHsmHvxe6PI+kCwdhbMfGIiQw4c75jl0ockB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 040/334] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
Date: Tue, 27 Feb 2024 14:18:18 +0100
Message-ID: <20240227131631.882763646@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit c92688cac239794e4a1d976afa5203a4d3a2ac0e ]

Continuous regulators can be configured to operate only in a certain
duty cycle range (for example from 0..91%). Add a check to error out if
the duty cycle translates to an unsupported (or out of range) voltage.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://msgid.link/r/20240113224628.377993-2-martin.blumenstingl@googlemail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/pwm-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 2aff6db748e2c..e33d10df7a763 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -158,6 +158,9 @@ static int pwm_regulator_get_voltage(struct regulator_dev *rdev)
 	pwm_get_state(drvdata->pwm, &pstate);
 
 	voltage = pwm_get_relative_duty_cycle(&pstate, duty_unit);
+	if (voltage < min(max_uV_duty, min_uV_duty) ||
+	    voltage > max(max_uV_duty, min_uV_duty))
+		return -ENOTRECOVERABLE;
 
 	/*
 	 * The dutycycle for min_uV might be greater than the one for max_uV.
-- 
2.43.0




