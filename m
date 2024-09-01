Return-Path: <stable+bounces-72288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD511967A06
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8579F1F22C6C
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF24417E00C;
	Sun,  1 Sep 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SB3z9qSB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBF61C68C;
	Sun,  1 Sep 2024 16:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209439; cv=none; b=anlGt1H1wLFM7xr06k5chTJWvJtiN9gP0E/QOHvCZ0KSTOsgjdYmIqdWNodON0uOMl9PWSiFCJuHlqLn4d1VrUzqkaf3Hwkx15cF+etnw1yE0xs+UZaYoIyzT+8QWZtLNLrbHsoUg86tu5UdpqlVTCt6/FhruPjAUnFYQP/5s9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209439; c=relaxed/simple;
	bh=s9VcL2Zm9AEhLr9eLNlZCiYyn4EfKrANyk8eyWw8MH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aH7/kl40zBPvk4LChI7qPL7Pj/9IdFFeyeNKyq3GGtOK/OauvVfbh1kMFgldpCPlzAJ56nXs+Am4NdAuP7ZfKE+la3UvFUNbpfLeZ4dpG96fmOARa1dT8WxkWqMAKALICqBqgfIcTRFt3zV6qFH4YSjNEdyJhIewYISRPx+scps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SB3z9qSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05051C4CEC3;
	Sun,  1 Sep 2024 16:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209439;
	bh=s9VcL2Zm9AEhLr9eLNlZCiYyn4EfKrANyk8eyWw8MH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SB3z9qSBEsEHBEpxaVcfNiNlXJvSRJ5htrSzib+e9SCZoT7uTvGjduMZhxAu5H4vA
	 7I5mWs6FHy1GY6iyWMOlg9mhXHmQ8X84fU7UGu0UtTZ/NcHY5/Lb1/LUZOqpOQ7Z2K
	 NHNJatwNcNxCfm+eMX+Wi7ZjoIwe6+dQiG4QRnQI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 037/151] media: radio-isa: use dev_name to fill in bus_info
Date: Sun,  1 Sep 2024 18:16:37 +0200
Message-ID: <20240901160815.498621329@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160814.090297276@linuxfoundation.org>
References: <20240901160814.090297276@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 8b7f3cf4eb9a95940eaabad3226caeaa0d9aa59d ]

This fixes this warning:

drivers/media/radio/radio-isa.c: In function 'radio_isa_querycap':
drivers/media/radio/radio-isa.c:39:57: warning: '%s' directive output may be truncated writing up to 35 bytes into a region of size 28 [-Wformat-truncation=]
   39 |         snprintf(v->bus_info, sizeof(v->bus_info), "ISA:%s", isa->v4l2_dev.name);
      |                                                         ^~
drivers/media/radio/radio-isa.c:39:9: note: 'snprintf' output between 5 and 40 bytes into a destination of size 32
   39 |         snprintf(v->bus_info, sizeof(v->bus_info), "ISA:%s", isa->v4l2_dev.name);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/radio/radio-isa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/radio-isa.c b/drivers/media/radio/radio-isa.c
index ad2ac16ff12dd..610d3e3269518 100644
--- a/drivers/media/radio/radio-isa.c
+++ b/drivers/media/radio/radio-isa.c
@@ -36,7 +36,7 @@ static int radio_isa_querycap(struct file *file, void  *priv,
 
 	strscpy(v->driver, isa->drv->driver.driver.name, sizeof(v->driver));
 	strscpy(v->card, isa->drv->card, sizeof(v->card));
-	snprintf(v->bus_info, sizeof(v->bus_info), "ISA:%s", isa->v4l2_dev.name);
+	snprintf(v->bus_info, sizeof(v->bus_info), "ISA:%s", dev_name(isa->v4l2_dev.dev));
 	return 0;
 }
 
-- 
2.43.0




