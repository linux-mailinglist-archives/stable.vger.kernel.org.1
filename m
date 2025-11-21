Return-Path: <stable+bounces-195454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E8EC77313
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 04:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E279F4E6D35
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 03:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA042882D0;
	Fri, 21 Nov 2025 03:52:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E266F1A2630;
	Fri, 21 Nov 2025 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697153; cv=none; b=WoBbHNPq5PS5rdpyn7rNQu80XWLcuCbODQHat2lUkRNdaJorJdaswUHCJ9Cy4+gm4/L4xOlC5rnObO+puNeE8cEdmXwmbFgm3N9+QTIRjVTgiv/BoyCVUh0hSRmONj6JD/S6ua17gAft//RDavGQ6z5j+U8hTFqrvz46ttm+lz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697153; c=relaxed/simple;
	bh=M6Ctx6m102bBxdU8/i2dOzPqVv+ZyA9HUSq23fFJuik=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UQQpmaiEzM/OZ50RI1sOxA7pxkNAES9WxJhtTO7ZM8GAOC9riFt37vigLVtkGi8ZRuC4GDKxLDpKGmGfizmauX5kuPofZrBEtfG3pM8zdUS665ta/y8axQmdWJDEM6OvztsOQ4x37QD97zS4T6fzRrRAbrsQqCQrbY9TQQDLico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowACnONvD4R9pEEJ_AQ--.40522S2;
	Fri, 21 Nov 2025 11:51:37 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	florian.fainelli@broadcom.com,
	stephen@networkplumber.org,
	robh@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make24@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: dsa: Fix error handling in dsa_port_parse_of
Date: Fri, 21 Nov 2025 11:51:30 +0800
Message-Id: <20251121035130.16020-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowACnONvD4R9pEEJ_AQ--.40522S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy7uFWkAryrGr4UCrWDXFb_yoW8XFy3pa
	13Cay5KrWDG392kr4vvw18C3y2kw40k3ySk34xC34Sqrn3Jr15JrWj9F1Y9w15ArWxC348
	JFZFqF95CFWUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPj14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUnYFADUUU
	U
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

When of_find_net_device_by_node() successfully acquires a reference to
a network device but the subsequent call to dsa_port_parse_cpu()
fails, dsa_port_parse_of() returns without releasing the reference
count on the network device.

of_find_net_device_by_node() increments the reference count of the
returned structure, which should be balanced with a corresponding
put_device() when the reference is no longer needed.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: 6ca80638b90c ("net: dsa: Use conduit and user terms")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 net/dsa/dsa.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 5b01a0e43ebe..632e0d716d62 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1246,6 +1246,7 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
 	struct device_node *ethernet = of_parse_phandle(dn, "ethernet", 0);
 	const char *name = of_get_property(dn, "label", NULL);
 	bool link = of_property_read_bool(dn, "link");
+	int err;
 
 	dp->dn = dn;
 
@@ -1259,7 +1260,13 @@ static int dsa_port_parse_of(struct dsa_port *dp, struct device_node *dn)
 			return -EPROBE_DEFER;
 
 		user_protocol = of_get_property(dn, "dsa-tag-protocol", NULL);
-		return dsa_port_parse_cpu(dp, conduit, user_protocol);
+		err = dsa_port_parse_cpu(dp, conduit, user_protocol);
+		if (err) {
+			put_device(conduit);
+			return err;
+		}
+
+		return 0;
 	}
 
 	if (link)
-- 
2.17.1


