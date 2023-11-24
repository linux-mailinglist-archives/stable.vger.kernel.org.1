Return-Path: <stable+bounces-1537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 787E67F802E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32359282552
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A2B364DE;
	Fri, 24 Nov 2023 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HBbSZ0Ra"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E7364AE;
	Fri, 24 Nov 2023 18:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023B6C433C8;
	Fri, 24 Nov 2023 18:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851648;
	bh=40JAoaQ/9WklF0VIPLHHMvVzw5xTn+GEjsNdw81Y11U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBbSZ0RaouqhDMMpNmgZwr2Jvlvxh0c9f1sWYbVr1RCoQOioogQSqFYklUL3khO95
	 DSgKSAK3yOQAoyEqeLVLzQ64rpkAFwJ/OZXpHfZmq4WfLGiT/dRe2xqJBFdEA82RtR
	 +o5AREYyIXZupiaWWiBhQ+ZVbIYacAhIlr/JyuXg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Airlie <airlied@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Zack Rusin <zackr@vmware.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 040/372] drm_lease.c: copy user-array safely
Date: Fri, 24 Nov 2023 17:47:07 +0000
Message-ID: <20231124172011.822005241@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit f37d63e219c39199a59b8b8a211412ff27192830 ]

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-6-pstanner@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_lease.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index d72c2fac0ff1a..b7362356e5448 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -507,8 +507,8 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 	/* Handle leased objects, if any */
 	idr_init(&leases);
 	if (object_count != 0) {
-		object_ids = memdup_user(u64_to_user_ptr(cl->object_ids),
-					 array_size(object_count, sizeof(__u32)));
+		object_ids = memdup_array_user(u64_to_user_ptr(cl->object_ids),
+					       object_count, sizeof(__u32));
 		if (IS_ERR(object_ids)) {
 			ret = PTR_ERR(object_ids);
 			idr_destroy(&leases);
-- 
2.42.0




