Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3F6FAB54
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjEHLMD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjEHLMA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:12:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CA51E988
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:11:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E798C62B77
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9781C433D2;
        Mon,  8 May 2023 11:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544316;
        bh=EntWdMyeiyAyFnSO1MQ5T/oUIXHBTYpC4ZPrGX4U+jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjsHdY0V8kilVSwa1BrN2ig6XRZYCbrBSb0xu+FcrwlZwPCRphGkqzKKsZk4CbGik
         BaTHHUeNJwCFaA/eE4r040TkWPu8vx3QXxX3MQd5dP9u48HRy3iWZQx7/TjO2zkaLf
         Ze8fHLtHTT4jZ3Ld2Wk+cQWzTN2xcVVGulwE7MTU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 370/694] testing/vsock: add vsock_perf to gitignore
Date:   Mon,  8 May 2023 11:43:25 +0200
Message-Id: <20230508094444.802336088@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Bobby Eshleman <bobby.eshleman@bytedance.com>

[ Upstream commit 24265c2c91ad6aae9446e18472566cd83e92b602 ]

This adds the vsock_perf binary to the gitignore file.

Fixes: 8abbffd27ced ("test/vsock: vsock_perf utility")
Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Reviewed-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20230327-vsock-add-vsock-perf-to-ignore-v1-1-f28a84f3606b@bytedance.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/vsock/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/vsock/.gitignore b/tools/testing/vsock/.gitignore
index 87ca2731cff94..a8adcfdc292ba 100644
--- a/tools/testing/vsock/.gitignore
+++ b/tools/testing/vsock/.gitignore
@@ -2,3 +2,4 @@
 *.d
 vsock_test
 vsock_diag_test
+vsock_perf
-- 
2.39.2



