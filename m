Return-Path: <stable+bounces-43432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264FA8BF2BC
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B3D284430
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BEB126F1B;
	Tue,  7 May 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qakxCW2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6211A1A6A;
	Tue,  7 May 2024 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123682; cv=none; b=XltMihuKPyJTLtpFaOAVpC3PDo8VxrYP7HnEEz5GxgJ4pkbpJkiimScFTQt2kNqK10YNL/coqC/InExtFUHbaoXd/rj7SQvqIcvu0glva15y53Iv7HM1/sOc7wTTJ4g5OjqgFqtrREXGZMYNC4dlQW6WYYhZoRWt3PTTtsD/j6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123682; c=relaxed/simple;
	bh=FFq1YsZ4lWDlVgX98/DsdDyntB51ZyHmLHMXwbuEUO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9be/bxlIXzhcVpfCG0bcw5flnexUSpiHShUCvgqU4kN7P3n80JmXNw+ojs4bCWSYFIsZA8LiAEATjlUOEXwNge2GOEG4u5KATDhF9M9Ltb9PHK1BzCukOkOlTm7uXznxN+9I4xSdLhGdju2uj/ffU61wRLcddCsnYj28VyvZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qakxCW2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C35C4AF17;
	Tue,  7 May 2024 23:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123682;
	bh=FFq1YsZ4lWDlVgX98/DsdDyntB51ZyHmLHMXwbuEUO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qakxCW2ewMbjqW1a7ej3hFcYrZnwxGUpG2WVrDw7v6YemDixruuosnq+o/dwgVJ1v
	 KlQqHFiiVV5a14msSq3ElNUrEPWmF4ysTkCK2bCBo+Tm4UAppAKkM2nt6Wtvpsq6Vy
	 Yj2kST2dXeodLgC7ezJGz13U3g4DrvJoigC6/6lW9v7fo6RlXa1o25SqKc54WSoc5a
	 4jKYk3gr5WC4YhytF+6C4/ZuLsZMozpRK7fSE1TCeJPyBvv2N/dCXh9qNjdB4mLTET
	 6thSPjA7JEvNOUkMEskKbWGJMvfhAe2p9NaOGZy9Bl7L5i+4E+skFrDmS+JY25ITSl
	 evJR7u2sw63/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 3/4] firewire: nosy: ensure user_length is taken into account when fetching packet contents
Date: Tue,  7 May 2024 19:14:34 -0400
Message-ID: <20240507231436.395448-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231436.395448-1-sashal@kernel.org>
References: <20240507231436.395448-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.313
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
index ac85e03e88e16..f3784c054dd6e 100644
--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -161,10 +161,12 @@ packet_buffer_get(struct client *client, char __user *data, size_t user_length)
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


