Return-Path: <stable+bounces-58380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E1792B6BB
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03401F24201
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A0A15821A;
	Tue,  9 Jul 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vims8eiV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5813A25F;
	Tue,  9 Jul 2024 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523760; cv=none; b=ek7OCzUsVL5S4p8VTCXhtLdgulKrA6mt33WJrtdoMnMq4OyWaIFkcPslldTV6zMWsjD0O4C+B5nt5LLABfwxJcszXROZTcbhYdhOQ6u/nHdHIsqxYnyw6RdQWwK2claxySMNMTBANsBpU38g/QOgHGRkjnNpC5w8hCiBAqTF5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523760; c=relaxed/simple;
	bh=ZZl/Cv3fGzAXEfdLRRTjQ/u4jr23Urz5vme2WR/zcec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHasBZdIZcX6alFPvWXc6weC9yjwybRRy8MBXXdYXpO9GYwAA5wN0gtMVHNDoFZ8F51EcquR6yfFUbfSvVIfLprmFjXQEI11VYyeQhHDx3x6xJF8SorIDJJUGg9GGNE+FyMBTYfUN1HySJZ5t4yGy11wu/s6DdBI+Rk7Hrw0koU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vims8eiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08160C3277B;
	Tue,  9 Jul 2024 11:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720523760;
	bh=ZZl/Cv3fGzAXEfdLRRTjQ/u4jr23Urz5vme2WR/zcec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vims8eiVvcmCIh03N3/8LmUl5s1nsLqt0gPvbdRbyorcRTZPCMV+Y+IZnApYVfzjJ
	 nwH0+SjADhuJLgQGxdaTZrMS4Ke3jyqW7XEbqroFuiOXIntfOmiSFh0qmY+fvJ9vKY
	 NBfKz4Jh4rviEfp0E9ujeAmfDTRWEKbKrYDAIlZs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.6 099/139] can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct
Date: Tue,  9 Jul 2024 13:09:59 +0200
Message-ID: <20240709110702.006208286@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110658.146853929@linuxfoundation.org>
References: <20240709110658.146853929@linuxfoundation.org>
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

From: Jimmy Assarsson <extja@kvaser.com>

commit 19d5b2698c35b2132a355c67b4d429053804f8cc upstream.

Explicitly set the 'family' driver_info struct member for leafimx.
Previously, the correct operation relied on KVASER_LEAF being the first
defined value in enum kvaser_usb_leaf_family.

Fixes: e6c80e601053 ("can: kvaser_usb: kvaser_usb_leaf: fix CAN clock frequency regression")
Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
Link: https://lore.kernel.org/all/20240628194529.312968-1-extja@kvaser.com
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -124,6 +124,7 @@ static const struct kvaser_usb_driver_in
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
 	.quirks = 0,
+	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 



