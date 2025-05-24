Return-Path: <stable+bounces-146273-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1E9AC304E
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E5327A2E07
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06B1EB9E8;
	Sat, 24 May 2025 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="txC+Iwjh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52931EA7DE
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748102023; cv=none; b=EOUOoxT9l+UkPBVo0E6UccEuZdNuzHyhqSc6apZdKR9My814MAwaIcjNz0tjnulwrg+QetNf3JUqtm3Nv0In2spcrKVu5vxMgE1YU9Vy7hgXuY/NH5YBh2+04flZ28pmvDBI04qe4Tg2pJ9GHKbuUkmCEGbr4kY9nYYVHOG8bgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748102023; c=relaxed/simple;
	bh=a2trgMhtcQHuX1Nt0eaT0Dl2w1j5rAumSl/XsdVwk9s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hP1rVN+yg6RbZVouWF4Blnmh3A6X0AHygQYvc2AKXtuAbf98E1jybeAVvqheTxsgHG32IYcPucMDmk6Jwjy97MpNzwjMgDIE1Q8VyHOgACZ+MDca8UB1OLpijrbM8WJIaN7fUkX62U+ofBUte5qXbU/GoXN5ImaUVRk6dEDS9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=txC+Iwjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FCBC4CEE4;
	Sat, 24 May 2025 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748102022;
	bh=a2trgMhtcQHuX1Nt0eaT0Dl2w1j5rAumSl/XsdVwk9s=;
	h=Subject:To:Cc:From:Date:From;
	b=txC+IwjhhJ8az5wwQi5T7UQPM1XEFaG+Xt89UW59GAFPuKaTRKVxQApKlP+3S5jqs
	 3d0OtRYp4tzMurexWc59RfuLYZFXcvQ9RCiW5a7HG5ep7dmffzIk3Fqrqfb7PDGmiA
	 pnMl995UBNiSIVMvvqhNaSlqZH3hxL12DSyoEG+A=
Subject: FAILED: patch "[PATCH] pmdomain: core: Fix error checking in" failed to apply to 5.4-stable tree
To: dan.carpenter@linaro.org,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:52:00 +0200
Message-ID: <2025052400-culinary-streak-b400@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 0f5757667ec0aaf2456c3b76fcf0c6c3ea3591fe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052400-culinary-streak-b400@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f5757667ec0aaf2456c3b76fcf0c6c3ea3591fe Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Thu, 8 May 2025 09:29:23 +0300
Subject: [PATCH] pmdomain: core: Fix error checking in
 genpd_dev_pm_attach_by_id()

The error checking for of_count_phandle_with_args() does not handle
negative error codes correctly.  The problem is that "index" is a u32 so
in the condition "if (index >= num_domains)" negative error codes stored
in "num_domains" are type promoted to very high positive values and
"index" is always going to be valid.

Test for negative error codes first and then test if "index" is valid.

Fixes: 3ccf3f0cd197 ("PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM domain")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/aBxPQ8AI8N5v-7rL@stanley.mountain
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 9b2f28b34bb5..d6c1ddb807b2 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3126,7 +3126,7 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	/* Verify that the index is within a valid range. */
 	num_domains = of_count_phandle_with_args(dev->of_node, "power-domains",
 						 "#power-domain-cells");
-	if (index >= num_domains)
+	if (num_domains < 0 || index >= num_domains)
 		return NULL;
 
 	/* Allocate and register device on the genpd bus. */


