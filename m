Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FD275CDB5
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjGUQOA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGUQNj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:13:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8284236
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:13:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8EB061D39
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053AEC433C7;
        Fri, 21 Jul 2023 16:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955990;
        bh=al6Z9zKAGSMmO2QzMvNUanx1U9z8Ulvjl+63X0v5Yg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFkhnTnkTQcwnYgUTA3xJjDKUD2j1UY8bPQjfdBCge1kciR45riZq/e9lpbwrPyPo
         wq++WyJk3jmnFoWqsxa5GYJItbXtBTIRcUKV35Hccl52sbgU9Q4JZhk5ZyGyePihzE
         wqx3T1IfTj7MkJrvyAHz6IkO1gLHvVqZ1d6hLzU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ankit Kumar <ankit.kumar@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 078/292] nvme: fix the NVME_ID_NS_NVM_STS_MASK definition
Date:   Fri, 21 Jul 2023 18:03:07 +0200
Message-ID: <20230721160532.161431805@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ankit Kumar <ankit.kumar@samsung.com>

[ Upstream commit b938e6603660652dc3db66d3c915fbfed3bce21d ]

As per NVMe command set specification 1.0c Storage tag size is 7 bits.

Fixes: 4020aad85c67 ("nvme: add support for enhanced metadata")
Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 779507ac750b8..2819d6c3a6b5d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -473,7 +473,7 @@ struct nvme_id_ns_nvm {
 };
 
 enum {
-	NVME_ID_NS_NVM_STS_MASK		= 0x3f,
+	NVME_ID_NS_NVM_STS_MASK		= 0x7f,
 	NVME_ID_NS_NVM_GUARD_SHIFT	= 7,
 	NVME_ID_NS_NVM_GUARD_MASK	= 0x3,
 };
-- 
2.39.2



