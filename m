Return-Path: <stable+bounces-194094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A0CC4AE47
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1AF54F7891
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90496303A0D;
	Tue, 11 Nov 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qez51ZZB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA1262FEC;
	Tue, 11 Nov 2025 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824793; cv=none; b=FMd0Hh9EQpzTbJp/gdyWaAikfRMApjCJes7h0SSd7ITV924vl4vLcaZiJPiL9jNHQIH/fPQu9dgMzHiwOELIaKOnx6d+/I4q28Te4+YfCw9QMyH6AM6REjYtrbfli07TKzBrsH7negOzzy4aMFuVrBdWE7STLhbStNsKeuoCJdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824793; c=relaxed/simple;
	bh=Coezu9Wl/JWNJGcI6x+JYiUftPatNoMBQDrvLsoGTOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DY17YfxpBlWqw0fYMOsIylfu8N19ynRIa62jDNmbiIlz2vsI940D4CWvFxzhRsLiZ/Dpi/hqYVtloX/sM6e7p9VEPgO6nK3cOLLDjDyOYlJoIgzzP7ZaJPXjksJyyeU3zn5KQei1G+oEOjjldN4RQj3eYnW8AyBaWxhF5U58/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qez51ZZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5A0C4CEF5;
	Tue, 11 Nov 2025 01:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762824793;
	bh=Coezu9Wl/JWNJGcI6x+JYiUftPatNoMBQDrvLsoGTOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qez51ZZBvYrXlGjnBv90rbAgP0cQejWvB3izmJS0FsSYPd+QWrrxDNJgnouu6rGh/
	 syHh9D4ommjkFElw6S0myUkz80ih3v4B/JtaVOdlLu0X7SK5yAZfuTBdfhUArMFNpa
	 BwY4FcYuz4HjPhmKanNFHIUyxNDXSpb7SH+eRKSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 518/565] gpiolib: fix invalid pointer access in debugfs
Date: Tue, 11 Nov 2025 09:46:14 +0900
Message-ID: <20251111004538.612759596@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 2f6115ad8864cf3f48598f26c74c7c8e5c391919 ]

If the memory allocation in gpiolib_seq_start() fails, the s->private
field remains uninitialized and is later dereferenced without checking
in gpiolib_seq_stop(). Initialize s->private to NULL before calling
kzalloc() and check it before dereferencing it.

Fixes: e348544f7994 ("gpio: protect the list of GPIO devices with SRCU")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20251103141132.53471-1-brgl@bgdev.pl
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index e5d0d2b0d7989..967ff661e4c96 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4997,6 +4997,8 @@ static void *gpiolib_seq_start(struct seq_file *s, loff_t *pos)
 	struct gpio_device *gdev;
 	loff_t index = *pos;
 
+	s->private = NULL;
+
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return NULL;
@@ -5030,7 +5032,11 @@ static void *gpiolib_seq_next(struct seq_file *s, void *v, loff_t *pos)
 
 static void gpiolib_seq_stop(struct seq_file *s, void *v)
 {
-	struct gpiolib_seq_priv *priv = s->private;
+	struct gpiolib_seq_priv *priv;
+
+	priv = s->private;
+	if (!priv)
+		return;
 
 	srcu_read_unlock(&gpio_devices_srcu, priv->idx);
 	kfree(priv);
-- 
2.51.0




