Return-Path: <stable+bounces-99004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3104D9E6D35
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E670E283677
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 11:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E7B1FBC88;
	Fri,  6 Dec 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ac9hXpzH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C4B1FA24F
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484100; cv=none; b=Q7UwrVz3nVCUFRh2b4H8TG8zPyVGbXsvCdiolLUOk6FokzymejqdWJ6xjRLt0uEUzxg9gzIYkR0/Eq7AT1NiRzjc44002E1ZnmvQAtNGxyv6NcpKxOYHTICNYie1x481QasfRrl+cZUqTjLqvNs2pMDaqkBKXlgmgRdO/JsveqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484100; c=relaxed/simple;
	bh=AzXSTuUtK3DhywzqmHLRzG/3rm4v5k2+o3FYEJrYEns=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jBcHzJ6nNbxkQpgFyWoeu6azm04sTbvnwbatVi57PcbrVwq3cxsQBS8v2zHQ9OYqak7BnHNP4/Mo4iVvgUPgGSaGB5TTes5Y8/ghSLLfj7yivrbNBs/7zbUuuF6iRA4u2N93eTH6WFdX5Ch7sLQhQP9/y25h0TZdSH/+By5iGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ac9hXpzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F306C4CEDD;
	Fri,  6 Dec 2024 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733484099;
	bh=AzXSTuUtK3DhywzqmHLRzG/3rm4v5k2+o3FYEJrYEns=;
	h=Subject:To:Cc:From:Date:From;
	b=ac9hXpzHZo+83jgcMsz9MgWe6z7UpouDoD0OsdtOdW+1O283+yhhnpKMs/+gQhydT
	 nj1ELUfVEWLm3HvRIHr182P1Rz8UeiiTHJimBwjBikjVJCHpVvAM/1yYAHiK5ocYvn
	 uaL+rOLchf0KqIkvvNmZPhnOed3eFoWJbdiHHwHE=
Subject: FAILED: patch "[PATCH] media: platform: exynos4-is: Fix an OF node reference leak in" failed to apply to 5.4-stable tree
To: joe@pf.is.s.u-tokyo.ac.jp,hverkuil@xs4all.nl,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 12:21:25 +0100
Message-ID: <2024120625-vanish-sizing-e68e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8964eb23408243ae0016d1f8473c76f64ff25d20
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120625-vanish-sizing-e68e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8964eb23408243ae0016d1f8473c76f64ff25d20 Mon Sep 17 00:00:00 2001
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Date: Mon, 4 Nov 2024 19:01:19 +0900
Subject: [PATCH] media: platform: exynos4-is: Fix an OF node reference leak in
 fimc_md_is_isp_available

In fimc_md_is_isp_available(), of_get_child_by_name() is called to check
if FIMC-IS is available. Current code does not decrement the refcount of
the returned device node, which causes an OF node reference leak. Fix it
by calling of_node_put() at the end of the variable scope.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Fixes: e781bbe3fecf ("[media] exynos4-is: Add fimc-is subdevs registration")
Cc: stable@vger.kernel.org
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[hverkuil: added CC to stable]

diff --git a/drivers/media/platform/samsung/exynos4-is/media-dev.h b/drivers/media/platform/samsung/exynos4-is/media-dev.h
index 786264cf79dc..a50e58ab7ef7 100644
--- a/drivers/media/platform/samsung/exynos4-is/media-dev.h
+++ b/drivers/media/platform/samsung/exynos4-is/media-dev.h
@@ -178,8 +178,9 @@ int fimc_md_set_camclk(struct v4l2_subdev *sd, bool on);
 #ifdef CONFIG_OF
 static inline bool fimc_md_is_isp_available(struct device_node *node)
 {
-	node = of_get_child_by_name(node, FIMC_IS_OF_NODE_NAME);
-	return node ? of_device_is_available(node) : false;
+	struct device_node *child __free(device_node) =
+		of_get_child_by_name(node, FIMC_IS_OF_NODE_NAME);
+	return child ? of_device_is_available(child) : false;
 }
 #else
 #define fimc_md_is_isp_available(node) (false)


