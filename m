Return-Path: <stable+bounces-53626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E322990D321
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0FE2825C1
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E1E156652;
	Tue, 18 Jun 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uq5QEX0I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3C618040
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717687; cv=none; b=AKYYA+zWUWf5ZcVl9AP7tfSZzPTXGyqWLCQeuQmeWKj5u5JMFkGpjyjtqoHr7UUFircgH6zU+Y6PXw29UMR5M8RV+ZhmRk+eGjmDJmHFhqpD14gxZ7kg3lLwwddBfiis7nbDxm0/bRw97NdFxZE8gNWC4x7llFwFkl5bEVomPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717687; c=relaxed/simple;
	bh=bKXihXcqi4A23xOrKQ2+JR3WIoUXqHwQ3yua4RBbBag=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kMHutIisAcVh8l6Jg4Pn8GvDE8n5kBnHZO3221icHjcZ87TgbyKmAvOp3JxgXdw5ibwvxhc/5H9gqXQRr7YIh4atfd6AGmeYzLwoswhpI+4DrfaFYpmWfLa1LBNYZdZU+ykEDvI3Ma3WNf5dyYP9q7Ds4WkIP5Cg9b/K0ajgdGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uq5QEX0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFEBC3277B;
	Tue, 18 Jun 2024 13:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718717686;
	bh=bKXihXcqi4A23xOrKQ2+JR3WIoUXqHwQ3yua4RBbBag=;
	h=Subject:To:Cc:From:Date:From;
	b=Uq5QEX0ItFVgXSaJIEeji7F8zP5pS59y3oAPpCFIxLAwEiCJ5pbQ+LeojCKXltPhr
	 1IuYh+PFy4333jSCCS3yDVZpFSRd4ghSoSJlrDvmkKi/g+PnsA0zc2cUuccPkNM+hy
	 nI0CCnio7qDCpHDnGudfXHD2p2eufyBWUznzHJhs=
Subject: FAILED: patch "[PATCH] spmi: hisi-spmi-controller: Do not override device identifier" failed to apply to 5.10-stable tree
To: vamshigajjela@google.com,gregkh@linuxfoundation.org,sboyd@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 18 Jun 2024 15:33:10 +0200
Message-ID: <2024061810-blandness-haven-2a3a@gregkh>
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
git cherry-pick -x eda4923d78d634482227c0b189d9b7ca18824146
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061810-blandness-haven-2a3a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

eda4923d78d6 ("spmi: hisi-spmi-controller: Do not override device identifier")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From eda4923d78d634482227c0b189d9b7ca18824146 Mon Sep 17 00:00:00 2001
From: Vamshi Gajjela <vamshigajjela@google.com>
Date: Tue, 7 May 2024 14:07:41 -0700
Subject: [PATCH] spmi: hisi-spmi-controller: Do not override device identifier

'nr' member of struct spmi_controller, which serves as an identifier
for the controller/bus. This value is a dynamic ID assigned in
spmi_controller_alloc, and overriding it from the driver results in an
ida_free error "ida_free called for id=xx which is not allocated".

Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
Fixes: 70f59c90c819 ("staging: spmi: add Hikey 970 SPMI controller driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240228185116.1269-1-vamshigajjela@google.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Link: https://lore.kernel.org/r/20240507210809.3479953-5-sboyd@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 674a350cc676..fa068b34b040 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -300,7 +300,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
 
 	spin_lock_init(&spmi_controller->lock);
 
-	ctrl->nr = spmi_controller->channel;
 	ctrl->dev.parent = pdev->dev.parent;
 	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
 


