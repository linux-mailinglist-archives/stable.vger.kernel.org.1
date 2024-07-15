Return-Path: <stable+bounces-59310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42F293121B
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 12:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9301C2236B
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 10:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBCA187351;
	Mon, 15 Jul 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ilGu+oWg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A41862A2
	for <stable@vger.kernel.org>; Mon, 15 Jul 2024 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721038634; cv=none; b=FXuIYhIL9zT9iGPdmPJdgwVQiC27aTD/jRCykND6nCqqP/OyOzPmejeqW3qb5hksTtIzO9poRmu5cXzfe40Scz1plyU8Gwvxm4DFAsUIMr3KyLiVqYrtROXfB5FqNbuXfpuNV0fyjsCsisQ4OOrFzja5e6h+CyEPp5eOuGBti4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721038634; c=relaxed/simple;
	bh=ILcp6l/pU7uhD7WHE1XSOyKGCx8ZZLo17lITSyuV2Wc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bb9z79ly1hl68acvNsXmpwYDwqQsTq3uMWu78RgqbTLZMT8EP4AoSHp1z6WTswnGnsdPtDNZHJj/dlKAXk17L1d10FKqH13uChTv080nBoy5AMMPJXssVrEJCjFJrRXrKqY3luqkPijiFe/Lrp1HJ7laaVedBtWkHgpYqBVFL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ilGu+oWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1126EC32782;
	Mon, 15 Jul 2024 10:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721038634;
	bh=ILcp6l/pU7uhD7WHE1XSOyKGCx8ZZLo17lITSyuV2Wc=;
	h=Subject:To:Cc:From:Date:From;
	b=ilGu+oWgfIQsjq5LR6JSF8DZh+upl9MvgEhRKrDDEu7yW8tI4agi8MOGit3mkZkOh
	 XBumFI7guF88AgDiMpEqtwS7vmeIQXGV4XQ4FTkQgN2+buHCXo1wnTn5jCcjdvd4Hg
	 OhHXeRQ26+86RARO5xo2M/OpDuYnCNlnvk7+RM8c=
Subject: FAILED: patch "[PATCH] nvmem: meson-efuse: Fix return value of nvmem callbacks" failed to apply to 4.19-stable tree
To: joychakr@google.com,dan.carpenter@linaro.org,gregkh@linuxfoundation.org,neil.armstrong@linaro.org,srinivas.kandagatla@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jul 2024 12:17:11 +0200
Message-ID: <2024071511-unwritten-backache-b96e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 7a0a6d0a7c805f9380381f4deedffdf87b93f408
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024071511-unwritten-backache-b96e@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

7a0a6d0a7c80 ("nvmem: meson-efuse: Fix return value of nvmem callbacks")
8cde3c2153e8 ("firmware: meson_sm: Rework driver as a proper platform driver")
611fbca1c861 ("nvmem: meson-efuse: add peripheral clock")
8649dbe58d35 ("nvmem: meson-efuse: add error message on user_max failure.")
0789724f86a5 ("firmware: meson_sm: Add serial number sysfs entry")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7a0a6d0a7c805f9380381f4deedffdf87b93f408 Mon Sep 17 00:00:00 2001
From: Joy Chakraborty <joychakr@google.com>
Date: Fri, 28 Jun 2024 12:37:02 +0100
Subject: [PATCH] nvmem: meson-efuse: Fix return value of nvmem callbacks

Read/write callbacks registered with nvmem core expect 0 to be returned
on success and a negative value to be returned on failure.

meson_efuse_read() and meson_efuse_write() call into
meson_sm_call_read() and meson_sm_call_write() respectively which return
the number of bytes read or written on success as per their api
description.

Fix to return error if meson_sm_call_read()/meson_sm_call_write()
returns an error else return 0.

Fixes: a29a63bdaf6f ("nvmem: meson-efuse: simplify read callback")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20240628113704.13742-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 33678d0af2c2..6c2f80e166e2 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -18,18 +18,24 @@ static int meson_efuse_read(void *context, unsigned int offset,
 			    void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
 
-	return meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
-				  bytes, 0, 0, 0);
+	ret = meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
+				 bytes, 0, 0, 0);
+
+	return ret < 0 ? ret : 0;
 }
 
 static int meson_efuse_write(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
 
-	return meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
-				   bytes, 0, 0, 0);
+	ret = meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+				  bytes, 0, 0, 0);
+
+	return ret < 0 ? ret : 0;
 }
 
 static const struct of_device_id meson_efuse_match[] = {


