Return-Path: <stable+bounces-62272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C993E7DB
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2F41B22599
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A26145A16;
	Sun, 28 Jul 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHJqRC3A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94CE145A03;
	Sun, 28 Jul 2024 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182843; cv=none; b=UoZ5shcL2AV8JwAHCkOYHZUv7Nkza7p2zueOoo17zX2zqdydapOcNiBUzj47qBD+a+Ouk8qw1dEhICdattc2rblDkTyOjo9RrCI+wwy9HTl1XWO7pou+wjdoZBuReRC5+zyXfqmJ6vcypenczaj6fvdsLd0seeuSkw9AVZ4tLyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182843; c=relaxed/simple;
	bh=G2lXc2chaRICMov1MuhBIDqpUBLOW+cnpt0Gia39VHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZjbev1NvJiezLglhwUjR8geaDHEvzyBR3hDfqzUloZcchYFwUatM3diZZjnXh4YKPL4vwbfeoy/392X5NrkVvr+ZM4270z8QfyEPGLJT4tHljBI+aXN5mMGSEGYGnsEAV/NPVmorG7szI/JJYarck8lZM0siaTZ5uTJS2q1ekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHJqRC3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B4AC116B1;
	Sun, 28 Jul 2024 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182843;
	bh=G2lXc2chaRICMov1MuhBIDqpUBLOW+cnpt0Gia39VHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHJqRC3AJBWcI3IT3VPX1MAPfti04kP17ehEux+qQuKfzFH9DxA3cAAxh7On21rB+
	 Dyy+0aC5tmjVwhEMlhiAoT0yrSSBTc+gKCMd3SIuRzja8PK0lRPycUMCRMusgVdCGH
	 82zIpVB3t1JoVD1WbMljWPlPU/ta8LFJnGslvmnFkJfLgs2fm14p4qDTMozfY6qCyV
	 9lj5fVRNTA6SaBsOo7/+dkqQ2MKBr0KusCOBeoaCXkFZkV16dgtY3/cP8Bn2x4g3i/
	 aXq2H5cULMBU5T57pPbti0Pvn//lSkBidFZuIfr4yef7JV+IDVU6+zY62bc9BNnMNl
	 96V108tarTf9A==
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
	saranya.gopal@intel.com,
	lk@c--e.de,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/17] usb: typec: ucsi: Fix null pointer dereference in trace
Date: Sun, 28 Jul 2024 12:06:42 -0400
Message-ID: <20240728160709.2052627-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160709.2052627-1-sashal@kernel.org>
References: <20240728160709.2052627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
index 2a886e58cd632..42c60eba5fb6e 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -404,7 +404,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return typec_port_register_altmode(con->port, desc);
 }
 
 static inline void
-- 
2.43.0


