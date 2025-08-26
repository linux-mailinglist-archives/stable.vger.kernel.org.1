Return-Path: <stable+bounces-174075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47AAB360DB
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C56E7B7949
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A823026B;
	Tue, 26 Aug 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eMN2ophb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEE3238149;
	Tue, 26 Aug 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213425; cv=none; b=s4oYc9JVd49WtRF0zPQncPhj17fGbQ8QVYaR9Txvzj3FXXrgCcwOo3ngVEzuR1eyyUSXI8W6OkuFmmRoB0BnUB+telBDQMSie/49IMXBqT3fBs7i90R0OeNVbImtg7ZDcUCUHsPuNbg73rUnPsdVXfTBSDXzepK6icy56EPrvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213425; c=relaxed/simple;
	bh=siJUL7WAFIz5Z0CvdRdrJo1OgcWaTR6xfKg+0wg+iRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xy13k7IoDK24WkyoLKZx69iUC6O0dnh9STV0KPyOQer++dMIyRBhOUHRPQ+HfdOwJhRjSu9GP6kdpbsHkFD0Rsd1t4SxNj7w14ttEwRL50D9ug1aHJtMgscM75AdMzV5GB1BzgxH5pwqnHPLmt5gLxs+cBOtYsHlELA3vs5bsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eMN2ophb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2D1C16AAE;
	Tue, 26 Aug 2025 13:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756213425;
	bh=siJUL7WAFIz5Z0CvdRdrJo1OgcWaTR6xfKg+0wg+iRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eMN2ophba8LL0wIXLHq9dy2Qifgc+JCxKfJZApAc9iQz7jNlrZWCipMXO3R3kVLaa
	 /pjTPqx66NSRq2TMkKOQkYNbKdc2bq0mF4ncjwHieIJW13wPyKH/pKl/5sP1crhRIM
	 1r2CE0pxZLFsmyVEZZtMPi6uNQ1W2oOyZJMlUdSc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jari Ruusu <jariruusu@protonmail.com>,
	Yi Yang <yiyang13@huawei.com>,
	GONG Ruiqi <gongruiqi1@huawei.com>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 6.6 344/587] Revert "vgacon: Add check for vc_origin address range in vgacon_scroll()"
Date: Tue, 26 Aug 2025 13:08:13 +0200
Message-ID: <20250826111001.665435940@linuxfoundation.org>
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

From: Helge Deller <deller@gmx.de>

commit e4fc307d8e24f122402907ebf585248cad52841d upstream.

This reverts commit 864f9963ec6b4b76d104d595ba28110b87158003.

The patch is wrong as it checks vc_origin against vc_screenbuf,
while in text mode it should compare against vga_vram_base.

As such it broke VGA text scrolling, which can be reproduced like this:
(1) boot a kernel that is configured to use text mode VGA-console
(2) type commands:  ls -l /usr/bin | less -S
(3) scroll up/down with cursor-down/up keys

Reported-by: Jari Ruusu <jariruusu@protonmail.com>
Cc: stable@vger.kernel.org
Cc: Yi Yang <yiyang13@huawei.com>
Cc: GONG Ruiqi <gongruiqi1@huawei.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/console/vgacon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1139,7 +1139,7 @@ static bool vgacon_scroll(struct vc_data
 				     c->vc_screenbuf_size - delta);
 			c->vc_origin = vga_vram_end - c->vc_screenbuf_size;
 			vga_rolled_over = 0;
-		} else if (oldo - delta >= (unsigned long)c->vc_screenbuf)
+		} else
 			c->vc_origin -= delta;
 		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
 		scr_memsetw((u16 *) (c->vc_origin), c->vc_video_erase_char,



