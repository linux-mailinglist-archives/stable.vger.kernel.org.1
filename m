Return-Path: <stable+bounces-92655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C69C55BC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DED3B33A5F
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E60218316;
	Tue, 12 Nov 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wN3jXjmL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28BB21830B;
	Tue, 12 Nov 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408154; cv=none; b=Ujo930g9/CZu0KVymu7fLjEpnzYX6EM8MdtBbrCevjmgkcXqV4o3lAIit53UC4Fr0jUGqGk9g6ZLdfgdNLOmW7WWEkOC3A63bsDCC7lK4pJk/Cd0np+WFGBv9ZrCvp0vPC0oYExeEkE8LCfJXc/0C9rBTFyTOzqQjXbvBi4l3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408154; c=relaxed/simple;
	bh=naXvWg0VtErlmY6LXrSFjJPSDSIJtibBEFlN76lDXhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ds1KUMfWN5BNcWo3sf0dfQiwDvj+wHSIILP4zQl7L5WefmDY3Hm2ZNfRJurtJ9VYPzrHvKqWTBP7GD0GmenRfWMlXeZZqgcRzQdHaGLT6MGBRS95LJ9L03zR4TihlZSU+PJqrnkqw9pSNkDDenwv8PEBQwd14cY9aB3intyp3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wN3jXjmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059FCC4AF0B;
	Tue, 12 Nov 2024 10:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408154;
	bh=naXvWg0VtErlmY6LXrSFjJPSDSIJtibBEFlN76lDXhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wN3jXjmLfLprmwT6tM9AO3lMfoBA9Mj1ER/M4OK67tBDfqwnhB1iizEBXSIlRGeyT
	 0Te+W+PyIT5XEZ42s4dkYChZdhZpVfZawREnN+K21prdCnkIH7Mavf9Cdc99wJWzEV
	 y0J3uAx2D+FclhO+9nCeE4HfVhUAn7iRLuV9die0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 6.11 077/184] media: ar0521: dont overflow when checking PLL values
Date: Tue, 12 Nov 2024 11:20:35 +0100
Message-ID: <20241112101903.816542399@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

commit 438d3085ba5b8b5bfa5290faa594e577f6ac9aa7 upstream.

The PLL checks are comparing 64 bit integers with 32 bit
ones, as reported by Coverity. Depending on the values of
the variables, this may underflow.

Fix it ensuring that both sides of the expression are u64.

Fixes: 852b50aeed15 ("media: On Semi AR0521 sensor driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ar0521.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/i2c/ar0521.c
+++ b/drivers/media/i2c/ar0521.c
@@ -255,10 +255,10 @@ static u32 calc_pll(struct ar0521_dev *s
 			continue; /* Minimum value */
 		if (new_mult > 254)
 			break; /* Maximum, larger pre won't work either */
-		if (sensor->extclk_freq * (u64)new_mult < AR0521_PLL_MIN *
+		if (sensor->extclk_freq * (u64)new_mult < (u64)AR0521_PLL_MIN *
 		    new_pre)
 			continue;
-		if (sensor->extclk_freq * (u64)new_mult > AR0521_PLL_MAX *
+		if (sensor->extclk_freq * (u64)new_mult > (u64)AR0521_PLL_MAX *
 		    new_pre)
 			break; /* Larger pre won't work either */
 		new_pll = div64_round_up(sensor->extclk_freq * (u64)new_mult,



