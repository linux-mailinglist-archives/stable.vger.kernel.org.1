Return-Path: <stable+bounces-67315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172494F4DC
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B3E1F214CA
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33953186E36;
	Mon, 12 Aug 2024 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EgNzyq+y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655715C127;
	Mon, 12 Aug 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480527; cv=none; b=HVkFh+pvrL9aYtnd4j/nOOcNGSHiDo4U6j2mMEvLfruLuN8F4rO2WGe7Nc1lj3klmg94L6DIJJxeQmexpFuLaEZzdtL0z4l8ISxdPde+23CY00T2oSlTOhIJtPp+Fj2c+x6Fi518rAyMk6JsxF3U7ftAQK5AzZI5a2W97r8418c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480527; c=relaxed/simple;
	bh=yfKw1TszDMECT7S1BjlNLUUTh13eZocExh4ic4MvSFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPOBFGUqlveQoPRh1QChxmLX2lF6c1QFUrBJsKNKLIv0Hk1YFwwvd54gMLK03jUDl8VxCfHpKIzJRd8jl+OeNH6iG6EZzmOmZmw/tyFqDolEpIEsNR8jbUg9J751tIbyxp9wx95kNRHg2kHOcyPJL0NS0edUtBef0my3U96AvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EgNzyq+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A466C32782;
	Mon, 12 Aug 2024 16:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480526;
	bh=yfKw1TszDMECT7S1BjlNLUUTh13eZocExh4ic4MvSFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EgNzyq+y3WJXVwXTJQJhPZOIFkU5rMVXJyQU6CdcHK8JSvcqdQVLltXIvMvqc//mB
	 ODfHQ8Jdbst5P6KPFLPoL0hpTvmXE+X0maKzTEb0SJFy90AqrG0rSly1mxVMnaP19w
	 xVH6KrN5xu/lfvjrIqU+8jd0a+aYYXJ/htXs0UAw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prashanth K <quic_prashk@quicinc.com>
Subject: [PATCH 6.10 191/263] usb: gadget: u_serial: Set start_delayed during suspend
Date: Mon, 12 Aug 2024 18:03:12 +0200
Message-ID: <20240812160153.857317980@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashanth K <quic_prashk@quicinc.com>

commit 5a444bea37e2759549ef72bfe83d1c8712e76b3d upstream.

Upstream commit aba3a8d01d62 ("usb: gadget: u_serial: add suspend
resume callbacks") added started_delayed flag, so that new ports
which are opened after USB suspend can start IO while resuming.
But if the port was already opened, and gadget suspend kicks in
afterwards, start_delayed will never be set. This causes resume
to bail out before calling gs_start_io(). Fix this by setting
start_delayed during suspend.

Fixes: aba3a8d01d62 ("usb: gadget: u_serial: add suspend resume callbacks")
Cc: stable@vger.kernel.org
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Link: https://lore.kernel.org/r/20240730125754.576326-1-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/u_serial.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1441,6 +1441,7 @@ void gserial_suspend(struct gserial *gse
 	spin_lock(&port->port_lock);
 	spin_unlock(&serial_port_lock);
 	port->suspended = true;
+	port->start_delayed = true;
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
 EXPORT_SYMBOL_GPL(gserial_suspend);



