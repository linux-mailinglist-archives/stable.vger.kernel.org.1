Return-Path: <stable+bounces-62664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E9940D0B
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3624B2C95A
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03250194154;
	Tue, 30 Jul 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hUzD0/yY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE9190053
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330381; cv=none; b=j9oAGpO7O2K3KoD1iQ6k0KSi8eJ+p1cGbqXUfQXzLla1Ca7pv8NpcGfzo7KmM/4GhugC5acDF5146hcKvYRyC546Qk2nY/PvUb8pdtoOLWXpckfu1Gu+khQ4AJ+AzeBrN0GWUGTB9RHKs/CHEanDvAUtzPzJDbytKVKYGRuHBRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330381; c=relaxed/simple;
	bh=MDJbo9K/F5uokvmK8kvhL8Hi8LcfItp5O45Z12nJh5w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AD5/5nf2MZUVuMgOi/qvmNwTxnc6f/Jn3hIes73Kk3wNFCZ+jELkJrnhYRbUKlxvBtXHY22gQn+WTaEIB8IlvPJ8P2nQUmnaPHpuA95UB/vbvjniG5niP8Z5FaVzfWOHu9uMj05QTtl85djf3BsngdNBgfUkROU0UiD9CRhH6EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hUzD0/yY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7804C4AF0B;
	Tue, 30 Jul 2024 09:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722330381;
	bh=MDJbo9K/F5uokvmK8kvhL8Hi8LcfItp5O45Z12nJh5w=;
	h=Subject:To:Cc:From:Date:From;
	b=hUzD0/yYePaH7DtVGd7CyhMYIEJPvoEJtI83o1Anm0eCF/gLY2NF0WFI2Q8GguWcP
	 0A9EVqSCk0KfmJNgDLz4ebnCl4tkoRfiuU0Oyy4E/SSV9OB+V2b96wRuXVQiH+8/Uo
	 WFONjj1zuYKvJL4EVffq3byitPptQIXzxNH+t1Oo=
Subject: FAILED: patch "[PATCH] devres: Fix memory leakage caused by driver API" failed to apply to 4.19-stable tree
To: quic_zijuhu@quicinc.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:06:07 +0200
Message-ID: <2024073007-discover-unearned-d69c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x bd50a974097bb82d52a458bd3ee39fb723129a0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073007-discover-unearned-d69c@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

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


