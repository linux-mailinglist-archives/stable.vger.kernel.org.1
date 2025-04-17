Return-Path: <stable+bounces-133134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B0A91E6A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D1819E798E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD3724E4D2;
	Thu, 17 Apr 2025 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D3LN6CtD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27224E01F
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897490; cv=none; b=KPpwAuGf2Tox+ytRDYtF5vdK+h4Sj8RA5BTO4/Lj4E/9MhPUfY5TikIxfRHM60u9ZV3kyeygwvmhcxQF0LvBTkvAlZnpzq1u5jD/KJRinOJVC3dKfjoflUt9xgLsuORRDW1neXP3QBqkAh9pGHGOgZjdE+4uXYgeEXkdpvvba2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897490; c=relaxed/simple;
	bh=0U5J3wj9n39g4cB76RyiboLuqtD2/owHvgQ2frCkTVE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=shleEowdClXB0C5nwaxgMKkWNH22cJdrS3LIZJNaVDt87OjXv9ZYvenyB7QVCBcfYAIUNYPYzcAGW9ESjP9wBL0eDHS+MqUyc9U0/1pxVcZGWjYzgN2lhUbJVJ24oxHpdJ49NSuUUFXfyBl4q+tkcyqIO1rAhaAdIcCe6Wn9j5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D3LN6CtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D98FC4CEEA;
	Thu, 17 Apr 2025 13:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897490;
	bh=0U5J3wj9n39g4cB76RyiboLuqtD2/owHvgQ2frCkTVE=;
	h=Subject:To:Cc:From:Date:From;
	b=D3LN6CtDOb7I2184qB3bcJdGS76x9zzxdF7Yw8ERzesx2Ltmc6xVZf4+sIYcVUVtR
	 dSPQiO4QqYzd20VE0WRcqAZ2wgunMGorMzVLmJNGbQTTYOWN5BtH2oJHizUSwjzyRl
	 wFxz9GxsHZt+b1BIgk9dAq+a8fCw6/MmUqDWKnDI=
Subject: FAILED: patch "[PATCH] misc: pci_endpoint_test: Avoid issue of interrupts remaining" failed to apply to 6.1-stable tree
To: hayashi.kunihiko@socionext.com,kwilczynski@kernel.org,manivannan.sadhasivam@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:40:37 +0200
Message-ID: <2025041737-debtor-grumbling-a49e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f6cb7828c8e17520d4f5afb416515d3fae1af9a9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041737-debtor-grumbling-a49e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6cb7828c8e17520d4f5afb416515d3fae1af9a9 Mon Sep 17 00:00:00 2001
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Date: Tue, 25 Feb 2025 20:02:48 +0900
Subject: [PATCH] misc: pci_endpoint_test: Avoid issue of interrupts remaining
 after request_irq error
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

After devm_request_irq() fails with error in pci_endpoint_test_request_irq(),
the pci_endpoint_test_free_irq_vectors() is called assuming that all IRQs
have been released.

However, some requested IRQs remain unreleased, so there are still
/proc/irq/* entries remaining, and this results in WARN() with the
following message:

  remove_proc_entry: removing non-empty directory 'irq/30', leaking at least 'pci-endpoint-test.0'
  WARNING: CPU: 0 PID: 202 at fs/proc/generic.c:719 remove_proc_entry +0x190/0x19c

To solve this issue, set the number of remaining IRQs to test->num_irqs,
and release IRQs in advance by calling pci_endpoint_test_release_irq().

Cc: stable@vger.kernel.org
Fixes: e03327122e2c ("pci_endpoint_test: Add 2 ioctl commands")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/20250225110252.28866-3-hayashi.kunihiko@socionext.com
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a3d2caa7a6bb..9e56d200d2f0 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -259,6 +259,9 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
 		break;
 	}
 
+	test->num_irqs = i;
+	pci_endpoint_test_release_irq(test);
+
 	return ret;
 }
 


