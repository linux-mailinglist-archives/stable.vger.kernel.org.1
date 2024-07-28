Return-Path: <stable+bounces-62325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6E093E87B
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 18:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97296280CC3
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 16:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA30190462;
	Sun, 28 Jul 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPtSb45l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCEB7BB06;
	Sun, 28 Jul 2024 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722183041; cv=none; b=HUqOWjx4m1RjbuYDgwxjWUASGoQzHvmLjIPG6TUgDaXmR4dyis79no0ZtzcL2hartT6kmiqn+fYslNIPaLE9mxkbVXteK6ZC0gAjqAUiOWXh8M5UzZsq5Z6222IF16kkGhwmBGYoVfQsD8zlvt7tuDoDdfp2npiwqmRcZE5wdMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722183041; c=relaxed/simple;
	bh=QJUwzYTFiW6cz4rYyo9kCxvZCCEkQkq6QTwQznkF4F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ar47pnzuT/Lw66FEL7jFRgmwaPTSgmmFz9i96zsMEm0TGqodL/MWcqNKJURr8C+yKS6XKl02YZ/fh86nNlX/J6J2TI3pBc332DJwyw2Ss+U3FqMFdmTDxdhQKxGyDcMWs3o1/p7Rbjs/LYEpTS4TcQBOnkLPpqcfqCTIe9EzE2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPtSb45l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCBFC4AF0A;
	Sun, 28 Jul 2024 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722183041;
	bh=QJUwzYTFiW6cz4rYyo9kCxvZCCEkQkq6QTwQznkF4F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPtSb45l1HSVlGKlPEsXWdzXjyEaIbloOVeP9sy8oBdFa8RyobvRAsE8g5p0V//k4
	 ZQReXTJnJ4haRzfUQvB1byXq0Kb3Ru/C9VXOdgqReBtqdrRqNYq3nILlnyFSfEvpa7
	 aV0YJFMsdIrgwDX9N3jSaF3jPLqHTep4liPZeqm2V8XPxXBQrTJqb+eyXbadZ6tgAd
	 oba2ti4Q0d6crjX7TIYDRXtMtS+vjHzdfP6E0GG3WxF82VXR2x2Ryuf3I4CPcFenjJ
	 2Bcgj949lQ4kE7VB75jJZcTJ0WRx2IccrJd8h0w+xkELEbRDqifc6vX/d6xZ3odnN+
	 SttrTaKvA0eZQ==
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
Subject: [PATCH AUTOSEL 5.4 3/7] usb: typec: ucsi: Fix null pointer dereference in trace
Date: Sun, 28 Jul 2024 12:10:23 -0400
Message-ID: <20240728161033.2054341-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728161033.2054341-1-sashal@kernel.org>
References: <20240728161033.2054341-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.281
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
index de87d0b8319d0..179ad343f42f0 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -446,7 +446,7 @@ ucsi_register_displayport(struct ucsi_connector *con,
 			  bool override, int offset,
 			  struct typec_altmode_desc *desc)
 {
-	return NULL;
+	return typec_port_register_altmode(con->port, desc);
 }
 
 static inline void
-- 
2.43.0


