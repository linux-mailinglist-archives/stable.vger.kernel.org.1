Return-Path: <stable+bounces-83803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 362A699C9C1
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 14:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A511F22A94
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5702219E971;
	Mon, 14 Oct 2024 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X1sz62YT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946519E7D1
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907897; cv=none; b=d+JED/ZULBCzsJp4K0I+dK844kWqbkrD4ErYXQjwP8ycONmjfvM6xkmkgeOCVWlmp/fls0w6Qw96x3rhm5iCFu+jPqlAWZ3YTE4S9hAt2vyQ+PCLIftXGtgozRgpqjHrIDKvpot/SYX4rD7YxX3a4Ij0ygtNSlH2sowoR54uLcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907897; c=relaxed/simple;
	bh=4uoUxZcw63w2+HvE13iWPpwQ0ICiqAuZPdhjtEY2/5U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uwhcZNqfDWY6HvTbWAMxoAMBPySdyS9+O91w/8/TDNzZ6IFNrbyqJgz1dFcZPm1Qwm4RXxghUV4uAQhKaXYSzF82SJoBXqZquGHlWk96TgwL8woW2DX6MbxRspTr0YANAkhrCxUlNNcGv/UqEcce50L5wxlkaEslDtvh/Ng9Ans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X1sz62YT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEADC4CEC3;
	Mon, 14 Oct 2024 12:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728907896;
	bh=4uoUxZcw63w2+HvE13iWPpwQ0ICiqAuZPdhjtEY2/5U=;
	h=Subject:To:Cc:From:Date:From;
	b=X1sz62YTnxB9yj81gFhPqdahFrJbIuGFP6x13/nBzzIqSiPETVwrOGa9ozROqPY2s
	 eDVmDA1e9bQsRRoi1gAkqVo1sUuYJAtgoKyARsxkY9+Y0CFMZY14mDFnYcVTMn5pV4
	 tlNkQYPIPKzPqXngnSihOzpkPevKjIGXA/DlCcDs=
Subject: FAILED: patch "[PATCH] drm/vc4: Stop the active perfmon before being destroyed" failed to apply to 5.15-stable tree
To: mcanal@igalia.com,bbrezillon@kernel.org,jasuarez@igalia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 14 Oct 2024 14:11:25 +0200
Message-ID: <2024101425-pug-throwback-22c7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0b2ad4f6f2bec74a5287d96cb2325a5e11706f22
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024101425-pug-throwback-22c7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


