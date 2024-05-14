Return-Path: <stable+bounces-44038-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8838C50E8
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8189A1F21F0F
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FF512A146;
	Tue, 14 May 2024 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="POwtyyP3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550D129E9C;
	Tue, 14 May 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683834; cv=none; b=H1hAeLztLoafArzRbhKe9+diYh+8UlM8x/frd6BCv6oYBgMSM0XuY+uxPv/rGg852hb7TEavTogjMPMuSmFwA+gvutlMWNSMwVzvagO7xodmRbyDH9j5txJq4UdcVxfViNpSS/CVILLhTHNt9QiQdcJiheThFg1aOx+ryBGsFtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683834; c=relaxed/simple;
	bh=YlLufRgaZmQxsB4tD9ry8yFUg9zIRCAcV0/duxZdbAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2WabLTSZx0Rfz0W2FspTaC4i6tkqh5/H23TXv9eg2+AnXtz/RdcfWueUAOP6Ovg0iy3bcj16crP8XA+GitBMktIguaAHzDlkuxtB0QozhiIJjG3NmEjo+0u3vleVgZV2GuWxvS9VRYhDVf39AkjB0aSiC3SZWji8BMpETIyU3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=POwtyyP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52779C2BD10;
	Tue, 14 May 2024 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683833;
	bh=YlLufRgaZmQxsB4tD9ry8yFUg9zIRCAcV0/duxZdbAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=POwtyyP3xgegzOhOU40ky8nAT3QkX0p4Tc1EHY+E/GmIQVc/mC4q/MNF9KO7jmMLs
	 2Rhcf9zqsDXH0DNLycbI+UmsJR1UYoq1+/PVwR/QBE2Izdrsl5N++JBtizP+wFNXy9
	 mRGSUJN5Qd8XVRYWdP7J+Tpp+Np8vR6jx7B1vsSc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Avdeev <me@provod.works>
Subject: [PATCH 6.8 251/336] usb: gadget: uvc: use correct buffer size when parsing configfs lists
Date: Tue, 14 May 2024 12:17:35 +0200
Message-ID: <20240514101048.094192843@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

From: Ivan Avdeev <me@provod.works>

commit 650ae71c80749fc7cb8858c8049f532eaec64410 upstream.

This commit fixes uvc gadget support on 32-bit platforms.

Commit 0df28607c5cb ("usb: gadget: uvc: Generalise helper functions for
reuse") introduced a helper function __uvcg_iter_item_entries() to aid
with parsing lists of items on configfs attributes stores. This function
is a generalization of another very similar function, which used a
stack-allocated temporary buffer of fixed size for each item in the list
and used the sizeof() operator to check for potential buffer overruns.
The new function was changed to allocate the now variably sized temp
buffer on heap, but wasn't properly updated to also check for max buffer
size using the computed size instead of sizeof() operator.

As a result, the maximum item size was 7 (plus null terminator) on
64-bit platforms, and 3 on 32-bit ones. While 7 is accidentally just
barely enough, 3 is definitely too small for some of UVC configfs
attributes. For example, dwFrameInteval, specified in 100ns units,
usually has 6-digit item values, e.g. 166666 for 60fps.

Cc: stable@vger.kernel.org
Fixes: 0df28607c5cb ("usb: gadget: uvc: Generalise helper functions for reuse")
Signed-off-by: Ivan Avdeev <me@provod.works>
Link: https://lore.kernel.org/r/20240413150124.1062026-1-me@provod.works
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/uvc_configfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -92,10 +92,10 @@ static int __uvcg_iter_item_entries(cons
 
 	while (pg - page < len) {
 		i = 0;
-		while (i < sizeof(buf) && (pg - page < len) &&
+		while (i < bufsize && (pg - page < len) &&
 		       *pg != '\0' && *pg != '\n')
 			buf[i++] = *pg++;
-		if (i == sizeof(buf)) {
+		if (i == bufsize) {
 			ret = -EINVAL;
 			goto out_free_buf;
 		}



