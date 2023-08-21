Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6464278317D
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjHUTtK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjHUTtJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:49:09 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDD0E8;
        Mon, 21 Aug 2023 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1692647340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DsJB+7sFuuWOoDx7Fh2DdE7VFZsdKo18N46Pkibr1aQ=;
        b=nszFs4BzGq34b6Yjsot5JzSkTw1ejeU0MABi473U4BX8XaObmjL2bYZ9RvI0BNNTHZqR0i
        46lG7TuOYW6qhyOOSZ82AWu8fYZhQaizM7QROtE9SDodbG5DulVyUKWe4nAeyZlwSAgRA6
        NPbl7cLXvbVGEtmwb3+uuJ6/cg+tIhw=
From:   Sven Eckelmann <sven@narfation.org>
Date:   Mon, 21 Aug 2023 21:48:48 +0200
Subject: [PATCH net] batman-adv: Hold rtnl lock during MTU update via
 netlink
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230821-batadv-missing-mtu-rtnl-lock-v1-1-1c5a7bfe861e@narfation.org>
X-B4-Tracking: v=1; b=H4sIAJ+/42QC/x3MwQqDMAwA0F+RnBewVVT8FdmhttGFaZSmykD89
 xWP7/IuUIpMCn1xQaSTlTfJMK8C/MfJTMghG2xpq7KzBkeXXDhxZVWWGdd0YEyy4LL5L46+9kR
 N21YmQC72SBP/nn4AoQTv+/4D4KcifHMAAAA=
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com,
        Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=sven@narfation.org;
 h=from:subject:message-id; bh=nowgqTBeuSUsF0MkPq8VVljqJ1v/j0h46T2v8/GwWCY=;
 b=owEBbQKS/ZANAwAKAV2HCgfBJntGAcsmYgBk47+pbaqBTAlTRuPwSw65wtkGsj6wTPGtx4Qrm
 YflxfdZDAKJAjMEAAEKAB0WIQQXXSuHYSVz3OMy4AJdhwoHwSZ7RgUCZOO/qQAKCRBdhwoHwSZ7
 RmEWEADJTs2FMiNg3J2roovo8WjYYATlIbupo+AwWF7L+jRF2SlAj46b3UJFnM2+wriGdw+5s+U
 4cLKgsaBfHrDOCOvWWs+pjaREH2RVTxQQ+c43GCqHifiPwiSCwKy9IRt/bnIh+LwyJJ47pEwFD3
 0FXyw04gGO8ylJhMA9zcL498GQp3mns94L/OkrgYbW6nuzTYPw2xa1tdDQz3OpczcQjd4v11ix1
 PecLmX1yHd61NTfcT3wOSnENaQPeaMHAcFBzC45zAnkssAeBBPF2uwSj7aYo5VUNfTm3R8ETTg/
 dV6gjStVy2Wcs7sDwTOBo1UZOcTb5rx32AeygcYvEeMtmJ13qD0gl+RAYRBMzKy2Q62fAPt/Dw3
 VFhSVc1RIZuDOCJ9OBTVU6wocm4NjmQr8aApOlHsxhS657PgpfEF2s9DYk8oGwFErJRiYhs1Bsz
 ywOmkziRRKSHX4PdPNAFoNu3q54TbCltb382+78fS3Zi4I4Mv9/0Dqf5pjoMKk/A4lYesqbsyY+
 L7pKXpDCz0EhkgEExy7JkONEgzsIpBy2y1PL6Xhy0bLnDPyCUo2XE6saGHTfqVUXWfOYjxHdYS8
 P+9cC2umm9hEoUgbkOkJ8uXE6krACR6/NuKoUeYHBdZ5H5ebEMNjpTzyw8Z+jxUn2Xig170NwjR
 uvZBu5MnbSu0G9w==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The automatic recalculation of the maximum allowed MTU is usually triggered
by code sections which are already rtnl lock protected by callers outside
of batman-adv. But when the fragmentation setting is changed via
batman-adv's own batadv genl family, then the rtnl lock is not yet taken.

But dev_set_mtu requires that the caller holds the rtnl lock because it
uses netdevice notifiers. And this code will then fail the check for this
lock:

  RTNL: assertion failed at net/core/dev.c (1953)

Cc: stable@vger.kernel.org
Reported-by: syzbot+f8812454d9b3ac00d282@syzkaller.appspotmail.com
Fixes: c6a953cce8d0 ("batman-adv: Trigger events for auto adjusted MTU")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
This problem was just identified by syzbot [1]. I hope it is ok to directly
send this patch to netdev instead of creating a single-patch PR from
the batadv/net branch. If you still prefer a PR then we can also prepare
it.

[1] https://lore.kernel.org/r/0000000000009bbb4b0603717cde@google.com
---
 net/batman-adv/netlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index ad5714f737be..6efbc9275aec 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -495,7 +495,10 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 		attr = info->attrs[BATADV_ATTR_FRAGMENTATION_ENABLED];
 
 		atomic_set(&bat_priv->fragmentation, !!nla_get_u8(attr));
+
+		rtnl_lock();
 		batadv_update_min_mtu(bat_priv->soft_iface);
+		rtnl_unlock();
 	}
 
 	if (info->attrs[BATADV_ATTR_GW_BANDWIDTH_DOWN]) {

---
base-commit: 421d467dc2d483175bad4fb76a31b9e5a3d744cf
change-id: 20230821-batadv-missing-mtu-rtnl-lock-bc4cee67731d

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

