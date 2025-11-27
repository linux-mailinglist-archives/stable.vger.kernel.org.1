Return-Path: <stable+bounces-197112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 538DBC8EAEE
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C73EC3467E2
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E7A32D421;
	Thu, 27 Nov 2025 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=arnaud.ferraris@collabora.com header.b="J8LfKDgZ"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27985224AF1;
	Thu, 27 Nov 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252272; cv=pass; b=KePZ/Gh72QZ3wjPEIg5hCzluHG44HZKMZPj/nd9+vkl95xOQwwQKC4kXasKA7cWMAvgNs3ffmjYZjJm9TgLb83S8lk0CFga5aIoV671T8dn+7la3g+k1T5u83xd64/ZX8at9SG5xro5yDZX5X49Cps5SSb2Cj4su3MTCxwd+2e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252272; c=relaxed/simple;
	bh=zSH9oYef+yo+lf15k0K+KNeqYYA7jcGkJPUcbBp5nvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bYDsQq9im2TVXRIY3f9eeSZOGOM0TM/hiKi0K8sDfgpWVuKFXaDj/oq0sqChhQlGDQOMFQQ0MgsJXNX36S0pxQtWETBNdkYN0QkiKzARuY7r9jotiLKSDokB+k9UWDleUdaIfZYfX4kX1glo+VOt7RrqZIAB2LZqzB8fxv0cZiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=arnaud.ferraris@collabora.com header.b=J8LfKDgZ; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764252261; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TQJA+he2nNYBSO5IW7DGoXLAdqeBVCaxkWNzNEQvYv+NHBT0yZGKTCjmSu6xZodNaZ5tOQFGvs+yJu6D90URdzM+1yOfwKDLAu4YZiuKgS/DC6EC0k0m4XpYjtGIvWY4A/k4/xXWbffmT6I69NLYmUbYZXuOIVkHCUphjf6YarM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764252261; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=zLAB4qPTd/MGlS5LCGhyc0whZPwR34rFPGRvnGXtvxI=; 
	b=Z27bAG2AxlgGYh55woY7KZKHWpe4tf681HlSn07rw6gpGETcbGizgmbgjWen/geOZ2Q7BYyiI1pGkV58Q7YBctTTFb1woKK+DFgYnY5HGMYFd23SKW5DV/awo0J5X2/2moPLnPg5Q+BhjLrznNKSlRgdvZjFJ2tV5KuUFOSuePs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=arnaud.ferraris@collabora.com;
	dmarc=pass header.from=<arnaud.ferraris@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764252261;
	s=zohomail; d=collabora.com; i=arnaud.ferraris@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=zLAB4qPTd/MGlS5LCGhyc0whZPwR34rFPGRvnGXtvxI=;
	b=J8LfKDgZnZwt40r/YbvS5OPoGzk9L8jlLjlZanZc7HoZ3FCikoMw5ebOUgz5wDeG
	+jYdCyd2FXeIqN1ZnKoDLe/xB2TpAsy1aq+r+iz078ariX2tZjrR+bl4Y9vVWXRxbXt
	RvXBGrFLArCR6utox4Hk7qi7sYZxrqGGLBUCUdec=
Received: by mx.zohomail.com with SMTPS id 1764252259899675.1368336078687;
	Thu, 27 Nov 2025 06:04:19 -0800 (PST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Date: Thu, 27 Nov 2025 15:04:15 +0100
Subject: [PATCH] tcpm: allow looking for role_sw device in the main node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-fix-ppp-power-v1-1-52cdd74c0ee6@collabora.com>
X-B4-Tracking: v=1; b=H4sIAF5aKGkC/x2MQQqAIBAAvxJ7biHNNPpKdIhcay+1KFQg/j3pO
 DAzGRJFpgRTkyHSzYmvs4JqG9iO9dwJ2VcG3elBKe0w8IsignI9FNF640K/OmPDCLWRSFX4f/N
 SygdVsxHZXwAAAA==
X-Change-ID: 20251127-fix-ppp-power-6d47f3a746f8
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1432;
 i=arnaud.ferraris@collabora.com; h=from:subject:message-id;
 bh=zSH9oYef+yo+lf15k0K+KNeqYYA7jcGkJPUcbBp5nvs=;
 b=owEBbQKS/ZANAwAIAdPrtZZruZGWAcsmYgBpKFphF4elyYbX9GsUcxjKkxK/0hi9VTFuYNIWS
 yyGWpz/Eb+JAjMEAAEIAB0WIQR5bbOT3D/0AiK26iLT67WWa7mRlgUCaShaYQAKCRDT67WWa7mR
 lpSCEACgc9UbLPpUsOpvEmiFZzQ/WQ20nV9XAMN4FnOgBL1C2pGzVC+GTXE0mfRM9NjyVlcAsGs
 w24xH6C0tzBnf8GQHET9HfzBLw6kf2AkYOXUUxCVM4LKka59Ry5vMmS2HvFI4n4zHK7vdWP9gPT
 iFh0eICbV4P31wGHUBObdsD6PNxvBEfe/shK++3cDcbfT7pXgTjiDcsAdOliqnnFjQV58GvIds8
 13RGEwSz9iKgXseIBE4JSq5VcsJUH/X209rkLZ3A8qXlJNPErukN68lWDaj8l2PKLe7yIAhqw/F
 Tna7jGqkPT9gbYfKLHmzlFM3xaFHfiEY5vGaIaUMvjOC1nqsdcOpCki0oVUyErpo8ZRvHf0NXz9
 bOIS5BLxEY31Wj3STaVyHvYECs0yvW9U78uK6o9YoFRv/z7aKTHNFZCXGFlImaGPb6QANPfLnxp
 j95JoyuSZRGVutKXuA+0+mnAgxjKFvGi5TEf8b60HOaZe2Yvcqt6LNUYiGJX2KtzwiGQPIDVQCk
 mEGBma2hEZiZEuyDcl1/wTzG7iZcasxz3wPZVlc+pkpV/V5qUmKiM7NgDSjEzdtaYsBYQKhJfrk
 oFzGiIdFvXZ87YaXgxNBjl1n9CCpjBIwaHMLw/0Cklyb53cISSC0McugrvXMZ+PlvQJDkMTh9Bg
 qadkY4cRf8eGFTA==
X-Developer-Key: i=arnaud.ferraris@collabora.com; a=openpgp;
 fpr=796DB393DC3FF40222B6EA22D3EBB5966BB99196
X-ZohoMailClient: External

When ports are defined in the tcpc main node, fwnode_usb_role_switch_get
returns an error, meaning usb_role_switch_get (which would succeed)
never gets a chance to run as port->role_sw isn't NULL, causing a
regression on devices where this is the case.

Fix this by turning the NULL check into IS_ERR_OR_NULL, so
usb_role_switch_get can actually run and the device get properly probed.

Fixes: 2d8713f807a4 ("tcpm: switch check for role_sw device with fw_node")
Cc: stable@vger.kernel.org
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index cc78770509dbc..37698204d48d2 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7877,7 +7877,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->partner_desc.identity = &port->partner_ident;
 
 	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
-	if (!port->role_sw)
+	if (IS_ERR_OR_NULL(port->role_sw))
 		port->role_sw = usb_role_switch_get(port->dev);
 	if (IS_ERR(port->role_sw)) {
 		err = PTR_ERR(port->role_sw);

---
base-commit: 765e56e41a5af2d456ddda6cbd617b9d3295ab4e
change-id: 20251127-fix-ppp-power-6d47f3a746f8

Best regards,
-- 
Arnaud Ferraris <arnaud.ferraris@collabora.com>


