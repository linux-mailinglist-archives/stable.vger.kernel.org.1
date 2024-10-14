Return-Path: <stable+bounces-83799-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3931499C9A8
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 936D81F22B31
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836B719E99B;
	Mon, 14 Oct 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fF4LvrkW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A54156F3F
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 12:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907475; cv=none; b=cEZxxKcdPORLG5aX9J/OgTCt5DeZGrfeZ2/PIg70BrmQAthB2XsbE50xGw5rjMw+ujjPOHv2ixp61gRl0ZsZPKz9shQjktUXktL5YJAnoFhR4X3gzHxzhOTy94BwFHjPPjXdl3ueJKB0cDpuLwJWpBcoMINUnAyMDIZ91OiwnIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907475; c=relaxed/simple;
	bh=AWBSKlAs1599kIgeYNDmjDhdF6gENn86/cIK1ZWxkjY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NUXg11JWiIMQcGQJVQ+tFrk7UayWgnjZoFxMo+Ie7H5b0cxzSUgWEUjMPncJuGBew4leCBpcBo2WkmcHPavYycVZaToG1ECBmNCEc+cyvuwrDwA3nhOL1BDnz0dj06uNFAltgneQMoaIo9ittnw8ZhgEYMNUHuMPifMQO5ws3sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fF4LvrkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFC1C4CEC3;
	Mon, 14 Oct 2024 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728907474;
	bh=AWBSKlAs1599kIgeYNDmjDhdF6gENn86/cIK1ZWxkjY=;
	h=Subject:To:Cc:From:Date:From;
	b=fF4LvrkWg1XfcI1SE0pMRqoYNvYe9R3YDqgjmsVExJ9Urae/gVGqKol9r+n3F2U5H
	 LQGJOf875h4Z33Xr6oS/bYfWO0UG8EjoJbMvD2M/9a3stYkNKOHsLDS00o6p7GFqwa
	 BlmjrsKcbgZ/JD1fpPYnkDOCx4s2bpexo5KUlNx0=
Subject: FAILED: patch "[PATCH] drm/vc4: Stop the active perfmon before being destroyed" failed to apply to 4.19-stable tree
To: mcanal@igalia.com,bbrezillon@kernel.org,jasuarez@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 14:04:31 +0200
Message-ID: <2024101431-able-caress-7fe5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 0b2ad4f6f2bec74a5287d96cb2325a5e11706f22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101431-able-caress-7fe5@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


