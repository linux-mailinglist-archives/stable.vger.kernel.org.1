Return-Path: <stable+bounces-245004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MDKIiAYAGr+CwEAu9opvQ
	(envelope-from <stable+bounces-245004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 07:31:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A90502A65
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 07:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8301B3020003
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 05:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCAF34AB06;
	Sun, 10 May 2026 05:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqbUg4Em"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E1347515
	for <stable@vger.kernel.org>; Sun, 10 May 2026 05:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391040; cv=none; b=lQYTSTSXKjetHdxgdl06/iKpIyJ24wdXpQEnlZuQqXnjhzdBCm+LXUtMTptCCY24kqIhA+FseoLyh4NtAaK4+1UnpZArnBYVUyP/y4YckMpRXLePOWfmuPSz9PaNykAmH8lrQMME2hMYjEgKuq9MhbESMfOCeHVVdo25eFT8yJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391040; c=relaxed/simple;
	bh=KIsmtJOEOeNGwnrSKy5ZyFdD72rmOYFJWN7TY1z7kXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MzJOBKA2UcqQhDkS6eIWHb/KYcC2UgEafL8vToG1Be0lhozaZRc1c5DsNQVLn+eW7/pSYVPsRJ7Mebue65GuIVIeQ4jQfIgDEhNCgnDNbZ5Uh8NjbYpIgKbx+psNc5kl/s3wXyUPSRaEITj1Ao2jSfoIAVF4WNnoM09PI5inEVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqbUg4Em; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso32150945ad.2
        for <stable@vger.kernel.org>; Sat, 09 May 2026 22:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778391038; x=1778995838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HiZtT3KiED6Ar39Wsw4WFRof7QOLYq294txhwcfCtho=;
        b=dqbUg4EmS0a2wkAW9uJOwwYJa4VZuYQjDeNoxX4ZI5kTDeCbypWx/PjQX0U1HbECNm
         jZ1WZKTf9nO5hlvYu/yLKFfkB08W7hjbKnT1pGW762A0eJSo6zFh0xx3uwii/iZGnKq2
         T4PYiSDplZF8L98tw59GDiZCtgmsiFIZhIx0QYoTQD6QOEosTjEDQ3PNiRwmZgtteKNd
         FemBWoMoaTJ1um1t1/zS7xHlChdCby9RLhwKzd/1GQyEGCH01D53/jZ7ljzs57lIxXWK
         H98/GjvEdA0PB8keaBgFDRz5CwekR499k55iynYVtZCmB4/z5l6QQUDuZmyEWtA38kq5
         Fv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778391038; x=1778995838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiZtT3KiED6Ar39Wsw4WFRof7QOLYq294txhwcfCtho=;
        b=XE/l6rCJu75WxmkB+l1DSXxrsJNUtgCkH95LHaeFRfi9jS0KjTBdFUWUyTlKrx8Zdo
         PLHHI81ZDVsoBMiAP9r7HW020zqjM7an9ycgmC929q6NAo9+qBxrRtGqSvNLnklFLa2l
         8h4pjs8TtA/aMkWzPyHl94qx57HScbYd2dqAspqtbx5p2Nxlh2OWFwtdc2tiw9uCKj14
         9Po5ZDweJauPLuAON9yC0arpqr3721w9+BFH663GPryEkyR1ENXNJ40dOiEsqVaw75GN
         28HnvoW9k6509esVVwLAulk9SLoYZ52wGQ4GfQ7W9TakUKQ0KsBssa6U+ysJyWdRdd20
         BrgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9isMQ4iMTsZ+jabfB93FD+doBgX7GFWEDwwXXqTqJShTFco3ifYFeBNdQqYsuSQmBWTioe+uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ6qg+3lNWO3dlryqpY46Ey/9YpRzauZbP8U9JKF5CgWgEMfSt
	aJxW3AsyrAGyepc5XfK33bHc3YxZ6QCsRcVo2j9UPI31qCEXCOw7MuXt
X-Gm-Gg: Acq92OHEU47YxfKwAYUXYI1eex9nhBP9qxTibpwKdtmHHsVyl1YXgqymt8ccI41Yf7b
	2LeEfBsBysR5EGlwRtanU6Q04YPQYBD5Lnei04/bA1PX59HLUH6pUv1zMlM8WRtUVneTJ4FO3tq
	3o9upmn1CfIaLoheMzZegTEtv0t+CMjaiRls980TtlrLyn71Ft3jxkIRIF3679ijWKDuPsMImFw
	zhmuk4NGC7s/xiEYh8XEtPcOhFQADN0CsBRgDqy70vtUdyq0HRd8btmI05P+SdlMDbJtsgktH4F
	QuLV0kVTzI18uc8tH7cUZTP54OYXBZmiyN8NoHwLXoA6ozpZVUvqP4MyIMu8mFurHaEWtomXC9I
	0L797yHfxJxhrKm7ddPPw21LbRUOGVgzpoq/yDKMeHPyo2vNWkgzqDz0NsWdQyDR6Uq4cv7ZbHP
	oYjS4vPcm4G09s3EkPl7X7UifDZeZdYaH6c4S2LGaMcWIbVvIxfpRr4nDbdrbgQWTA7AJNX9qYK
	E9kUJo=
X-Received: by 2002:a17:903:388c:b0:2ba:307:4584 with SMTP id d9443c01a7336-2bc7aa40967mr50895195ad.32.1778391036502;
        Sat, 09 May 2026 22:30:36 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:5d23:3a35:10d1:5ed6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ebea72sm67859095ad.77.2026.05.09.22.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 22:30:36 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] drm/virtio: check virtio_gpu_array_lock_resv() return in cursor update
