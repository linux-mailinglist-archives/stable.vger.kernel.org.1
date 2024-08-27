Return-Path: <stable+bounces-71115-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5334E9611B3
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80B9B1C237A4
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E751C462B;
	Tue, 27 Aug 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lpX9YhFe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0D1A072D;
	Tue, 27 Aug 2024 15:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772150; cv=none; b=cRI//Z8plzmeAtDI8K6V3WTeogDiWq2/HGuzLryzLjnz697HiXFKIkjEbiiD6GkIAUyUA+r1pTNrsmXa8FqLjQsbBgE/E4J0rYR4QBVNQrVpPKjWJHpD5n/yf2TqKYsWHNpcBF5peNXLXFLMDQUe6vouNaW0yppWlkmF+fW40zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772150; c=relaxed/simple;
	bh=x9JJnD2zAlEK8aQOT/tcxK6WqxRjGCoYt230lBWtMRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=In9tdCMB5TrfTrynp5oZjfbL1UpPbX8enMNdufFzmFXp9EaRn2qHc6jSt/W4b06FtqSN9qYN5MEljVT3puAzl6pR+onSQUz9dV8Vb7A/cOH0T7+zJr4NxkkAjbC79e89T9fIOpgUHwz7MHGrKA0HHrdc5J9UUEbOgApy5u7rg9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lpX9YhFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C794DC61043;
	Tue, 27 Aug 2024 15:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724772150;
	bh=x9JJnD2zAlEK8aQOT/tcxK6WqxRjGCoYt230lBWtMRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lpX9YhFed25tjHwzmvbOU+k3OO0V7MLYE/egV+o2u0MS62fzqsPJ93ybMoMwuB34Y
	 qctgWsyoqJVs8qYG42oV54WSe9d2aW5zuwzEuNC7vvgD6F+dR9nMTS97gNSuyJvepm
	 AiwKNCY8wIcVZelflSd3XX73cxAy/3I3+zf4a/BU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 128/321] usb: gadget: uvc: cleanup request when not in correct state
Date: Tue, 27 Aug 2024 16:37:16 +0200
Message-ID: <20240827143843.117083510@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit 52a39f2cf62bb5430ad1f54cd522dbfdab1d71ba ]

The uvc_video_enable function of the uvc-gadget driver is dequeing and
immediately deallocs all requests on its disable codepath. This is not
save since the dequeue function is async and does not ensure that the
requests are left unlinked in the controller driver.

By adding the ep_free_request into the completion path of the requests
we ensure that the request will be properly deallocated.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Link: https://lore.kernel.org/r/20230911140530.2995138-3-m.grzeschik@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/uvc_video.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index be48d5ab17c7b..95e3611811cd6 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -259,6 +259,12 @@ uvc_video_complete(struct usb_ep *ep, struct usb_request *req)
 	struct uvc_device *uvc = video->uvc;
 	unsigned long flags;
 
+	if (uvc->state == UVC_STATE_CONNECTED) {
+		usb_ep_free_request(video->ep, ureq->req);
+		ureq->req = NULL;
+		return;
+	}
+
 	switch (req->status) {
 	case 0:
 		break;
-- 
2.43.0




