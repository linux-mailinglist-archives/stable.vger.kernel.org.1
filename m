Return-Path: <stable+bounces-78570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C990C98C48A
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCF5B229BF
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674221CCEF7;
	Tue,  1 Oct 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="VP5UEnGj"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982031CCEC3
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803935; cv=none; b=OBr+UlnAcfpP+07bHvY25G3ASauxQnitTHVIWgA41q4cwWxtzZKQsPqOcMXtiVd2WOzAz5JiaYzwkKmcdBvd4GJnl8wk3l9f8ZCR76CaIP3yLWz3eR+yIY4j+xPPVzQMPJzGbYdk+VsbT74ocOM70/zNQ87wF3DiEM1U2kwWT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803935; c=relaxed/simple;
	bh=sVXoRa3TsqDBKsgTaREp1zzsof1dAq+XUY/Prh3ZPu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfOukTyxLFs7mdniKPHH4s7t1YtNSMpAQ8sDiriUJcoQCIdfLu2hIb14ZlTlMA9lb9CfMlJeX+tILQ/5JssPCUxXnE/sn8cdY0L1aK2KCXMfXuBH4yRgyCKY0+QDZkBXbQTEEr++5mgBMEoHuLkAAl1nI/0i1UdvQVjuZbRz5VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=VP5UEnGj; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sVXoRa3TsqDBKsgTaREp1zzsof1dAq+XUY/Prh3ZPu4=;
	b=VP5UEnGj0QS+SARoDlUp4YPdPSbCzs9ZBezkM4oaru4qBWtSJzyEpjKIdjGbIIFfORyGrA
	XP2/g+o1bpdBiHD4l4L8GiWRFJarRLqw8lYUPK5TK/aZc3W4lGUEEiE4EH76V4mIqVg7By
	AW7u5FzXexXib7yIbcCSsPpPirlDpOE=
Received: from g8t13017g.inc.hp.com (g8t13017g.inc.hp.com [15.72.64.135]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-GrdOUHwCOLyxMv2YdaWF1Q-1; Tue,
 01 Oct 2024 13:32:11 -0400
X-MC-Unique: GrdOUHwCOLyxMv2YdaWF1Q-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g8t13017g.inc.hp.com (Postfix) with ESMTPS id BAAA160008BE;
	Tue,  1 Oct 2024 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 4CB5D18;
	Tue,  1 Oct 2024 17:32:09 +0000 (UTC)
From: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: qin.wan@hp.com,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	mika.westerberg@linux.intel.com,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Subject: [PATCH 6.6 06/14] thunderbolt: Use weight constants in tb_usb3_consumed_bandwidth()
Date: Tue,  1 Oct 2024 17:31:01 +0000
Message-Id: <20241001173109.1513-7-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001173109.1513-1-alexandru.gagniuc@hp.com>
References: <20241001173109.1513-1-alexandru.gagniuc@hp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit 4d24db0c801461adeefd7e0bdc98c79c60ccefb0 ]

Instead of magic numbers use the constants we introduced in the previous
commit to make the code more readable. No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tunnel.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 9947b9d0d51a..b81344c6c06a 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -1747,14 +1747,17 @@ static int tb_usb3_activate(struct tb_tunnel *tunne=
l, bool activate)
 static int tb_usb3_consumed_bandwidth(struct tb_tunnel *tunnel,
 =09=09int *consumed_up, int *consumed_down)
 {
-=09int pcie_enabled =3D tb_acpi_may_tunnel_pcie();
+=09int pcie_weight =3D tb_acpi_may_tunnel_pcie() ? TB_PCI_WEIGHT : 0;
=20
 =09/*
 =09 * PCIe tunneling, if enabled, affects the USB3 bandwidth so
 =09 * take that it into account here.
 =09 */
-=09*consumed_up =3D tunnel->allocated_up * (3 + pcie_enabled) / 3;
-=09*consumed_down =3D tunnel->allocated_down * (3 + pcie_enabled) / 3;
+=09*consumed_up =3D tunnel->allocated_up *
+=09=09(TB_USB3_WEIGHT + pcie_weight) / TB_USB3_WEIGHT;
+=09*consumed_down =3D tunnel->allocated_down *
+=09=09(TB_USB3_WEIGHT + pcie_weight) / TB_USB3_WEIGHT;
+
 =09return 0;
 }
=20
--=20
2.45.1


