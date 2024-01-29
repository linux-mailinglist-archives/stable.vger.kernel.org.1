Return-Path: <stable+bounces-17263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC1B84107A
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADA828637B
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C91076032;
	Mon, 29 Jan 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0+e2t2a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA3876051;
	Mon, 29 Jan 2024 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548630; cv=none; b=diXLe86oZEjVEDtVrVql14FABRrl163d6McLpgEHJWTEQ/3nmLMlwFxlIgtcOzyDf+5ozeCX09Y3+wbF7iZFJfU7wI1M01Krb2DS/H0rBgrA2yr4o3kD8U9qjMvCgqulZlPJ7+zUXrF6gEsTGRy3fLD3bHE1n1AqkRmY2ThkDEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548630; c=relaxed/simple;
	bh=4WMZx4Xgusrynob61z4/KwXqBk3HqWdu5gCBy8hRnKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFbygDW/ZEPiOMsp2m/m8ky6paeAFyT4VkKRCf9ESKKZMr353M9vb7aKE3swq45uEohpYe4coFjHtbiVRwXcsM2GPUk0bcXtL/dkIGPf672efVmKJ5lageVXV6h1cwcaUkYNRL5q5weLjOFp7twoR6WS7BEs5H91We4BzmapzC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0+e2t2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF6FC43390;
	Mon, 29 Jan 2024 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548630;
	bh=4WMZx4Xgusrynob61z4/KwXqBk3HqWdu5gCBy8hRnKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0+e2t2aK8Fm964J+5MuzHt4LrzprHhe55F9Mbz9cRONfRJKrSXKJvEy424x+5DbW
	 mLuzrjjp9M5zDZJZYviykinnOFUPGPJnWMs9qpV/meiT9T0vFCP0HANt9eMLis+yaf
	 RjbL6zJz8i772zQgtu9UH2Vr0B26DZy2RmFal62s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 279/331] media: v4l: cci: Include linux/bits.h
Date: Mon, 29 Jan 2024 09:05:43 -0800
Message-ID: <20240129170023.025579027@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit eba5058633b4d11e2a4d65eae9f1fce0b96365d9 ]

linux/bits.h is needed for GENMASK(). Include it.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: d92e7a013ff3 ("media: v4l2-cci: Add support for little-endian encoded registers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/media/v4l2-cci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/media/v4l2-cci.h b/include/media/v4l2-cci.h
index 0f6803e4b17e..f2c2962e936b 100644
--- a/include/media/v4l2-cci.h
+++ b/include/media/v4l2-cci.h
@@ -7,6 +7,7 @@
 #ifndef _V4L2_CCI_H
 #define _V4L2_CCI_H
 
+#include <linux/bits.h>
 #include <linux/types.h>
 
 struct i2c_client;
-- 
2.43.0




