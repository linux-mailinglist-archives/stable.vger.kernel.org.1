Return-Path: <stable+bounces-201135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A43CC0BA9
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 04:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A1733025597
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 03:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC63D30F538;
	Tue, 16 Dec 2025 03:37:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7EE30DD12;
	Tue, 16 Dec 2025 03:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765856239; cv=none; b=lX+e/oobSPbaAdCb6MhXnCUvOnIQdNdZ/SJky4neZ3srylrTQY0Etx5StDYgpSXQCDKzb9K8amLnWohd0dWjYTX51yBgDDjILwZcCushmWZdMY2HJNqz+0ohUwVdneFgLdkXsyK7QVjg5w4LO6a8x/FGW4ytdFHpqhiEy09pcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765856239; c=relaxed/simple;
	bh=bAD7qxNiFLFdzt7WlIweVUEMW3vywq12f1bQwNdKBXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eO1RgKm8dyrtWYTjseiQX4QKHw+RakOr23A4MX7AkTHikgadDeGWn5Tj/xRdj8CTf5nX5om5ZX4RnK4wsojdzG2onXCfx/AMHFTBDG68eWKqJHl0RzFKh+x1bhKqlwr9NcmKfbIGW2DlgevEGVl+VpNiQqS98uumRMra7l8jZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowABX7A_Q00Bpk4rTAA--.50339S2;
	Tue, 16 Dec 2025 11:36:48 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: razor@blackwall.org,
	petrm@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] vxlan: fix dst ref count leak in the vxlan_xmit_one() error path
Date: Tue, 16 Dec 2025 03:36:47 +0000
Message-Id: <20251216033647.1792250-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX7A_Q00Bpk4rTAA--.50339S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWDGr47Xw1DZr1rur47CFg_yoW8XrWfpF
	4v9398ZFW3J3yqqw4xJw1rXFWrKay0k34Ikr1vka4Fqw13A34DGa4q9Fy29rs0qrWxury5
	Jr42gryrAF98ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUn9a9DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgSA2lArg2VKgAAsg

In the vxlan_xmit_one(), when the encap_bypass_if_local() returns an
error, the function jumps to out_unlock without releasing the dst
reference obtained from the udp_tunnel_dst_lookup(). This causes a
reference count leak in both IPv4 and IPv6 paths.

Fix by calling the dst_release() before goto out_unlock in both error
paths:
- For IPv4: release &rt->dst
- For IPv6: release ndst

Fixes: 56de859e9967 ("vxlan: lock RCU on TX path")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/vxlan/vxlan_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index dab864bc733c..41bbc92cc234 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2479,8 +2479,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET,
 						    dst_port, ifindex, vni,
 						    &rt->dst, rt->rt_flags);
-			if (err)
+			if (err) {
+				dst_release(&rt->dst);
 				goto out_unlock;
+			}
 
 			if (vxlan->cfg.df == VXLAN_DF_SET) {
 				df = htons(IP_DF);
@@ -2560,8 +2562,10 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
 						    dst_port, ifindex, vni,
 						    ndst, rt6i_flags);
-			if (err)
+			if (err) {
+				dst_release(ndst);
 				goto out_unlock;
+			}
 		}
 
 		err = skb_tunnel_check_pmtu(skb, ndst,
-- 
2.34.1


