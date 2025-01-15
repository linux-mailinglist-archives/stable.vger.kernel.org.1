Return-Path: <stable+bounces-109083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A264A121BD
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE4E7A1548
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EED61E7C02;
	Wed, 15 Jan 2025 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZJfABJJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFDE248BB0;
	Wed, 15 Jan 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938792; cv=none; b=OzUm+9b5zC4XHOKDBAYR/17q0onQ0b+gkgsgSucX4zP9/eNcaXu7P/IzDxRf0wL93DkqTlcO2i59VdTbF0snPd/Mly4plzN9rKg0KGLevWu6+McfQI+9a2JTtEG+2NzLgxpzyxXHMevIbtdt4sO06UmSGL9nOSj7ULPM83I6AUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938792; c=relaxed/simple;
	bh=ah+zMvKMjd8upROTCtkHdQaFfBCraTQkYsTrhBSTp4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyV3FP8ivN0EWjE4xi3w3Clz32TTO3IX2sG6oeDBGEFb3zOc0PfbxREAEQhh+H9MQZC5M0obrJHwr81ONQmFPxyaKzJ4aXZbQXwOeRRO7KBDAxB9jAUcdJXiQnqeC7VGjEUrviRUXIjbEe4gR4CrS6rBeiMjWm6uHLsVrvpDabU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZJfABJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD834C4CEDF;
	Wed, 15 Jan 2025 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736938792;
	bh=ah+zMvKMjd8upROTCtkHdQaFfBCraTQkYsTrhBSTp4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZJfABJJR11J6KoJWqsuQA7Skp09ixysWgJwrh49AOL+pFAp7k4SNZkSRPOXgZTLN
	 tecBHI3qFZIzSRweHy2B7f1NP25Zb6kWEMDjTgqlIJVMZY6UFk27Xu84yxp7bWXqhV
	 QeVMh12nS1MKphMHkoqh1OJl+mMrS6WDJINdYF4Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.6 099/129] usb: typec: tcpm/tcpci_maxim: fix error code in max_contaminant_read_resistance_kohm()
Date: Wed, 15 Jan 2025 11:37:54 +0100
Message-ID: <20250115103558.309588394@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103554.357917208@linuxfoundation.org>
References: <20250115103554.357917208@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

commit b9711ff7cde0cfbcdd44cb1fac55b6eec496e690 upstream.

If max_contaminant_read_adc_mv() fails, then return the error code.  Don't
return zero.

Fixes: 02b332a06397 ("usb: typec: maxim_contaminant: Implement check_contaminant callback")
Cc: stable <stable@kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: André Draszik <andre.draszik@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/f1bf3768-419e-40dd-989c-f7f455d6c824@stanley.mountain
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/maxim_contaminant.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -137,7 +137,7 @@ static int max_contaminant_read_resistan
 
 		mv = max_contaminant_read_adc_mv(chip, channel, sleep_msec, raw, true);
 		if (mv < 0)
-			return ret;
+			return mv;
 
 		/* OVP enable */
 		ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCOVPDIS, 0);
@@ -159,7 +159,7 @@ static int max_contaminant_read_resistan
 
 	mv = max_contaminant_read_adc_mv(chip, channel, sleep_msec, raw, true);
 	if (mv < 0)
-		return ret;
+		return mv;
 	/* Disable current source */
 	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, SBURPCTRL, 0);
 	if (ret < 0)



