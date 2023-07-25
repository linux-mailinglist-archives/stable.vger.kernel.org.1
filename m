Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9257614E2
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjGYLXl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbjGYLXi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:23:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C117F1BD3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49BD96169A
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57426C433C8;
        Tue, 25 Jul 2023 11:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284210;
        bh=J19Qaday07Uv44WYgE9dAlg5dZV0n7ZkTIbcQ0Wbe34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lT2hIRekWRfTK9B50mbha1Tg+gGdW5Hj/M3WJZUy8atBOGm+IZvQW61Xc8KaIPBeX
         CkX8F96tt5rCw7XC1X1XKJ9sJrNPbW/fE+2oE7438xXz8YX/6Xqsw703y2RhS77kF2
         Fn+Mpy4wIwq5xB7e+9f5Q5bzWejGmm7u7JKBF5YM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 274/509] s390/qeth: Fix vipa deletion
Date:   Tue, 25 Jul 2023 12:43:33 +0200
Message-ID: <20230725104606.294431311@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thorsten Winkler <twinkler@linux.ibm.com>

[ Upstream commit 80de809bd35e2a8999edf9f5aaa2d8de18921f11 ]

Change boolean parameter of function "qeth_l3_vipa_store" inside the
"qeth_l3_dev_vipa_del4_store" function from "true" to "false" because
"true" is used for adding a virtual ip address and "false" for deleting.

Fixes: 2390166a6b45 ("s390/qeth: clean up L3 sysfs code")

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: Thorsten Winkler <twinkler@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_l3_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 997fbb7006a7c..316f8622f3ccb 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -652,7 +652,7 @@ static QETH_DEVICE_ATTR(vipa_add4, add4, 0644,
 static ssize_t qeth_l3_dev_vipa_del4_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
-	return qeth_l3_vipa_store(dev, buf, true, count, QETH_PROT_IPV4);
+	return qeth_l3_vipa_store(dev, buf, false, count, QETH_PROT_IPV4);
 }
 
 static QETH_DEVICE_ATTR(vipa_del4, del4, 0200, NULL,
-- 
2.39.2



