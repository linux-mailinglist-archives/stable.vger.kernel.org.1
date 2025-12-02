Return-Path: <stable+bounces-198035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B283FC99D3E
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 03:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C80E54E23D7
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38121205E26;
	Tue,  2 Dec 2025 02:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgOExArU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96601A0BD6
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764641108; cv=none; b=OSwWZot1DxnPZ6jZnyjrmKYlEUT1qQePnn7KvWDEsW9+zo0v1ME35aTohKdNOZ0+NxsvVETOZ6WvMDIG5wUkZQG6Xh2EAlT+mCIUtOwaZzKanGZlX72Q0LNNtux/q8icf1Kyy1qF+jhirCQSzivOpoEmhN6tcodR8ELZOoUpwmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764641108; c=relaxed/simple;
	bh=ZkcrwJ4Tsa2ffUYK9xZS5Ye4ueaqQMKzrpmbAtpk1Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2dfcztVrcRLwNbV0Ber3y2h2yem2ak778sut5u7sDp62i7+Oavuwjw4ntcOqBiqoRkEMcLB21Iwi8eSFGTSB6R1kUGxXLVvmpGkXKK1cXAc55oCsMzSKOyV6HL4I3OVjahUTrZdZ4XeX3Fj5AGSOzsxRMvCoZJwfJy/UJrjIhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgOExArU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C069C4CEF1;
	Tue,  2 Dec 2025 02:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764641108;
	bh=ZkcrwJ4Tsa2ffUYK9xZS5Ye4ueaqQMKzrpmbAtpk1Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgOExArU7+8Q4RJhsFySYjmfriPIVjCHMJm4EZh4ksub1YMFh8ApJSSRoRq+mpwnO
	 E2GnnGv1wTJNrxQCjQgXHynGAC8etQTuKw+dnSXaNuhFtLPsWKUfTkfp1UqWzebWnm
	 uvzy8A7NEPMJ7M2BEaJDYB20MzJkTZgQZc7Huk5KfjXfFlfGgJOEJi1RjqEViA8jWk
	 fyOo/FCl5uqWq5Kom2pCEE/Znsx2YctWrj2hF2UvHPeE+/dU40BO69gQvYuTJW/olN
	 ZpdCqDj/4RPx2mUOnmB61VDGaQp2y2kFKsB8pZn59W0Nb208UkQtL4V1J2npBiCBly
	 f8aIEL45OWJ8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] usb: udc: Add trace event for usb_gadget_set_state
Date: Mon,  1 Dec 2025 21:05:04 -0500
Message-ID: <20251202020505.1616609-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120122-submitter-flame-5478@gregkh>
References: <2025120122-submitter-flame-5478@gregkh>
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
index d98da3c44ff5e..37f83606477fc 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1123,6 +1123,7 @@ void usb_gadget_set_state(struct usb_gadget *gadget,
 {
 	gadget->state = state;
 	schedule_work(&gadget->work);
+	trace_usb_gadget_set_state(gadget, 0);
 }
 EXPORT_SYMBOL_GPL(usb_gadget_set_state);
 
diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
index a5ed26fbc2dad..661158d3a39cd 100644
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


