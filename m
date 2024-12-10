Return-Path: <stable+bounces-100367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA919EAC36
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C777A28FFA2
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5035F223E9A;
	Tue, 10 Dec 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kRBA58sT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB4223E65
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823064; cv=none; b=uyQobyOvwppp0FpGGhDFu5zLBHxnGfQ1MAFGw6GWy8egtj4mvugUQjHRvjkr3T+8Ib8+3M2lMcQHc6EPJvEiB9QAXi92pq2zorNcZZ7I3w22C++z7KeUnUyZJh1077J7Ruf3qSrM2zttxaZLEnzILic7ugwREM1EZp2Awo5bZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823064; c=relaxed/simple;
	bh=RAH/myYEorX5HQz6TA/xlgTGbP9Ek06qzQMfWR7BbVM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n1I3BtpEO9/sM4ZHldeCa67BIdt/jZdtVROwKBjGHG/bYf8ASFiuTl0DP6w8oNSFrW4o3LCnHpTfb3az2Qw2OdO7MGlQzjsyBcCS0AIQIhb7dONNyxsvLvFVjVD3kHNZf6l0MNLwd4a6M2MysWvmn3JSjpXAwVTYJmrtw8pJtNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kRBA58sT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92812C4CED6;
	Tue, 10 Dec 2024 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733823063;
	bh=RAH/myYEorX5HQz6TA/xlgTGbP9Ek06qzQMfWR7BbVM=;
	h=Subject:To:Cc:From:Date:From;
	b=kRBA58sTu+BdgSMaXCqxbIipDQRGvcHZFR/Tk9LxzcpWtTuwHoKxPzHZrBhOtff+S
	 1+9rBYrh3BGGv/uBbFa5y/z1Robj0xnJg/k2QdHN+2pvSfXQZJtQmfnEfFO0McZisJ
	 GZ6u8SK3apOQQY1cER4W36dPXeobGDX/RxfdnyvI=
Subject: FAILED: patch "[PATCH] pmdomain: core: Add missing put_device()" failed to apply to 5.10-stable tree
To: ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 10 Dec 2024 10:30:22 +0100
Message-ID: <2024121022-riverside-turbofan-2e56@gregkh>
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
git cherry-pick -x b8f7bbd1f4ecff6d6277b8c454f62bb0a1c6dbe4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024121022-riverside-turbofan-2e56@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b8f7bbd1f4ecff6d6277b8c454f62bb0a1c6dbe4 Mon Sep 17 00:00:00 2001
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Nov 2024 14:42:02 +0100
Subject: [PATCH] pmdomain: core: Add missing put_device()

When removing a genpd we don't clean up the genpd->dev correctly. Let's add
the missing put_device() in genpd_free_data() to fix this.

Fixes: 401ea1572de9 ("PM / Domain: Add struct device to genpd")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Message-ID: <20241122134207.157283-2-ulf.hansson@linaro.org>

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a6c8b85dd024..4d8b0d18bb4a 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -2183,6 +2183,7 @@ static int genpd_alloc_data(struct generic_pm_domain *genpd)
 
 static void genpd_free_data(struct generic_pm_domain *genpd)
 {
+	put_device(&genpd->dev);
 	if (genpd_is_cpu_domain(genpd))
 		free_cpumask_var(genpd->cpus);
 	if (genpd->free_states)


