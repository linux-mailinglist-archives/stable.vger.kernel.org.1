Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296CC73524F
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjFSKd1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjFSKd0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:33:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E273CB3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F30A60B67
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90895C433C8;
        Mon, 19 Jun 2023 10:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170804;
        bh=6gpORcAxPIswk5rt3904T6pVzx2l7Ca1K3vmcaIsjyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDGOAco1u0Ph+PE79CalVeGvfl2OQFoxisbP6gxJS5pLomqVBOb/8xV4hNiWlGNlb
         ihHzgLcrQsQstFuzFr6y1hn/Nrhrhbkyh2rnqtr03UbSXqNiTMh9yBfdMO8PW8N/6C
         HsdZumCx041JMH4lRQk0pB3gjawTOeiEKnY+htj0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 016/187] power: supply: Ratelimit no data debug output
Date:   Mon, 19 Jun 2023 12:27:14 +0200
Message-ID: <20230619102158.391455354@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit 155c45a25679f571c2ae57d10db843a9dfc63430 ]

Reduce the amount of output this dev_dbg() statement emits into logs,
otherwise if system software polls the sysfs entry for data and keeps
getting -ENODATA, it could end up filling the logs up.

This does in fact make systemd journald choke, since during boot the
sysfs power supply entries are polled and if journald starts at the
same time, the journal is just being repeatedly filled up, and the
system stops on trying to start journald without booting any further.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index c228205e09538..4bbb3053eef44 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -285,7 +285,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 
 		if (ret < 0) {
 			if (ret == -ENODATA)
-				dev_dbg(dev, "driver has no data for `%s' property\n",
+				dev_dbg_ratelimited(dev,
+					"driver has no data for `%s' property\n",
 					attr->attr.name);
 			else if (ret != -ENODEV && ret != -EAGAIN)
 				dev_err_ratelimited(dev,
-- 
2.39.2



