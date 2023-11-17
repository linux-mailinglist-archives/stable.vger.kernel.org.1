Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAAC7EEBC3
	for <lists+stable@lfdr.de>; Fri, 17 Nov 2023 05:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjKQEpx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 16 Nov 2023 23:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjKQEpw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 16 Nov 2023 23:45:52 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD950D52;
        Thu, 16 Nov 2023 20:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5xG8OsDdM026U58BhU49rf1VRAgi//Kvg0Y3QhHrkBM=; b=S7mftWDFLoZmcwic3YG4qsSAUT
        +mk9rJSp581OU36/YQpTiDDRM8ugkth8iu4DSDamkHTa1afWKp+BRulcBKJzHbbJqqZ9MYbfwPSzV
        b2nke6mmOOSo/OLQdCwYDq9pD4tmGwsPM9YprnS9kGxJzwi5oeFlGzXpDc/s8oXSnXgtqZAXxZS9i
        pVqx3/JLNw4twiaJQQIQmphsE3HmzduhuUTuZLhaM8ZdGZMTAlw0gO1lFboeZLxU4LXFrz1qAZBbG
        zo9SjvnqDOto+K61r4UXHcH7z/C1oIFybC4wrkt4Eq+F6qGPsJFPoGWNK6lZOPnf8CkVpdF79O4v2
        +K4AwVFg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r3qji-00GsY8-2Y;
        Fri, 17 Nov 2023 04:45:46 +0000
Date:   Fri, 17 Nov 2023 04:45:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, idryomov@gmail.com, jlayton@kernel.org,
        vshankar@redhat.com, mchangir@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] ceph: fix deadlock or deadcode of misusing dget()
Message-ID: <20231117044546.GC1957730@ZenIV>
References: <20231117031951.710177-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117031951.710177-1-xiubli@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 17, 2023 at 11:19:51AM +0800, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> The lock order is incorrect between denty and its parent, we should
> always make sure that the parent get the lock first.
> 
> Switch to use the 'dget_parent()' to get the parent dentry and also
> keep holding the parent until the corresponding inode is not being
> refereenced.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> URL: https://www.spinics.net/lists/ceph-devel/msg58622.html
> Fixes: adf0d68701c7 ("ceph: fix unsafe dcache access in ceph_encode_dentry_release")
> Cc: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>

> +	if (!dir) {
> +		parent = dget_parent(dentry);
> +		dir = d_inode(parent);
> +	}

It's never actually called with dir == NULL.  Not since 2016.

All you need is this, _maybe_ with BUG_ON(!dir); added in the beginning of the function.

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 2c0b8dc3dd0d..22d6ea97938f 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4887,7 +4887,6 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 			       struct inode *dir,
 			       int mds, int drop, int unless)
 {
-	struct dentry *parent = NULL;
 	struct ceph_mds_request_release *rel = *p;
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	struct ceph_client *cl;
@@ -4903,14 +4902,9 @@ int ceph_encode_dentry_release(void **p, struct dentry *dentry,
 	spin_lock(&dentry->d_lock);
 	if (di->lease_session && di->lease_session->s_mds == mds)
 		force = 1;
-	if (!dir) {
-		parent = dget(dentry->d_parent);
-		dir = d_inode(parent);
-	}
 	spin_unlock(&dentry->d_lock);
 
 	ret = ceph_encode_inode_release(p, dir, mds, drop, unless, force);
-	dput(parent);
 
 	cl = ceph_inode_to_client(dir);
 	spin_lock(&dentry->d_lock);
