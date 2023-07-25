Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF337611C6
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjGYK4H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjGYKzi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B7026A8
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10D0A615FE
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242D2C433C8;
        Tue, 25 Jul 2023 10:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282407;
        bh=tPlnrUOB44ixW+YBquQhtPmxhbOHRKsLyCXO3Ctx5n8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUAh2P+qJXxmbrqhF+JUUlggLtRm2q8QcArFRUxZIyK2qToLVjjVcJK9LYWMl6xu/
         FlT2b909R6ecALphPzBCl18IvKjkGfQty38m+ueZGA+Mn+VL9iU+nSqMKCZZQ7GtSR
         ysVrn3MfaYsULhtTL+JlcCiatK2CWoOL22KVQMFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Pirko <jiri@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 118/227] devlink: make health report on unregistered instance warn just once
Date:   Tue, 25 Jul 2023 12:44:45 +0200
Message-ID: <20230725104519.689852286@linuxfoundation.org>
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

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 6f4b98147b8dfcabacb19b5c6abd087af66d0049 ]

Devlink health is involved in error recovery. Machines in bad
state tend to be fairly unreliable, and occasionally get stuck
in error loops. Even with a reasonable grace period devlink health
may get a thousand reports in an hour.

In case of reporting on an unregistered devlink instance
the subsequent reports don't add much value. Switch to
WARN_ON_ONCE() to avoid flooding dmesg and fleet monitoring
dashboards.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Link: https://lore.kernel.org/r/20230531015523.48961-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/devlink/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 0839706d5741a..194340a8bb863 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -480,7 +480,7 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 	int err;
 
 	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
-	WARN_ON(!xa_get_mark(&devlinks, devlink->index, DEVLINK_REGISTERED));
+	ASSERT_DEVLINK_REGISTERED(devlink);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg)
-- 
2.39.2



