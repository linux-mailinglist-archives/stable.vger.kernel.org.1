Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1606FAD25
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbjEHLb7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbjEHLbi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:31:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18083ED90
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:30:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 882386305D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C31EC433EF;
        Mon,  8 May 2023 11:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545457;
        bh=QLhEU+bG9y1YJg/006OtBhIUpOz6md9Y2sUqxsGYKkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbL9UWY8bwhFpqR7g9yFF3GzdgXBbIsLywyXVcsL0Bf/B1WE4j+UntIQTCGh0NV6U
         OoyKNMcuiyCmAkEuUX304FcfDDR0P/ahZqNhyCa+Yydap5krwR2ml61Gv1Ie8pbndv
         nOOgnknh3jZxiquLhYJwZ4HBp6sdM5stqCkBNugY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 5.15 046/371] ksmbd: call rcu_barrier() in ksmbd_server_exit()
Date:   Mon,  8 May 2023 11:44:07 +0200
Message-Id: <20230508094813.880529105@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Namjae Jeon <linkinjeon@kernel.org>

commit eb307d09fe15844fdaebeb8cc8c9b9e925430aa5 upstream.

racy issue is triggered the bug by racing between closing a connection
and rmmod. In ksmbd, rcu_barrier() is not called at module unload time,
so nothing prevents ksmbd from getting unloaded while it still has RCU
callbacks pending. It leads to trigger unintended execution of kernel
code locally and use to defeat protections such as Kernel Lockdown

Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-20477
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ksmbd/server.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -611,6 +611,7 @@ err_unregister:
 static void __exit ksmbd_server_exit(void)
 {
 	ksmbd_server_shutdown();
+	rcu_barrier();
 	ksmbd_release_inode_hash();
 }
 


