Return-Path: <stable+bounces-2935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1A77FC46F
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 20:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBB9282D29
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 19:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2E73D0CE;
	Tue, 28 Nov 2023 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C1510F0;
	Tue, 28 Nov 2023 11:49:45 -0800 (PST)
Received: from francesco-nb.toradex.int (31-10-194-107.static.upc.ch [31.10.194.107])
	by mail11.truemail.it (Postfix) with ESMTPA id 47FC0206FC;
	Tue, 28 Nov 2023 20:49:42 +0100 (CET)
From: Francesco Dolcini <francesco@dolcini.it>
To: Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Gross <markgross@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] platform/surface: aggregator: fix recv_buf() return value
Date: Tue, 28 Nov 2023 20:49:35 +0100
Message-Id: <20231128194935.11350-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Serdev recv_buf() callback is supposed to return the amount of bytes
consumed, therefore an int in between 0 and count.

Do not return negative number in case of issue, when
ssam_controller_receive_buf() returns ESHUTDOWN just returns 0, e.g. no
bytes consumed, this keep the exact same behavior as it was before.

This fixes a potential WARN in serdev-ttyport.c:ttyport_receive_buf().

Cc: <stable@vger.kernel.org>
Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/platform/surface/aggregator/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index 1a6373dea109..6152be38398c 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -231,9 +231,12 @@ static int ssam_receive_buf(struct serdev_device *dev, const unsigned char *buf,
 			    size_t n)
 {
 	struct ssam_controller *ctrl;
+	int ret;
 
 	ctrl = serdev_device_get_drvdata(dev);
-	return ssam_controller_receive_buf(ctrl, buf, n);
+	ret = ssam_controller_receive_buf(ctrl, buf, n);
+
+	return ret < 0 ? 0 : ret;
 }
 
 static void ssam_write_wakeup(struct serdev_device *dev)
-- 
2.25.1


