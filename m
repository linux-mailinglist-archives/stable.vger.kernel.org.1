Return-Path: <stable+bounces-160131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE023AF8442
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 01:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430C5580ED8
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 23:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDCC253B7E;
	Thu,  3 Jul 2025 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gqmaSlT6"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F923BF8F;
	Thu,  3 Jul 2025 23:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751585453; cv=none; b=aPAdnY9O9+R9w3ENbG+xDHh2M9ulkzpmHLmdHaZqNlBMApnAE0PfLq3dg0VlhiTLHxwGvJG3KKms/ZAcBg2wGKQ3qK88RxNpeJ7BGTl6T1S7rMPsCV0Ttck6ew5f+e9thSqzCg/lEZt7G+KMS2X6jYXCE1nDfcRje1Mrxqyi8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751585453; c=relaxed/simple;
	bh=Fbr49hbBAxR3XMugzTtxxp6IAUj7O8sJIFIGqHQZ34c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tRtluBaPoQwMQgUnlB9utVeVx7ghN0oOp0MQS8R6pZc9KgPnXlcTHnYR7vTb8LQjrFbMTbZ2eOBStMzgotGXT4kT/6RDpnYoPxdrFYpW+gTga/0xHs1wsVA6/TeO5rD67JZb8YmOlucBbhffLreHheUQz3QnF5zRTVM3LTCDYLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gqmaSlT6; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC9A6433D1;
	Thu,  3 Jul 2025 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751585448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tt2N6G+At1qhUgwy4yABNWj0FBwZam0bZ476OEZxgn4=;
	b=gqmaSlT648m32aJZHmRZiIlMw17YRd/ab1WZiUkOlWM2Fbx141xgrPqrbKgfduLMuedSKt
	b6O7l01E6WInSldYVRA7qVhJUXUE4jkD3cXbVZMJIuKUTHbhENXnDDgxTzYAwS78O1aNdw
	ZBYAenhvsbB+moitvIH61X1s7C7N/NAevks6HDSLW+YPlJtsCNjp3xvXORxFplaOlE0U9X
	2L0OqVxQnrtzpUNZTzRTPsj6s0Czdxoyq+G24HnKd2r2ECNptwhVSD5YlGwjw+l8SiQ19z
	NVXa1tH04EWBexm9plh6g6kT1/yEdrVdLxmSlpRWbtbn9750RpqgTk8puisevg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 04 Jul 2025 01:30:18 +0200
Subject: [PATCH v2] drm/bridge: tc358767: fix uninitialized variable
 regression
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-drm-bridge-alloc-fix-tc358767-regression-v2-1-ec0e511bedd0@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAIkSZ2gC/52NTQqDMBCFryJZd0p+NEpXvUdxEZNRB9SUiUiLe
 PdGj9Dl997jfbtIyIRJPIpdMG6UKC4Z9K0QfnTLgEAhs9BSV7KWBgLP0DGF3Lhpih56+sDqTdX
 UtgbGgTGdJ1AZi043Vrneinz3ZszTS/VqM4+U1sjfy7ypM/1DsilQ0PRalz5Ia3z57GJcJ1ruP
 s6iPY7jB/R1LR7iAAAA
X-Change-ID: 20250703-drm-bridge-alloc-fix-tc358767-regression-536ea2861af6
To: "Colin King (gmail)" <colin.i.king@gmail.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvudeitdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkffvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdeuleetffeutdfhvedvjeffuddtteejtdfhffdvhedvleevteekjeejgfejgfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphephedurddujeelrddutdefrdehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeehuddrudejledruddtfedrheehpdhhvghloheplgduledvrdduieekrddurdduleeingdpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegumhhithhrhidrsggrrhihshhhkhhovhesohhsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnv
 ghlrdhorhhgpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthh
X-GND-Sasl: luca.ceresoli@bootlin.com

Commit a59a27176914 ("drm/bridge: tc358767: convert to
devm_drm_bridge_alloc() API") split tc_probe_bridge_endpoint() in two
functions, thus duplicating the loop over the endpoints in each of those
functions. However it missed duplicating the of_graph_parse_endpoint() call
which initializes the struct of_endpoint, resulting in an uninitialized
read.

Fixes: a59a27176914 ("drm/bridge: tc358767: convert to devm_drm_bridge_alloc() API")
Cc: stable@vger.kernel.org
Reported-by: Colin King (gmail) <colin.i.king@gmail.com>
Closes: https://lore.kernel.org/all/056b34c3-c1ea-4b8c-9672-c98903ffd012@gmail.com/
Reviewed-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
- Link to v1: https://lore.kernel.org/r/20250703-drm-bridge-alloc-fix-tc358767-regression-v1-1-8f224cd063c4@bootlin.com
---

Changes in v2:
- fix 'Closes:' tag URL
- add 'Cc: stable@vger.kernel.org'
---
 drivers/gpu/drm/bridge/tc358767.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 61559467e2d22b4b1b4223c97766ca3bf58908fd..562fea47b3ecf360e64a414e95ab5d645e610e9e 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2422,6 +2422,7 @@ static int tc_probe_bridge_endpoint(struct tc_data *tc, enum tc_mode mode)
 	struct device_node *node = NULL;
 
 	for_each_endpoint_of_node(dev->of_node, node) {
+		of_graph_parse_endpoint(node, &endpoint);
 		if (endpoint.port == 2) {
 			of_property_read_u8_array(node, "toshiba,pre-emphasis",
 						  tc->pre_emphasis,

---
base-commit: b4cd18f485687a2061ee7a0ce6833851fc4438da
change-id: 20250703-drm-bridge-alloc-fix-tc358767-regression-536ea2861af6

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


