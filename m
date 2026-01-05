Return-Path: <stable+bounces-204590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4F6CF2807
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 09:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0B9B300A6D2
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 08:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2587131A551;
	Mon,  5 Jan 2026 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=arnaud.ferraris@collabora.com header.b="V8JkBV2F"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121A931327B;
	Mon,  5 Jan 2026 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767602680; cv=pass; b=BHf2tSI8fyVG9o6s4QqtT1EIoU5YEi3QcEZwh3HThLE3Thr1l18rH00iIJrhGAI8TKcmgKwtob7hTsgfs5QogwJ+60M+isGLSc5wU0qdsQHdQZNW17SenMI7Vxne4egU7gJOk/x2pEfNSjuoL4vBEIYe5bag8eGRPcqspVKaZHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767602680; c=relaxed/simple;
	bh=hwT/CLG4lyg1rnPS0bDBMJo3Ucwba/T665KGkUmSYw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rKjLyMMqtxXUu6bH5+b5h3qeU863eqh6s2W6i4VlD5mMGYKQYakrN3iQZT2TIrgbynJ0s3twbgBrkrUkJ8trsL0WCDtpwno6SRil6T+JYCI4woPJQa7dg2z7I7qwfCKH4xjNKAv7RV8vudxeNbwCzpNyvbdrHspDlecCAboMseI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=arnaud.ferraris@collabora.com header.b=V8JkBV2F; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1767602664; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bTnZvmT/7Y70TQ1Yb80dVrzduDWflF/nYUb9s3M28K/QD65FTjEWgcf3IEHTK/YQS0AImySRYQfvVs9P+eJ7oQMS+8stQLmtzfISsyL/imJ4c/fGsCpSIj+5QGyUwUphax+Tc/1+c2rkTSX8tPsXlkjexZKnwahiF+V/GekzwUg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767602664; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=bR8vnC+25hlvZCXz81UWFMEaAs3IoPXaBpMnjlIa7+s=; 
	b=AG8SM47ujnemUDqH0RKM04bfcRYuX8OMMlltkExDTg6Wf9YBI0k8f4kR/s2d15BUsBtPBXZkfQavoXbMvlUH+lYI2yCpnDkLUrDBLmTXXcTrJmvPgOHEA1oDbQBXzKKKnQQnJuN2ZBcWsHPfYRIXHcdZ2a2v6yXXMkL+zNjVAvA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=arnaud.ferraris@collabora.com;
	dmarc=pass header.from=<arnaud.ferraris@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767602664;
	s=zohomail; d=collabora.com; i=arnaud.ferraris@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=bR8vnC+25hlvZCXz81UWFMEaAs3IoPXaBpMnjlIa7+s=;
	b=V8JkBV2FrEvoS9ry8F49nCqFpGqZjEUPTrYdwrGAJ03lTi/O5r3nTcbrJYJHcYp6
	xvzG9i3Cjm6r0mUggDhXVcGbOP3gxlfs2lQJP25W1UsDpwYpk5dOjh3xjtKyoS9Y6ho
	2NUIJpglh/6JDuPQcosCQ2VL1v8vNDrws2O99jLQ=
