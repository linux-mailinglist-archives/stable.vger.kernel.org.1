Return-Path: <stable+bounces-44317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 846B88C5239
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D5D1C2172E
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CF444C6E;
	Tue, 14 May 2024 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjD7/7FR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873DB2943F;
	Tue, 14 May 2024 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715685667; cv=none; b=iHadYL1nafWBwown0dZ9dBltcJcLJxgzVZPXRduY50i3qGWVbaYeCTNF1w6zZ8ey+rL9AM+r+OxDDnoBGYK4ZA+wjf/gcHXtse5JWLDGhWbQOzYCVt1H2u7TKHQBSvEuw0Rg+ETMLANcrPuSGuhTeQquGPAFPkZmnHAS4dC7ymQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715685667; c=relaxed/simple;
	bh=BzmcymKq72jMmVLKWEUMrOvPcI/fbeTrUuTT8uyxt9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBscoYejtfKle23nsHJEDRiOyvjYd8BF05bCAZCGVeUGTO/STW5z5nS9NSOrkmwLOifENr2VzTYq5V9JT5/FegH1fx5IOAvc54zYJORVJrOn02x52SbHQH1l1f4OnUi3DYsiY6HlbCbtEDiarOPyG6DKupegZ6hC3ZSMXj9352c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjD7/7FR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4D7C2BD10;
	Tue, 14 May 2024 11:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715685667;
	bh=BzmcymKq72jMmVLKWEUMrOvPcI/fbeTrUuTT8uyxt9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hjD7/7FRYVVVFQGg7e7CyK1p/fN0T3+Dk/MoshHKU+75DCEZUjJxWoN0JuqrEFV3z
	 2HP+clTTEVYO7f2cjCJxoxWTVS9Ps8GjFRiNF7mGCrGQxcrd2smHi5t24MykqYwvUR
	 VzXIAXvviTeSf+TPxbpXijkMKClZsv/J03tMDZv4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thanassis Avgerinos <thanassis.avgerinos@gmail.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 6.6 223/301] firewire: nosy: ensure user_length is taken into account when fetching packet contents
Date: Tue, 14 May 2024 12:18:14 +0200
Message-ID: <20240514101040.676217482@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101032.219857983@linuxfoundation.org>
References: <20240514101032.219857983@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>

commit 38762a0763c10c24a4915feee722d7aa6e73eb98 upstream.

Ensure that packet_buffer_get respects the user_length provided. If
the length of the head packet exceeds the user_length, packet_buffer_get
will now return 0 to signify to the user that no data were read
and a larger buffer size is required. Helps prevent user space overflows.

Signed-off-by: Thanassis Avgerinos <thanassis.avgerinos@gmail.com>
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firewire/nosy.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/firewire/nosy.c
+++ b/drivers/firewire/nosy.c
@@ -148,10 +148,12 @@ packet_buffer_get(struct client *client,
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



