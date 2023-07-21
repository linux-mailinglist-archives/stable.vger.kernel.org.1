Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8402D75D19E
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGUSu5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 14:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjGUSu4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 14:50:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC8F30FD
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 11:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FC8961D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 18:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E4CC433CA;
        Fri, 21 Jul 2023 18:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689965454;
        bh=0pUfJIBp2hc9NQBmlBzlR7LOQhF7dGUU63YKR0g7/MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jIkovS5mVKlJeynV9uInFx6IV6sivYTvvBhApZ2wbndvFo2WMXUO0mRFMmK+VBSzZ
         alwypWuzITttY5ZVpd7MZ9MlpGGvAoqfXXE4vzPTyxxncR3q0jRtXAOIkbtkrTQrjq
         Lsy3bp9JAI1Ta/242SkUdpLk6MNH4rxlGch1GE+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.4 290/292] net: dsa: ocelot: unlock on error in vsc9959_qos_port_tas_set()
Date:   Fri, 21 Jul 2023 18:06:39 +0200
Message-ID: <20230721160541.416710183@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

commit cad7526f33ce1e7d387d1d0568a089e41deec5c2 upstream.

This error path needs call mutex_unlock(&ocelot->tas_lock) before
returning.

Fixes: 2d800bc500fb ("net/sched: taprio: replace tc_taprio_qopt_offload :: enable with a "cmd" enum")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1449,7 +1449,8 @@ static int vsc9959_qos_port_tas_set(stru
 		mutex_unlock(&ocelot->tas_lock);
 		return 0;
 	} else if (taprio->cmd != TAPRIO_CMD_REPLACE) {
-		return -EOPNOTSUPP;
+		ret = -EOPNOTSUPP;
+		goto err_unlock;
 	}
 
 	ret = ocelot_port_mqprio(ocelot, port, &taprio->mqprio);


