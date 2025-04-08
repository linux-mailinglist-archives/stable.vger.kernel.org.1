Return-Path: <stable+bounces-130664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A9EA805C7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2531E1B631BD
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF8A2690FA;
	Tue,  8 Apr 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zWuGwGj8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E7A267B9C;
	Tue,  8 Apr 2025 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114317; cv=none; b=C5tZhtaJ7CgNGKPA2DVjYv2GcEqS6t9HcFPD9ldD1fkK+iPft7xi3Hv9RGtv3NnVF/wC40ThHCCWxs0WndqEbGBHnlwV7YxITt+lZ/XzaCCegnHH7jWNhU7R2TLqusLdvpNWTIvN3O+kOm4SQ/7PfJx1NPpQ9e5vw4S4VpzGUHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114317; c=relaxed/simple;
	bh=wbeymzP2N6HiTUzh6t40Z11vVtAZ4z4YG6FpBkaMwPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFMxzhkvx/GoRXM5kHn9zmG242Q5KqVis667G0jO0ZI87BXAxw+Q4vWW/mrNoouZ5NKfI6V/k0AI5tq8HHItzLk/rRkvhSmLRFc0sVxsN0PmjYQfp5U1IF1pd1KypQdNxuajBbU1EwWXC7r6UjRLbUyhNoGQBVyARG4SCLrmIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zWuGwGj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC07C4CEE5;
	Tue,  8 Apr 2025 12:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114317;
	bh=wbeymzP2N6HiTUzh6t40Z11vVtAZ4z4YG6FpBkaMwPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zWuGwGj8boMS++Kx59ZL3QIxywR4kiWq0UGfJLfGJVNa/iV84vvTmF+oltxVF0Tir
	 3IoYPdYBUINcwDYNR1O2Dsn3gThy2yM0vxq1FJNmdpT8VnLuFg35xXYF3ZPniMR8dt
	 P2w4Ajo6fX18/adxHdYF+JW350EYLVmcSeA9jBGw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Keeping <jkeeping@inmusicbrands.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 062/499] drm/ssd130x: fix ssd132x encoding
Date: Tue,  8 Apr 2025 12:44:34 +0200
Message-ID: <20250408104852.780526986@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Keeping <jkeeping@inmusicbrands.com>

[ Upstream commit 1e14484677c8e87548f5f0d4eb8800e408004404 ]

The ssd132x buffer is encoded one pixel per nibble, with two pixels in
each byte.  When encoding an 8-bit greyscale input, take the top 4-bits
as the value and ensure the two pixels are distinct and do not overwrite
each other.

Fixes: fdd591e00a9c ("drm/ssd130x: Add support for the SSD132x OLED controller family")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250115110139.1672488-2-jkeeping@inmusicbrands.com
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/solomon/ssd130x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 486d8f5282f93..4ceccad91ba0b 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -881,7 +881,7 @@ static int ssd132x_update_rect(struct ssd130x_device *ssd130x,
 			u8 n1 = buf[i * width + j];
 			u8 n2 = buf[i * width + j + 1];
 
-			data_array[array_idx++] = (n2 << 4) | n1;
+			data_array[array_idx++] = (n2 & 0xf0) | (n1 >> 4);
 		}
 	}
 
-- 
2.39.5




