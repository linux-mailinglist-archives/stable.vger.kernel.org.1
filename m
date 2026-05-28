Return-Path: <stable+bounces-254713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6As0Bf3FF2oqQQgAu9opvQ
	(envelope-from <stable+bounces-254713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 06:35:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EAF5EC861
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 06:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 010B73042F12
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 04:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5BD2FFFA4;
	Thu, 28 May 2026 04:35:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A39248886;
	Thu, 28 May 2026 04:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779942905; cv=none; b=KFz5Y/BQ7W430CJShhBGiEfg7aAi/3p8i9CKjkNrKHXxT00M2obF1CDwOGoQ3jewM6f4T1PylIreY6QcHmoEll1Ik86M97v4tp8em7enFoQYW0CoHcNQnyl6FoWmXB3V5zd1PvK8gDXe7sh9faU5UBl45UawtrgyVXs8PJT01/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779942905; c=relaxed/simple;
	bh=2tOUi+/B16c4Tl7qst8vMP1e9dr6F0GzqQz6Zg/EavQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HhEpEcG7l6xEk68UkwdV3IpVWb92I5cv8oecOyR7IY1SWFRA4L26mea/4dyt0XlANGZ3euJ3E6WPkMm1J6z350b8oCnbI44f+cPyXtloWUHPMcXB/SWBy4+yJlk+jM1d3Iq5I4cO7WYT2aCQcNRwgJ+xi7pQK7lZgOEU7m3AYTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABXa9LmxRdqBZioEg--.74S2;
	Thu, 28 May 2026 12:34:46 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: James Chapman <jchapman@katalix.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] l2tp: fix tunnel refcount leak on register failure
Date: Thu, 28 May 2026 04:34:18 +0000
Message-Id: <20260528043418.1153320-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXa9LmxRdqBZioEg--.74S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww1rJrW5Zw43KFW8WryUWrg_yoW8JFy3pr
	15Cr4kJFyrtFn3Jw4UZa1kXa45GrZYvay5GFZ8Cw17ZwnxX3yfGay7WFWxWF1UGF4vyw1Y
	vryjgry8Z3WDJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUqeHgUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwoBA2oXgFzp7gAAsp
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254713-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 76EAF5EC861
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pppol2tp_tunnel_get() creates a new tunnel via l2tp_tunnel_create()
which initializes tunnel->ref_count to 1, then increments it to 2 via
refcount_inc(). If l2tp_tunnel_register() subsequently fails, the
error path calls kfree(tunnel) directly, bypassing the refcount
mechanism entirely. This leaves the tunnel's ref_count at 2 with no
way to properly release it through l2tp_tunnel_put().

Replace kfree(tunnel) with l2tp_tunnel_put(tunnel) to properly release
the reference through the standard refcount cleanup path, which will
call l2tp_tunnel_free() when the counter reaches zero.

Cc: stable@vger.kernel.org
Fixes: 6b9f34239b00 ("l2tp: fix races in tunnel creation")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/l2tp/l2tp_ppp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 99d6582f41de..16672e9df748 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -661,7 +661,7 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
 			refcount_inc(&tunnel->ref_count);
 			error = l2tp_tunnel_register(tunnel, net, &tcfg);
 			if (error < 0) {
-				kfree(tunnel);
+				l2tp_tunnel_put(tunnel);
 				return ERR_PTR(error);
 			}
 
-- 
2.34.1


