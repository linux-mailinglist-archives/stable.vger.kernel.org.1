Return-Path: <stable+bounces-43308-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6438BF196
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0478B27AA2
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2077F134CD0;
	Tue,  7 May 2024 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhnuvFLZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D137F13F45D;
	Tue,  7 May 2024 23:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123336; cv=none; b=esDw8oRDvRP1oWjSOwPfdkXGrYZaPQ8Xntf8ILlIrpD1UwE4Ngb9hXT5EuC10zycLXh+TBwKA9IM5f5I4QAcKG6gwC4+N0bwj1Pc7q/1wJsrcnvrlA+aUkX5mcJZrE/xH3nrgL9PJzmMwr/S8Rjz7f8mueIP0pX3gwB6QroexSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123336; c=relaxed/simple;
	bh=f43ozCLdsfglP1LAVYw8NC7+1NYU/w/xvIQAowU7pjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFKXmdMpk89PDK6F/1+9kTLQT06u4bN02w7vuvyrTK1XCFOv3Ry6MKl0uP7FENbriZy8gECLBY27pq0CEiClFBhR3dNZxFLwErw5XrmF95y4Kn/oKTtHCxt6LJzyRl/QELNXvcFihafsKSSCoKa34y9P69mQGpgLus5y1t9/xtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhnuvFLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003EAC4AF17;
	Tue,  7 May 2024 23:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123336;
	bh=f43ozCLdsfglP1LAVYw8NC7+1NYU/w/xvIQAowU7pjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UhnuvFLZVtvT/oNdGGT6vfP7ldAJyaHBxaihasg4B15wpG++8Hg/Tt7unt8wN+94J
	 n8X2urYC3/Bt2moZO8iF9ezh4+9sigWvRbR05x+xGjL75+gDtRAEWSUVP16Ir2c1v1
	 dNWfeK8Ci/L7HRlx7iVgZwm/rd+HFDe89qmAhvsj6g+0mPJvp/xFXAIBlmJhSLBob3
	 DDF93/DkznMQCuvKskTwCKpUHRoKhD4ynZOj8iHh6U9RAPit0a6JsqT0u2oPHwqTk8
	 FHxJ+379Qoven4IOqXuPiptt4FVzjp3nl47CpuI3mvL4dr1ciPPigeW2mX17+7eGGd
	 xCdN+w6qiKS2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.8 29/52] firewire: nosy: ensure user_length is taken into account when fetching packet contents
Date: Tue,  7 May 2024 19:06:55 -0400
Message-ID: <20240507230800.392128-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230800.392128-1-sashal@kernel.org>
References: <20240507230800.392128-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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


