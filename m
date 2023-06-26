Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5035373E974
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjFZSgS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjFZSgO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:36:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EE0AC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:36:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67E1560F40
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750B1C433CA;
        Mon, 26 Jun 2023 18:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687804572;
        bh=VJaVBTYUPT8lxunxp5u6E0VrFppW5VIlI6v11XKaSZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xkans/v/Q9D5zOGhp/+grrqf/tpAYufmzBHh3O1DR4rrJsN8dYUOD/xm6pwQzSwVw
         O5mpl8W/9TWJ8Z/EzgSTyt5MYCMP+UTbR03WG7RzYzeH5ZZmih7m+xLcUm8dZNmwIu
         vpfStCXd8+fPSfJNJwoB1s3s3HJbwl/2qobHSC7M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>,
        Rishabh Bhatnagar <risbhat@amazon.com>
Subject: [PATCH 5.4 22/60] cifs: Merge is_path_valid() into get_normalized_path()
Date:   Mon, 26 Jun 2023 20:12:01 +0200
Message-ID: <20230626180740.452292122@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180739.558575012@linuxfoundation.org>
References: <20230626180739.558575012@linuxfoundation.org>
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

From: "Paulo Alcantara (SUSE)" <pc@cjr.nz>

commit ff2f7fc08268f266372c30a815349749e8499eb5 upstream.

Just do the trivial path validation in get_normalized_path().

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/dfs_cache.c |   21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -75,13 +75,11 @@ static void refresh_cache_worker(struct
 
 static DECLARE_DELAYED_WORK(refresh_task, refresh_cache_worker);
 
-static inline bool is_path_valid(const char *path)
+static int get_normalized_path(const char *path, char **npath)
 {
-	return path && (strchr(path + 1, '\\') || strchr(path + 1, '/'));
-}
+	if (!path || strlen(path) < 3 || (*path != '\\' && *path != '/'))
+		return -EINVAL;
 
-static inline int get_normalized_path(const char *path, char **npath)
-{
 	if (*path == '\\') {
 		*npath = (char *)path;
 	} else {
@@ -828,9 +826,6 @@ int dfs_cache_find(const unsigned int xi
 	char *npath;
 	struct cache_entry *ce;
 
-	if (unlikely(!is_path_valid(path)))
-		return -EINVAL;
-
 	rc = get_normalized_path(path, &npath);
 	if (rc)
 		return rc;
@@ -875,9 +870,6 @@ int dfs_cache_noreq_find(const char *pat
 	char *npath;
 	struct cache_entry *ce;
 
-	if (unlikely(!is_path_valid(path)))
-		return -EINVAL;
-
 	rc = get_normalized_path(path, &npath);
 	if (rc)
 		return rc;
@@ -929,9 +921,6 @@ int dfs_cache_update_tgthint(const unsig
 	struct cache_entry *ce;
 	struct cache_dfs_tgt *t;
 
-	if (unlikely(!is_path_valid(path)))
-		return -EINVAL;
-
 	rc = get_normalized_path(path, &npath);
 	if (rc)
 		return rc;
@@ -989,7 +978,7 @@ int dfs_cache_noreq_update_tgthint(const
 	struct cache_entry *ce;
 	struct cache_dfs_tgt *t;
 
-	if (unlikely(!is_path_valid(path)) || !it)
+	if (!it)
 		return -EINVAL;
 
 	rc = get_normalized_path(path, &npath);
@@ -1049,8 +1038,6 @@ int dfs_cache_get_tgt_referral(const cha
 
 	if (!it || !ref)
 		return -EINVAL;
-	if (unlikely(!is_path_valid(path)))
-		return -EINVAL;
 
 	rc = get_normalized_path(path, &npath);
 	if (rc)


