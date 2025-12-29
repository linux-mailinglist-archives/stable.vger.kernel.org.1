Return-Path: <stable+bounces-203662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 624C5CE7451
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF71730142EF
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E519C264627;
	Mon, 29 Dec 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svbwSEFX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6A23F27B
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023828; cv=none; b=ZH220TNXphhPpStHzB7rAlNBWWvaj/AT3DqNQZj0oKRWLWFb5V5Ij5j1LuuCC5ooVf8ZoJdJZnnqXRRcfsW8ly7Fb3bzVpdRZ6caoGP8nCXIlmP7/EN1bjB0PGIPoeDqBpIV21BF7AdVy9L4PaW+DeIjwDMs8Oot01shjT5FppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023828; c=relaxed/simple;
	bh=3iXP6z4K1lXBLk9ta1oYyz97crRvex4kgNxshl/G5jw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L40FCorZoBOqHB031E1ISfZOzXRtYph6mGBm6LmDPSqe72NdDEr7e3KUggKupEmYhlZ4VjglEmNhjuV9LEztxGtn7GCn1h6xJHmfoHUfxGbwMONzU0WQaMZMYwBpSmH1hMUKk1Peoex0M1Ad6AjmTB9iGxtiRu3OYPn2Arj1CL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svbwSEFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B6BC4CEF7;
	Mon, 29 Dec 2025 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767023828;
	bh=3iXP6z4K1lXBLk9ta1oYyz97crRvex4kgNxshl/G5jw=;
	h=Subject:To:Cc:From:Date:From;
	b=svbwSEFXC3OWYw4HOaXOmRfZrs1Jb+Kgjvky4Hcy5uqy5ybiVt6YHYXBakFdPdpmn
	 NbtoHsioKv+4oTODATxsLdA0C/hcgkVCH4LplYY3KwXlBBbs3PR3VQxaXupu28mpcL
	 GvTJekE8Na1lZxB6HkvNWSyee14d19Nok9Kj8rOk=
Subject: FAILED: patch "[PATCH] hwmon: (max16065) Use local variable to avoid TOCTOU" failed to apply to 5.10-stable tree
To: hanguidong02@gmail.com,linux@roeck-us.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 16:57:05 +0100
Message-ID: <2025122905-unstable-smuggling-c1a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b8d5acdcf525f44e521ca4ef51dce4dac403dab4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122905-unstable-smuggling-c1a3@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8d5acdcf525f44e521ca4ef51dce4dac403dab4 Mon Sep 17 00:00:00 2001
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Fri, 28 Nov 2025 20:47:09 +0800
Subject: [PATCH] hwmon: (max16065) Use local variable to avoid TOCTOU

In max16065_current_show, data->curr_sense is read twice: once for the
error check and again for the calculation. Since
i2c_smbus_read_byte_data returns negative error codes on failure, if the
data changes to an error code between the check and the use, ADC_TO_CURR
results in an incorrect calculation.

Read data->curr_sense into a local variable to ensure consistency. Note
that data->curr_gain is constant and safe to access directly.

This aligns max16065_current_show with max16065_input_show, which
already uses a local variable for the same reason.

Link: https://lore.kernel.org/all/CALbr=LYJ_ehtp53HXEVkSpYoub+XYSTU8Rg=o1xxMJ8=5z8B-g@mail.gmail.com/
Fixes: f5bae2642e3d ("hwmon: Driver for MAX16065 System Manager and compatibles")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://lore.kernel.org/r/20251128124709.3876-1-hanguidong02@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/max16065.c b/drivers/hwmon/max16065.c
index 0ccb5eb596fc..4c9e7892a73c 100644
--- a/drivers/hwmon/max16065.c
+++ b/drivers/hwmon/max16065.c
@@ -216,12 +216,13 @@ static ssize_t max16065_current_show(struct device *dev,
 				     struct device_attribute *da, char *buf)
 {
 	struct max16065_data *data = max16065_update_device(dev);
+	int curr_sense = data->curr_sense;
 
-	if (unlikely(data->curr_sense < 0))
-		return data->curr_sense;
+	if (unlikely(curr_sense < 0))
+		return curr_sense;
 
 	return sysfs_emit(buf, "%d\n",
-			  ADC_TO_CURR(data->curr_sense, data->curr_gain));
+			  ADC_TO_CURR(curr_sense, data->curr_gain));
 }
 
 static ssize_t max16065_limit_store(struct device *dev,


