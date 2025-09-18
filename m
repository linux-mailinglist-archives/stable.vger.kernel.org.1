Return-Path: <stable+bounces-171582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4C4B2AACD
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2551BA51E8
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0844A35A288;
	Mon, 18 Aug 2025 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btq3nOvO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B235A282;
	Mon, 18 Aug 2025 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526418; cv=none; b=f2Osh6PrWCXHffiFK0N+ZphF6p59Zb9xJ6RichPraTFMfXfSR1l7eP+Ga9qN7ESPvhZX6FYXaDqJi6hdTTSzgqH+sCc94fffW6H5ci+1z31mghVWcVIrFlI5puw5pDBJArQTEgHgkFlPwrh6gMHoyJdcTgY5UF+UdyaCejpmKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526418; c=relaxed/simple;
	bh=rUyLp2oSB7F3kKgS9VQ5KWAGnUqwBAlkMIAbeQjmB20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDmtlXCpxEBKQyvESkhmVXlc38YVJkL2kQzz23Ucx8ahrnSuKMsdpwcsflqAjjTIehjZ2GbRbF51VoHf4R535GaGjvuPmEALqPUcN2SyxZQgzJExJL5w0h08rU3atykjURq8CVXJ6k8hlrLUhLnrIx/YUUAgMx5+dUt3/6nvPL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btq3nOvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997DAC4CEEB;
	Mon, 18 Aug 2025 14:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526418;
	bh=rUyLp2oSB7F3kKgS9VQ5KWAGnUqwBAlkMIAbeQjmB20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=btq3nOvOwgOUzJCYwaFPeQHFgH5FLhkMJqJ2yzrXBVR0Cfxx/cRi2yosnGodX4YdM
	 scRyaMDPfkxFJSACJ3T7H50anCCUJAjzOiZZgX1JnlMp4nDl7L+mQcWwU4hsEPuHoM
	 smVwvDYqxof2vZto5m618UlgJE/leIE3S2NMkS+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Youngjun Lee <yjjuny.lee@samsung.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.16 548/570] media: uvcvideo: Fix 1-byte out-of-bounds read in uvc_parse_format()
Date: Mon, 18 Aug 2025 14:48:55 +0200
Message-ID: <20250818124526.981100350@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Youngjun Lee <yjjuny.lee@samsung.com>

commit 782b6a718651eda3478b1824b37a8b3185d2740c upstream.

The buffer length check before calling uvc_parse_format() only ensured
that the buffer has at least 3 bytes (buflen > 2), buf the function
accesses buffer[3], requiring at least 4 bytes.

This can lead to an out-of-bounds read if the buffer has exactly 3 bytes.

Fix it by checking that the buffer has at least 4 bytes in
uvc_parse_format().

Signed-off-by: Youngjun Lee <yjjuny.lee@samsung.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Cc: stable@vger.kernel.org
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
Link: https://lore.kernel.org/r/20250610124107.37360-1-yjjuny.lee@samsung.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/uvc/uvc_driver.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -344,6 +344,9 @@ static int uvc_parse_format(struct uvc_d
 	u8 ftype;
 	int ret;
 
+	if (buflen < 4)
+		return -EINVAL;
+
 	format->type = buffer[2];
 	format->index = buffer[3];
 	format->frames = frames;



