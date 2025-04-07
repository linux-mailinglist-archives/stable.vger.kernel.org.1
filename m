Return-Path: <stable+bounces-128700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF7A7EAF5
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B48717D668
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B09267F65;
	Mon,  7 Apr 2025 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeclPCKu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976A267B70;
	Mon,  7 Apr 2025 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049700; cv=none; b=XyRwDrhIDq7LI5v323lrByn7GuaXbzZl7bcmfvt06dcZ5PvilC/FjqT3g/K6bvPRgAPYmzDk4TD+q6cKU5IvrlfDlyLPjHXucyp7+kCqbB1iVrWcA7rTUbkZ/xp/b35nOFMfUpaVzB1VRZniAhOskn02E69XQVoTUwBd7BeI7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049700; c=relaxed/simple;
	bh=9MZmQ3RNAYgi3VfmPE9AOSD+2RKITI9HdG8hqPzZGAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EBe/F9GgXcnFN7edUU1F+jCinumWEg8dEMzoYRIqg3Tlddwg0mf6jjA4EZ7Eb6TyIlNWewWH0Y+TqR3uDIqFs7ZXid4e8Fd69wwjF0kOINmABSw0hwvW1NtvM0Jho+Y8H4xJWq6Px3LE14JdDgjp/5Gq0dGUV524srz/QWv+njA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeclPCKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A5DC4CEED;
	Mon,  7 Apr 2025 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049700;
	bh=9MZmQ3RNAYgi3VfmPE9AOSD+2RKITI9HdG8hqPzZGAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TeclPCKuEzTx16p/MUZpSi5QkVgPrb/tPw8hcqlT9E9A3Kt6Q9GGL5c577LLgO2I3
	 yFu2sGvZSRLAz29bDGn8mvh1Ve7PmOsT06zfnVfQt7SCoNzEWBv0LKbGs+DASSmDsQ
	 xJxG1lKGfGrpOGKJzlQ0sFO757mGXlZ3m0h7XsnHcEPAMyayQzuEu4bBhOPeizYCuD
	 QVLb9QMRD2R4/e9yK9BgGz8C0r3+zbvEZ4CQLBsrWEeicpwfHR5eQRkZiRHSVcUOsr
	 jIXTqVlcpV3OpxaeibStjbiBst7myb4pxgTPcHLtXM00ryMN5I4f9hxKXUNtSBIm54
	 Rt55Ge+7zG2LA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	kernel-team@android.com,
	Betty Zhou <bettyzhou@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 05/13] sound/virtio: Fix cancel_sync warnings on uninitialized work_structs
Date: Mon,  7 Apr 2025 14:14:39 -0400
Message-Id: <20250407181449.3183687-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181449.3183687-1-sashal@kernel.org>
References: <20250407181449.3183687-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.133
Content-Transfer-Encoding: 8bit

From: John Stultz <jstultz@google.com>

[ Upstream commit 3c7df2e27346eb40a0e86230db1ccab195c97cfe ]

Betty reported hitting the following warning:

[    8.709131][  T221] WARNING: CPU: 2 PID: 221 at kernel/workqueue.c:4182
...
[    8.713282][  T221] Call trace:
[    8.713365][  T221]  __flush_work+0x8d0/0x914
[    8.713468][  T221]  __cancel_work_sync+0xac/0xfc
[    8.713570][  T221]  cancel_work_sync+0x24/0x34
[    8.713667][  T221]  virtsnd_remove+0xa8/0xf8 [virtio_snd ab15f34d0dd772f6d11327e08a81d46dc9c36276]
[    8.713868][  T221]  virtsnd_probe+0x48c/0x664 [virtio_snd ab15f34d0dd772f6d11327e08a81d46dc9c36276]
[    8.714035][  T221]  virtio_dev_probe+0x28c/0x390
[    8.714139][  T221]  really_probe+0x1bc/0x4c8
...

It seems we're hitting the error path in virtsnd_probe(), which
triggers a virtsnd_remove() which iterates over the substreams
calling cancel_work_sync() on the elapsed_period work_struct.

Looking at the code, from earlier in:
virtsnd_probe()->virtsnd_build_devs()->virtsnd_pcm_parse_cfg()

We set snd->nsubstreams, allocate the snd->substreams, and if
we then hit an error on the info allocation or something in
virtsnd_ctl_query_info() fails, we will exit without having
initialized the elapsed_period work_struct.

When that error path unwinds we then call virtsnd_remove()
which as long as the substreams array is allocated, will iterate
through calling cancel_work_sync() on the uninitialized work
struct hitting this warning.

Takashi Iwai suggested this fix, which initializes the substreams
structure right after allocation, so that if we hit the error
paths we avoid trying to cleanup uninitialized data.

Note: I have not yet managed to reproduce the issue myself, so
this patch has had limited testing.

Feedback or thoughts would be appreciated!

Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: virtualization@lists.linux.dev
Cc: linux-sound@vger.kernel.org
Cc: kernel-team@android.com
Reported-by: Betty Zhou <bettyzhou@google.com>
Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: John Stultz <jstultz@google.com>
Message-Id: <20250116194114.3375616-1-jstultz@google.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/virtio/virtio_pcm.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index c10d91fff2fb0..1ddec1f4f05d5 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -337,6 +337,21 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 	if (!snd->substreams)
 		return -ENOMEM;
 
+	/*
+	 * Initialize critical substream fields early in case we hit an
+	 * error path and end up trying to clean up uninitialized structures
+	 * elsewhere.
+	 */
+	for (i = 0; i < snd->nsubstreams; ++i) {
+		struct virtio_pcm_substream *vss = &snd->substreams[i];
+
+		vss->snd = snd;
+		vss->sid = i;
+		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
+		init_waitqueue_head(&vss->msg_empty);
+		spin_lock_init(&vss->lock);
+	}
+
 	info = kcalloc(snd->nsubstreams, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
@@ -350,12 +365,6 @@ int virtsnd_pcm_parse_cfg(struct virtio_snd *snd)
 		struct virtio_pcm_substream *vss = &snd->substreams[i];
 		struct virtio_pcm *vpcm;
 
-		vss->snd = snd;
-		vss->sid = i;
-		INIT_WORK(&vss->elapsed_period, virtsnd_pcm_period_elapsed);
-		init_waitqueue_head(&vss->msg_empty);
-		spin_lock_init(&vss->lock);
-
 		rc = virtsnd_pcm_build_hw(vss, &info[i]);
 		if (rc)
 			goto on_exit;
-- 
2.39.5


