Return-Path: <stable+bounces-62663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C153940CEB
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 11:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DF2E1C2264C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 09:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B32C19414B;
	Tue, 30 Jul 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u9S42jYg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0907D190053
	for <stable@vger.kernel.org>; Tue, 30 Jul 2024 09:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722330378; cv=none; b=YJo/aliH4zhkd6KUPOcLM4+IHvKPZjZVjUE1osnWNSvS5jFdvxRRII8XvCjushvEH8SD6ZuhnqotGfQWA2rH+tjKcH3vzAw7xaOfBnnjM5lyrlfFGm0JcbB9SCkloPe5GngdrSZfWp31eAyDl47NiE0T02aN9Jn356LfsXzOEYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722330378; c=relaxed/simple;
	bh=D2PdiyMJSsCJx6e4PKm8cc8AJM9C5BWgLq1wxWhwTTY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c3lYooqox5XbzWbKnZRCalFxu72lRthBkez63YHPEmc+WrYj8lb41TvU53C5Bw6sFt/MCRJK0nbYu/7isss6Km46qEfkRmubYyBeTpAI/HK7hF7f2/pB2OqNhVo1IMmKJpKAggg+l/q+TEi/vruGb+9RE4C//Pj6UduEMuo4xhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u9S42jYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620B7C4AF09;
	Tue, 30 Jul 2024 09:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722330377;
	bh=D2PdiyMJSsCJx6e4PKm8cc8AJM9C5BWgLq1wxWhwTTY=;
	h=Subject:To:Cc:From:Date:From;
	b=u9S42jYg3omwphLgcfAWM9mLrdcYMDUsJDp7FfP2VgR46ivQ11jEp5mwmb36Dql73
	 sIu/urpNxI+qzT8ma1Rtyw0HR0Av1YPY+gw8A6Ma8Ch0BMz1A14CzJHURTQQWhos2f
	 J3HVLPY43zKW7UfEhLbiVTmYUPgpHiC+syY3AQjg=
Subject: FAILED: patch "[PATCH] devres: Fix memory leakage caused by driver API" failed to apply to 5.4-stable tree
To: quic_zijuhu@quicinc.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 30 Jul 2024 11:06:06 +0200
Message-ID: <2024073006-taekwondo-rocker-e76a@gregkh>
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
git cherry-pick -x bd50a974097bb82d52a458bd3ee39fb723129a0c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024073006-taekwondo-rocker-e76a@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

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


