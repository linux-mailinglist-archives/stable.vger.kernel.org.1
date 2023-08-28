Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83C978ABF5
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjH1Kfk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjH1Kfa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:35:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA32129
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:35:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5780E63E81
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B885C433C8;
        Mon, 28 Aug 2023 10:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218925;
        bh=43BXpHg6krl5O5bmEZNLd+M8prYoMJhMZ9HY7X7qxTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vw9Y+7AyciX+ooThTXVZo7bmodCNRjUK8YK4yULNtwZvcyIjHEk8RArjGcwGGccwG
         5Y9C/2w1n1wnEIlGHKLqmC9sYuBqSEIwIl/Ksf0bVHkNtEV8IznwhYbqHMuYpgydcP
         pcuiNJerIVRzaXq3QuyDRi5A4PzgQY0OIn7mfggI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 011/158] ovl: check type and offset of struct vfsmount in ovl_entry
Date:   Mon, 28 Aug 2023 12:11:48 +0200
Message-ID: <20230828101157.712162232@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit f723edb8a532cd26e1ff0a2b271d73762d48f762 ]

Porting overlayfs to the new amount api I started experiencing random
crashes that couldn't be explained easily. So after much debugging and
reasoning it became clear that struct ovl_entry requires the point to
struct vfsmount to be the first member and of type struct vfsmount.

During the port I added a new member at the beginning of struct
ovl_entry which broke all over the place in the form of random crashes
and cache corruptions. While there's a comment in ovl_free_fs() to the
effect of "Hack! Reuse ofs->layers as a vfsmount array before freeing
it" there's no such comment on struct ovl_entry which makes this easy to
trip over.

Add a comment and two static asserts for both the offset and the type of
pointer in struct ovl_entry.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/overlayfs/ovl_entry.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 28348c44ea5b2..8d81e88f1d1ef 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -27,6 +27,7 @@ struct ovl_sb {
 };
 
 struct ovl_layer {
+	/* ovl_free_fs() relies on @mnt being the first member! */
 	struct vfsmount *mnt;
 	/* Trap in ovl inode cache */
 	struct inode *trap;
@@ -37,6 +38,14 @@ struct ovl_layer {
 	int fsid;
 };
 
+/*
+ * ovl_free_fs() relies on @mnt being the first member when unmounting
+ * the private mounts created for each layer. Let's check both the
+ * offset and type.
+ */
+static_assert(offsetof(struct ovl_layer, mnt) == 0);
+static_assert(__same_type(typeof_member(struct ovl_layer, mnt), struct vfsmount *));
+
 struct ovl_path {
 	struct ovl_layer *layer;
 	struct dentry *dentry;
-- 
2.40.1



