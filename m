Return-Path: <stable+bounces-43387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10DE8BF251
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF161C21BDE
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54A21BED63;
	Tue,  7 May 2024 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jg06hrux"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD61A38D3;
	Tue,  7 May 2024 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123572; cv=none; b=iZsDn87qfBsBt+OkT1Id5y1u3IhZKHjcgL32XM0EUH1tFssT0KqNxFcSDv6j+5MocvWkqvhNlXVqd4ZxVMpTH18/WlbrdLTcXXQX8Rh/NpFTrdX+R+CmPtsbaYDdsQrwspzKVFYn7NjM8SC+kZsUCM25PdnUrDLUjvVRwOSWUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123572; c=relaxed/simple;
	bh=f43ozCLdsfglP1LAVYw8NC7+1NYU/w/xvIQAowU7pjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjQJL7ANVOJNBMzGAMWSL61O9wvyfRThmPwdn5ywkDav0gDtXnm9JyMxuIRNLZv7szosK02mdZ5QTniPD2RdmBPSMBz20+5lFpgFG1Hs13i177sllG5Tyrks47M21unlJN5lltbqefXcnQ7FPUQV3ylJaRpBivZh9v0HkSe4Ojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jg06hrux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09A3C3277B;
	Tue,  7 May 2024 23:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123572;
	bh=f43ozCLdsfglP1LAVYw8NC7+1NYU/w/xvIQAowU7pjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jg06hruxAhcziPjvKkKyCyf4do7rJ9W0Se8Bbazqtkf+27TjpzaEdHnvpKLv+KEqh
	 0Vv4ZmDhW9zmog3FsDub2zItF3n20gDsmruqO7xARW8LIwFTPai2YPWBL6dVHM1yYk
	 D9Y9JeTNETAv6E/iGE89LXr6AcpoBOJVziSZNMb5R+GBg/tsU+gs+L786PInke1so5
	 Sr9akVZDYHxrW4TDot52mAT+qTkrpiqHt0nC+pgJ4DGIGi5k3eGTbJmbWS7ooDOF8c
	 F9pheXI9flAoE2eO5616CPjuauTfQzoV+O9h8kVmLqLlroqXtJO0Pedq2XL29M95Xw
	 ltIzERMhFVpMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.1 12/25] firewire: nosy: ensure user_length is taken into account when fetching packet contents
Date: Tue,  7 May 2024 19:11:59 -0400
Message-ID: <20240507231231.394219-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231231.394219-1-sashal@kernel.org>
References: <20240507231231.394219-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
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


