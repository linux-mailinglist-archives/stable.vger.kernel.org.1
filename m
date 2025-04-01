Return-Path: <stable+bounces-127296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2154A7769B
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 10:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D15188A455
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C363E1EB1AC;
	Tue,  1 Apr 2025 08:39:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835261E47C9;
	Tue,  1 Apr 2025 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496797; cv=none; b=falYdLFL1lhLbc71g3ODPjPH4fclwPBpV9Jhojejq96nZIT+SL4hCIhmNolRBhO3X5LgRUduTnPlaa7qDn8XElljTMcxFrDODubcpkzHL0KGAejVu7UVrQ2T4oFaDc7Fn0Y5DDR16yZl1hW1hL7RZeiQmAaUdSKGdOAtaK+EuPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496797; c=relaxed/simple;
	bh=M+neyQM2i4qoH8h0avruc2kXdgJ2YHJWrKz+OdjGL7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3+6Kn0NLUOagBkQbwiV2BXycDzLOfdS3ZOL9OkR++oPSHRwZTWlV9hJwq4tsAfcA2/M4LV8xaIpwdAkoHCulPmHEJPCcx6WtSRslppVpBC7Fx2MDFGzqK2760ot9l3vi+4eTgYzEVOIARPGLCKzAzFqFq8ND6McQwd9P8MESQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-01 (Coremail) with SMTP id qwCowAA33f1AputnQ5eqBA--.451S2;
	Tue, 01 Apr 2025 16:39:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: mareklindner@neomailbox.ch,
	sw@simonwunderlich.de,
	a@unstable.cc,
	sven@narfation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: b.a.t.m.a.n@lists.open-mesh.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] batman-adv: batman-adv: handle tvlv unicast send errors
Date: Tue,  1 Apr 2025 16:39:00 +0800
Message-ID: <20250401083901.2261-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA33f1AputnQ5eqBA--.451S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1rGF1DCrW8XrWUuw13CFg_yoW8XF17pF
	Z5Gr15Gw1DJa1SqFyjq345Zr4Yyws7KrWj9FZ7A3W3ZFsxKrySgay8Z34jyF4rXay2ka1D
	Xr4qgF9xAa4DCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ8TA2frlbhKlQAAso

In batadv_tvlv_unicast_send(), the return value of
batadv_send_skb_to_orig() is ignored. This could silently
drop send failures, making it difficult to detect connectivity
issues.

Add error checking for batadv_send_skb_to_orig() and log failures
via batadv_dbg() to improve error visibility.

Fixes: 1ad5bcb2a032 ("batman-adv: Consume skb in batadv_send_skb_to_orig")
Cc: stable@vger.kernel.org # 4.10+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/batman-adv/tvlv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 2a583215d439..f081136cc5b7 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -625,6 +625,7 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, const u8 *src,
 	unsigned char *tvlv_buff;
 	unsigned int tvlv_len;
 	ssize_t hdr_len = sizeof(*unicast_tvlv_packet);
+	int r;
 
 	orig_node = batadv_orig_hash_find(bat_priv, dst);
 	if (!orig_node)
@@ -657,7 +658,10 @@ void batadv_tvlv_unicast_send(struct batadv_priv *bat_priv, const u8 *src,
 	tvlv_buff += sizeof(*tvlv_hdr);
 	memcpy(tvlv_buff, tvlv_value, tvlv_value_len);
 
-	batadv_send_skb_to_orig(skb, orig_node, NULL);
+	r = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	if (r != NET_XMIT_SUCCESS)
+		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
+			   "Fail to send the ack.");
 out:
 	batadv_orig_node_put(orig_node);
 }
-- 
2.42.0.windows.2


