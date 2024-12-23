Return-Path: <stable+bounces-105615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADAB9FAE43
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607DE1882DB9
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A70194C69;
	Mon, 23 Dec 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FuSup9Q4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A435473E
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734956708; cv=none; b=usnDUUEeoPOzyuuyE73pE0gN+473Yqaimp83dtz027R7b9MJ25FBLAG0dXklbaALiyiD8hbQUuQENj0kPurCxH8g+EWjAwq4rdVECRUGOuFbGy35b7lCQYzdIBzDt/IRdARf+Xv8Xlc/TFyNpd6LsbNBYnMTLymRSCpXWvWVuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734956708; c=relaxed/simple;
	bh=c6wTeR2sb6CtWeRVQdmMf4oRThAgV8Pa7Cx7H6YathA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FAEcVKrqT5B6zSCkOj74gyOX1XmKOyNb3tUH5QJ65oRRNCSJEzbiOyH1aKv013xjvX+T+0tab0VlVx2lVrW/85rRLoIM+hUS9XMdnWRE3fN5a9AOBA43qGoIt9rp3T0JdeWSs48hWNQxQYkL1oPGyO7nvo9E1kREtwLMcWQa/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FuSup9Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D441FC4CED3;
	Mon, 23 Dec 2024 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734956708;
	bh=c6wTeR2sb6CtWeRVQdmMf4oRThAgV8Pa7Cx7H6YathA=;
	h=Subject:To:Cc:From:Date:From;
	b=FuSup9Q4mlwQTCs4oaNMME5vTksFr9Zikmo7vmuyZAzkoJmpUVF78gX3Tt3aPlZzj
	 TfpCiQKqfWHUmC4e1FYKwJb/JKQBEyfNfxQ/OZDvSNkdYav4wPcw1qeYVuPX3pIK3P
	 9xvckpGfmtZKMuQSq9DhILpoA62kgvVCL6lUV+wA=
Subject: FAILED: patch "[PATCH] of: address: Preserve the flags portion on 1:1 dma-ranges" failed to apply to 5.15-stable tree
To: andrea.porta@suse.com,herve.codina@bootlin.com,robh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 23 Dec 2024 13:24:57 +0100
Message-ID: <2024122356-overdress-spoiler-5b36@gregkh>
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
git cherry-pick -x 7f05e20b989ac33c9c0f8c2028ec0a566493548f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024122356-overdress-spoiler-5b36@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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


