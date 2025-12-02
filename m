Return-Path: <stable+bounces-198031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 161ECC99CD8
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 02:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C10343461D2
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 01:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C8B1E9B3D;
	Tue,  2 Dec 2025 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0QcsYw8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6094A1DF24F
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640333; cv=none; b=Zh6bNSicnoRJwVIjeWVl2tub/PMxgGTOvPYxLJqFdXzZZihHW6q04UNKSV9DquXsoU6TY2L7D+o0QXTZG9Z56OD1DXoaB4khAeVfczXxwKx0YUdp7JbOt+hsFn/b78zYKmxJf62Qlbbb2Qz9bkSZnYy8sb6ZJpF2986pDNNjGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640333; c=relaxed/simple;
	bh=J7/HyJYfd3EBCJQEhfxprc4HH1CP7UuxNxUaTiVt89M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBR1LJxrRKhEGJiZL6J1nVaev5qrQBR5FnFRO2a4HKVeG+l4vCEf65GjbonBSPzMXkcUGF6EW1smA4iNLrxJ/RCouZyHleKQCYpiOVvb4RDLuTPUWYnMqgeqWJWsNqcyNN7kxmtYdGlxVQFoFGMGa7+aYitYr5zwXAe4JsRe2bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0QcsYw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A949C4CEF1;
	Tue,  2 Dec 2025 01:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764640332;
	bh=J7/HyJYfd3EBCJQEhfxprc4HH1CP7UuxNxUaTiVt89M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G0QcsYw8FVyBhCluIAt2UrPxFujRzRLqgMxmxRoFRMJQbUthuTte5Oj8+pqpeBIZn
	 q3Y6vXT/LPwNb0zBdHAwm6AHSMCn/jip7MsyaHOp1EHErZmXRmIhQMwtZllCj86XNX
	 svElsI5Q6Tux4+nxOByKALQeba0pvJzPf/xvdcOzDXe2RdPutW7z83mMmGJJcXT04h
	 SuN718z0ZmWI78UfJbjMyCx9D2tgBTmAZXDiQimt9RaQJzcywjJAX0xMUP5ZX96qGZ
	 yZeROmrliLLSp8s9KXrv2Bmu8JWBoOVQL90MVcHr1/eiV/nu8YpMrr+d2wA4G8FIm+
	 yle+vl+pKpoZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] usb: udc: Add trace event for usb_gadget_set_state
Date: Mon,  1 Dec 2025 20:52:08 -0500
Message-ID: <20251202015209.1607256-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120121-sift-shiny-dd51@gregkh>
References: <2025120121-sift-shiny-dd51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuen-Han Tsai <khtsai@google.com>

[ Upstream commit 7bf1158514e410310aec975e630cec99d4e4092f ]

While the userspace program can be notified of gadget state changes,
timing issue can lead to missed transitions when reading the state
value.

Introduce a trace event for usb_gadget_set_state to reliably track state
transitions.

Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
Link: https://lore.kernel.org/r/20250818082722.2952867-1-khtsai@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: baeb66fbd420 ("usb: gadget: udc: fix use-after-free in usb_gadget_state_work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/core.c  | 1 +
 drivers/usb/gadget/udc/trace.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index e3d63b8fa0f4c..694653761c44c 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1128,6 +1128,7 @@ void usb_gadget_set_state(struct usb_gadget *gadget,
 {
 	gadget->state = state;
 	schedule_work(&gadget->work);
+	trace_usb_gadget_set_state(gadget, 0);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index 4e334298b0e8a..fa3e6ddf0a128 100644
--- a/drivers/usb/gadget/udc/trace.h
+++ b/drivers/usb/gadget/udc/trace.h
@@ -81,6 +81,11 @@ DECLARE_EVENT_CLASS(udc_log_gadget,
 		__entry->ret)
 );
 
+DEFINE_EVENT(udc_log_gadget, usb_gadget_set_state,
+	TP_PROTO(struct usb_gadget *g, int ret),
+	TP_ARGS(g, ret)
+);
+
 DEFINE_EVENT(udc_log_gadget, usb_gadget_frame_number,
 	TP_PROTO(struct usb_gadget *g, int ret),
 	TP_ARGS(g, ret)
-- 
2.51.0


