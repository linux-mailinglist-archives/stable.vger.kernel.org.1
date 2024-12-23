Return-Path: <stable+bounces-105616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F12A9FAE47
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23207162E55
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C501A8F88;
	Mon, 23 Dec 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bfK1lJSK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0066D1A8F92
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734956807; cv=none; b=cS2Zn4aSSfL4RTGdJ2/vFNOXMLOpIosIjIpmIEuH8Sv8Ypg4GLFFBBr7tnYZ4s4MRU2sixANANnYKDr+IpybbpYzCHiqktZMvZ+Y2tN2PN+l7Oa0y0yNocn/2VFYE4ZJRmcmP2RmYrU90dDayqpBcVOnwethnTX/TlAuDnd6d4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734956807; c=relaxed/simple;
	bh=qK+qarpwdIFTWMuhJptdu2ZdziC8VloLqoSLaJR+wm4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mXEVAFsHUnu5Ssd+hrFE6ZBAUpp4v8IA9B75xTJ5E38GWGiCuode1pNL77TQ5kl5Ws1AacLAgoasB4CKj9BUF3oGxPqjo/qBXzyDYLboggnC0SJwQxKfpcOGajLze2qBy9ZXD/5bCXL2HXXqByq2Dj8vu0TgxezxXtQHrQ3eu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bfK1lJSK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12740C4CED4;
	Mon, 23 Dec 2024 12:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734956806;
	bh=qK+qarpwdIFTWMuhJptdu2ZdziC8VloLqoSLaJR+wm4=;
	h=Subject:To:Cc:From:Date:From;
	b=bfK1lJSKnN8MVlbkX34AXz2Cdj04Nqj4ioeLkKT6sFotdNVeBxaFw/qocxKj+bTfH
	 9nJiSv9EOQU4Lyo92990VBRDH9SVwdw7gLPKKifI8MCr5dJR4Qs6XiQfHb7eX4nYot
	 HGlkYZaWX4ElQzfTHM5XdFx7R4yjaScKLKLYEaVQ=
Subject: FAILED: patch "[PATCH] of: address: Preserve the flags portion on 1:1 dma-ranges" failed to apply to 6.6-stable tree
To: andrea.porta@suse.com,herve.codina@bootlin.com,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 13:26:21 +0100
Message-ID: <2024122321-uptake-awhile-44ab@gregkh>
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
git cherry-pick -x 7f05e20b989ac33c9c0f8c2028ec0a566493548f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122321-uptake-awhile-44ab@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


