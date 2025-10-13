Return-Path: <stable+bounces-184204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA93DBD25A0
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 11:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 97884349C09
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E962FF149;
	Mon, 13 Oct 2025 09:43:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD452FF143
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348630; cv=none; b=KtpjdFpgcbS2TCe/LGpW3AXIQGiFUhaPkbrw+MX+2Hx2M/qbAMTL9EH2oCrL3SjvmpeZtvS++b9Iz4LIUTCLymFADSlXN4rcOhfLko1VDxGUAK2DwIGbO/XUhAkpKqV+ik3EJc2L2Xi4yWqZ7Aayy6yuI6INyV6EMmpAm6K7NAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348630; c=relaxed/simple;
	bh=6I3vbFqrC8hpi6PcBC7EqlmHPrHJF/Who5etpts5xAo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sWeg3EnySfww66Bw7rt0aiKBNdkYgP0pKQJkLVoZxgKGC2iPCuSch8QsfR7S1OJ/pQ4Hk4rL1hxM7I6zazbAbm3p9lBeT9KcoQzMXpnhgUpTuyCgxR/u09J0qyeTa+15T5gJjDwqcH3eSwYbV7tScr2ytoTcjxVHje8+e3keTq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1v8F5i-0004bA-3c; Mon, 13 Oct 2025 11:43:42 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1v8F5h-003MXH-14;
	Mon, 13 Oct 2025 11:43:41 +0200
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1v8F5h-00000005PWJ-148F;
	Mon, 13 Oct 2025 11:43:41 +0200
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Mon, 13 Oct 2025 11:43:40 +0200
Subject: [PATCH v2] tcpm: switch check for role_sw device with fw_node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-b4-ml-topic-tcpm-v2-1-63c9b2ab8a0b@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAMvJ7GgC/32NSw6DIBRFt2LeuK8B/GA66j4aBwpUX1KBACU2x
 r2XuoAOz0nuuTtEE8hEuFU7BJMpkrMFxKUCtYx2Nki6MAgmWs5YjVOD6wuT86QwKb+ikLzppJB
 adiOUmQ/mSduZfAyFF4rJhc/5kPnP/olljhxrpTVr274f1XT3xs7vFJyl7aoNDMdxfAGm8Bitt
 QAAAA==
X-Change-ID: 20251003-b4-ml-topic-tcpm-27146727d76a
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@pengutronix.de, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=6I3vbFqrC8hpi6PcBC7EqlmHPrHJF/Who5etpts5xAo=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBo7MnMdESNHo1oHL+TIzCTJWUxgtXZSxdrszpPq
 C9+FgsLmk6JAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCaOzJzAAKCRC/aVhE+XH0
 qyLdEAC0HfkrZDmd4Ins3Cm3NudISCVaNHEVcNOVnUuUwOLNExKAxfMuptvlQodUkmI8WohV4qX
 mGybcGXt8uBYdfVQEg2RcJi+aEW5fCfQNvxI7zFGko8Itw3AWVXUD574Ay8bs2g8BWl+k9ygux6
 SetYhpdSqhLAJM8lzpkyl7yEmIFpjIAGg4Kkw+UhPFI25JciWG8tcOOiM886JbDAtmBZUZkUKaT
 8qRY3dgsFYEMhkYrWYf+4upACzhMW+1ctgGVon0g3doM7Ofz49WCmxu8Ve9c8pBj2Ehb4PBnbux
 NBG+cgCSiS2qcawhWFO/FagkrmgFW3jFf25ZCG5zxadyc0cAFH6Jaudnxv1TZucvd//Q2TN3SZe
 Up7ni4Bz0U6u9jc91M5sObSG5q8pIa1z4/uq+i8Q/Etu5EWY4hLlLR68hkAyVRUyW0ql04wy1M7
 Qud1GY4zM11+X76YtYGJlqfDZzRbCDwWUoc+ZIrwbYE24vk/+oFgA8cHF5PKWm5fYOaFAsZlfga
 VBWTv3MbUjRgT5iFhbCi4BVtmjpWQPrQM357+cNR4J9pWwe4+GPAaRMkaun5pkfn5KGheVH0rQA
 KZ/3BQBObm+vTpu2snSXmWKkb/JhL+8jcLZ3lYUy1STHgcuwKfiXpoCqDHlAASCrngZ3k0kEDum
 b42WoCvjGL+mHcg==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

When there is no port entry in the tcpci entry itself, the driver will
trigger an error message "OF: graph: no port node found in /...../typec" .

It is documented that the dts node should contain an connector entry
with ports and several port pointing to devices with usb-role-switch
property set. Only when those connector entry is missing, it should
check for port entries in the main node.

We switch the search order for looking after ports, which will avoid the
failure message while there are explicit connector entries.

Fixes: d56de8c9a17d ("usb: typec: tcpm: try to get role switch from tcpc fwnode")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
Changes in v2:
- fixed typos in the description
- added fixes tag
- added Cc: stable@vger.kernel.org
- Link to v1: https://lore.kernel.org/r/20251003-b4-ml-topic-tcpm-v1-1-3cdd05588acb@pengutronix.de
---
 drivers/usb/typec/tcpm/tcpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index b2a568a5bc9b0ba5c50b7031d8e21ee09cefa349..cc78770509dbc6460d75816f544173d6ab4ef873 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7876,9 +7876,9 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 	port->partner_desc.identity = &port->partner_ident;
 
-	port->role_sw = usb_role_switch_get(port->dev);
+	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
 	if (!port->role_sw)
-		port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
+		port->role_sw = usb_role_switch_get(port->dev);
 	if (IS_ERR(port->role_sw)) {
 		err = PTR_ERR(port->role_sw);
 		goto out_destroy_wq;

---
base-commit: e406d57be7bd2a4e73ea512c1ae36a40a44e499e
change-id: 20251003-b4-ml-topic-tcpm-27146727d76a

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


