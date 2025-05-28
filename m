Return-Path: <stable+bounces-147930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0098AC656E
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 11:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06169188BDCF
	for <lists+stable@lfdr.de>; Wed, 28 May 2025 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8909C276046;
	Wed, 28 May 2025 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="kEF+eOLg"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5246F275844
	for <stable@vger.kernel.org>; Wed, 28 May 2025 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423603; cv=none; b=ozdDUg+BkdJ21DPdx5+Z+QOVJNzUyoRB3wZ9okLZao4xedn7W2Z79xgt9mPWyr456fCVhManqWzZUIIQ4S9Oekf07t+QEVi8lfIuQ93f0sXvLxYoYNnZybwtjP4qQCoNrbq2TgBf/id2Ac2JrUxoVbmSYbZUGoAvupSklLH/B3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423603; c=relaxed/simple;
	bh=PkosjLFXCMYV0+R/p0aF+qSSlXYgLL8DzrQ4Y2CQht0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaCL6tU4FS1FA7eYT7fVt9q8W0QAvsSkq+BDwGE2Ekl/XWsph4nIVJ3HFth0AbPc1JfnypvWYMSCApaOZnz180gKgeI1ijZqhDQ8dBUc/QsIdnqMYrt7U/VJLD8YDz9+rIVnfpxN0BXJTJWLRPeuVg4UgHP1uX4WP7794ZFEdfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=kEF+eOLg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-44a57d08bbfso32352345e9.2
        for <stable@vger.kernel.org>; Wed, 28 May 2025 02:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1748423599; x=1749028399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9q66come6SeS35Z4+H4REbaGVF8j8A5bWLsS2teBos=;
        b=kEF+eOLgjs4Eb0Vz6f0Jvb2p7WAhdsvobRJONHtX43ZrOEaE6DAZITtHSNSZd3ARG0
         QfHl4JAstqwtFc1javvInxVJisNL4TcsVMVXyH95lCG+UdciwA7FNfMZGZ6skKJdqCZU
         Asvc92FXxhZIajD2X6cDRhM+6pKfh0W0c1k2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423599; x=1749028399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9q66come6SeS35Z4+H4REbaGVF8j8A5bWLsS2teBos=;
        b=txrc19+aIVhTwvB+XxVj6bWnyk4Ioi6ko17aMbd4unY97thRXLoyOsDMg8XQbYMqDN
         106PaNTBCH4DCKok8j5vMLKVFp0l23sI7KlEMUmcKd9UWIFzLn1uW+Jdg0XK6mh5uPva
         F2XMnhPgnUgee2PbewKpm+NCypABnZKPd8YHFkL0kYDfySZaAtPuGO/XmrYLdqseUmI3
         LtNqVI9Aj4rHPuwE29+mWAdd9QYXY6kw2+wukmLU6SC+5C5EUXXpSI65dOHuZen5WhLN
         VgTIJC6ZfatOxRHhzXtu0PnN3q8L9JJ14LP4+wSyL6xCNV6dFPv8/D69XYYN7AEmZLue
         wYuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8MkvIZwmK63DugUqq4DBni+Vslj+//3Tq5gYbQTURhxQ0f2IMXsEGTTD56I15U4yPaFNMcZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9FCTfdLE4zg2MOYZ/6d45zOKsFiUDBXLzMoiVKqar1YFNvRon
	77XmZ634RXUZi1HQ7Y2565eQWbuXvwdlPNtz0cCq++ZwqiP8G/8gZ9poaEqrb+ksL0c=
X-Gm-Gg: ASbGncvFP5OFvaggxaNNRNKcfz/4q6XwVKOglho+hDlAiArGa56t5JIlNJFd0W2II+8
	aH6LGiJKePyPb5XFizSW3viunjDSIkgO3jhM/yRV1EuaCpMinxUN6HSi3Cs3dhQNIQSZKyhlF4/
	V/iDDIPI+sgfUn9cMK+lqZtVGcV/3zQncjhguzYpXhhwETSz+wrY6h08k7s7rYTg1Sv5BWT57F1
	7oEWdkFbizs9H6RrP0sUsl6PGnF5eXMmsEHy0O1hXvmFhIcSIPuahH+I6SsqRTl6d7nWq6XuzXI
	i4xJoUNHFH88e6QPEDVMYAgI3Letq4hN26KZInI2odw7KHLLTvdwRzx0WjzYtvY=
X-Google-Smtp-Source: AGHT+IHCdJjf/CaKt4eUMaaCGYd4N1EV7jgocpxCcj39hada3ZW2Jiep3JAak6Ekwh7yr4ee9sg8zg==
X-Received: by 2002:a05:600c:630a:b0:43d:fa59:be39 with SMTP id 5b1f17b1804b1-44fd2eec75fmr20647115e9.33.1748423599246;
        Wed, 28 May 2025 02:13:19 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4500e1d85b5sm14811715e9.32.2025.05.28.02.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 02:13:18 -0700 (PDT)
