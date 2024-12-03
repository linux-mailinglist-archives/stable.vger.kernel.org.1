Return-Path: <stable+bounces-96466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140069E200E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEF616532F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E821F7596;
	Tue,  3 Dec 2024 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iYRobKBN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235961F7560;
	Tue,  3 Dec 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733237582; cv=none; b=G8OZJNjg2kOMgC93m3oS6Wpk1VRiTlHKooWqHV6AFsq2mnMhmgdNKnJJKRIDmncIfkDS1LgLQykAUUaZYfysgwEmSKSKblupG6uoAF66cQv+UcY7LkdE7btWx4k6fDjUFHwTnrS8kHWy4r3f0MuBFL8BNQvHsUICebxhEjSO8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733237582; c=relaxed/simple;
	bh=kyQ0DgKkDjeXH3ouZv0W8hzJmQt/Fs5ddUQNaegTIaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBVsu8El5rUZcYQqOU3OhoIMBO302kyFH5yISbGZ40DopBM5UIwmGRYO2Rq+zFGmQnwn/fz0rbDT9BHoXejRju+ZYy/EEQE4G80JBc+1QXfaGtffP+eIUvATKXuHQLvQ6Yblfqrpqi2GKvfVnLEMioH2uaBRQ1CJ3vmd+IMYXDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iYRobKBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3922CC4CED6;
	Tue,  3 Dec 2024 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733237581;
	bh=kyQ0DgKkDjeXH3ouZv0W8hzJmQt/Fs5ddUQNaegTIaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iYRobKBNj1WImD1uomVizgRSPLElavFBiutKZzMQW6Fe/mbn2hD8MfgCo4hfLI6lA
	 xfMK8Ehr9Gv2f5TjZbTEPSin4rpTJkaFi4YMKHEn/LukqziizHFE4hfC2Kv4gYxL2B
	 50aP6doO1Dck0MZ9BVTKGMjOdEo30EFKJvaelkdo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Benjamin=20Gro=C3=9Fe?= <ste3ls@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 013/817] usb: add support for new USB device ID 0x17EF:0x3098 for the r8152 driver
Date: Tue,  3 Dec 2024 15:33:05 +0100
Message-ID: <20241203143956.153788173@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Große <ste3ls@gmail.com>

[ Upstream commit 94c11e852955b2eef5c4f0b36cfeae7dcf11a759 ]

This patch adds support for another Lenovo Mini dock 0x17EF:0x3098 to the
r8152 driver. The device has been tested on NixOS, hotplugging and sleep
included.

Signed-off-by: Benjamin Große <ste3ls@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20241020174128.160898-1-ste3ls@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index a5612c799f5ef..468c739740463 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10069,6 +10069,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3062) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3069) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3082) },
+	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x3098) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7205) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x720c) },
 	{ USB_DEVICE(VENDOR_ID_LENOVO,  0x7214) },
-- 
2.43.0




