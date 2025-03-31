Return-Path: <stable+bounces-127117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70298A76886
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0367A12DA
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A37217734;
	Mon, 31 Mar 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN1eq0Yt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AB5229B2B;
	Mon, 31 Mar 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431808; cv=none; b=gg+yLmdO2Ae585ug4d4BT+I/9th8mRjLotP3skrEg2UKI+8ekCLbLSRHoSxT8lYmLdsLPe/jvqIDw+gabyQ9jqk30undQ2M7y9lPdWegMH7O4of7bLxfU8TTQIG9gHM2htBlpypzsAHUaSDzeVl9pMGUx8lJcwpZ0HCpX4BR11U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431808; c=relaxed/simple;
	bh=xaEMZxbQp1Qr9ivAjB59KF4a/0OwWMSbOUS1BmmeD7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NKdKxDJsENGnJLkYEmzULb4kXYl6EKnDfPfyC07ZdycESZiUKZ3KJ81ja9kFGY76wE6eRfit8QoJcJO3XP8yxNVppUAUWFASkNBNrEoBX9ccb1A7z6tXTcUqVU2yHsbBVVcgMmwTJuJGJdCvhXtBrb3myW44VEEwHcsfFjXm1Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN1eq0Yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D72C4CEEE;
	Mon, 31 Mar 2025 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431808;
	bh=xaEMZxbQp1Qr9ivAjB59KF4a/0OwWMSbOUS1BmmeD7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eN1eq0YtD4BVRafaWoALnEDXnSwnTuH7VOLwWEq/b4QMqGVUQNp48de4M0d4s/5Xb
	 EzSeGLaNg0fEdSTB8xE2rldw9pzhUcYVAyq7Y7RRiug4SBU5+lJ2qYOb4NLCUeV6e6
	 2DckbF+gqjk47QZYDAeHo2mQeG5NUH8UI1pMV3UG96FYRom0EvsN7dfBw4eNh9syFb
	 cjVBMfuYP8Itt0GQd2mdU69TprsqI+xtQLXS7vrwPGxnvUqTDG4wx66sjkG7AHtfZg
	 incyNnNjWco0DVUQMYl1OYqbvqZP0Y216SF+zqx9BDC1PrJThHLyOItk2g7lWo1xdC
	 Aps8Cd/NJeO9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 5/6] xen/mcelog: Add __nonstring annotations for unterminated strings
Date: Mon, 31 Mar 2025 10:36:31 -0400
Message-Id: <20250331143634.1686409-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143634.1686409-1-sashal@kernel.org>
References: <20250331143634.1686409-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 1c3dfc7c6b0f551fdca3f7c1f1e4c73be8adb17d ]

When a character array without a terminating NUL character has a static
initializer, GCC 15's -Wunterminated-string-initialization will only
warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
with __nonstring to and correctly identify the char array as "not a C
string" and thereby eliminate the warning.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=117178 [1]
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Kees Cook <kees@kernel.org>
Acked-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250310222234.work.473-kees@kernel.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/xen/interface/xen-mca.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/xen/interface/xen-mca.h b/include/xen/interface/xen-mca.h
index 464aa6b3a5f92..1c9afbe8cc260 100644
--- a/include/xen/interface/xen-mca.h
+++ b/include/xen/interface/xen-mca.h
@@ -372,7 +372,7 @@ struct xen_mce {
 #define XEN_MCE_LOG_LEN 32
 
 struct xen_mce_log {
-	char signature[12]; /* "MACHINECHECK" */
+	char signature[12] __nonstring; /* "MACHINECHECK" */
 	unsigned len;	    /* = XEN_MCE_LOG_LEN */
 	unsigned next;
 	unsigned flags;
-- 
2.39.5


