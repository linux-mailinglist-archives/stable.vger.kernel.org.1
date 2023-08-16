Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3577E69F
	for <lists+stable@lfdr.de>; Wed, 16 Aug 2023 18:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjHPQkg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 16 Aug 2023 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344804AbjHPQk0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 Aug 2023 12:40:26 -0400
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346661BE6;
        Wed, 16 Aug 2023 09:40:25 -0700 (PDT)
Received: from kero.packetmixer.de (p200300FA272a67000Bb2D6DcAf57d46E.dip0.t-ipconnect.de [IPv6:2003:fa:272a:6700:bb2:d6dc:af57:d46e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.simonwunderlich.de (Postfix) with ESMTPSA id 10E88FB5BB;
        Wed, 16 Aug 2023 18:33:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
        s=09092022; t=1692203603; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWJjm22J4n2farjLKQ2JALJubJD+AmAphywPy0CjxeE=;
        b=sOIpOAt7xFjzl5mZKYlVPnsMdSoU2zGdai60iDENgeRQ4ofK2lu9nzrLRezA+t5XxfaAjU
        /OnrgBdY8K7BwNY8u1mZd65wgI5wom9KbFHICZ7K6ApW1ZzAfNLe4ssFtEwieBc7ih4rMo
        cGm7n02Q8g/NRWNkkSBdeJwZXiFgZtGEmrDagZevQ+BEVpS1MGr7h2+xxRdOX38CQODti+
        0X9z8sF9HNdn8XNLQClB8OFMGa6pa0vXTwiR7HdKuH941BwAnJ9IKcB4Mi1KDunDDAwf9x
        rjV57ALjTLx8+LU93ULAmczOi0xusmrYDiu/QLOmczN2gQQ2RjJZAqjgV1d0sQ==
From:   Simon Wunderlich <sw@simonwunderlich.de>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        Remi Pommarel <repk@triplefau.lt>, stable@vger.kernel.org,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5/5] batman-adv: Fix batadv_v_ogm_aggr_send memory leak
Date:   Wed, 16 Aug 2023 18:33:18 +0200
Message-Id: <20230816163318.189996-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816163318.189996-1-sw@simonwunderlich.de>
References: <20230816163318.189996-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simonwunderlich.de; s=09092022; t=1692203603;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tWJjm22J4n2farjLKQ2JALJubJD+AmAphywPy0CjxeE=;
        b=05gDzm+7Bk0y9EcIvLVx8SyVtVrunguWJXAotzRRhSiNBOnIFMkredSMRXEnD4g4IQYOHT
        jsPWkfxRgZGYaaGDvTTTkA32KdSW1/k+GzJEyJnxFbfC/stYXpT546j7dy2UVoKut3GU8J
        EgSKP1bTtJ6pg/+dkSKzr4idH9wKbN/ZL4zeHH1Z6ERcwJOicch0TS7ZwWfFse13M7PkfF
        xKlt9UjKGP5DASVXKlFMuOcP7qEsAbGXec4uIudax+9gYT8xkTzU13+QnaSXjSZzFDlZnr
        xjTBrjndlIO/kKJKoXnd0VMcPRaeoeGvG77+DNneuaxi2oTqGiZBufwFTA56pw==
ARC-Seal: i=1; s=09092022; d=simonwunderlich.de; t=1692203603; a=rsa-sha256;
        cv=none;
        b=Ux25l/wyk4uz0vjixhwRzPIVELEgQ4BEm36PxW+Sb+M7c7xv2dfilbKWSZF3lSQLCs/+I9cuAexF6pfknBHAis4Hpuei2+pxUHsMsYesV8IgHYcZjNKWUnhrS2gU5PCBUvd/O2NndMDy+Zxrb7n7fsvtheVwcGjaRrWkiYlt4ehCPz5FilySFobXyLvjpqXNsYFUXZ74fNJyPnJIiAqBhdSgHj9hxMWlAjuQEvrrfamX56q7vgjmEUCTFpzW5QuvxjKYcuIAAciTcSHs5hAbDpz4D0pbzSKLly4C0jcWA2WR03dUkMk93p9KhjmHrV/QWgzWlJFQmHRYIE3rNR0wbw==
ARC-Authentication-Results: i=1;
        mail.simonwunderlich.de;
        auth=pass smtp.auth=sw@simonwunderlich.de smtp.mailfrom=sw@simonwunderlich.de
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Remi Pommarel <repk@triplefau.lt>

When batadv_v_ogm_aggr_send is called for an inactive interface, the skb
is silently dropped by batadv_v_ogm_send_to_if() but never freed causing
the following memory leak:

  unreferenced object 0xffff00000c164800 (size 512):
    comm "kworker/u8:1", pid 2648, jiffies 4295122303 (age 97.656s)
    hex dump (first 32 bytes):
      00 80 af 09 00 00 ff ff e1 09 00 00 75 01 60 83  ............u.`.
      1f 00 00 00 b8 00 00 00 15 00 05 00 da e3 d3 64  ...............d
    backtrace:
      [<0000000007ad20f6>] __kmalloc_track_caller+0x1a8/0x310
      [<00000000d1029e55>] kmalloc_reserve.constprop.0+0x70/0x13c
      [<000000008b9d4183>] __alloc_skb+0xec/0x1fc
      [<00000000c7af5051>] __netdev_alloc_skb+0x48/0x23c
      [<00000000642ee5f5>] batadv_v_ogm_aggr_send+0x50/0x36c
      [<0000000088660bd7>] batadv_v_ogm_aggr_work+0x24/0x40
      [<0000000042fc2606>] process_one_work+0x3b0/0x610
      [<000000002f2a0b1c>] worker_thread+0xa0/0x690
      [<0000000059fae5d4>] kthread+0x1fc/0x210
      [<000000000c587d3a>] ret_from_fork+0x10/0x20

Free the skb in that case to fix this leak.

Cc: stable@vger.kernel.org
Fixes: 0da0035942d4 ("batman-adv: OGMv2 - add basic infrastructure")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_ogm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 84eac41d4658..e503ee0d896b 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -123,8 +123,10 @@ static void batadv_v_ogm_send_to_if(struct sk_buff *skb,
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->soft_iface);
 
-	if (hard_iface->if_status != BATADV_IF_ACTIVE)
+	if (hard_iface->if_status != BATADV_IF_ACTIVE) {
+		kfree_skb(skb);
 		return;
+	}
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_MGMT_TX);
 	batadv_add_counter(bat_priv, BATADV_CNT_MGMT_TX_BYTES,
-- 
2.39.2

