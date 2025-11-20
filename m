Return-Path: <stable+bounces-195351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBACC7569A
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F05C364379
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECB7358D22;
	Thu, 20 Nov 2025 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VWM4G2hS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5B63358A1
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656166; cv=none; b=XGxYKSMuXp/34/+HDYRSdQaiOfvj9E6oyttAkDoWobZwMYncPnpUdJYvBI4LGZvcHa3AlzopZVED32dRssxnfvVPXc6ekKp/nAFDOjt3g/s/99GVhT+OjEMXMJOxO8sxwn63gALB2AreyUnvnswMA7x/HPIj3nYS3Cp2QxrGEFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656166; c=relaxed/simple;
	bh=w0qO68hhIQyHWM1oAQwfupOpPq6V8IcLspVZ5bqFKd4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qjftg/WYFWrhTpvjtK7Og/tnNKN7ijOBGTrGa4iLKZv5jzRq6XXxhlZoqG63iKAkbiNM+p6waHlpANs+++uPgCtbQA/u0wcf6Xmu7t3ABFBB2Y8gOdqMdOaxJhGz8qXe6TrvGXmG9cGi3b0d1STcjB+7VVAoPTAgwtW50YZjyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VWM4G2hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0ED3C4CEF1;
	Thu, 20 Nov 2025 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763656166;
	bh=w0qO68hhIQyHWM1oAQwfupOpPq6V8IcLspVZ5bqFKd4=;
	h=Subject:To:Cc:From:Date:From;
	b=VWM4G2hSkl2+9OWSfJSa6vTlUEdYsCKkQX4K94ovhxWh1oOI5kuQmSZItLHyfCcx8
	 Ws1PalB+t3TyVm+ymm90+ZtKWB3yiurLhHsoY3xykYi/fglwVpR56H5KX3VXoLhiP8
	 g4KLkYWP3Zu0lZP472keqqegbFy76gssbolwa3Yc=
Subject: FAILED: patch "[PATCH] pmdomain: imx: Fix reference count leak in imx_gpc_remove" failed to apply to 5.10-stable tree
To: linmq006@gmail.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 17:29:10 +0100
Message-ID: <2025112010-prewashed-hatchback-7cb7@gregkh>
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
git cherry-pick -x bbde14682eba21d86f5f3d6fe2d371b1f97f1e61
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112010-prewashed-hatchback-7cb7@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