Date: Sun, 10 May 2026 11:00:25 +0530
Message-ID: <20260510053025.100224-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E3A90502A65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,lists.linux.dev,vger.kernel.org,lists.linaro.org,gmail.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-245004-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,collabora.com,chromium.org,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,linaro.org,amd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,72bd3dd3a5d5f39a0271];
	NEURAL_HAM(-0.00)[-0.916];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Action: no action

virtio_gpu_cursor_plane_update() calls virtio_gpu_array_lock_resv()
but ignores its return value. The function can fail in two ways:

  - dma_resv_lock_interruptible() returns -ERESTARTSYS when a signal
    is delivered while waiting for the reservation lock.
  - dma_resv_reserve_fences() returns -ENOMEM if it fails to allocate
    a fence slot; in this case lock_resv unlocks before returning.

In both cases the resv lock is not held on return. The cursor path
proceeds to queue a fenced transfer command. The queue path then
walks the object array and calls dma_resv_add_fence() on the cursor
BO's reservation. dma_resv_add_fence() requires the resv lock to be
held; with lockdep enabled the missing lock trips
dma_resv_assert_held():

  WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840
  Call Trace:
   virtio_gpu_array_add_fence+0xcd/0x140
   virtio_gpu_queue_ctrl_sgs
   virtio_gpu_queue_fenced_ctrl_buffer+0x578/0xfb0
   virtio_gpu_cursor_plane_update+0x411/0xbc0
   drm_atomic_helper_commit_planes+0x497/0xf10
   ...
   drm_mode_cursor_ioctl+0xd4/0x110
   drm_ioctl+0x5e6/0xc60
   __x64_sys_ioctl+0x18e/0x210

Beyond the WARN, mutating the dma_resv fence list without the lock
races with concurrent readers/writers and can corrupt the list.

Check the return value of virtio_gpu_array_lock_resv(). On failure,
drop the references taken by virtio_gpu_array_add_obj() with
virtio_gpu_array_put_free() (which does not unlock, matching the
not-locked state) and return without queueing the command. A
skipped cursor frame is harmless; the WARN and the underlying race
are not.

The bug was reported by syzbot, triggered via fault injection
(fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
-ENOMEM branch in dma_resv_reserve_fences().

Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a126d1b25f46..ca379b08b9ec 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -459,7 +459,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_array_lock_resv(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
-- 
2.43.0


