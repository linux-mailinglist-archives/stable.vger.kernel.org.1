Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C7F7A7FE8
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjITMbO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbjITMbM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:31:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2D793
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:31:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E11C433CD;
        Wed, 20 Sep 2023 12:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695213064;
        bh=GUecnBtGvksMdvIp3OwF13TnKiA0wZfgTRPEIQ7i/A4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KVusYpu96E+kPNNKueQmrOmscZm2h83FAg1y+hCuz4F61L+EbEpgHR/aCbMYb+IYc
         4OB0e+FqHgDVcLFIEpMPhf2K1wzqu66OGzV2OddxkeUqOSixnYSXklul7ZY2jeJUws
         XTns9tgjzST1kpAe36LyumfrlF6bkwnLXlSFgB+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Su Hui <suhui@nfschina.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 147/367] fs: lockd: avoid possible wrong NULL parameter
Date:   Wed, 20 Sep 2023 13:28:44 +0200
Message-ID: <20230920112902.477408645@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112858.471730572@linuxfoundation.org>
References: <20230920112858.471730572@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit de8d38cf44bac43e83bad28357ba84784c412752 ]

clang's static analysis warning: fs/lockd/mon.c: line 293, column 2:
Null pointer passed as 2nd argument to memory copy function.

Assuming 'hostname' is NULL and calling 'nsm_create_handle()', this will
pass NULL as 2nd argument to memory copy function 'memcpy()'. So return
NULL if 'hostname' is invalid.

Fixes: 77a3ef33e2de ("NSM: More clean up of nsm_get_handle()")
Signed-off-by: Su Hui <suhui@nfschina.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/mon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/lockd/mon.c b/fs/lockd/mon.c
index 1eabd91870e6f..d770a41f85695 100644
--- a/fs/lockd/mon.c
+++ b/fs/lockd/mon.c
@@ -276,6 +276,9 @@ static struct nsm_handle *nsm_create_handle(const struct sockaddr *sap,
 {
 	struct nsm_handle *new;
 
+	if (!hostname)
+		return NULL;
+
 	new = kzalloc(sizeof(*new) + hostname_len + 1, GFP_KERNEL);
 	if (unlikely(new == NULL))
 		return NULL;
-- 
2.40.1



