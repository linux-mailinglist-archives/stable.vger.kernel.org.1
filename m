Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0841A7B8A8B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244472AbjJDSgx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244480AbjJDSg2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:36:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A1A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:36:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39182C433C9;
        Wed,  4 Oct 2023 18:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444585;
        bh=+dU/iIz0gpBfsHAFUIqCx5Vj89RlPApdYpGgTT8OPjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoH276f6IdHXH1vtRKOHFCM7eJSM/60DDlNR4qxfS0iyNDvtqyFZDEResSJpzTWn8
         53vu64+o/pRsCYJyRttHFrMkuVRLcChVXMFkJEqLH5iQ8kFFgAfONAmkk+CJahCxVd
         V1nrhA13MqvYDH72GWvPAWOQnJAggOtvNf5h/ZwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Willy Tarreau <w@1wt.eu>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Quang Le <quanglex97@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 301/321] fs/smb/client: Reset password pointer to NULL
Date:   Wed,  4 Oct 2023 19:57:26 +0200
Message-ID: <20231004175243.240243395@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quang Le <quanglex97@gmail.com>

commit e6e43b8aa7cd3c3af686caf0c2e11819a886d705 upstream.

Forget to reset ctx->password to NULL will lead to bug like double free

Cc: stable@vger.kernel.org
Cc: Willy Tarreau <w@1wt.eu>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Quang Le <quanglex97@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/fs_context.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1532,6 +1532,7 @@ static int smb3_fs_context_parse_param(s
 
  cifs_parse_mount_err:
 	kfree_sensitive(ctx->password);
+	ctx->password = NULL;
 	return -EINVAL;
 }
 


