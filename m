Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E937B88FF
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjJDSVu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244199AbjJDSVj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:21:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29183A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:21:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714E7C433C8;
        Wed,  4 Oct 2023 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443695;
        bh=ktIEOo6OZYwdoTeK5dUEekSqkKJ9MI7nBVq3ruzJnPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tUF0WSdRZ3W7FM2kJiG2bZ3+GU+1ec9CswL6js5Cpc7nbWFzgG6d+BeprBY+kIKdv
         tWGokLvMkGmfV6c2q6S/+LgVCMKfBYI80x3tAq/RKI1l3zqJ7yyfyk/NtTADP+qjit
         FA1YZBFkZTPv7rhzR4IJLLgM24ggW+cCeuw9ksTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Willy Tarreau <w@1wt.eu>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Quang Le <quanglex97@gmail.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 246/259] fs/smb/client: Reset password pointer to NULL
Date:   Wed,  4 Oct 2023 19:56:59 +0200
Message-ID: <20231004175228.669209221@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1487,6 +1487,7 @@ static int smb3_fs_context_parse_param(s
 
  cifs_parse_mount_err:
 	kfree_sensitive(ctx->password);
+	ctx->password = NULL;
 	return -EINVAL;
 }
 


