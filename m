Return-Path: <stable+bounces-112221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D3A27915
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 18:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C995164CD1
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 17:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54311216E06;
	Tue,  4 Feb 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y2zCTnDN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117A21661F
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 17:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691722; cv=none; b=owZxxiK+qg8UQded7YX0jm5jzBj9jACXqb+txyH7wcxMWGHP40da9gJxdavpVXkEg9y8q6sAcaA0uyDAtP3zpyv1wUu7193Xi/0GeHVvB2j8QxXwlL2YjUCJ0wy0FI7Mmh+tMpNYweKS1H25YhjRSHku2eiXxxbdkDqKKx7k78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691722; c=relaxed/simple;
	bh=62/9Yzrdlp+F1egpqSxmL1UghcPhBOessMlgNSJS5sg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=efcFBi6IMtUTEnDZhNzgG/62lBzLYlfq+Xy0j6sEKmCamgICKbSKuorI3PIldJH0Dd65KFiT77v9qMjyGxdZfPx38Yo7oK9AUQcHvZ9Cew1z4ECB5YRmBvasIH0c1/RxdPZmhZzWNuS5IeETT3s4H8sSYM2LSSwQmtD8hfQBq+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y2zCTnDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85352C4CEDF;
	Tue,  4 Feb 2025 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738691721;
	bh=62/9Yzrdlp+F1egpqSxmL1UghcPhBOessMlgNSJS5sg=;
	h=Subject:To:Cc:From:Date:From;
	b=Y2zCTnDNL4TzwTRK6h+2offHpVojtmsufu4S+/5RYsOIcldR/sf4jNdHD4O+FbrRv
	 0sOpXa6YaCPsdZlI+h3E6BUx6HmDX+mIH0l9B3H3/3XSbjtE6Isc4MielLOdZl4xun
	 3rC7OASGQ1ngJcjnABWsLZ165rG8ZLuPNqFGqYKI=
Subject: FAILED: patch "[PATCH] media: imx-jpeg: Fix potential error pointer dereference in" failed to apply to 5.15-stable tree
To: dan.carpenter@linaro.org,hverkuil@xs4all.nl,ming.qian@nxp.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 04 Feb 2025 18:54:58 +0100
Message-ID: <2025020458-egotism-espresso-bb20@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1378ffec30367233152b7dbf4fa6a25ee98585d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025020458-egotism-espresso-bb20@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1378ffec30367233152b7dbf4fa6a25ee98585d1 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 17 Oct 2024 23:34:16 +0300
Subject: [PATCH] media: imx-jpeg: Fix potential error pointer dereference in
 detach_pm()

The proble is on the first line:

	if (jpeg->pd_dev[i] && !pm_runtime_suspended(jpeg->pd_dev[i]))

If jpeg->pd_dev[i] is an error pointer, then passing it to
pm_runtime_suspended() will lead to an Oops.  The other conditions
check for both error pointers and NULL, but it would be more clear to
use the IS_ERR_OR_NULL() check for that.

Fixes: fd0af4cd35da ("media: imx-jpeg: Ensure power suppliers be suspended before detach them")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 7f5fe551179b..1221b309a916 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -2677,11 +2677,12 @@ static void mxc_jpeg_detach_pm_domains(struct mxc_jpeg_dev *jpeg)
 	int i;
 
 	for (i = 0; i < jpeg->num_domains; i++) {
-		if (jpeg->pd_dev[i] && !pm_runtime_suspended(jpeg->pd_dev[i]))
+		if (!IS_ERR_OR_NULL(jpeg->pd_dev[i]) &&
+		    !pm_runtime_suspended(jpeg->pd_dev[i]))
 			pm_runtime_force_suspend(jpeg->pd_dev[i]);
-		if (jpeg->pd_link[i] && !IS_ERR(jpeg->pd_link[i]))
+		if (!IS_ERR_OR_NULL(jpeg->pd_link[i]))
 			device_link_del(jpeg->pd_link[i]);
-		if (jpeg->pd_dev[i] && !IS_ERR(jpeg->pd_dev[i]))
+		if (!IS_ERR_OR_NULL(jpeg->pd_dev[i]))
 			dev_pm_domain_detach(jpeg->pd_dev[i], true);
 		jpeg->pd_dev[i] = NULL;
 		jpeg->pd_link[i] = NULL;


