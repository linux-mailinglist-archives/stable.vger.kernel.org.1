Return-Path: <stable+bounces-78416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E523698B989
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1411F233BD
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A257619D08C;
	Tue,  1 Oct 2024 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BIlolhIm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6375E3209
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778298; cv=none; b=mSVoj4/Y4gq9t3l/iWLC4c47WCbdmtWuwpCgt333EO1Qy+x/NrUriN33qVxQck9zDroWWHF2E4WpNpWqAwFhS+wHuUFJaa6T0pjpRSx+pWjy0SokClm8kCsc07lFTAMKjKP1lAyqNClZVrWxxS7j0WtUmDgCi2IVd8aQf39D4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778298; c=relaxed/simple;
	bh=eXS9N+HgozgbxnHwYgnz6oZvO/4KKrBCw7USaTea/BU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aj99MtaPtCd2h3aZAPjoIcHhK+L0EIDVmNitfvdpD3A9fkZkHCmWiBHshrD4wBY6DkeC5MhEQvBObZMN0qFIgC9oLnBu/83Twp4cEVPq5Q0/3bYztHQe2CzYAOsZUFUFPghoF1vlkS8LM7VOPal4R29kGhF3EMQFwPrUQlVVhTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BIlolhIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03DAC4CEC6;
	Tue,  1 Oct 2024 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778298;
	bh=eXS9N+HgozgbxnHwYgnz6oZvO/4KKrBCw7USaTea/BU=;
	h=Subject:To:Cc:From:Date:From;
	b=BIlolhIm1c4whLrofOytr3gsj42NtRZ7SZxjmPwFhZEtwPZ7la4laU2mDYwrK9ffO
	 UIN3QH6hF/4cg6zyG3b4p4JEM64qHmAokjmiShxVURN5FGJTvND5ezDd/2ZQvTlodA
	 NuAhsVbuIslWs+QkrcmbyTb1eDYCa42nPWWEmlVs=
Subject: FAILED: patch "[PATCH] pps: add an error check in parport_attach" failed to apply to 6.1-stable tree
To: make24@iscas.ac.cn,giometti@enneenne.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:24:53 +0200
Message-ID: <2024100153-escapable-tank-00f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 62c5a01a5711c8e4be8ae7b6f0db663094615d48
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100153-escapable-tank-00f9@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


