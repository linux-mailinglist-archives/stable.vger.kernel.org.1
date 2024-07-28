Return-Path: <stable+bounces-62303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D393E836
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94834B2253E
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4818A187863;
	Sun, 28 Jul 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkGJuxiX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028401534EC;
	Sun, 28 Jul 2024 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182960; cv=none; b=AYhoUP9SpiT1Sm4wOFitJaDUskwIDQJAMRQYIy13x/pJYITQqzXjP6QBoYPdvjNPUuhJsoSJBR4mkVGQA+rWnwyKtjcIzJ5dtAK0iRppB7w+XybmbJ1fnftSbk2QXwsJ4P74laLqXO1bjf1wtwy21GbKv/KMGDLcGeoU6Mhhues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182960; c=relaxed/simple;
	bh=O1orXoIgbNcTl70cjmRw394bi1YKlzTuo40EbWq0OCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+VNNRoL16Vf4cEGQlunXvw+JjMfkrRbOlDlyTu53WR+fAXCzcSidbfUJS9d5AA2h7NZRc71ufiuXLPXzzHLAORZUugK0MP0ahGc6azH0i5ZjPoWm4vpHl6rA4Ku9C2/WSpvQ3/YINpk2AduVksJyiCg+M4APQnu08/xm3rV/c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkGJuxiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE21C32782;
	Sun, 28 Jul 2024 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182959;
	bh=O1orXoIgbNcTl70cjmRw394bi1YKlzTuo40EbWq0OCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lkGJuxiXiqHHc93QUNtfbajpgtJ1PC2YF0RGrZypz6tO8AbL8ja75acg1YVnpWAIW
	 WInEQMsAbrKe7Eh8tyre/7NQYoPtXHOT/cwqcAiwtteudV+5RfEx7cfVspw4pQWEg6
	 fyBuu2kF9S0rLTjvL1KNi35J0cLgdaGtm+20Y+Vgb0JwM1GpLAK0oI/+juoe44aacH
	 K5ej3/iHszEoEdTGU0fXYmKd5HtZinkJ28RvA+qCV+iOBb/1ois5E5RCwK4IgM2xzV
	 wTF4ER1fca/wxfy+hbOJv/T5GN8HlQClYPsq1J63vlZ7DTnm7xnNTbqfjt34uS5VTH
	 ZawRnukv5lr+g==
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
Subject: [PATCH AUTOSEL 5.15 05/13] usb: typec: ucsi: Fix null pointer dereference in trace
Date: Sun, 28 Jul 2024 12:08:47 -0400
Message-ID: <20240728160907.2053634-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160907.2053634-1-sashal@kernel.org>
References: <20240728160907.2053634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 3dc3da8dbbdf8..656a53ccd8917 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -368,7 +368,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return typec_port_register_altmode(con->port, desc);
 }
 
 static inline void
-- 
2.43.0


