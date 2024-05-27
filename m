Return-Path: <stable+bounces-47283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E188D0D5D
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4042814EB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C921607AB;
	Mon, 27 May 2024 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NcGp8YgN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A687415FCFC;
	Mon, 27 May 2024 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716838142; cv=none; b=GfzTunjmhpQmt1PHW5D0KWsodc0m+/ZbtJP58OYXYDwyxvvLruwjOCLGMU2dYla2MCp9PtYjAFl8LvPAdX++N3dxNM0YYV3/Su4F3pGNCHMZCaOk2mRGtw+brKbGmPUs4/v6UZHZV0C8/vrJjch1gTX/cOBRMoGQXm1TMbUALE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716838142; c=relaxed/simple;
	bh=9vl1yng7QTDO8rlLVxX/A3kYJnr8egxe6brGZPT+Pes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwgGs/DXsjWoLwOox1n0bof0vSpEIFcZHPlpmhp7VO+gb50gGppOy8BTIB+M2mIym9olHaXUOrm6KOy8PiABYO+FyXeMO1sgPD3TlWZ0eBn5tOtQlPdo7ZSnQq8pge/5HKDRL0zj2GRUvpULGcPA0WiPhTI7eH6sdwLuxsp+3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NcGp8YgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D18C2BBFC;
	Mon, 27 May 2024 19:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716838142;
	bh=9vl1yng7QTDO8rlLVxX/A3kYJnr8egxe6brGZPT+Pes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NcGp8YgNz+zlJ1afGHBLha7258q3gVfMcHWepmt+ShWuql3N7Vki4cShri/MLaxKY
	 ezrDWIdM4otsPRI4SyBcIKfpIe9js0RbM5WI7l9oOg5qWXW/MRhyXTO0YLWb0RV9UI
	 OMypCLjFff0EPGOWgZrD/cOsxbwjrwECdINxVRoM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wander Lairson Costa <wander@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 282/493] kunit: unregister the device on error
Date: Mon, 27 May 2024 20:54:44 +0200
Message-ID: <20240527185639.531371911@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185626.546110716@linuxfoundation.org>
References: <20240527185626.546110716@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wander Lairson Costa <wander@redhat.com>

[ Upstream commit fabd480b721eb30aa4e2c89507b53933069f9f6e ]

kunit_init_device() should unregister the device on bus register error,
but mistakenly it tries to unregister the bus.

Unregister the device instead of the bus.

Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Fixes: d03c720e03bd ("kunit: Add APIs for managing devices")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/device.c b/lib/kunit/device.c
index 9ea399049749e..3a31fe9ed6fc5 100644
--- a/lib/kunit/device.c
+++ b/lib/kunit/device.c
@@ -51,7 +51,7 @@ int kunit_bus_init(void)
 
 	error = bus_register(&kunit_bus_type);
 	if (error)
-		bus_unregister(&kunit_bus_type);
+		root_device_unregister(kunit_bus_device);
 	return error;
 }
 
-- 
2.43.0




