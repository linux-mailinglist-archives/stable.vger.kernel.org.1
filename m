Return-Path: <stable+bounces-59526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A643A932A8D
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 616122835A8
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A331DDCE;
	Tue, 16 Jul 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="idhRoRKw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D6CA40;
	Tue, 16 Jul 2024 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144115; cv=none; b=bTs4Z5MzplUUM1GojTqQZ+HHW/vpp9zQD6cCpvccAXYp6FgDYgNCwIo/PysbKcUlEStao3F9N1fSr8cHjedJ/RFbNzaKJSRDQGpEibz0zEMImlJGmHtbyji+N5OICDVdd0DQQ2mi8mtByiJQIgtG9t5UHLjdHNK5Ey1f2c8Pxco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144115; c=relaxed/simple;
	bh=jq6qnmLq8xvCZqtO6nhl7H+fWp1zl0pGhnVyo7oWi3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjEO7Gu6zN0DK1LRozgPYOVhfhcKwOo06VcwqKh+EHXjk1wPJZ3EnPZ/TdwoRL0DgnMuWG2ZFGaStHlJuobqNIbE0lI1VkPxE9JzcN1g7hQcdVbJSmQrhE1yuJIzKMoDznVaT8eaek/sB/OU7gjak7PyhusSxXXKXDPVpHAXgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=idhRoRKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427A8C116B1;
	Tue, 16 Jul 2024 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144115;
	bh=jq6qnmLq8xvCZqtO6nhl7H+fWp1zl0pGhnVyo7oWi3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idhRoRKwcBuHWuWQCRtMdLmyTpraRA5T0UMTU+5vjKhLMopPVFUjpFcnTooaqUWoC
	 oyCm2dP/YmfRbYfaE7YUzaIObez1UmqoO+Jw5H2dwwRSVC9YNCNB+M5hMCxtJBbOFq
	 2DycK+KtKcqDRBdzq7LB4T3mahs/DMY+kH2lddKs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jimmy Assarsson <extja@kvaser.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.19 33/66] can: kvaser_usb: Explicitly initialize family in leafimx driver_info struct
Date: Tue, 16 Jul 2024 17:31:08 +0200
Message-ID: <20240716152739.432485753@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
References: <20240716152738.161055634@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -114,6 +114,7 @@ static const struct kvaser_usb_driver_in
 
 static const struct kvaser_usb_driver_info kvaser_usb_driver_info_leafimx = {
 	.quirks = 0,
+	.family = KVASER_LEAF,
 	.ops = &kvaser_usb_leaf_dev_ops,
 };
 



