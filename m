Return-Path: <stable+bounces-210324-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C4FD3A762
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 12:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E081830DE762
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 11:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB73318BB6;
	Mon, 19 Jan 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2hbHApJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AD317702
	for <stable@vger.kernel.org>; Mon, 19 Jan 2026 11:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823156; cv=none; b=qN0JsWBBixOSxPssOdfI8Vmjx6S8guZUcMkawYY2dMQKDsbS4No7AbOOuyE2YHIYBlIP3g/wFwOHh1daLpXTUER/jNRp5aW5RMGgWVqokVUYnWmYHTEUKPl3GQyMoBPs5Vfp1cOB6qZp6ur1yR95PbQAIj2eAwk4nhKvOunaHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823156; c=relaxed/simple;
	bh=dX3JOwjS5e6b3fUJAjSeI/QqH2gw1QZMMxXEsQG4AhA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sEY17o5MUePv7oPjAWSZIInvA5wRVMz/p45MimjuJzCr/nuU8FAOb1TFrqBRj+CoTCQt2BuzxH7BclsMU+Cs1OhGXrLj/TmwB3mg32+cMwHtWBSSYfFelKwUewEDF2SbSKH//EeFZAmd6Bdrf00hR0/BNln3lz54VLWq1BEa6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2hbHApJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522F5C116C6;
	Mon, 19 Jan 2026 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768823155;
	bh=dX3JOwjS5e6b3fUJAjSeI/QqH2gw1QZMMxXEsQG4AhA=;
	h=Subject:To:Cc:From:Date:From;
	b=2hbHApJIwAeGE3Y+tnjEGcjiIs6qEY2XQG8wxAVymlrxi9sNCZc6i579jLJ+4Mjr+
	 YH0uk8h8F/4stmXt5GSrL02BkaovqBlc1ilXGCNRJ7rcppKKsGtWpw7w2J4VYERen/
	 rCi2B7bCqXzn2ReJNZHxKIMB9FsUeTIe8QGxPnUI=
Subject: FAILED: patch "[PATCH] nvme-apple: add "apple,t8103-nvme-ans2" as compatible" failed to apply to 6.6-stable tree
To: j@jannau.net,hch@lst.de,kbusch@kernel.org,neal@gompa.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Jan 2026 12:45:42 +0100
Message-ID: <2026011942-princess-discharge-9432@gregkh>
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
git cherry-pick -x 7d3fa7e954934fbda0a017ac1c305b7b10ecceef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026011942-princess-discharge-9432@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d3fa7e954934fbda0a017ac1c305b7b10ecceef Mon Sep 17 00:00:00 2001
From: Janne Grunau <j@jannau.net>
Date: Wed, 31 Dec 2025 11:10:57 +0100
Subject: [PATCH] nvme-apple: add "apple,t8103-nvme-ans2" as compatible

After discussion with the devicetree maintainers we agreed to not extend
lists with the generic compatible "apple,nvme-ans2" anymore [1]. Add
"apple,t8103-nvme-ans2" as fallback compatible as it is the SoC the
driver and bindings were written for.

[1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/

Cc: stable@vger.kernel.org # v6.18+
Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Reviewed-by: Neal Gompa <neal@gompa.dev>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 15b3d07f8ccd..ed61b97fde59 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1704,6 +1704,7 @@ static const struct apple_nvme_hw apple_nvme_t8103_hw = {
 
 static const struct of_device_id apple_nvme_of_match[] = {
 	{ .compatible = "apple,t8015-nvme-ans2", .data = &apple_nvme_t8015_hw },
+	{ .compatible = "apple,t8103-nvme-ans2", .data = &apple_nvme_t8103_hw },
 	{ .compatible = "apple,nvme-ans2", .data = &apple_nvme_t8103_hw },
 	{},
 };


