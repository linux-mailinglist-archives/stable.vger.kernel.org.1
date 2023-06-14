Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710D7713E8C
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjE1Tgf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjE1Tge (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2815DC9
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:36:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC8A861E42
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E7AC4339B;
        Sun, 28 May 2023 19:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302592;
        bh=QQnnE4i3eL6R307oEqra6ayyV8n51uDN9f9ilv2MX+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ik4lZE/es+uunosYTtui/ci1PrM3O3+vbrUZ3KCYKbP9OeVxGn0G8nhw1tQupKl8K
         BQPfYZj5QbM5XIDOntu+HIjp4MwEgV5BzcRedMt2nVsAqv15KzS9Gk3bIeKO+dsbQm
         ruBIu0UiKvDntrUiAiAsLKWWArrO9HFF2wfYFp9s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jocelyn Falempe <jfalempe@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Matthew Auld <matthew.auld@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.1 065/119] drm: fix drmm_mutex_init()
Date:   Sun, 28 May 2023 20:11:05 +0100
Message-Id: <20230528190837.647782960@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
References: <20230528190835.386670951@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Matthew Auld <matthew.auld@intel.com>

commit c21f11d182c2180d8b90eaff84f574cfa845b250 upstream.

In mutex_init() lockdep identifies a lock by defining a special static
key for each lock class. However if we wrap the macro in a function,
like in drmm_mutex_init(), we end up generating:

int drmm_mutex_init(struct drm_device *dev, struct mutex *lock)
{
      static struct lock_class_key __key;

      __mutex_init((lock), "lock", &__key);
      ....
}

The static __key here is what lockdep uses to identify the lock class,
however since this is just a normal function the key here will be
created once, where all callers then use the same key. In effect the
mutex->depmap.key will be the same pointer for different
drmm_mutex_init() callers. This then results in impossible lockdep
splats since lockdep thinks completely unrelated locks are the same lock
class.

To fix this turn drmm_mutex_init() into a macro such that it generates a
different "static struct lock_class_key __key" for each invocation,
which looks to be inline with what mutex_init() wants.

v2:
  - Revamp the commit message with clearer explanation of the issue.
  - Rather export __drmm_mutex_release() than static inline.

Reported-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reported-by: Sarah Walker <sarah.walker@imgtec.com>
Fixes: e13f13e039dc ("drm: Add DRM-managed mutex_init()")
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230519090733.489019-1-matthew.auld@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_managed.c |   22 ++--------------------
 include/drm/drm_managed.h     |   18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 21 deletions(-)

--- a/drivers/gpu/drm/drm_managed.c
+++ b/drivers/gpu/drm/drm_managed.c
@@ -264,28 +264,10 @@ void drmm_kfree(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drmm_kfree);
 
-static void drmm_mutex_release(struct drm_device *dev, void *res)
+void __drmm_mutex_release(struct drm_device *dev, void *res)
 {
 	struct mutex *lock = res;
 
 	mutex_destroy(lock);
 }
-
-/**
- * drmm_mutex_init - &drm_device-managed mutex_init()
- * @dev: DRM device
- * @lock: lock to be initialized
- *
- * Returns:
- * 0 on success, or a negative errno code otherwise.
- *
- * This is a &drm_device-managed version of mutex_init(). The initialized
- * lock is automatically destroyed on the final drm_dev_put().
- */
-int drmm_mutex_init(struct drm_device *dev, struct mutex *lock)
-{
-	mutex_init(lock);
-
-	return drmm_add_action_or_reset(dev, drmm_mutex_release, lock);
-}
-EXPORT_SYMBOL(drmm_mutex_init);
+EXPORT_SYMBOL(__drmm_mutex_release);
--- a/include/drm/drm_managed.h
+++ b/include/drm/drm_managed.h
@@ -105,6 +105,22 @@ char *drmm_kstrdup(struct drm_device *de
 
 void drmm_kfree(struct drm_device *dev, void *data);
 
-int drmm_mutex_init(struct drm_device *dev, struct mutex *lock);
+void __drmm_mutex_release(struct drm_device *dev, void *res);
+
+/**
+ * drmm_mutex_init - &drm_device-managed mutex_init()
+ * @dev: DRM device
+ * @lock: lock to be initialized
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
+ *
+ * This is a &drm_device-managed version of mutex_init(). The initialized
+ * lock is automatically destroyed on the final drm_dev_put().
+ */
+#define drmm_mutex_init(dev, lock) ({					     \
+	mutex_init(lock);						     \
+	drmm_add_action_or_reset(dev, __drmm_mutex_release, lock);	     \
+})									     \
 
 #endif


