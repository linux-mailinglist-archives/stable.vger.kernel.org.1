Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD5735555
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjFSLDn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232614AbjFSLDG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:03:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8166D2967
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1609F60B94
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 11:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE95C433C0;
        Mon, 19 Jun 2023 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172532;
        bh=ZIVB6nrYbfrwdoSnTrcBETAlvock7OqJMnCKz5PmXVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=muhpXn6Uqo1HTZL4bzn4VP6CNX3OMmUrx9XZnHNR/l0IKCZEfLW5mSzptj7oXBgh8
         SdoJhsKjiRQ8GAUDzeUByvSjYxhmpkrsbERAMeSk0iLEJCe/5tuwOmUI4ZJkvfKgQG
         JS5Kr2cENOPVh7ofRe/NLcwkit4ZOxelLBz0ZHvs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gaosheng Cui <cuigaosheng1@huawei.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 102/107] net: Remove unused inline function dst_hold_and_use()
Date:   Mon, 19 Jun 2023 12:31:26 +0200
Message-ID: <20230619102146.193649529@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gaosheng Cui <cuigaosheng1@huawei.com>

commit 0b81882ddf8ac2743f657afb001beec7fc3929af upstream.

All uses of dst_hold_and_use() have
been removed since commit 1202cdd66531 ("Remove DECnet support
from kernel"), so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/dst.h |    6 ------
 1 file changed, 6 deletions(-)

--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -238,12 +238,6 @@ static inline void dst_use_noref(struct
 	}
 }
 
-static inline void dst_hold_and_use(struct dst_entry *dst, unsigned long time)
-{
-	dst_hold(dst);
-	dst_use_noref(dst, time);
-}
-
 static inline struct dst_entry *dst_clone(struct dst_entry *dst)
 {
 	if (dst)