From: Simona Vetter <simona.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: intel-xe@lists.freedesktop.org,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@intel.com>
Subject: [PATCH 1/8] drm/gem: Fix race in drm_gem_handle_create_tail()
Date: Wed, 28 May 2025 11:12:59 +0200
Message-ID: <20250528091307.1894940-2-simona.vetter@ffwll.ch>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528091307.1894940-1-simona.vetter@ffwll.ch>
References: <20250528091307.1894940-1-simona.vetter@ffwll.ch>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Object creation is a careful dance where we must guarantee that the
object is fully constructed before it is visible to other threads, and
GEM buffer objects are no difference.

Final publishing happens by calling drm_gem_handle_create(). After
that the only allowed thing to do is call drm_gem_object_put() because
a concurrent call to the GEM_CLOSE ioctl with a correctly guessed id
(which is trivial since we have a linear allocator) can already tear
down the object again.

Luckily most drivers get this right, the very few exceptions I've
pinged the relevant maintainers for. Unfortunately we also need
drm_gem_handle_create() when creating additional handles for an
already existing object (e.g. GETFB ioctl or the various bo import
ioctl), and hence we cannot have a drm_gem_handle_create_and_put() as
the only exported function to stop these issues from happening.

Now unfortunately the implementation of drm_gem_handle_create() isn't
living up to standards: It does correctly finishe object
initialization at the global level, and hence is safe against a
concurrent tear down. But it also sets up the file-private aspects of
the handle, and that part goes wrong: We fully register the object in
the drm_file.object_idr before calling drm_vma_node_allow() or
obj->funcs->open, which opens up races against concurrent removal of
that handle in drm_gem_handle_delete().

Fix this with the usual two-stage approach of first reserving the
handle id, and then only registering the object after we've completed
the file-private setup.

Jacek reported this with a testcase of concurrently calling GEM_CLOSE
on a freshly-created object (which also destroys the object), but it
should be possible to hit this with just additional handles created
through import or GETFB without completed destroying the underlying
object with the concurrent GEM_CLOSE ioctl calls.

Note that the close-side of this race was fixed in f6cd7daecff5 ("drm:
Release driver references to handle before making it available
again"), which means a cool 9 years have passed until someone noticed
that we need to make this symmetry or there's still gaps left :-/
Without the 2-stage close approach we'd still have a race, therefore
that's an integral part of this bugfix.

More importantly, this means we can have NULL pointers behind
allocated id in our drm_file.object_idr. We need to check for that
now:

- drm_gem_handle_delete() checks for ERR_OR_NULL already

- drm_gem.c:object_lookup() also chekcs for NULL

- drm_gem_release() should never be called if there's another thread
  still existing that could call into an IOCTL that creates a new
  handle, so cannot race. For paranoia I added a NULL check to
  drm_gem_object_release_handle() though.

- most drivers (etnaviv, i915, msm) are find because they use
  idr_find, which maps both ENOENT and NULL to NULL.

- vmgfx is already broken vmw_debugfs_gem_info_show() because NULL
  pointers might exist due to drm_gem_handle_delete(). This needs a
  separate patch. This is because idr_for_each_entry terminates on the
  first NULL entry and so might not iterate over everything.

- similar for amd in amdgpu_debugfs_gem_info_show() and
  amdgpu_gem_force_release(). The latter is really questionable though
  since it's a best effort hack and there's no way to close all the
  races. Needs separate patches.

- xe is really broken because it not uses idr_for_each_entry() but
  also drops the drm_file.table_lock, which can wreak the idr iterator
  state if you're unlucky enough. Maybe another reason to look into
  the drm fdinfo memory stats instead of hand-rolling too much.

- drm_show_memory_stats() is also broken since it uses
  idr_for_each_entry. But since that's a preexisting bug I'll follow
  up with a separate patch.

Reported-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: stable@vger.kernel.org
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Signed-off-by: Simona Vetter <simona.vetter@intel.com>
Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_gem.c | 10 +++++++++-
 include/drm/drm_file.h    |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 1e659d2660f7..e4e20dda47b1 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -279,6 +279,9 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
 	struct drm_file *file_priv = data;
 	struct drm_gem_object *obj = ptr;
 
+	if (WARN_ON(!data))
+		return 0;
+
 	if (obj->funcs->close)
 		obj->funcs->close(obj, file_priv);
 
@@ -399,7 +402,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 	idr_preload(GFP_KERNEL);
 	spin_lock(&file_priv->table_lock);
 
-	ret = idr_alloc(&file_priv->object_idr, obj, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc(&file_priv->object_idr, NULL, 1, 0, GFP_NOWAIT);
 
 	spin_unlock(&file_priv->table_lock);
 	idr_preload_end();
@@ -420,6 +423,11 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 			goto err_revoke;
 	}
 
+	/* mirrors drm_gem_handle_delete to avoid races */
+	spin_lock(&file_priv->table_lock);
+	obj = idr_replace(&file_priv->object_idr, obj, handle);
+	WARN_ON(obj != NULL);
+	spin_unlock(&file_priv->table_lock);
 	*handlep = handle;
 	return 0;
 
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 5c3b2aa3e69d..d344d41e6cfe 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -300,6 +300,9 @@ struct drm_file {
 	 *
 	 * Mapping of mm object handles to object pointers. Used by the GEM
 	 * subsystem. Protected by @table_lock.
+	 *
+	 * Note that allocated entries might be NULL as a transient state when
+	 * creating or deleting a handle.
 	 */
 	struct idr object_idr;
 
-- 
2.49.0


