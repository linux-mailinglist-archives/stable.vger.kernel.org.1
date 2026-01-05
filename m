Return-Path: <stable+bounces-204653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB5CF3201
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 12:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C23D13071BB0
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F7432E136;
	Mon,  5 Jan 2026 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m9xsCg4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE79332D451
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610707; cv=none; b=cpYqW2BZvIbd0wukIuff/1hpr1SRD5WSH9rslH3NeFjBf+CGqNPJ/F2e2z4uu5BdDeILXsb4JLP79afG9Co2so5jh3Nk7GLJaS5ifBeTWAW03Apv7JDKvAwtmXIWTim1xFVz8DZXIx7aw3ChJH/As+e88pTmIeY9oRmeepmvjMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610707; c=relaxed/simple;
	bh=AakWy/lwS9V+lkeHFZgjFwthrRq+M8JgduB/lzeWh4o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YNq5ElYP4cu6n2Knctynslg/f4esaEwnXNfhQBlKEmBsnKMsY+jtBbAmQmWaoiaql6TM25acwepCl8oYt/Iq+2qBPWtRxZp7xFSg17NWYVSJGzjKxcGV9ZGZ6GmnIy/ySOm/SmVaWkMQsPxlkls1W8vpnYtpgCiO4LYfLE+s8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m9xsCg4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E942AC116D0;
	Mon,  5 Jan 2026 10:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767610707;
	bh=AakWy/lwS9V+lkeHFZgjFwthrRq+M8JgduB/lzeWh4o=;
	h=Subject:To:Cc:From:Date:From;
	b=m9xsCg4hj+sHHP87n/K/DL9KKreOBxYdp1kz+ehMaNJd20cuTOJWqIfC7xq7OcYU7
	 +oWVplc+3qkHj5W4yxMqJIgq32QE2i2kE29aiulKLyMHe5krXw2TRj9C5raOe2WFE/
	 c2HGg6AGsGa04F6FwKFaJXYsdofr3SKexNCU9S3w=
Subject: FAILED: patch "[PATCH] media: renesas: rcar_drif: fix device node reference leak in" failed to apply to 5.15-stable tree
To: linmq006@gmail.com,fabrizio.castro.jz@renesas.com,geert+renesas@glider.be,hverkuil+cisco@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:58:24 +0100
Message-ID: <2026010524-purr-canopener-358c@gregkh>
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
git cherry-pick -x 445e1658894fd74eab7e53071fa16233887574ed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010524-purr-canopener-358c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 445e1658894fd74eab7e53071fa16233887574ed Mon Sep 17 00:00:00 2001
From: Miaoqian Lin <linmq006@gmail.com>
Date: Wed, 3 Sep 2025 21:37:29 +0800
Subject: [PATCH] media: renesas: rcar_drif: fix device node reference leak in
 rcar_drif_bond_enabled

The function calls of_parse_phandle() which returns
a device node with an incremented reference count. When the bonded device
is not available, the function
returns NULL without releasing the reference, causing a reference leak.

Add of_node_put(np) to release the device node reference.
The of_node_put function handles NULL pointers.

Found through static analysis by reviewing the doc of of_parse_phandle()
and cross-checking its usage patterns across the codebase.

Fixes: 7625ee981af1 ("[media] media: platform: rcar_drif: Add DRIF support")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/renesas/rcar_drif.c b/drivers/media/platform/renesas/rcar_drif.c
index 11bf47fb8266..0844934f7aa6 100644
--- a/drivers/media/platform/renesas/rcar_drif.c
+++ b/drivers/media/platform/renesas/rcar_drif.c
@@ -1246,6 +1246,7 @@ static struct device_node *rcar_drif_bond_enabled(struct platform_device *p)
 	if (np && of_device_is_available(np))
 		return np;
 
+	of_node_put(np);
 	return NULL;
 }
 


