Return-Path: <stable+bounces-128909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A12A7FB80
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 683E87A8ACC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A52620459F;
	Tue,  8 Apr 2025 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qdpv9hkE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06186263C8A
	for <stable@vger.kernel.org>; Tue,  8 Apr 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107275; cv=none; b=tV3hvNGS2V7aYzrwvi37117h7lgHRgPfZ8aUQ8GMc2O/m2j9nRNuMoQzqjDShI4lJJeBv58fc3FoD+bATz/h5wNEh3y+c++tFvpWMH9utucNodV2gs7k45DOaTQsv/eb6hwLxh844K+iTPZAXsv1BnX0zIGl1KvP3udZTcv4i0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107275; c=relaxed/simple;
	bh=rC81MeolOMnC/4hNItSoZakP6crWI463Riji0yZholQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CGjgM8KPQoeYz2NAmNbBU/PV9OU0ZBIHopYyGyGrBeVXjtF360hyEyBTaTgfA/EH8tQdhfUws9atUrFwXuocm27t/f/0IX7LSehE9H6Kk+SSnOXEPWg5ENzKDORdLfWwVAIIGghEpRq2z9ELK5PpVeUT2CDsrKowF7Ac9qIPJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qdpv9hkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE05C4CEEA;
	Tue,  8 Apr 2025 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744107274;
	bh=rC81MeolOMnC/4hNItSoZakP6crWI463Riji0yZholQ=;
	h=Subject:To:Cc:From:Date:From;
	b=qdpv9hkEQN6pcC6f38L4dJKD45lSBi0xdl0g5QuT/TFXCLPaTYWeveCgFKOsHjCZg
	 sOmwqL9FFR2xMy3AKR1aeKs2i1VAcNSJDbBLZOaufy0+XrxqYOtXzkfyzo0+vDSmsi
	 ggg3BeKScyG5mfBSBdmJYphz6AUuNEt6HGsjSipA=
Subject: FAILED: patch "[PATCH] media: vimc: skip .s_stream() for stopped entities" failed to apply to 5.15-stable tree
To: n.zhandarovich@fintech.ru,hverkuil@xs4all.nl
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Apr 2025 12:13:01 +0200
Message-ID: <2025040801-surging-justify-20fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 36cef585e2a31e4ddf33a004b0584a7a572246de
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025040801-surging-justify-20fe@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 36cef585e2a31e4ddf33a004b0584a7a572246de Mon Sep 17 00:00:00 2001
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Date: Sun, 2 Mar 2025 17:58:25 +0300
Subject: [PATCH] media: vimc: skip .s_stream() for stopped entities

Syzbot reported [1] a warning prompted by a check in call_s_stream()
that checks whether .s_stream() operation is warranted for unstarted
or stopped subdevs.

Add a simple fix in vimc_streamer_pipeline_terminate() ensuring that
entities skip a call to .s_stream() unless they have been previously
properly started.

[1] Syzbot report:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5933 at drivers/media/v4l2-core/v4l2-subdev.c:460 call_s_stream+0x2df/0x350 drivers/media/v4l2-core/v4l2-subdev.c:460
Modules linked in:
CPU: 0 UID: 0 PID: 5933 Comm: syz-executor330 Not tainted 6.13.0-rc2-syzkaller-00362-g2d8308bf5b67 #0
...
Call Trace:
 <TASK>
 vimc_streamer_pipeline_terminate+0x218/0x320 drivers/media/test-drivers/vimc/vimc-streamer.c:62
 vimc_streamer_pipeline_init drivers/media/test-drivers/vimc/vimc-streamer.c:101 [inline]
 vimc_streamer_s_stream+0x650/0x9a0 drivers/media/test-drivers/vimc/vimc-streamer.c:203
 vimc_capture_start_streaming+0xa1/0x130 drivers/media/test-drivers/vimc/vimc-capture.c:256
 vb2_start_streaming+0x15f/0x5a0 drivers/media/common/videobuf2/videobuf2-core.c:1789
 vb2_core_streamon+0x2a7/0x450 drivers/media/common/videobuf2/videobuf2-core.c:2348
 vb2_streamon drivers/media/common/videobuf2/videobuf2-v4l2.c:875 [inline]
 vb2_ioctl_streamon+0xf4/0x170 drivers/media/common/videobuf2/videobuf2-v4l2.c:1118
 __video_do_ioctl+0xaf0/0xf00 drivers/media/v4l2-core/v4l2-ioctl.c:3122
 video_usercopy+0x4d2/0x1620 drivers/media/v4l2-core/v4l2-ioctl.c:3463
 v4l2_ioctl+0x1ba/0x250 drivers/media/v4l2-core/v4l2-dev.c:366
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2b85c01b19
...

Reported-by: syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5bcd7c809d365e14c4df
Fixes: adc589d2a208 ("media: vimc: Add vimc-streamer for stream control")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/test-drivers/vimc/vimc-streamer.c b/drivers/media/test-drivers/vimc/vimc-streamer.c
index 807551a5143b..15d863f97cbf 100644
--- a/drivers/media/test-drivers/vimc/vimc-streamer.c
+++ b/drivers/media/test-drivers/vimc/vimc-streamer.c
@@ -59,6 +59,12 @@ static void vimc_streamer_pipeline_terminate(struct vimc_stream *stream)
 			continue;
 
 		sd = media_entity_to_v4l2_subdev(ved->ent);
+		/*
+		 * Do not call .s_stream() to stop an already
+		 * stopped/unstarted subdev.
+		 */
+		if (!v4l2_subdev_is_streaming(sd))
+			continue;
 		v4l2_subdev_call(sd, video, s_stream, 0);
 	}
 }


