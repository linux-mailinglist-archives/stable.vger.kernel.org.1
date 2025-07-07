Return-Path: <stable+bounces-160375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16038AFB717
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4811C3B986B
	for <lists+stable@lfdr.de>; Mon,  7 Jul 2025 15:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DB82E1C7C;
	Mon,  7 Jul 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="bdCnkURk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A428ECF2
	for <stable@vger.kernel.org>; Mon,  7 Jul 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901509; cv=none; b=B5UeVw20JOFHNn2oMtm3GNqjZsGodApXCoxdD/oHh10kLljXkgCpZNaoO1fL5G6+6iGae6PkjmVH/wguipwgBoZVzDO6M7ZZzZTJthcBdhP8WEXbS9b+4EEzNQgPK2ohYKEk0ltWbQZlmsExTwLDJlYOJMZ9tMYpUvMCFNzXFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901509; c=relaxed/simple;
	bh=nhX3ytbPbkZSJUv/tvzuXtN2kNn2AvgOd1XC1S4xyDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nB5c1lu3HXHBgdxOaFXEz1fGhsXkblIMMZi7DQf+QUeihV0ojR0qRjw/rUQlsOXGUa3gEcHAsDUpdmdaUodoaxjXqjukizJRHdl/v9pqSbZmR23R73IIZ5RjGLXmlY5AFA18DYOZXFlYK3YC4/3lVxcXFrMDzFeE7lSLfedz094=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=bdCnkURk; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso1464398f8f.0
        for <stable@vger.kernel.org>; Mon, 07 Jul 2025 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1751901506; x=1752506306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDyUvZNv5CDa5hocwZakQH5cNmENDMsfcPjRy3ud2is=;
        b=bdCnkURke4VYXJRDMUFz3eN7VlRWsv+IGFrGMshckcZud8jojO+bKWLvsWnE2Nh8ou
         aty7qGWSeb0x03J1GGzIp1lQkyX/LKwsrjPgW1AHCZr9yK9ldgRk99nTI9hZSRtlKuo+
         EE/PdAMZ/5flOZQTHlkuADTPeIkxbUnjHxR0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751901506; x=1752506306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dDyUvZNv5CDa5hocwZakQH5cNmENDMsfcPjRy3ud2is=;
        b=BH7vhKlr87iR93QSyEM9lyKvsvq7h0mT/PqMBMZq0LtjtKzqIdoMBCbc4RCymSBM9/
         DSmfK5hIr/JW3+aqkg0CJJN0PXKOjMqQNdSeXteqSqIcl/vRfiZY9O39dQ96cHfs8WR0
         fC+zRlQZwEyGa3EuUyuZQnXyprVyTqSItoLv8vmwunFm0lN0+D8cQaDiQA7xrFjMECAq
         8F1JYKACD8XGbsK2pFlbfgfua8Vg1M1pY468Kksyocluuac4vaxIqZFsBVmTIY23jO04
         Y5R0MBIM3RXsUvAyoI5vllKAczmTXDfjbIAszhYAwtPo5Jzzs0CSGyEcxFVkS7fwhGjQ
         naag==
X-Forwarded-Encrypted: i=1; AJvYcCWeaDq1WuKwW2AMRULDkdfBwfLodiFahdN4+N46NOLHlHR+Ro4s8Pr9itpK9HOsagdwoEKN+Qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTp8mAz2Uz2AKOqfktmMsZ46QdEnqzBcKlHITM5P3ov0j0SlaW
	tsFr82WN26QMyIzZdSZ6D2jk6hK9/t2EHT3fVhr20fYd2ljxGWDSn44H37FoQ4lswDA=
X-Gm-Gg: ASbGncuqQyQjInA0/A0t+ihytonech4MVlY/UBLk+XZgimNyIL/UonsYv6O3MSMUu1Q
	4cs+faVbjzHNcKNBzUShE1taKaCYRvmNA4Nyk3hlC6WJqwOvcg4Oi7V7t9Vgg/ou5tlTP3S0BMB
	6wVnjsaKf6PhBNWDyYy7ySqqxtCUzPUtSBhTyWUfNZxfb8FUn6w8juMH/RIwo7MPF65M92LzzDa
	dqkUH9dbr/CLcaDbFKgGBaCErezmGG6XzPfGkrrqZPm978s5AfFcKkjc5C+yc01uniXcmX7H7Py
	NrPKGDa5u+p3KTQ4UdUpHEFWK5/lhbVE/l9zt8D+uXjAzQJ1iMYrwfHZiNXQgyNF3v6UWmj5Ig=
	=
X-Google-Smtp-Source: AGHT+IHkcWwX9LDmtC86uNJtoHdD49oLmsozTA8OJxJjZUo33P5D+GyfKtm4tZh+OpBnEJdv54iyJA==
X-Received: by 2002:a05:6000:41e4:b0:3a4:d53d:be20 with SMTP id ffacd0b85a97d-3b49aa60651mr5656442f8f.18.1751901506040;
        Mon, 07 Jul 2025 08:18:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b46d4c8619sm10369057f8f.0.2025.07.07.08.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:18:25 -0700 (PDT)
From: Simona Vetter <simona.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Xe Development <intel-xe@lists.freedesktop.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Simona Vetter <simona.vetter@intel.com>
Subject: [PATCH 1/2] drm/gem: Fix race in drm_gem_handle_create_tail()
Date: Mon,  7 Jul 2025 17:18:13 +0200
Message-ID: <20250707151814.603897-1-simona.vetter@ffwll.ch>
X-Mailer: git-send-email 2.49.0
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
  idr_find(), which maps both ENOENT and NULL to NULL.

- drivers using idr_for_each_entry() should also be fine, because
  idr_get_next does filter out NULL entries and continues the
  iteration.

- The same holds for drm_show_memory_stats().

v2: Use drm_WARN_ON (Thomas)

Reported-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Tested-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
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
index bc505d938b3e..1aa9192c4cc6 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -316,6 +316,9 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
 	struct drm_file *file_priv = data;
 	struct drm_gem_object *obj = ptr;
 
+	if (drm_WARN_ON(obj->dev, !data))
+		return 0;
+
 	if (obj->funcs->close)
 		obj->funcs->close(obj, file_priv);
 
@@ -436,7 +439,7 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
 	idr_preload(GFP_KERNEL);
 	spin_lock(&file_priv->table_lock);
 
-	ret = idr_alloc(&file_priv->object_idr, obj, 1, 0, GFP_NOWAIT);
+	ret = idr_alloc(&file_priv->object_idr, NULL, 1, 0, GFP_NOWAIT);
 
 	spin_unlock(&file_priv->table_lock);
 	idr_preload_end();
@@ -457,6 +460,11 @@ drm_gem_handle_create_tail(struct drm_file *file_priv,
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
index eab7546aad79..115763799625 100644
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


