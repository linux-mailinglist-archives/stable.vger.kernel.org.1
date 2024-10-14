Return-Path: <stable+bounces-83802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5859499C9C0
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8C8281658
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE43D19F421;
	Mon, 14 Oct 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DK/nT8e7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0D319F410
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907888; cv=none; b=DTEd4BXfE6tIw3zg40FogI4UsasXGJW2vDtlX83prBPG/yHgiQ64Pt4wof1vyi7MH95eGwefntw6LBOmlxeBw4C0apWE/i6z91CjrjaKMEhG3809T5/ZHovrNdzQ3dBhtun9xceN+5VorOABL7PZaJNjBzKQk5+Qzwq1SPLOJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907888; c=relaxed/simple;
	bh=5JildJhxhvZXrVMCizruy8FSHYsEhilf+SUvdMbw4Fc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MAaHmNQEQqSBudY++Jgw2VKMhGe7jvWPm7S9JEj1QzLRTMia/bWx4rVoaTR+jm24GXYl8xD45HTn+QM+jxNc5ctuqDWANvDxnUzX4u97ciF/PnQW2iBj7VH8ZQ00ykRnT67SjYNUWurzn1iXGIR+Yw46/kmkTL+XoXwNn9tBRgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DK/nT8e7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A991EC4CEC3;
	Mon, 14 Oct 2024 12:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728907888;
	bh=5JildJhxhvZXrVMCizruy8FSHYsEhilf+SUvdMbw4Fc=;
	h=Subject:To:Cc:From:Date:From;
	b=DK/nT8e7KOIDeuzXJKO6FemNMWrtaO4DS7zYEqhQuV6sr36LzKIOoytTerPE8bavI
	 GXAqcqzn29GuDaVDxcwcLvLNRRjHp+GbxhD/9d2NLR2ByzxCH6FPdfZwZ5BI5stErk
	 fSF7cFhBJcEW1i95tf7Pa+hEqx+YUtrEgv10zGdY=
Subject: FAILED: patch "[PATCH] drm/vc4: Stop the active perfmon before being destroyed" failed to apply to 5.10-stable tree
To: mcanal@igalia.com,bbrezillon@kernel.org,jasuarez@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 14:11:24 +0200
Message-ID: <2024101424-skinning-tightness-ecf1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0b2ad4f6f2bec74a5287d96cb2325a5e11706f22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101424-skinning-tightness-ecf1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

0b2ad4f6f2be ("drm/vc4: Stop the active perfmon before being destroyed")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0b2ad4f6f2bec74a5287d96cb2325a5e11706f22 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Date: Fri, 4 Oct 2024 09:36:00 -0300
Subject: [PATCH] drm/vc4: Stop the active perfmon before being destroyed
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Upon closing the file descriptor, the active performance monitor is not
stopped. Although all perfmons are destroyed in `vc4_perfmon_close_file()`,
the active performance monitor's pointer (`vc4->active_perfmon`) is still
retained.

If we open a new file descriptor and submit a few jobs with performance
monitors, the driver will attempt to stop the active performance monitor
using the stale pointer in `vc4->active_perfmon`. However, this pointer
is no longer valid because the previous process has already terminated,
and all performance monitors associated with it have been destroyed and
freed.

To fix this, when the active performance monitor belongs to a given
process, explicitly stop it before destroying and freeing it.

Cc: stable@vger.kernel.org # v4.17+
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Juan A. Suarez Romero <jasuarez@igalia.com>
Fixes: 65101d8c9108 ("drm/vc4: Expose performance counters to userspace")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Juan A. Suarez <jasuarez@igalia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241004123817.890016-2-mcanal@igalia.com

diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
index c4ac2c946238..c00a5cc2316d 100644
--- a/drivers/gpu/drm/vc4/vc4_perfmon.c
+++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
@@ -116,6 +116,11 @@ void vc4_perfmon_open_file(struct vc4_file *vc4file)
 static int vc4_perfmon_idr_del(int id, void *elem, void *data)
 {
 	struct vc4_perfmon *perfmon = elem;
+	struct vc4_dev *vc4 = (struct vc4_dev *)data;
+
+	/* If the active perfmon is being destroyed, stop it first */
+	if (perfmon == vc4->active_perfmon)
+		vc4_perfmon_stop(vc4, perfmon, false);
 
 	vc4_perfmon_put(perfmon);
 
@@ -130,7 +135,7 @@ void vc4_perfmon_close_file(struct vc4_file *vc4file)
 		return;
 
 	mutex_lock(&vc4file->perfmon.lock);
-	idr_for_each(&vc4file->perfmon.idr, vc4_perfmon_idr_del, NULL);
+	idr_for_each(&vc4file->perfmon.idr, vc4_perfmon_idr_del, vc4);
 	idr_destroy(&vc4file->perfmon.idr);
 	mutex_unlock(&vc4file->perfmon.lock);
 	mutex_destroy(&vc4file->perfmon.lock);


