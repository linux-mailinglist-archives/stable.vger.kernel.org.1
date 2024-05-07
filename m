Return-Path: <stable+bounces-43427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7A28BF2B1
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DF021C214C8
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047D145A01;
	Tue,  7 May 2024 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zc6Hj1lY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557461459F7;
	Tue,  7 May 2024 23:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123670; cv=none; b=d5pvyrUkHdxoksYkveiG3bknV7FfKUK0N6MOrmZiegKDJBiuycOn7eWsB3g3gT8iOneEV8gpfMkpg6z9+mdx+DuGfcEr3mMlu4e3m6RbX0Pm+L7LxxD3GJgbkOmcsjGvo0+gRLI4Dwf+kOlEi8c4BaAK1L/du2oJBQhbZBnHai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123670; c=relaxed/simple;
	bh=4cqSLfg1qBS3vh5R41qnWms+cmFodGH/kFqLwubDhDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+Llv9dNbFNe1i5P6k+Npo5ln/8DnvbXFXF8XQ6bT8GYhSaxe4hYd4tKWgmoDAInndEZr7Rfrumluvzu0BUr3PvlJOVf963D4ma8shxeKELNGshpT55CDlbXVziRXhrzE4g28d7Kgs5bJCx8DxhUFSoQ4yI50/YbHRN8tDOeUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zc6Hj1lY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4C0C4AF17;
	Tue,  7 May 2024 23:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123669;
	bh=4cqSLfg1qBS3vh5R41qnWms+cmFodGH/kFqLwubDhDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zc6Hj1lYSPOqlv7cr2OUXMVor2LO9n76fiBL+8LkVhoXlpRwk506j2SKMTN0i2bmG
	 6qVkLbxAK/tvJH8/kc8ZKFfndRJjFIild2CLyUgR0QTPZ/xcHvO9CT56+im+IxiLO6
	 O7Y1GcbwT/8pZQPx9dbJgKg+Gbv8YcslxhuvXQgJpvZkT3gV9cgt+S2Wz5VsGWMrP2
	 qQKZSogR+AAUgNWLITPlrDMYXQAlE0BRcw9OFLHCPfMgbgFTs11SnEopHQ9bgmhZQU
	 GrlZc/lDo3L/3UGRJGrcQgvWlVcD8GSNbuVCNZd8WpfC/Dl7FeYTFB+IHlHXB14FAE
	 o98intftQiaIw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.4 3/6] firewire: nosy: ensure user_length is taken into account when fetching packet contents
Date: Tue,  7 May 2024 19:14:19 -0400
Message-ID: <20240507231424.395315-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231424.395315-1-sashal@kernel.org>
References: <20240507231424.395315-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.275
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
index 9ee747a85ee49..8bb609085911f 100644
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


