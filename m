Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7568A761232
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbjGYK76 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbjGYK7m (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00930EB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:56:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23E8A6166E
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBD9C433C7;
        Tue, 25 Jul 2023 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282611;
        bh=GZA6wExYjc3AFatZg/N0vDbT6mOAnsOX0iPXu8574nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z4PKCyYnJap5Pv33nrgTaG05tIBBoFzWYYWovFcekAddA7DEtXS5L0DirPaVHBrEJ
         nMLaNGTiz9rnKkyIwTrmZVKYxKHPWdwGsatqGTF4kK+rxKaWIF6DIORgx7uZBMaPgg
         VsIYaf3UZ5u+dVw8NEOeM8Xzpfcu5UgnGr2pxmxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 162/227] regulator: da9063: fix null pointer deref with partial DT config
Date:   Tue, 25 Jul 2023 12:45:29 +0200
Message-ID: <20230725104521.634184325@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
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

From: Martin Fuzzey <martin.fuzzey@flowbird.group>

[ Upstream commit 98e2dd5f7a8be5cb2501a897e96910393a49f0ff ]

When some of the da9063 regulators do not have corresponding DT nodes
a null pointer dereference occurs on boot because such regulators have
no init_data causing the pointers calculated in
da9063_check_xvp_constraints() to be invalid.

Do not dereference them in this case.

Fixes: b8717a80e6ee ("regulator: da9063: implement setter for voltage monitoring")
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Link: https://lore.kernel.org/r/20230616143736.2946173-1-martin.fuzzey@flowbird.group
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/da9063-regulator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index c5dd77be558b6..dfd5ec9f75c90 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -778,6 +778,9 @@ static int da9063_check_xvp_constraints(struct regulator_config *config)
 	const struct notification_limit *uv_l = &constr->under_voltage_limits;
 	const struct notification_limit *ov_l = &constr->over_voltage_limits;
 
+	if (!config->init_data) /* No config in DT, pointers will be invalid */
+		return 0;
+
 	/* make sure that only one severity is used to clarify if unchanged, enabled or disabled */
 	if ((!!uv_l->prot + !!uv_l->err + !!uv_l->warn) > 1) {
 		dev_err(config->dev, "%s: at most one voltage monitoring severity allowed!\n",
-- 
2.39.2



