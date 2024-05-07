Return-Path: <stable+bounces-43409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062208BF286
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB761F231F5
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA6621C19C;
	Tue,  7 May 2024 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHqAMuA+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB7921C195;
	Tue,  7 May 2024 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123629; cv=none; b=kHG1jBNMt1WNNDCSbebXNgA0udXFCulkr54kOlw2+MTbDTsxUaogcjqJMJnzXwi9nJJeRIhiUUp0f87YRYkoAEXG0Yd01hQUiMkeUBZruahLrLanXVsWRFJUnu8a6YcomjfQmkmIgrOYLV9HkHvTLajUX3SlHYxFzr13mymKY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123629; c=relaxed/simple;
	bh=f43ozCLdsfglP1LAVYw8NC7+1NYU/w/xvIQAowU7pjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmW78sR5XQ/e+ntPmvSr8EjHa2C5S4FHKSvKibhWcK3u2HGzue7sdiWdUVS002Wz+WD/Q/dM+WaeKTc1IWGdyKlB/max9SLN0JtmaqVxJRILZ8TYC16Dip1Vmfmc0j79+msHJfmcNEmQ2wz+hI5mHBcteYJxnhBaVqzZDjMyllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHqAMuA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26996C3277B;
	Tue,  7 May 2024 23:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123628;
	bh=f43ozCLdsfglP1LAVYw8NC7+1NYU/w/xvIQAowU7pjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PHqAMuA+BZ3KG3+SoaR2fF/dbuXB3SFxEI9VCpCK+c6b09TIRmJHbvi9j3LkCd0AC
	 dWk7gR7ZrCiO3axrQEWSB67IcyV4BFeui3qf+4b4d2o2/oGMtZHVvNiDY8+HxlmsKJ
	 VoeMqLrVku+n8nDRbqaUuLoUcNoKXH8xBy/t+kWfTOhqcCHLhuPqdy1r0mM7dxiC6B
	 xJaUXy5M6UhslQoXS++GI2KzBWBPEqBH9Sf0Pssi2dHxpvAwTMtYg1EJBfz7iuxH3B
	 Ug9IyEqDNO3Xdv3J63MEBSceXAFsr02JS4ryhlMIoEyIFC6LZPGtcZyed6M7cg3YTN
	 zxd+o1HXh3Nag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.15 09/15] firewire: nosy: ensure user_length is taken into account when fetching packet contents
Date: Tue,  7 May 2024 19:13:18 -0400
Message-ID: <20240507231333.394765-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231333.394765-1-sashal@kernel.org>
References: <20240507231333.394765-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
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


