Return-Path: <stable+bounces-195353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8C9C755F4
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 196152BCE3
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34905368282;
	Thu, 20 Nov 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N8XH912u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EBE35B15A
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656171; cv=none; b=jTBxFNhcQgoeaydDaCSzbjCzGN5T+Aj9KroZT3d7hqUvpvnkVCST597RKz/1ww2BaTLVXnBFihBpWXOSowIqjHKFgVyzJeINtOAEnTv92p8vW4UrYolUyxL5kzz2+OvlF7TZ0tEs0leT4LvzWOUOYBsCq763g4Llysktqp5wdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656171; c=relaxed/simple;
	bh=24+Paez/3rpjbvUDhwziImq2DpsxhPR49vW+09O+j1k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UzcbeAfA2XpOXv0oU5kAp/HNxaXY9T6j7SuSo5MebQn9yRA7p5fZxCfi35Wk08VZsrTl1jsoRqpQgv6W+actGe2BymdeY+HTOsAWl0Ba2UMZC5qRGVKi6/jIycFqq0cLk4gs+vn44+el5twunEc5EtASe3xZKgUSUA82CDKuL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N8XH912u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9C9C4CEF1;
	Thu, 20 Nov 2025 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656171;
	bh=24+Paez/3rpjbvUDhwziImq2DpsxhPR49vW+09O+j1k=;
	h=Subject:To:Cc:From:Date:From;
	b=N8XH912umGiwAxy9l96DAZ36TpVXxGS4MAaYGqdDy0wyKRX6iuXDYD13gOmscToD1
	 ROzRCX1b2/2w7V+O2UPi5JpChKF1FMfIzsFIz3PTyP555hFdzksbHz5IpBcGhKiUVa
	 PtWAEcyregASMydwKMwWICkhicLcyjNsqbGlAhgk=
Subject: FAILED: patch "[PATCH] pmdomain: imx: Fix reference count leak in imx_gpc_remove" failed to apply to 5.4-stable tree
To: linmq006@gmail.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:29:11 +0100
Message-ID: <2025112011-seltzer-flock-722f@gregkh>
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
git cherry-pick -x bbde14682eba21d86f5f3d6fe2d371b1f97f1e61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112011-seltzer-flock-722f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bbde14682eba21d86f5f3d6fe2d371b1f97f1e61 Mon Sep 17 00:00:00 2001
From: Miaoqian Lin <linmq006@gmail.com>
Date: Tue, 28 Oct 2025 11:16:20 +0800
Subject: [PATCH] pmdomain: imx: Fix reference count leak in imx_gpc_remove

of_get_child_by_name() returns a node pointer with refcount incremented, we
should use of_node_put() on it when not needed anymore. Add the missing
of_node_put() to avoid refcount leak.

Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 33991f3c6b55..a34b260274f7 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -536,6 +536,8 @@ static void imx_gpc_remove(struct platform_device *pdev)
 			return;
 		}
 	}
+
+	of_node_put(pgc_node);
 }
 
 static struct platform_driver imx_gpc_driver = {


