Return-Path: <stable+bounces-180760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D72EB8DAA7
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631191787C1
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C528F23D7E8;
	Sun, 21 Sep 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NyfV5DOm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8287C34BA52
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758457099; cv=none; b=sXFFmRjAKkgPi975MU046/Bx3I90LqeOWApF9ASvir2M92WyO/owL0ITuhmWY3CxM69QQZjk6UDKCPgeutpaejzwn9uJexTvaYO3/alklY3wo7+o/WXkX9bz3PG9YWBU7uioujn4Khd6komnvzaDRv7xWhvlpUKhJXaiC4EXZ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758457099; c=relaxed/simple;
	bh=0fzq9PPjgMUmIdMXNPiqz6Irp8gkaO5eK4iJcZagj3Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T7kQQfSPYOUJPSpJBfPausNFH/dkNBfLT/vN+X2znynfxYOklviK26oEXiYtvCCQK0eyH4Aavr7PGgCasJLQj8Q45DaVeC+22vIVu94uUDc5qC9bqxQk3K7KKnrKP/KKtf71rroeFpxhIWK/rGttl5Lqya3f4IuA6w/3C5S06rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NyfV5DOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03F7C4CEE7;
	Sun, 21 Sep 2025 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758457099;
	bh=0fzq9PPjgMUmIdMXNPiqz6Irp8gkaO5eK4iJcZagj3Y=;
	h=Subject:To:Cc:From:Date:From;
	b=NyfV5DOml5/apYR4nqo1LdaQwuJKbaux+VeeT9R39r95yxiiOeD8vflxNUdrGw5Mr
	 MmEHjP9/ZhqveKfQqb7WPu2sViUSj2bMm/iEnSKseQeozvm3by97ruR2qrvwWhplBZ
	 bEiRDfXnKyHRESk9Hky9WRO6oVU4QWRt/w0wdEEA=
Subject: FAILED: patch "[PATCH] samples/damon/mtier: avoid starting DAMON before" failed to apply to 6.16-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 21 Sep 2025 14:18:16 +0200
Message-ID: <2025092116-ceramics-stratus-5d18@gregkh>
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
git cherry-pick -x c62cff40481c037307a13becbda795f7afdcfebd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025092116-ceramics-stratus-5d18@gregkh' --subject-prefix 'PATCH 6.16.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c62cff40481c037307a13becbda795f7afdcfebd Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Mon, 8 Sep 2025 19:22:38 -0700
Subject: [PATCH] samples/damon/mtier: avoid starting DAMON before
 initialization

Commit 964314344eab ("samples/damon/mtier: support boot time enable
setup") is somehow incompletely applying the origin patch [1].  It is
missing the part that avoids starting DAMON before module initialization.
Probably a mistake during a merge has happened.  Fix it by applying the
missed part again.

Link: https://lkml.kernel.org/r/20250909022238.2989-4-sj@kernel.org
Link: https://lore.kernel.org/20250706193207.39810-4-sj@kernel.org [1]
Fixes: 964314344eab ("samples/damon/mtier: support boot time enable setup")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/samples/damon/mtier.c b/samples/damon/mtier.c
index 7ebd352138e4..beaf36657dea 100644
--- a/samples/damon/mtier.c
+++ b/samples/damon/mtier.c
@@ -208,6 +208,9 @@ static int damon_sample_mtier_enable_store(
 	if (enabled == is_enabled)
 		return 0;
 
+	if (!init_called)
+		return 0;
+
 	if (enabled) {
 		err = damon_sample_mtier_start();
 		if (err)


