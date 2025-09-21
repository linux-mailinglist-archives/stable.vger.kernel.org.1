Return-Path: <stable+bounces-180761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821EFB8DAAA
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB30440B01
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56F81A9F97;
	Sun, 21 Sep 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wTpgrVeg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A320434BA52
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457104; cv=none; b=nRzM/PJBb3xbifzAaWaEe5ID21rZ70bVbZkI333l6kSNA7v32jES37p5BiKyFkWFdriWyGrAYpPdopKQgXcFvwvwdbaJPgWOygmD+kIq7LStjU64mBKDrkHkgWhH1+oGW1ehFHDFiOFRy4OyamMvElMWkdCcbiMUlzzYe4x+W4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457104; c=relaxed/simple;
	bh=xKMgFROjm0AtHmQ5VE0BiiSYQ6u0IyPC9y9Vpcl/De8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ctAapLh8PsMWIVpUZymQ7J98Mn0ZKm82RFzlkXr/tt8QFoSunHws9P3icaipUkcJyeUURsi1HPOrTvJ2yJjQGrSRsPBZTkyU7zydcDPUHebqe190mtVideyArYzxj68m+QqHNg850fG+sBeSumuwfzpgXtfcIXWTdMqp3WSYJe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wTpgrVeg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48A1C4CEE7;
	Sun, 21 Sep 2025 12:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457104;
	bh=xKMgFROjm0AtHmQ5VE0BiiSYQ6u0IyPC9y9Vpcl/De8=;
	h=Subject:To:Cc:From:Date:From;
	b=wTpgrVegkzBCLRIcdGyN3odoJzwLPXW4iNQaaXig+Wjuk2NUaOEOn0Qpv3KmgQJbn
	 D9vh7wLm90V4a1FJQNs+HHo++72i7a+Df4ww63azHvoS6XJckac2b4FUmMGmYuBIu7
	 NfyE2kuOyySvm/jo70YXpaVFMaG/Kmgs6nAsRjhg=
Subject: FAILED: patch "[PATCH] samples/damon/prcl: avoid starting DAMON before" failed to apply to 6.16-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:18:21 +0200
Message-ID: <2025092121-boned-marbles-55ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.16-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.16.y
git checkout FETCH_HEAD
git cherry-pick -x e6b733ca2f99e968d696c2e812c8eb8e090bf37b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092121-boned-marbles-55ea@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e6b733ca2f99e968d696c2e812c8eb8e090bf37b Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 8 Sep 2025 19:22:37 -0700
Subject: [PATCH] samples/damon/prcl: avoid starting DAMON before
 initialization

Commit 2780505ec2b4 ("samples/damon/prcl: fix boot time enable crash") is
somehow incompletely applying the origin patch [1].  It is missing the
part that avoids starting DAMON before module initialization.  Probably a
mistake during a merge has happened.  Fix it by applying the missed part
again.

Link: https://lkml.kernel.org/r/20250909022238.2989-3-sj@kernel.org
Link: https://lore.kernel.org/20250706193207.39810-3-sj@kernel.org [1]
Fixes: 2780505ec2b4 ("samples/damon/prcl: fix boot time enable crash")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 1b839c06a612..0226652f94d5 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -137,6 +137,9 @@ static int damon_sample_prcl_enable_store(
 	if (enabled == is_enabled)
 		return 0;
 
+	if (!init_called)
+		return 0;
+
 	if (enabled) {
 		err = damon_sample_prcl_start();
 		if (err)


