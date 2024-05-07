Return-Path: <stable+bounces-43421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7DA8BF2A4
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F959B21B13
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4098D19D42D;
	Tue,  7 May 2024 23:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lquJQisr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2AB19F0F8;
	Tue,  7 May 2024 23:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123657; cv=none; b=Ct9Eovi6s/ph8IwgZv7Dc43ZKb56xUbK5iQnPOaW27JDVmW8teBmQuBkbvH/K4bagqFPY4AhU6WHSGCH9gQRYy+D5FkEXSjugMvjDSmvqeuOOT98u+/s7mlXHOBs8Bc47Bb4zhS+JDKY+URU8mLdtCce8KEemOQ6FmMeQsmPHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123657; c=relaxed/simple;
	bh=039aMml/7RrxBQVlYP2HFi9FN5TCDhwn8OIvAOg4d+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPrFjY7AZ1uMi+OZ4aUCasENQVgeEgvTAI5x6YzBWUMp+BIyOasirAN33ys6/z9EXDnQOls6Zs8lShPcnS2wjAOKdIMIBDzqWrDiSImmAMjuMCjVPimjbOGWbiZ9JWFZInQg3vYFuOylCj75tAlcYz00W1tvmwCfJQORgR/krps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lquJQisr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C438C4AF17;
	Tue,  7 May 2024 23:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123657;
	bh=039aMml/7RrxBQVlYP2HFi9FN5TCDhwn8OIvAOg4d+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lquJQisrYhX32kspyr/UrEMBf0RfP9KYuWGFR6eC02ompZ39tP35H9Sp59SMnSEYx
	 M3oVu6FlIzPk7wjwR2dzFcmxxwLTW9Q6Bu5AiQGfa6qYUExsn+TjHow7Pl4NYm87hL
	 d8UfYS2Rd3kHhPueC7mYac5lD+hC5xpMHt2GpCX5cq32KHIyT4STasEA1B/gamWuKA
	 qta7EydMROVoKBCDKM4d+U70d6lFFWYxwV8klvZwtSAZ5fUui771UU0fKFjP8D24XM
	 jfdP0Rzy+4MtzGCeiaLRCT2i3mubh1/oznY4aMKnfpOi3McTNRUScMoa+ovsk9rHKv
	 w8QwxT09ht6MA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Sasha Levin <sashal@kernel.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.10 6/9] firewire: nosy: ensure user_length is taken into account when fetching packet contents
Date: Tue,  7 May 2024 19:14:01 -0400
Message-ID: <20240507231406.395123-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231406.395123-1-sashal@kernel.org>
References: <20240507231406.395123-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
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
index 88ed971e32c0d..42d9f25efc5c3 100644
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


