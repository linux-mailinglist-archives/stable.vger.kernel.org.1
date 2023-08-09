Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A46775CDD
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjHILbe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjHILbb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029E410DC
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BFF2633BD
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8A3C433C8;
        Wed,  9 Aug 2023 11:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580690;
        bh=oVfaT3LyWREIPZg0lWZrLgphT+bY5TTA3LUodind8S0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKGkkXaAKqr8UO6gOlzDsLjbpJMaqL0Kfdmyicmqy8GYOo+IhQ8p01l1Bu86zt20y
         mpyataz/L3/iOjIzTgVYUIQzW8mHP+nMf5St1hdV9E0YDKsc9DxSFJ741obnUKlJB/
         /c+Xp6HuU+UHztYP7JH4pdwboM/haDJ8TOoTmCn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Qu Wenruo <wqu@suse.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        David Sterba <dsterba@suse.com>,
        Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Subject: [PATCH 5.4 085/154] btrfs: qgroup: return ENOTCONN instead of EINVAL when quotas are not enabled
Date:   Wed,  9 Aug 2023 12:41:56 +0200
Message-ID: <20230809103639.803346761@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Marcos Paulo de Souza <mpdesouza@suse.com>

commit 8a36e408d40606e21cd4e2dd9601004a67b14868 upstream.

[PROBLEM]
qgroup create/remove code is currently returning EINVAL when the user
tries to create a qgroup on a subvolume without quota enabled. EINVAL is
already being used for too many error scenarios so that is hard to
depict what is the problem.

[FIX]
Currently scrub and balance code return -ENOTCONN when the user tries to
cancel/pause and no scrub or balance is currently running for the
desired subvolume. Do the same here by returning -ENOTCONN  when a user
tries to create/delete/assing/list a qgroup on a subvolume without quota
enabled.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/qgroup.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1411,7 +1411,7 @@ int btrfs_add_qgroup_relation(struct btr
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 	member = find_qgroup_rb(fs_info, src);
@@ -1470,7 +1470,7 @@ static int __del_qgroup_relation(struct
 		return -ENOMEM;
 
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 
@@ -1536,7 +1536,7 @@ int btrfs_create_qgroup(struct btrfs_tra
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 	quota_root = fs_info->quota_root;
@@ -1570,7 +1570,7 @@ int btrfs_remove_qgroup(struct btrfs_tra
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 
@@ -1621,7 +1621,7 @@ int btrfs_limit_qgroup(struct btrfs_tran
 
 	mutex_lock(&fs_info->qgroup_ioctl_lock);
 	if (!fs_info->quota_root) {
-		ret = -EINVAL;
+		ret = -ENOTCONN;
 		goto out;
 	}
 


