Return-Path: <stable+bounces-62288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC55D93E80A
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1481C21022
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52615623A;
	Sun, 28 Jul 2024 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMGtnFvB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6612155CB8;
	Sun, 28 Jul 2024 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722182905; cv=none; b=hrupxWQov8oa4CpssEWZrpd0Re2IascDTynZ0XJf+4j33Cfwd/0QXKuEWtggzofjoYuFAjy+4oiGNf1tr+uJX2WPSlmfVeGVXjwwAn6u6mSq3imd1ipKXNXSCP/KzqWplrT5zjiKzxc942K+Mzhppaf0BP15aGHUDiuaCHAAhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722182905; c=relaxed/simple;
	bh=3ar0RBFoFJRyCI7ocqq/nPuWy36KEnVdbIy5WsRKwMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1zIRRniNb4MYVDrJl1rHm45l5UJHRkHb1lsangBcHqRiq4JIapLtgoIrGlEBfCZLJi6r5HUcP2zNueeSAdxDh3tmQW5fz/Sg0+Z6AlPB+ceSSTIAwZJNnmLuIEcJKfrbaMcXHYnRxBL4fZD8lGGZn/OaWfTeV+pi39uSXBVvJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMGtnFvB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C608BC32782;
	Sun, 28 Jul 2024 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722182905;
	bh=3ar0RBFoFJRyCI7ocqq/nPuWy36KEnVdbIy5WsRKwMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMGtnFvBE78DvFrR9Z9XpZDDgey5wu1tsXeGOyEt4nYP392zCTpDdXmZ8YxsQ54Zb
	 dp+2lOPsV3+sQq5mZuCWsbCGLpGoj0o+BJlsq1LohEBgdXSoSO/T8ETxZYFSB2TEyA
	 IVi5AvKYHlQk9xayndiomq9UMJBKKQKFbj2VhczOiBSikk+jqUlbcEi6vp9qadPLFR
	 XYi8pDS2WkvLZGNtk/C8RwiGxI2knzudF/2XjiFSaZTjg9tSmFMR+GVzghzKPCeFtN
	 4dsWCHCeoYcxylmRpvoMIsoWj7AgY8iun150duhz0cti6eSg9vkhlGkk2ATwJdz0+K
	 uP4ccs4avfzJA==
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
Subject: [PATCH AUTOSEL 6.1 05/15] usb: typec: ucsi: Fix null pointer dereference in trace
Date: Sun, 28 Jul 2024 12:07:49 -0400
Message-ID: <20240728160813.2053107-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728160813.2053107-1-sashal@kernel.org>
References: <20240728160813.2053107-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
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
index dbb10cb310d4c..4a1a86e37fd52 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -373,7 +373,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return typec_port_register_altmode(con->port, desc);
 }
 
 static inline void
-- 
2.43.0


