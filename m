Return-Path: <stable+bounces-62251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ADE93E796
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE601F20FEF
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4716484039;
	Sun, 28 Jul 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+6Tpcdy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419C823D1;
	Sun, 28 Jul 2024 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182760; cv=none; b=CHFK7U2126j3SAF2OUxbt2G9W6ADAh4NEqvBAPu5eAwktKGhMLMz+X9QddY3Fetqs3wHgFyAsneaa6FX1lI9auhXRnfv4sf44K8Qy0A1PRjyX7HXRzdpKsUj737pcEweJKtcesnwzIBaOTSeAFCPayCAtOlWN7a3r5oas6koGIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182760; c=relaxed/simple;
	bh=OGVgNZ2EQczDn0ER3TQ3ANEh6AQfLdzJIUHxh3+ZC1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXKhFqQXWcOQ9ulO7PNsonq5oEG+ZL033sPwJv+ZtyGvEPoBcuui4IZr958RpLT/TDUK3BuWDKZ+LKO38NvNh00Rh9nFhl3s1yytPvte2tIXs3JU8bvQtm8wZhourmBoFH0cd+9kICI2N2DB8iuhZ3ZT5Hz6GNo9KTGsSlKhMpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+6Tpcdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39309C116B1;
	Sun, 28 Jul 2024 16:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182759;
	bh=OGVgNZ2EQczDn0ER3TQ3ANEh6AQfLdzJIUHxh3+ZC1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+6TpcdyzdFMkoJYaRYHkiCTH3vbFaJRNDENgP+z6aliK+0NqqnQPwYumwreHm7Nz
	 1ogtfhH94WJ3gOZFjJdZQGeRicMNT4E0oxUk/P5oPmbabh6+ExKVst66vBV2yXHAT+
	 hMFMW9gDZ9GEeGHLnz5YMc68pHw08v+grXR6JQzW8urEuXuH3QLNLLtyq4UxbqMwW1
	 yXCfTx/8KdPHhsIw/8F/1lw+uCwU5AK9Gxo8OgCC8zRZiC+xJ34ekThiNGI21pRmB7
	 DjOoEnsjPVrmCYmlGtiaaI0Dix9eGBwXDhThQYXQvwt1BOk0zrNJ42XU0VTWY5GWtu
	 rVJb6fr1/NROQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jameson Thies <jthies@google.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	pmalani@chromium.org,
	lk@c--e.de,
	saranya.gopal@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 08/23] usb: typec: ucsi: Fix null pointer dereference in trace
Date: Sun, 28 Jul 2024 12:04:49 -0400
Message-ID: <20240728160538.2051879-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160538.2051879-1-sashal@kernel.org>
References: <20240728160538.2051879-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

[ Upstream commit 99516f76db48e1a9d54cdfed63c1babcee4e71a5 ]

ucsi_register_altmode checks IS_ERR for the alt pointer and treats
NULL as valid. When CONFIG_TYPEC_DP_ALTMODE is not enabled,
ucsi_register_displayport returns NULL which causes a NULL pointer
dereference in trace. Rather than return NULL, call
typec_port_register_altmode to register DisplayPort alternate mode
as a non-controllable mode when CONFIG_TYPEC_DP_ALTMODE is not enabled.

Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240510201244.2968152-2-jthies@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index c4d103db9d0f8..f66224a270bc6 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -496,7 +496,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return typec_port_register_altmode(con->port, desc);
 }
 
 static inline void
-- 
2.43.0


