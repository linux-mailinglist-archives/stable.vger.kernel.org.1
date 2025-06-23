Return-Path: <stable+bounces-155572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC95FAE42B6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD1C189A574
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A722B25178C;
	Mon, 23 Jun 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2YJ7JFZl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB824678E;
	Mon, 23 Jun 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750684774; cv=none; b=WU70MJ19/Cl3Z80u0wabQWQsLWQsFiOFfCfdFIPiXdUIL0Go/n6szUPyjhf8bQ5nG2w9vqFycgB/SIm3tmbAZjnxx/Q0mrTOfZ6MWel9d7u/eAmsLHHXfFje+G1uGmzNAyPqKUNiVXgNnmGgS9IipJHVH99DoGPsfeUYiUBvlh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750684774; c=relaxed/simple;
	bh=EUHH09yp5loIY3I7Kq7kkLz51QglqwkZA9G4zHUO8Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRbePxlZQPpsXc13wSzcYtQbrDfc+66AFSGwS6jrXv1IMQJjjURpuAxam8Oms+rvgI3ZAQafyW3ZdfD4U8prmBXzbOscm0zN4JzbyvPXIyZ0+9i7uvrPik1rtaJ9OKPFTqfHsx72p+nfdju/x/qs9GNdvcz1fTqcXAtLVjfqGCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2YJ7JFZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DB0C4CEEA;
	Mon, 23 Jun 2025 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750684774;
	bh=EUHH09yp5loIY3I7Kq7kkLz51QglqwkZA9G4zHUO8Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2YJ7JFZl3VlbobREdCqzhQ96d7Mq+e8UHpwSsClpiF8fb18KVuL6hXjxhICzIRSrI
	 0K1iAXPeyFbqbP3lllaGn9D/Rm3Rh8lIwkAybIhXBg3uB3txEdbWh5obPB4M1OKrts
	 Ki+1NbC6FLUtvFGIfpoA0OFtv/3lnAYZSROuLZXo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.15 169/592] regulator: max14577: Add error check for max14577_read_reg()
Date: Mon, 23 Jun 2025 15:02:07 +0200
Message-ID: <20250623130704.298929090@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit 65271f868cb1dca709ff69e45939bbef8d6d0b70 upstream.

The function max14577_reg_get_current_limit() calls the function
max14577_read_reg(), but does not check its return value. A proper
implementation can be found in max14577_get_online().

Add a error check for the max14577_read_reg() and return error code
if the function fails.

Fixes: b0902bbeb768 ("regulator: max14577: Add regulator driver for Maxim 14577")
Cc: stable@vger.kernel.org # v3.14
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20250526025627.407-1-vulab@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/max14577-regulator.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -40,11 +40,14 @@ static int max14577_reg_get_current_limi
 	struct max14577 *max14577 = rdev_get_drvdata(rdev);
 	const struct maxim_charger_current *limits =
 		&maxim_charger_currents[max14577->dev_type];
+	int ret;
 
 	if (rdev_get_id(rdev) != MAX14577_CHARGER)
 		return -EINVAL;
 
-	max14577_read_reg(rmap, MAX14577_CHG_REG_CHG_CTRL4, &reg_data);
+	ret = max14577_read_reg(rmap, MAX14577_CHG_REG_CHG_CTRL4, &reg_data);
+	if (ret < 0)
+		return ret;
 
 	if ((reg_data & CHGCTRL4_MBCICHWRCL_MASK) == 0)
 		return limits->min;



