Return-Path: <stable+bounces-174054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF7FB36112
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BF42A2C9D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DF91A8F84;
	Tue, 26 Aug 2025 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FcdY1WVL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED148635D;
	Tue, 26 Aug 2025 13:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213370; cv=none; b=ISnYaTCy4w2z1PgyHWNuEbmkp3+p5C9bdxqzGy98Sg/uftwuJ4PsBYB1aE01c2tknjBJsb4DRTD46uvuFUyP0/kcIb+S9jvqp6JghkVnNvOV+MRhwvv8RRsPQduqNAkbIwf/J2QX1owLHSNYpZWgvNenjXUo3eXDOhwd5zmgXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213370; c=relaxed/simple;
	bh=hUrjycjcH2o3j029JTj2Cij98UoPWGvjabwqUDyB7vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSjEtwnc7dUzhqmlB0HadY69ocL1oW/VNcbwUFxbp0PY0n2rYM5geyOA1o5OZIGMt3Y9ykkoaKLG/o0r3SUbUEi/puhEJvr9IjzXHX2W5d7K6H0w3MJeAbkiRLlIavcNEHdC+Qc1FKiGYR1uCEV20eN+FvgFyc4UupqqCrY20YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FcdY1WVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5691C4CEF1;
	Tue, 26 Aug 2025 13:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213370;
	bh=hUrjycjcH2o3j029JTj2Cij98UoPWGvjabwqUDyB7vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FcdY1WVLCCzE6lWrG5FdKfwWGQriUeJ2WLU21GjFSbQOx9qriCMhz7ZqFsLCZ+unz
	 o4RJibouWq5nrrCffAlFY/IPY3dbzcOgvJWNOadQxzkVohRlaG56VFYX99Yp2bNH13
	 SQy4Yc54cjfx7DBVDZzro27QGdwHrWIaxoyyzIYM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Youngjun Lee <yjjuny.lee@samsung.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.6 321/587] media: uvcvideo: Fix 1-byte out-of-bounds read in uvc_parse_format()
Date: Tue, 26 Aug 2025 13:07:50 +0200
Message-ID: <20250826111001.083549585@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -235,6 +235,9 @@ static int uvc_parse_format(struct uvc_d
 	unsigned int i, n;
 	u8 ftype;
 
+	if (buflen < 4)
+		return -EINVAL;
+
 	format->type = buffer[2];
 	format->index = buffer[3];
 	format->frames = frames;



