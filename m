Return-Path: <stable+bounces-62662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B23940CEA
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59371C222C4
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFEC194126;
	Tue, 30 Jul 2024 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2CAJGm9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20E7442C
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330370; cv=none; b=c/S9+HcFn2cMx83N9yjec3f7JuNUchSgltmWJMG2FdQRVqrGBVulRxtmJI5NFApAuwDLeG/A/zlpS2yh8x93YVJTt0VmycBH1Dd+b8a5EjuGGu1ssLUzEZ/dXcHp6PDWzNEFyUt7bPLrr5eqhY+csHnEjtPsxqGWgM4mZp8MZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330370; c=relaxed/simple;
	bh=EZilLiVQOHxVQ5YHHrVd83vyX4lOiXJDuiOtk0F5rGw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MgfAEYWjwGCcdjknaoOB5LEQfIUSTVAgGoA8FdxtqXzW3QjRWRNZsE+NNy81SDBncJgnF8UlQL8gtuhgb/lej7+6AWqjpDAtpRrtT76vObiL4j11noseyDaJhExudmsGI1uL2eQa4JxvMTUvyq2Pqp7bT9taQJiwMzA4xslv3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2CAJGm9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5C0C4AF0B;
	Tue, 30 Jul 2024 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722330369;
	bh=EZilLiVQOHxVQ5YHHrVd83vyX4lOiXJDuiOtk0F5rGw=;
	h=Subject:To:Cc:From:Date:From;
	b=2CAJGm9H9bstV1PNBWDRksgUz12JPmYR/Zysa8GWaA3QnE+xHWqjiFhlmvybj+yLu
	 geMnOH3bJ6FrBG2kQ7SwDhnmhL0dCHibBoTO/4h7oHcO8/XhaH0WA3qpzuFdosGE5r
	 sHrNhANxik176UEQs3aLPZOrBe6yw+Pz0FDpdlEU=
Subject: FAILED: patch "[PATCH] devres: Fix memory leakage caused by driver API" failed to apply to 5.10-stable tree
To: quic_zijuhu@quicinc.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:06:05 +0200
Message-ID: <2024073005-sporty-elm-72e4@gregkh>
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
git cherry-pick -x bd50a974097bb82d52a458bd3ee39fb723129a0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073005-sporty-elm-72e4@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

bd50a974097b ("devres: Fix memory leakage caused by driver API devm_free_percpu()")
d7aa44f5a1f8 ("driver core: Cast to (void *) with __force for __percpu pointer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bd50a974097bb82d52a458bd3ee39fb723129a0c Mon Sep 17 00:00:00 2001
From: Zijun Hu <quic_zijuhu@quicinc.com>
Date: Tue, 2 Jul 2024 22:51:51 +0800
Subject: [PATCH] devres: Fix memory leakage caused by driver API
 devm_free_percpu()

It will cause memory leakage when use driver API devm_free_percpu()
to free memory allocated by devm_alloc_percpu(), fixed by using
devres_release() instead of devres_destroy() within devm_free_percpu().

Fixes: ff86aae3b411 ("devres: add devm_alloc_percpu()")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
Link: https://lore.kernel.org/r/1719931914-19035-3-git-send-email-quic_zijuhu@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index ff2247eec43c..8d709dbd4e0c 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -1225,7 +1225,11 @@ EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
  */
 void devm_free_percpu(struct device *dev, void __percpu *pdata)
 {
-	WARN_ON(devres_destroy(dev, devm_percpu_release, devm_percpu_match,
+	/*
+	 * Use devres_release() to prevent memory leakage as
+	 * devm_free_pages() does.
+	 */
+	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
 			       (__force void *)pdata));
 }
 EXPORT_SYMBOL_GPL(devm_free_percpu);


