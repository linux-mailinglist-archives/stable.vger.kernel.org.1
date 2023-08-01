Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16BF76AFEB
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjHAJvZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjHAJvI (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:51:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C4BEC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 129F0614F5
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCD6C433C8;
        Tue,  1 Aug 2023 09:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883438;
        bh=jGA1dXvjAAjWHb7G6CJmhV08MAhVrkRGKY95rvSxsuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTomeSrYC+pyonKz7+SB0YPy3TLC1HeMWl3QORbVJGheuokQoSp1RC+LGy83NCJVT
         3M8twDwf35N2gy09fpIUmURdnNGedyEsQmkYMeaK+2zO1otI+DYm8A33majw9pC68Q
         xZqoR8zQ7f4vVMQGQQsFxUFR4uBI1CaHv3CR4G7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH 6.4 219/239] fs/9p: fix type mismatch in file cache mode helper
Date:   Tue,  1 Aug 2023 11:21:23 +0200
Message-ID: <20230801091933.816764349@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
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

From: Eric Van Hensbergen <ericvh@kernel.org>

commit 09430aba3a9ffd986834614a3406a13588170bde upstream.

There were two flags (s_flags and s_cache) which had incorrect signed
type in the parameters of the file cache mode helper function.

Cc: stable@vger.kernel.org
Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/9p/fid.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 297c2c377e3d..29281b7c3887 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -46,8 +46,8 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
  * NOTE: these are set after open so only reflect 9p client not
  * underlying file system on server.
  */
-static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
-	int s_cache, unsigned int f_flags)
+static inline void v9fs_fid_add_modes(struct p9_fid *fid, unsigned int s_flags,
+	unsigned int s_cache, unsigned int f_flags)
 {
 	if (fid->qid.type != P9_QTFILE)
 		return;
-- 
2.41.0



