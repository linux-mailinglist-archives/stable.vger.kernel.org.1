Return-Path: <stable+bounces-87007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B939A5D9E
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC101F2153F
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4FC1E0B9C;
	Mon, 21 Oct 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O8JNDIen"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9397C1E0E0C
	for <stable@vger.kernel.org>; Mon, 21 Oct 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497134; cv=none; b=uC6D/09/5XPqOVs/Z+f/1aRhz6+WNMVGFsiuMqxFXIFgvECIKmnDH6MR6e5saDJht/FQJ/N4tAlh46BvSEPb2Nu379wnPCC2prntD1V94OsfXuzTZcfQn8it/XvJXrlaiCxpZybbdzVurAoyB2s/ORxG1cz4+SKgu3Ykipg7zo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497134; c=relaxed/simple;
	bh=2K2GRtouArGlDPeM/fH9zSnkA4EuiPRioDvjUOyeJO4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NAFWBUmzYKLCzCH8ABlyd9WOsIYFT0PyO5HZpApAWWeTeRFo69+5EmT6A+j++dOBwkGx0kQ9FT5H6yKrisdKr3r8xpyKw6q3ldTXjpCs26e0cLtDz11dac6gr6pGp6C3nfU8TTgUOLp/r8SD0c/L4fiThPZySdQv7/r1rKkd6P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O8JNDIen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9ED7C4CEC3;
	Mon, 21 Oct 2024 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729497134;
	bh=2K2GRtouArGlDPeM/fH9zSnkA4EuiPRioDvjUOyeJO4=;
	h=Subject:To:Cc:From:Date:From;
	b=O8JNDIenNisL5KLaF/Zsz1lGow356V42Y0534JXqXQOqElelNqYFAyZI3yEQWgtpU
	 TqgpyG/996Lr5DiImpMnmGuThzO29QgdcNMQNwrRmo15dYIRmnJNR55LxjbXT2jFf/
	 imSnAb4Dt3DWlverFuCervkbDgPucWPZnfjH0VjE=
Subject: FAILED: patch "[PATCH] usb: gadget: f_uac2: fix return value for" failed to apply to 6.6-stable tree
To: kgroeneveld@lenbrook.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Oct 2024 09:52:11 +0200
Message-ID: <2024102111-unbalance-roman-5bdd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9499327714de7bc5cf6c792112c1474932d8ad31
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024102111-unbalance-roman-5bdd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9499327714de7bc5cf6c792112c1474932d8ad31 Mon Sep 17 00:00:00 2001
From: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Date: Sun, 6 Oct 2024 19:26:31 -0400
Subject: [PATCH] usb: gadget: f_uac2: fix return value for
 UAC2_ATTRIBUTE_STRING store

The configfs store callback should return the number of bytes consumed
not the total number of bytes we actually stored. These could differ if
for example the passed in string had a newline we did not store.

If the returned value does not match the number of bytes written the
writer might assume a failure or keep trying to write the remaining bytes.

For example the following command will hang trying to write the final
newline over and over again (tested on bash 2.05b):

  echo foo > function_name

Fixes: 993a44fa85c1 ("usb: gadget: f_uac2: allow changing interface name via configfs")
Cc: stable <stable@kernel.org>
Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
Link: https://lore.kernel.org/r/20241006232637.4267-1-kgroeneveld@lenbrook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 1cdda44455b3..ce5b77f89190 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -2061,7 +2061,7 @@ static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
 					  const char *page, size_t len)	\
 {									\
 	struct f_uac2_opts *opts = to_f_uac2_opts(item);		\
-	int ret = 0;							\
+	int ret = len;							\
 									\
 	mutex_lock(&opts->lock);					\
 	if (opts->refcnt) {						\
@@ -2072,8 +2072,8 @@ static ssize_t f_uac2_opts_##name##_store(struct config_item *item,	\
 	if (len && page[len - 1] == '\n')				\
 		len--;							\
 									\
-	ret = scnprintf(opts->name, min(sizeof(opts->name), len + 1),	\
-			"%s", page);					\
+	scnprintf(opts->name, min(sizeof(opts->name), len + 1),		\
+		  "%s", page);						\
 									\
 end:									\
 	mutex_unlock(&opts->lock);					\