Received: by mx.zohomail.com with SMTPS id 1767602660593833.5025653575118;
	Mon, 5 Jan 2026 00:44:20 -0800 (PST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Date: Mon, 05 Jan 2026 09:43:23 +0100
Subject: [PATCH v2] tcpm: allow looking for role_sw device in the main node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-fix-ppp-power-v2-1-6924f5a41224@collabora.com>
X-B4-Tracking: v=1; b=H4sIAKp5W2kC/3WMwQ7CIBAFf6XZs2sKUjCe+h+mB4TFktRCwKCm4
 d/F3j3Oy5vZIFPylOHSbZCo+OzD2oAfOjCzXu+E3jYG3vOBMa7Q+TfGGDGGFyWUVih30kpId4b
 mxETtsPeuU+PZ52dInz1f2G/9VyoMGQ7cWKuE6YnkaMKy6FtI+mjCA6Za6xcvEpAhrgAAAA==
X-Change-ID: 20251127-fix-ppp-power-6d47f3a746f8
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Dragan Simic <dsimic@manjaro.org>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1713;
 i=arnaud.ferraris@collabora.com; h=from:subject:message-id;
 bh=hwT/CLG4lyg1rnPS0bDBMJo3Ucwba/T665KGkUmSYw4=;
 b=owEBbQKS/ZANAwAIAdPrtZZruZGWAcsmYgBpW3niwdIpHgdTFBqpj2G09M0VQ94RNlgrLcYkY
 6KK0hPcofCJAjMEAAEIAB0WIQR5bbOT3D/0AiK26iLT67WWa7mRlgUCaVt54gAKCRDT67WWa7mR
 lnF2EACaIsp2ILS9bvK2ge+xGmNtn2CP2K7aindt0MYqFGFzseN16d5/wg3uGEEsNzpVshVgJ7j
 TlePbahfU0Cz1VBzlA4Xb8F406/2vlKEq7BN3SPyBxfpv9Mt3vmfEVynumtPP7E/SU1kzcWnWKZ
 5hLue6HpejO01Ry3OAc8VYB1K2KQXAJbxMhcSJdFX8F4Jfvsydgysy2J72LheOji0GrSrFcL/Hm
 Q28hZOHvm3as2DOBPxs0onpNrZFoyBXcyezjw1D5vT25i8TwtggZWFyjzv09sXCgGg6P23uNvBv
 +2Nm0cDUaRTY/2g9IMR+e/sD8OTNkrdF07pKAayB5GUrJJqkiUdIeQIQIsxyjZnH5Hia0MMBtPl
 BGU2wk2uU3f/oDmEoTOBO6MTq9Tkd2wJwys/LtgcOwker/At3BPrEuW/+hn/OIdn6PqzkvKjh9x
 M8RLeimxsdpz/3shGLZTTKSZIoHqF9lDI8441wcTUhnDAN1H0sgCclNndawvf4Cnvwke23PaAFZ
 +qPaPrIVqBL7ed/ZuANznA8u6oyp11Yo9MALKI03mHMrIx45l8yB4TM+MTt44Y0o5TqWqttXmZ9
 SKgsLWGw1/mnpDYH+jrWsFegZV9G/uq4jr5HY+ISP85GiKNSKTdpWVKa6H9KrQfecnAQER5HF4V
 Ba5s0Qkja3myb0A==
X-Developer-Key: i=arnaud.ferraris@collabora.com; a=openpgp;
 fpr=796DB393DC3FF40222B6EA22D3EBB5966BB99196
X-ZohoMailClient: External

If ports are defined in the tcpc main node, fwnode_usb_role_switch_get()
returns an error, meaning usb_role_switch_get() (which would succeed)
never gets a chance to run as port->role_sw isn't NULL, causing a
regression on devices where this is the case.

Fix this by turning the NULL check into IS_ERR_OR_NULL(), so
usb_role_switch_get() can actually run and the device get properly probed.

Fixes: 2d8713f807a4 ("tcpm: switch check for role_sw device with fw_node")
Cc: stable@vger.kernel.org
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
Changes in v2:
- Apply suggestions improving commit message
- Link to v1: https://lore.kernel.org/r/20251127-fix-ppp-power-v1-1-52cdd74c0ee6@collabora.com
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 4ca2746ce16bc..be49a976428fc 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7890,7 +7890,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->partner_desc.identity = &port->partner_ident;
 
 	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
-	if (!port->role_sw)
+	if (IS_ERR_OR_NULL(port->role_sw))
 		port->role_sw = usb_role_switch_get(port->dev);
 	if (IS_ERR(port->role_sw)) {
 		err = PTR_ERR(port->role_sw);

---
base-commit: 3609fa95fb0f2c1b099e69e56634edb8fc03f87c
change-id: 20251127-fix-ppp-power-6d47f3a746f8

Best regards,
-- 
Arnaud Ferraris <arnaud.ferraris@collabora.com>


