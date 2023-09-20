Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E97A7EAE
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbjITMUP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjITMTl (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:19:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE8AAD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:19:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947B0C433C8;
        Wed, 20 Sep 2023 12:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212374;
        bh=uT6+ofBvE7Bpufbp6Jy3HAPdXBXrlhAb5jZGMswd6ZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjSgXaP/VpTfvI0yYr/tHVgz8LSXEqgP5GXOT4SiyaVXPGOBNzEMF9z7NbglDbACj
         cqgBeg5tAbaer5u/YJ1M6K/0u8IWqmQHfZ3bfwHXB4aTqaEoA2IkMijGmcCJkfqPgf
         kYrZMKyd03LxqGfTD1YfEmSCypWUyyj0dbSQzJmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, ruanjinjie <ruanjinjie@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 253/273] powerpc/pseries: fix possible memory leak in ibmebus_bus_init()
Date:   Wed, 20 Sep 2023 13:31:33 +0200
Message-ID: <20230920112854.106526457@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ruanjinjie <ruanjinjie@huawei.com>

[ Upstream commit afda85b963c12947e298ad85d757e333aa40fd74 ]

If device_register() returns error in ibmebus_bus_init(), name of kobject
which is allocated in dev_set_name() called in device_add() is leaked.

As comment of device_add() says, it should call put_device() to drop
the reference count that was set in device_initialize() when it fails,
so the name can be freed in kobject_cleanup().

Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20221110011929.3709774-1-ruanjinjie@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/pseries/ibmebus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index c7c1140c13b6c..3fce7508a4fc6 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -452,6 +452,7 @@ static int __init ibmebus_bus_init(void)
 	if (err) {
 		printk(KERN_WARNING "%s: device_register returned %i\n",
 		       __func__, err);
+		put_device(&ibmebus_bus_device);
 		bus_unregister(&ibmebus_bus_type);
 
 		return err;
-- 
2.40.1



