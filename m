Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE486FA9FA
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbjEHK5g (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjEHK5G (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:57:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F8B30AFB
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3327B629B2
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:56:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234FCC433EF;
        Mon,  8 May 2023 10:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543367;
        bh=wLtQqlvpw56+8x2JhP757xkkBKJEtgWxzFXJVVzaEIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZdLNJObfVR4BVWM/Vf6CY3+V6KP6u/1zcwxRzvLqWz+m1gHxGJbyPBejYxi/K9xWE
         j/+e7LH3/GHE783JdIwO8+aRLWoaLfN0rF7ZKw8658n0DfPxPqLBoEk0W5Xubsd/Z1
         wkbq9sCZAB4Ysj+g/cYwDHHhWrFh07EaInm6wHjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        zdi-disclosures@trendmicro.com
Subject: [PATCH 6.3 067/694] ksmbd: call rcu_barrier() in ksmbd_server_exit()
Date:   Mon,  8 May 2023 11:38:22 +0200
Message-Id: <20230508094434.729473698@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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
@@ -606,6 +606,7 @@ err_unregister:
 static void __exit ksmbd_server_exit(void)
 {
 	ksmbd_server_shutdown();
+	rcu_barrier();
 	ksmbd_release_inode_hash();
 }
 


