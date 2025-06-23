Return-Path: <stable+bounces-156828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7EEAE514D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05014A34EB
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C198F1EEA5D;
	Mon, 23 Jun 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BVJQ8fSP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF8C2AD04;
	Mon, 23 Jun 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714365; cv=none; b=WuCL6foGhveCNsurIxwCEgcule3KRECljZMRAvFtDuEFzAioSBSbdi4ZrghRRUaSX7KO4RqhMzs+zbQJCUdWLvXj2Dp+kf8wCApifwlmoe15R3XFY0cqXdRunBNdjxJ8mt0tci1k4peHCi0j4WpiKGeXLyRu+CWLsboeMmbWdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714365; c=relaxed/simple;
	bh=GNo6LJMB3dZiyFGgb4oJG8UmtQ8ePVrB2BRaXliglLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dK9+i2NDb02j/zigyacXBT8izuduTpqeIyqfS08G1pR2iHTH4WZPQbLrPbrv6BYfgRR414+9ZbaukWipBV0P7uU9m/xNxt7n6XmeJky1/XMYxEfC8omlRB9J+NpUTH7XTFYkeCX+VzvWJq5G56QHozZxy9L2g2xtT4UJ0fw6AYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BVJQ8fSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073BAC4CEEA;
	Mon, 23 Jun 2025 21:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714365;
	bh=GNo6LJMB3dZiyFGgb4oJG8UmtQ8ePVrB2BRaXliglLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BVJQ8fSP5sqxw+233h65L7AFSa28Dq7FMKvGGinyDdU3hzbcPf/+DPe9jDX+3Xsje
	 undja8FTK1b7toBUtNDPoTNeBX8SbcjirtJAaZqmxcEl8h9RwSkBcXz6FDzIxd68JD
	 ktS0YlZbFV3lISrDkYQE1IQrh7mtKgmULyL2/O9Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.12 098/414] Input: gpio-keys - fix possible concurrent access in gpio_keys_irq_timer()
Date: Mon, 23 Jun 2025 15:03:55 +0200
Message-ID: <20250623130644.544941434@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130642.015559452@linuxfoundation.org>
References: <20250623130642.015559452@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gatien Chevallier <gatien.chevallier@foss.st.com>

commit 8f38219fa139623c29db2cb0f17d0a197a86e344 upstream.

gpio_keys_irq_isr() and gpio_keys_irq_timer() access the same resources.
There could be a concurrent access if a GPIO interrupt occurs in parallel
of a HR timer interrupt.

Guard back those resources with a spinlock.

Fixes: 019002f20cb5 ("Input: gpio-keys - use hrtimer for release timer")
Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
Link: https://lore.kernel.org/r/20250528-gpio_keys_preempt_rt-v2-2-3fc55a9c3619@foss.st.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/keyboard/gpio_keys.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -449,6 +449,8 @@ static enum hrtimer_restart gpio_keys_ir
 						      release_timer);
 	struct input_dev *input = bdata->input;
 
+	guard(spinlock_irqsave)(&bdata->lock);
+
 	if (bdata->key_pressed) {
 		input_report_key(input, *bdata->code, 0);
 		input_sync(input);



