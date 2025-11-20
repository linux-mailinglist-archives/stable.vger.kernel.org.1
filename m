Return-Path: <stable+bounces-195349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DD4C756AF
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB9C034FA2F
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35C4362145;
	Thu, 20 Nov 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HY0fZGRA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DCF274FC2
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656160; cv=none; b=Px9I6+ujltsr+OeZppr7NzJ40sctm9gnOjJ/YRaXFOO/kjZM3cYTI1ula8jnBLvUOyKjI4UST0pHzrfTVbHGELXeOKoNdlB57S0aM3Nj75lvu7shXpxBoRi/6Uz5K372SOcl5zS03/veMHtK76lXElQRPE5KtPfuFWbWWOpbyZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656160; c=relaxed/simple;
	bh=oDnBiczSSUq26tm41JX0IodTY2TvxBRJH6Sk/fM+QDI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q3fd2vbmenn40TfIRDvrIahqlYHEWgun1Rz4m3bwLZ45WWjVxnZi48O+Inh9+xlvznKkKD8KBMbeaZTZMZIkSOfyDjpshR8b+aFa2bmGluLaoizonIrLMll0HJ9ysFVULP58xvsIxANC+AixAiS+hhEMCVvjEowpI4wDmkw/bCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HY0fZGRA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD0DC4CEF1;
	Thu, 20 Nov 2025 16:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656160;
	bh=oDnBiczSSUq26tm41JX0IodTY2TvxBRJH6Sk/fM+QDI=;
	h=Subject:To:Cc:From:Date:From;
	b=HY0fZGRA7OogQy0mKpCG25I5KpTdIrFaIQrriEhAqkiUv0OU5KABzzqlWc8P8xIa1
	 N355Hm7T6YzlW8VgDj3l9FABgE4xnticRY7KahvYDET6llRyLl9pvrscojKOc9kBwr
	 YGeXmq5+BV92EDx5h21nNh+rGRKQAy80fPeOFmT0=
Subject: FAILED: patch "[PATCH] pmdomain: imx: Fix reference count leak in imx_gpc_remove" failed to apply to 6.6-stable tree
To: linmq006@gmail.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:29:09 +0100
Message-ID: <2025112009-appliance-symptom-7a59@gregkh>
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
git cherry-pick -x bbde14682eba21d86f5f3d6fe2d371b1f97f1e61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112009-appliance-symptom-7a59@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


