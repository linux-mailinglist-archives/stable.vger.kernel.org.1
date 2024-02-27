Return-Path: <stable+bounces-24872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 952AE8696AC
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F901C238E8
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5097B1420DA;
	Tue, 27 Feb 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LoM66wNy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10116145B05;
	Tue, 27 Feb 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043227; cv=none; b=CrSUoVwmcqFBV2WSIagmP+gwxyNG4+F/Az7AKDaUWqVf7TvYBU4Z7i7gwFptD/+SNW/4uM5jAlWpPP7JpHuUyJUxknLOBCgbgdFWWIvyc0rvhuCOAkeXBd64f93YuN+aK4WtA3solPolSba5KvCAFYdaSXQk2Ql5wF9PxDEmhbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043227; c=relaxed/simple;
	bh=henCDuT3K5Z9imXUnBdD9Q+K9RCj7SIZM45ph8Uqpdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVAvd4YNV8C6Pc27I96v9QUrgoe5crwygATo2NzgOfAZIfnHoq++kjkiP2k0EiXHjc70I/O2rXdUDG0MNrpuf+wv7TD1Suu7vLni0eFzFf4zQhwOVNDg0suBGDD+PwvFBWv9jShT9nEKUwPSK4v8hpECSRsdc9YPYYmzYy48vXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LoM66wNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900DBC433C7;
	Tue, 27 Feb 2024 14:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709043226;
	bh=henCDuT3K5Z9imXUnBdD9Q+K9RCj7SIZM45ph8Uqpdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LoM66wNyabYxtl1iMk/nPO7fNVxvUB1+9I/xyEyN+nu0nAvkvKIYUJlqOLfxf/wFL
	 /ghBgVpI//JeSmJ88qDe2lbnp/X56Vy6PQtxKE9vy/kGgGeeD0FEShCHyij8NhmB0V
	 upBgGFmo8catjxIJXD+fxgYnRGKZAdj5W5h6JjaY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 031/195] regulator: pwm-regulator: Add validity checks in continuous .get_voltage
Date: Tue, 27 Feb 2024 14:24:52 +0100
Message-ID: <20240227131611.420901369@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131610.391465389@linuxfoundation.org>
References: <20240227131610.391465389@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index b9eeaff1c6615..925e486f73a6d 100644
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




