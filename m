Return-Path: <stable+bounces-78420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D260398B98D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBD51F23415
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC856192D74;
	Tue,  1 Oct 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Dims67N/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E68E3209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778311; cv=none; b=KRmipNl3Cy5HXt3Jk4XXx/jKkvUs063AAbc6CmBWzvtaGvuu+cepCtqzaxd6i/SrHNvULQk1QihAZ5OBTTn+GgZv2rNeP8cKDct9fZsT/gLnAofcf4MWwEGql3yonVcczsvR9b+ZG6S7KP87pmJqsK9nGYt1ZAMPkaHvDzTheRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778311; c=relaxed/simple;
	bh=iv6XNIvfrovzA0FJVj+PQf73NHO33pmD4BsY8XpImvY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nrDuEIkA0rc4BIcv2opeCGvaM2tcAcn8CKhDfJAVC5cj/9wVrXbtfP21rxLBjOm/FPmEi6oUB3Hy/aJOqxpRlx4J3IqYDdvWcT1Nw7oXaZtPf5rme2AuECryemMj9djiXk8R7Kn+ocgksbMTTKkZI8UaG4VxH0hOsbL6lCJ4r6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dims67N/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9378C4CEC6;
	Tue,  1 Oct 2024 10:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778311;
	bh=iv6XNIvfrovzA0FJVj+PQf73NHO33pmD4BsY8XpImvY=;
	h=Subject:To:Cc:From:Date:From;
	b=Dims67N/2j2FMedoaWvpMzpLT7PCasIehnMDoRjTvbou1ikNMiPOxgpnA/ovFy/MS
	 fnF8pecDWyFRQBAubq1SIxsxyE6jQYQra0scYao78nugiEjuHMNl2QV+Xa4QhQiJnF
	 WTWXp1ree6iT0b+RxqTeoipS6SXYUPmGHyLtYw1w=
Subject: FAILED: patch "[PATCH] pps: add an error check in parport_attach" failed to apply to 4.19-stable tree
To: make24@iscas.ac.cn,giometti@enneenne.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:24:56 +0200
Message-ID: <2024100156-boasting-salute-2f1f@gregkh>
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
git cherry-pick -x 62c5a01a5711c8e4be8ae7b6f0db663094615d48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100156-boasting-salute-2f1f@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

62c5a01a5711 ("pps: add an error check in parport_attach")
55dbc5b5174d ("pps: remove usage of the deprecated ida_simple_xx() API")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 62c5a01a5711c8e4be8ae7b6f0db663094615d48 Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Wed, 28 Aug 2024 21:18:14 +0800
Subject: [PATCH] pps: add an error check in parport_attach

In parport_attach, the return value of ida_alloc is unchecked, witch leads
to the use of an invalid index value.

To address this issue, index should be checked. When the index value is
abnormal, the device should be freed.

Found by code review, compile tested only.

Cc: stable@vger.kernel.org
Fixes: fb56d97df70e ("pps: client: use new parport device model")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Link: https://lore.kernel.org/r/20240828131814.3034338-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 63d03a0df5cc..abaffb4e1c1c 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -149,6 +149,9 @@ static void parport_attach(struct parport *port)
 	}
 
 	index = ida_alloc(&pps_client_index, GFP_KERNEL);
+	if (index < 0)
+		goto err_free_device;
+
 	memset(&pps_client_cb, 0, sizeof(pps_client_cb));
 	pps_client_cb.private = device;
 	pps_client_cb.irq_func = parport_irq;
@@ -159,7 +162,7 @@ static void parport_attach(struct parport *port)
 						    index);
 	if (!device->pardev) {
 		pr_err("couldn't register with %s\n", port->name);
-		goto err_free;
+		goto err_free_ida;
 	}
 
 	if (parport_claim_or_block(device->pardev) < 0) {
@@ -187,8 +190,9 @@ static void parport_attach(struct parport *port)
 	parport_release(device->pardev);
 err_unregister_dev:
 	parport_unregister_device(device->pardev);
-err_free:
+err_free_ida:
 	ida_free(&pps_client_index, index);
+err_free_device:
 	kfree(device);
 }
 


