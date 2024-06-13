Return-Path: <stable+bounces-50963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE56906D9C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439881C23449
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6AC14533A;
	Thu, 13 Jun 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2NVuu6RU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8AB1448E5;
	Thu, 13 Jun 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279903; cv=none; b=Gzc220rjyeOgGzfpXz2bsbnGYPdiKzR1uy4quiL3KT0YuG+9z004tylOG5ky37BQA9ItqPNSCBlTgasRiDpnvJ+WYIkgeQLmykIVl4cmpubr0KvsAdld4vYDu/lqHpZP0vBbICmeHqHPx1TfpdWwksLgXxkN49PIH2VsziWiDUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279903; c=relaxed/simple;
	bh=0PrcuI2PMneRp/DMECtt3oWDNk+NvKFuL08AcyLVtHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OCewKQWXI1MUlAdHRmGLesmKfWTm0dEO/cFWCtQyJQ6/nwL3W6Uj/hqe1KPDsqIx6/PNOQpeeqizLkocTdZ4s637d1eE80Wc4BpQRLLxxnySxUHLabpaS6ScDlcjbmJFVPvCceLqfUQQwkKJa10T4Tu9aeCDOgB/AGNRI7ohqF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2NVuu6RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93F9C32786;
	Thu, 13 Jun 2024 11:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279903;
	bh=0PrcuI2PMneRp/DMECtt3oWDNk+NvKFuL08AcyLVtHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2NVuu6RUTstSF8LCu5rgJDOFuPIJnrctLl/KvlCTjE8t9NkLNUwBaMLPH+lJD0Nn+
	 ePLxZZmS79Qv5BDZH3pvrhm4rCS8gjuIi/RM4E7C1Pi9f31zLpv4BMT7R1BEOsqP77
	 AOK4+jr+Is5RbWCaVQmqeMqz3lZeOXeQ+k5j/g6w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 075/202] media: radio-shark2: Avoid led_names truncations
Date: Thu, 13 Jun 2024 13:32:53 +0200
Message-ID: <20240613113230.669368622@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ricardo Ribalda <ribalda@chromium.org>

[ Upstream commit 1820e16a3019b6258e6009d34432946a6ddd0a90 ]

Increase the size of led_names so it can fit any valid v4l2 device name.

Fixes:
drivers/media/radio/radio-shark2.c:197:17: warning: ‘%s’ directive output may be truncated writing up to 35 bytes into a region of size 32 [-Wformat-truncation=]

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/radio/radio-shark2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index f1c5c0a6a335c..e3e6aa87fe081 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -62,7 +62,7 @@ struct shark_device {
 #ifdef SHARK_USE_LEDS
 	struct work_struct led_work;
 	struct led_classdev leds[NO_LEDS];
-	char led_names[NO_LEDS][32];
+	char led_names[NO_LEDS][64];
 	atomic_t brightness[NO_LEDS];
 	unsigned long brightness_new;
 #endif
-- 
2.43.0




