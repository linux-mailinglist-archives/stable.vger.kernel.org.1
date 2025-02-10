Return-Path: <stable+bounces-114553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E70A2EE8E
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210433A03E6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A2B22257D;
	Mon, 10 Feb 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CHfnhjh2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927BA17BB6
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739194910; cv=none; b=tenVDtbbMKDvP03yJAqjKYjEPn92irnKc+OMfAupN4nN4n9TB0NQ9Dr/wuYEIhyWtz3fhwLNIe55IdPJrtk16gEQspqAwxstSgnKwjb51ZbOdhxUq5/OLcRUAjG9vYKJXy+ycX3wLxe6FmNEpKWmOX0COYZlAGbRMGhDNTd+U/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739194910; c=relaxed/simple;
	bh=NPdJXKw7rn1QLRvud6CnP6GwXEAGMoEZdx9HNkkKrCs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ATkPt6+3rpuaHPdVRrbmLw+WskwYImjwA10czqgf2v0Q3eCbe+onMAofLiBWiJxqarAZmUGpSCLoIn10nWHgD8/TSFcqZ4OlauQlRUuf92CCOXJvVbiKXJC0r4JSvnPpYM56iR/6KctpLTNJnXbZ2oV5gkGLohGD7ayHOK0+GYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CHfnhjh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EEEC4CED1;
	Mon, 10 Feb 2025 13:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739194910;
	bh=NPdJXKw7rn1QLRvud6CnP6GwXEAGMoEZdx9HNkkKrCs=;
	h=Subject:To:Cc:From:Date:From;
	b=CHfnhjh2gfM16wwqQFrlcfsQnr/ACnwI9LI8i7QwuTsVhrZ15eaEfQc2dx+2P4hDt
	 001TwLa+A3qOJ1VTUv38H9dRnCI1YbKQk+Is4TEju0L79Dyza5gJjXxDo8Mw21foiV
	 FuncVt9739yd78vCA1JA9rB9ncbAmxGYMk6/bwMI=
Subject: FAILED: patch "[PATCH] Input: bbnsm_pwrkey - add remove hook" failed to apply to 6.6-stable tree
To: peng.fan@nxp.com,dmitry.torokhov@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:41:47 +0100
Message-ID: <2025021047-wiry-tweed-c09f@gregkh>
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
git cherry-pick -x 55b75306c3edf369285ce22ba1ced45e335094c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021047-wiry-tweed-c09f@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 55b75306c3edf369285ce22ba1ced45e335094c2 Mon Sep 17 00:00:00 2001
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 12 Dec 2024 11:03:22 +0800
Subject: [PATCH] Input: bbnsm_pwrkey - add remove hook

Without remove hook to clear wake irq, there will be kernel dump when
doing module test.
"bbnsm_pwrkey 44440000.bbnsm:pwrkey: wake irq already initialized"

Add remove hook to clear wake irq and set wakeup to false.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Fixes: 40e40fdfec3f ("Input: bbnsm_pwrkey - add bbnsm power key support")
Link: https://lore.kernel.org/r/20241212030322.3110017-1-peng.fan@oss.nxp.com
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/input/misc/nxp-bbnsm-pwrkey.c b/drivers/input/misc/nxp-bbnsm-pwrkey.c
index eb4173f9c820..7ba8d166d68c 100644
--- a/drivers/input/misc/nxp-bbnsm-pwrkey.c
+++ b/drivers/input/misc/nxp-bbnsm-pwrkey.c
@@ -187,6 +187,12 @@ static int bbnsm_pwrkey_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void bbnsm_pwrkey_remove(struct platform_device *pdev)
+{
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
+}
+
 static int __maybe_unused bbnsm_pwrkey_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -223,6 +229,8 @@ static struct platform_driver bbnsm_pwrkey_driver = {
 		.of_match_table = bbnsm_pwrkey_ids,
 	},
 	.probe = bbnsm_pwrkey_probe,
+	.remove = bbnsm_pwrkey_remove,
+
 };
 module_platform_driver(bbnsm_pwrkey_driver);
 


