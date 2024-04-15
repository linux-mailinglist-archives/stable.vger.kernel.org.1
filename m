Return-Path: <stable+bounces-39817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8C28A54E3
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FE51F21A36
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BB81ACA;
	Mon, 15 Apr 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sJaPmknc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7E81ABF;
	Mon, 15 Apr 2024 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191902; cv=none; b=G9mMh+6FyRyPIDIo5NfZBJHkK2rgBqCvCQT3YbJWdQBd6mJDw5Z5TIDzmfbj353VyC2ObJq9aMeSESC7CN+CT1yU3ueqVlMLQhJuO6frtaVIqIdblT+EQM61CL9olI5LdA/2EZn5G7lvgOgGpsq7MR1Jd4VrH9qV230RqqGTnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191902; c=relaxed/simple;
	bh=dHE5tQOJqqL+geyvbVN4ffA6yx6Pg8KEg/9YwchZxNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gs+LfmXWxw7xjarcKSdffXUO1Pt4vBIXNp/6Cn4LMehu5UjHS7mIWYLolpWXowlbTY8KteXnsNXTuy4xXK3+LEcWajpREdceSPfaVNDm4Gr2AktoXdZiuFO2WVZzgx5d8hn6qTD1dju5QSo9Y66Kr4zcr8IVc6iQXIz0UXNYhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sJaPmknc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FC0C113CC;
	Mon, 15 Apr 2024 14:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191902;
	bh=dHE5tQOJqqL+geyvbVN4ffA6yx6Pg8KEg/9YwchZxNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJaPmknc01vroUXE29HZdN90IOQ8aILc83eduop+Xzyb27SykGY3/bmRbON2munUS
	 tYDa5MHOTmVhCSTT2pATs3ByCwQPsY4Bzfz9mr+JIfPtNG6eHQg4+KxQtOxBdyZia7
	 WvefWggtCQiJ1FS12RCeNemo963wkTQH2eGwKess=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: [PATCH 6.6 087/122] accel/ivpu: Fix deadlock in context_xa
Date: Mon, 15 Apr 2024 16:20:52 +0200
Message-ID: <20240415141955.986106993@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
References: <20240415141953.365222063@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

commit fd7726e75968b27fe98534ccbf47ccd6fef686f3 upstream.

ivpu_device->context_xa is locked both in kernel thread and IRQ context.
It requires XA_FLAGS_LOCK_IRQ flag to be passed during initialization
otherwise the lock could be acquired from a thread and interrupted by
an IRQ that locks it for the second time causing the deadlock.

This deadlock was reported by lockdep and observed in internal tests.

Fixes: 35b137630f08 ("accel/ivpu: Introduce a new DRM driver for Intel VPU")
Cc: <stable@vger.kernel.org> # v6.3+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240402104929.941186-9-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/accel/ivpu/ivpu_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -517,7 +517,7 @@ static int ivpu_dev_init(struct ivpu_dev
 	vdev->context_xa_limit.min = IVPU_USER_CONTEXT_MIN_SSID;
 	vdev->context_xa_limit.max = IVPU_USER_CONTEXT_MAX_SSID;
 	atomic64_set(&vdev->unique_id_counter, 0);
-	xa_init_flags(&vdev->context_xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&vdev->context_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	xa_init_flags(&vdev->submitted_jobs_xa, XA_FLAGS_ALLOC1);
 	lockdep_set_class(&vdev->submitted_jobs_xa.xa_lock, &submitted_jobs_xa_lock_class_key);
 



