Return-Path: <stable+bounces-105614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25FA9FAE42
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CB917A1EC8
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3575819D09F;
	Mon, 23 Dec 2024 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MNr59B+4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB85473E
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734956700; cv=none; b=DLzZ0spkYmJzYZV/pzwP+Qm6dq5Ll5CV5bEKGc7E3M2kNowlN/wl6aizFVSDUCVBu0DDJiwEdFffgDbbsQfE5BcAzWUhKGvyhT3Wp2OTOCGbmrg2puIR14gEvwPQ98ynLdvZldEgspYBWDqUa1Hv6dem6defPT4ddfofXs8Hk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734956700; c=relaxed/simple;
	bh=0x2YNHAMntle8k56A6cbNUGzyJ4jnPLgk8KouwQZmjU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=t5V9WpsuYQO1qYHpdL4uYvitisstjcQz0hPC/Vku2CPtwdEOEj1ar2pbIoU2dytOmhW8154AsAeIkQfOv5i3LyuG9LMhtHtTyMxJhkJcbBSG3KplsXLwHnxs342pVIkXTPnNsBGLgxpbodE9RkLFLd6/4gNF/ZQv/7J/egQXa4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MNr59B+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D748EC4CED3;
	Mon, 23 Dec 2024 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734956699;
	bh=0x2YNHAMntle8k56A6cbNUGzyJ4jnPLgk8KouwQZmjU=;
	h=Subject:To:Cc:From:Date:From;
	b=MNr59B+41wruRr2QrZtpcIAc8YMjBNlogsJ2/QY4K/gAwKF3YjUkB7GP84PKwxOKD
	 4Hy158cB+ZWBBQqJqPrX1cLk2kUIULYCiuKuY1tRN6qHTh41xz+QYli4Yn51XQP9sL
	 5KTyO55RWyppOUJ4u47xz2OAdi4Lj/OJQ4ZUZEuA=
Subject: FAILED: patch "[PATCH] of: address: Preserve the flags portion on 1:1 dma-ranges" failed to apply to 5.10-stable tree
To: andrea.porta@suse.com,herve.codina@bootlin.com,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 13:24:56 +0100
Message-ID: <2024122356-zen-badland-29c9@gregkh>
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
git cherry-pick -x 7f05e20b989ac33c9c0f8c2028ec0a566493548f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122356-zen-badland-29c9@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f05e20b989ac33c9c0f8c2028ec0a566493548f Mon Sep 17 00:00:00 2001
From: Andrea della Porta <andrea.porta@suse.com>
Date: Sun, 24 Nov 2024 11:05:37 +0100
Subject: [PATCH] of: address: Preserve the flags portion on 1:1 dma-ranges
 mapping

A missing or empty dma-ranges in a DT node implies a 1:1 mapping for dma
translations. In this specific case, the current behaviour is to zero out
the entire specifier so that the translation could be carried on as an
offset from zero. This includes address specifier that has flags (e.g.
PCI ranges).

Once the flags portion has been zeroed, the translation chain is broken
since the mapping functions will check the upcoming address specifier
against mismatching flags, always failing the 1:1 mapping and its entire
purpose of always succeeding.

Set to zero only the address portion while passing the flags through.

Fixes: dbbdee94734b ("of/address: Merge all of the bus translation code")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Tested-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/r/e51ae57874e58a9b349c35e2e877425ebc075d7a.1732441813.git.andrea.porta@suse.com
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

diff --git a/drivers/of/address.c b/drivers/of/address.c
index c5b925ac469f..5b7ee3ed5296 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -459,7 +459,8 @@ static int of_translate_one(const struct device_node *parent, const struct of_bu
 	}
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_number(addr, na);
-		memset(addr, 0, pna * 4);
+		/* set address to zero, pass flags through */
+		memset(addr + pbus->flag_cells, 0, (pna - pbus->flag_cells) * 4);
 		pr_debug("empty ranges; 1:1 translation\n");
 		goto finish;
 	}


