Return-Path: <stable+bounces-50585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E7906B5A
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0A5BB21F12
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD3B1428FC;
	Thu, 13 Jun 2024 11:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u3h0seiy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD8DDB1;
	Thu, 13 Jun 2024 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278796; cv=none; b=iW8fKmoaP05MHgTOsSXstYreCDiB62o2EWp0AhQKkk35a3AAs0Bv32IyijZ4IynyyfSa9P8+i7GYuPOy+wJL4xKBBJ/w0Unk8vD3/khlQn/HCMQcgalYyJZNp3XC32sTug5sETnsRi8PahfbJAjHSRNG7vPt4oTXnmOxH6tXTMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278796; c=relaxed/simple;
	bh=1w2bB3iVygRE2uZ5j5JWVEmZtDBMcJUStYLqaO5NjyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPZf+wGepdhWv05AXPUKOwq3VK65xkGjTG51RDMsebe8aV5aIqc63DQS8F/fcNmq/qwu1cDQe+ybyUc2IAASM1qEVUa8L+loNu0zO84Entqd3JFDYaG7fth1ztAie5UQPM4eQTJefetDmAQx5giuDV5hFaVDmZX8BYU32s5iMvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u3h0seiy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A5DC2BBFC;
	Thu, 13 Jun 2024 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278795;
	bh=1w2bB3iVygRE2uZ5j5JWVEmZtDBMcJUStYLqaO5NjyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u3h0seiyGt9yxBttmuu70UmXdhIxqVQLsihy+SsRou5QtFfawE3J3hr/VpE5OXKo+
	 PYmQ4U2HcJiLfV160DAkmtrpYD7Uuck68U7jiJVV9Bqxk9EPdyCD5kux2NlH5PwsNF
	 zJSr+CQ2fZhkmwIohjBzddtVeAmquVbKKVQiufPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ricardo Ribalda <ribalda@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 072/213] media: radio-shark2: Avoid led_names truncations
Date: Thu, 13 Jun 2024 13:32:00 +0200
Message-ID: <20240613113230.785467983@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index 5356941f54aef..fda988139fa46 100644
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




