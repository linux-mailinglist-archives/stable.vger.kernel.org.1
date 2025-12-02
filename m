Return-Path: <stable+bounces-198033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 109AAC99CF3
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 02:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC0394E224A
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 01:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84E21EB5F8;
	Tue,  2 Dec 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrNxX75B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569E13C3F2
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640793; cv=none; b=usFrbnpgU67fYkW3nibS8zpVteYhgzn+SShekzI94MnilZ/lNP4FMW2cJwfvK3988Qqp3SP0AQTX9m6ofnpusMIrtWbvLmnz81Kc7zmqK95KgA7dUtzHD4i89e1sIx71rx7S9p0RAaMnD7dmaRDBbxxOVNyw5aQHJJJUdQTOwqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640793; c=relaxed/simple;
	bh=rhJDJZRPjfJr/9W4B7dNuGiat7d8PHHb7yElm7VrhlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0egaEMcFV1JRseRfBnSokmdruagyvmwxmjvXE1Drbbwtx8DFjQuV/4OK4UTQ+qs8GWqIgTgjCbMn77P7UeZTILeZ39RikZQ1Tui9KFuikeBvheMSp0N4G+9gbtn9PuJzzXtNxvusMNlQi+I5dbZrdaYHQZS7r4bJeHzyY7jwgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrNxX75B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1ADC4CEF1;
	Tue,  2 Dec 2025 01:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764640793;
	bh=rhJDJZRPjfJr/9W4B7dNuGiat7d8PHHb7yElm7VrhlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrNxX75BkfObG5f4JH0Fqmh+pXwzVyZwz1NNlngmD0y8e+KRp2h19YQ2m/bgMn0S3
	 D6nWHtdXFhP1VmlI3EGRhZ4RO8o/PICcFKfZDmXJDlT2Fns2Bu7bs5F6mldEpGdV1t
	 Mdd7Uo2oGicEE4KQNWoEBsnjVRAp4s0Tto15aw4fe+8d3WJBn4PaObseka7Ynskpc9
	 C2uiMfAwdm1542rHd6NyaziaIjuBNkSiucd7Fs2jGafS4F3Te9AcCOSrutd2r4J3Pl
	 oaA+1Mx7SuPzzNAz6Rcr6NWT1s3N+zPrZGwQoaeMpyFnHTkE6sOwEIaFnveY+HgKl6
	 dRwtBLxNi+5JQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kuen-Han Tsai <khtsai@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] usb: udc: Add trace event for usb_gadget_set_state
Date: Mon,  1 Dec 2025 20:59:48 -0500
Message-ID: <20251202015949.1613366-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120122-shelter-unlit-af6a@gregkh>
References: <2025120122-shelter-unlit-af6a@gregkh>
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
index 25bbb7a440ce2..a2a760e716ecf 100644
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


