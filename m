Return-Path: <stable+bounces-62317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A9A93E862
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06AAD1C213EA
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD68A18F2C5;
	Sun, 28 Jul 2024 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3h3kgaR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7998C77F1B;
	Sun, 28 Jul 2024 16:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183011; cv=none; b=EYeV6zaD9O4Me3m4BiEVBxHyhP+m83yc6jvyWIpzfzD2ZsiPuJ52kWVsdfFDGxYcLYQZDd78F/2S1t2DQ/bj4qyLXDbNjqLIRXANYlsDpHsiO1F6JkCqIkqcE6RVmgFuJajfXQQo/T7tVZCopY6pUrWPuQRyS9XWaHnM6ETblho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183011; c=relaxed/simple;
	bh=NI/wuk2GObGxpebkzVtvqQ0eJI2ECKaCu0D1FjsKuHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyDGtm7h+MPmrxQz3+Ql8KdvSOzmody6F1T89dmT6YrYV1IzJT/oy9MfjsIsFLZwM9UFUCBmSePA3Brsv4ECdmzOxWSVBw/1i1gEKVVl6HhGd9HXiesiemS9y5l9Xow/swvTYpnu3AbtylmH9eXmkJ0X592uQkeUxtZ5n9ICpR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3h3kgaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33FFC32782;
	Sun, 28 Jul 2024 16:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183011;
	bh=NI/wuk2GObGxpebkzVtvqQ0eJI2ECKaCu0D1FjsKuHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3h3kgaRIZOFKO3xmLy9V5UmrixQv28uxrhWMCtMPUfd8y2u80UK+FNuIEa4jtFG2
	 puVSqf2nY7Zx7YLgXc5ohWOct6DtEgCYkIvNuSOC/LEaT7956jN1xDyHpdGBSM4DjI
	 O0DV6+S000I0eiJRjMpYCCmuDopqwZE8i0HC8nxbXdgowJbu1b/8yUxIptF0odnTyF
	 5KA+Eyvl2O1PsYMZqdG4GKWjvzZoRR+623rMB6NzyoeIcKdQVYCBY31VwZbLGDC/o+
	 k3ag/1fDVP0Ok5off+0vOf9oRDCZTkQUVKjjmZob4C9QweM2YygAif8NWqmOQ7gttF
	 oh1tOfigEP1Zw==
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
	lk@c--e.de,
	saranya.gopal@intel.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/11] usb: typec: ucsi: Fix null pointer dereference in trace
Date: Sun, 28 Jul 2024 12:09:39 -0400
Message-ID: <20240728160954.2054068-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160954.2054068-1-sashal@kernel.org>
References: <20240728160954.2054068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
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
index 41e1a64da82e8..f75b1e2c05fec 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -365,7 +365,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return typec_port_register_altmode(con->port, desc);
 }
 
 static inline void
-- 
2.43.0


