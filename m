Return-Path: <stable+bounces-175593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E8B3685A
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190427B41E4
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C092AE7F;
	Tue, 26 Aug 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="khjJk/Bt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F68352FC4;
	Tue, 26 Aug 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217456; cv=none; b=n66BVFQHo1xM8c7nPf+OKO53x8us+ml8Ju+5znH8WqJMdjwPkPSYyPCAXbysNGIBitqBosiR5gpdwYTieBQ2LXOuhHRW2txI6BcDiatZZyN5iyfDhwfbYQnb3WEDQ7WMweto/ZRhJ8uSEk0Pb1U2m6OSWJTogF9nEBChYNYYWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217456; c=relaxed/simple;
	bh=iBJPYxh4OBViWXNm1+5pJytfJ3NE2AjMM337l0zovP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBxhY61JiL5RgniVFPvEtJ29HPvX4Cvri4roeG1vuYW/cE16pRdbukO0cn98Coi9wZUsPJhJO+C3yo+fe8wj6BgXbF6yKr1L8TqpR1GSRnD1gy6LQB5te9WPKx52L1oiFrN7TtiHhcUyjg4R+2kt52bOik/VJOsJPa1vNUqk98g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=khjJk/Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCFCC4CEF1;
	Tue, 26 Aug 2025 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756217455;
	bh=iBJPYxh4OBViWXNm1+5pJytfJ3NE2AjMM337l0zovP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=khjJk/BtJgLEsP3VRPz4cTet60xePiCbG/nAXJ2fRF16WhraL18Ch4onuOhD50lAF
	 ajJO3gJnNVvmGaVWe4Avpf8o+DL6FwRQtV1/DzBf3MATlrMVJL+XaMbuhxV1D4Vjfd
	 WiVt3XA4+1YNS6OzU6vFatJTlxVX5L1vNTGWx0L4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Masney <bmasney@redhat.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 150/523] rtc: ds1307: fix incorrect maximum clock rate handling
Date: Tue, 26 Aug 2025 13:06:00 +0200
Message-ID: <20250826110928.186179936@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110924.562212281@linuxfoundation.org>
References: <20250826110924.562212281@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brian Masney <bmasney@redhat.com>

[ Upstream commit cf6eb547a24af7ad7bbd2abe9c5327f956bbeae8 ]

When ds3231_clk_sqw_round_rate() is called with a requested rate higher
than the highest supported rate, it currently returns 0, which disables
the clock. According to the clk API, round_rate() should instead return
the highest supported rate. Update the function to return the maximum
supported rate in this case.

Fixes: 6c6ff145b3346 ("rtc: ds1307: add clock provider support for DS3231")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Link: https://lore.kernel.org/r/20250710-rtc-clk-round-rate-v1-1-33140bb2278e@redhat.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 3a2401ce2ec9..ba420201505c 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1518,7 +1518,7 @@ static long ds3231_clk_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
 			return ds3231_clk_sqw_rates[i];
 	}
 
-	return 0;
+	return ds3231_clk_sqw_rates[ARRAY_SIZE(ds3231_clk_sqw_rates) - 1];
 }
 
 static int ds3231_clk_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.39.5




