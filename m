Return-Path: <stable+bounces-198028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2147C99CA2
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 02:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12653A521F
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 01:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBF7191F91;
	Tue,  2 Dec 2025 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOCL4F1C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A39117DFE7
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639835; cv=none; b=pyqad7lWD4C/awOr0PuD4SwCpKvtLuy1TqRWc4OrEX2dbQ/JrVI5Cz+NI1TCBIOQCHIE6vFSpRC2mbQEv6r4wvvQgvn256apxmCdgPASZOEfK1ZMFbjKOVMsNpl5y9xbn8u/mui3s05NDNmGPWsAluGEBNuysl3ZopscuNMHDLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639835; c=relaxed/simple;
	bh=J7/HyJYfd3EBCJQEhfxprc4HH1CP7UuxNxUaTiVt89M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeyECIyIB4MfyEw4m5wrLKbxaacZvf5gcyIn7uxfO9/p0Y6RfYmmW+Po033wOvDkUFEyynaJJMiddtIsBU6dPISGcrIw4skXW4vd5+8BRiFOz9myXfbwh5NYch1ljs0Wk2jXSPwmltvgI5Y/u6xAyWiCPighl33ymFYy6fxB4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOCL4F1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1307CC4CEF1;
	Tue,  2 Dec 2025 01:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764639834;
	bh=J7/HyJYfd3EBCJQEhfxprc4HH1CP7UuxNxUaTiVt89M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nOCL4F1C5u3A1YQ7bDi4+lTqObDj1QSMuaUbFlMbpsVE4mbh2SC2nUr0aPIEkIDdx
	 hKNcYUJUPqvNW9Y0z5b6iPP3ig8HPu7GBVIsfarC1R+wQLNbOxjTMo0nu7RPwchqn4
	 XksO9itP7Wq99OPDEEup4YS6yF0dM4h/OoU8xgEOIKq2P0027L3H7wuj6zYVJ4PgcP
	 yuXh+XpPn3T24qON8s9jA9mXdby6G2t76peH/PrSQApJY2m0ZnXSXz93cbxdlkkAb4
	 RxsXBqdMcj8UDxG7OFirTqupCn+t8XCwzi9N3hDaIC9jAOFRTUciiePe+2PcT2kiUJ
	 phM6quwycBMKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] usb: udc: Add trace event for usb_gadget_set_state
Date: Mon,  1 Dec 2025 20:43:44 -0500
Message-ID: <20251202014345.1598525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120120-whooping-whole-a5b2@gregkh>
References: <2025120120-whooping-whole-a5b2@gregkh>
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


