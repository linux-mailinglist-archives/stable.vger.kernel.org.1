Return-Path: <stable+bounces-43356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD88BF206
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B1C2873C1
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ACB16C87D;
	Tue,  7 May 2024 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FelSheqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB515F3E1;
	Tue,  7 May 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123480; cv=none; b=onUJtWOUByi69BJGH/rulN9fL/Vxk5meFKN3mpdvlt5NrtkPR/fcrWEqwhMIGfwyVvrC1hTdsi3jGAL+eOUDt4OCJWQJ8hDrgsrxiWt6KaQPGlCX9fPEq4BvfABGeMydh1rndQ4AT0eYM823ErKeJ5Pg4YGJ4fHNrVUpi9KsGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123480; c=relaxed/simple;
	bh=f43ozCLdsfglP1LAVYw8NC7+1NYU/w/xvIQAowU7pjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0ZpDbsuumdSeEgjCde8BR9n6UAkdf2np91OExUZPI1KvRye0HE1IWYHmtpJr0nMhIDdDyaIPfDmJu0Zdr7vA8w7M7vU2V0QGy/vuubIiR7sHe22kwdy3m3/7meTvPtptRrQm3ZgxSq1aci8fw3/tMkO9Wvj0IxvtiKeJiNudzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FelSheqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4DFC4AF67;
	Tue,  7 May 2024 23:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123479;
	bh=f43ozCLdsfglP1LAVYw8NC7+1NYU/w/xvIQAowU7pjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FelSheqhBAC4ZvNSr0pcF5c7swSjrQYqKReAEqsytkQeCb1WP/OCF/zJXKX2GiFps
	 36O8sB8DpAiyG151UwLcV9pezCKUU1QoYDdIsLl36Uv5sTifG0h3zrqyCrWxN/FZRR
	 zZ5wsUxtCHb4+h4oidjNz+bp3q7BjYnpuNNNIRqntPD8R6XDYPDNxDjrodfoi6z7SR
	 JrA+X9bTGWwr2Nfm4x4XkKksvnWdC8owC67EXy3FKtcqYEHXWspHF2TVOBKD+OBUCi
	 CLAL4tORCQ74KuRGSuv+TUYU6X3dL3SNM0brwI3zHGdML70v02NOf7tTtxmS9Vp7Zj
	 PnOZ7APyGHlNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.6 24/43] firewire: nosy: ensure user_length is taken into account when fetching packet contents
Date: Tue,  7 May 2024 19:09:45 -0400
Message-ID: <20240507231033.393285-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>

[ Upstream commit 38762a0763c10c24a4915feee722d7aa6e73eb98 ]

Ensure that packet_buffer_get respects the user_length provided. If
the length of the head packet exceeds the user_length, packet_buffer_get
will now return 0 to signify to the user that no data were read
and a larger buffer size is required. Helps prevent user space overflows.

Signed-off-by: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firewire/nosy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/nosy.c b/drivers/firewire/nosy.c
index b0d671db178a8..ea31ac7ac1ca9 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -148,10 +148,12 @@ packet_buffer_get(struct client *client, char __user *data, size_t user_length)
 	if (atomic_read(&buffer->size) == 0)
 		return -ENODEV;
 
-	/* FIXME: Check length <= user_length. */
+	length = buffer->head->length;
+
+	if (length > user_length)
+		return 0;
 
 	end = buffer->data + buffer->capacity;
-	length = buffer->head->length;
 
 	if (&buffer->head->data[length] < end) {
 		if (copy_to_user(data, buffer->head->data, length))
-- 
2.43.0


