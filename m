Return-Path: <stable+bounces-30794-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 025D1888C69
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 05:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0277028EE1F
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 04:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7842E5392;
	Mon, 25 Mar 2024 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPBfR0bx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED09317C18E;
	Sun, 24 Mar 2024 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323759; cv=none; b=e91Hq+FYrbAgUtH0Ktzwd68ACcdNgz4wSvPlWJb/B2hj/AbhmT4u5Qfa4XmZ9XXOv1jxtPj62xW/1TOR9hfjfEziqt0Na0wv5h9IuY3Sg+AAj5eJFD7Ragyq2R2BiAEB+f5bEQjCH8LK/Au7e0ZqQdqzimmFNPwa+HEq4CObcIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323759; c=relaxed/simple;
	bh=MVy30skJmr/gnrE3NXzsrkaw9rfY27uWDHKUBovWHjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FsfOsWfeFW8dYPn3HI7eSiRfLDZNe5wHpIOSZ1UFQoO1SciNtIt258/rsY/I+UN8FqQWBq2QTaFu/xm/h2522imKsYQj+FwlBlRhi8hm8Wg2ED0DNPZWoLd9PFX4XyNNDzOkA1otRfwyZx3+RKP2oCMb99P4s7KKVzTbRk5Fy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPBfR0bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B8BC433A6;
	Sun, 24 Mar 2024 23:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323757;
	bh=MVy30skJmr/gnrE3NXzsrkaw9rfY27uWDHKUBovWHjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPBfR0bxtw9yjR0nJeqRIatwE4je79zUOEufcped2TQorl0ugAZoSyt221j7grr0/
	 umGLwdBT9wdT64jfLlvd2Ns3D4keZc1uB+qHR46tHCvClYb7Xh7njO0a8vs5dTKlCa
	 nC65ZVAPI8J8iCrx99gBjNx1w88CeCT/e3l7UnraFThHv6MG8R477OpQd+4eoG5Xni
	 TQRRACkD+5AuyVhrQk1GuGMZQUdHtWgU5AWEqMeuv9LBn9FuGrYVxwLD8iSOrpp2js
	 ey8IQvgBBM8ObE/xuj/n4zr2N9YiJihlLOgczAVshAWmuFDbJdV9LarM/rh9L49bX2
	 PkcZGqXwFHctw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 132/238] media: em28xx: annotate unchecked call to media_device_register()
Date: Sun, 24 Mar 2024 19:38:40 -0400
Message-ID: <20240324234027.1354210-133-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit fd61d77a3d28444b2635f0c8b5a2ecd6a4d94026 ]

Static analyzers generate alerts for an unchecked call to
`media_device_register()`. However, in this case, the device will work
reliably without the media controller API.

Add a comment above the call to prevent future unnecessary changes.

Suggested-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Fixes: 37ecc7b1278f ("[media] em28xx: add media controller support")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/usb/em28xx/em28xx-cards.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/em28xx/em28xx-cards.c b/drivers/media/usb/em28xx/em28xx-cards.c
index 26408a972b443..5deee83132c62 100644
--- a/drivers/media/usb/em28xx/em28xx-cards.c
+++ b/drivers/media/usb/em28xx/em28xx-cards.c
@@ -4049,6 +4049,10 @@ static int em28xx_usb_probe(struct usb_interface *intf,
 	 * topology will likely change after the load of the em28xx subdrivers.
 	 */
 #ifdef CONFIG_MEDIA_CONTROLLER
+	/*
+	 * No need to check the return value, the device will still be
+	 * usable without media controller API.
+	 */
 	retval = media_device_register(dev->media_dev);
 #endif
 
-- 
2.43.0


