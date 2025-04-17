Return-Path: <stable+bounces-133152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FA7A91E79
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B47319E7B0A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FDB22FF20;
	Thu, 17 Apr 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NGf6X0Fl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F8B84D2B
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897550; cv=none; b=g9tksaYpJ/UdFF/BcCCrYu36F8cF1woNPPcpVNLEP2fq7qCvrsZovdHrR1KrW7g3qk9+xy/3jrGFo63lFSdH0NndTBk/FNqqm0WGEkng05PvWdZjdJtq/bLxSgNHN7EhbHtmk8+EgpOAWiq1sT0ncQyVt6gVoXPxQ0Z8dTon2AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897550; c=relaxed/simple;
	bh=V1S1GJyyaPKc5WlQHH6dvbANae1PE9R0hv4uT70GtFQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u7R35yNu7CP5nySRgI8tS1/Jyhe3IKDHn7YyRZZYTKI8/bVhS5R16pVAMh506POUGb2B2spxd477xgSkCDY/D+C/iz5BDa2n+xFvY7LX6GEYvlAUm8CVS91QmN7OJ82kgLnAD7T9n6zOGIHuOkGGg8ORCMvRvxPVf5nTJTjasYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NGf6X0Fl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4F1C4CEEA;
	Thu, 17 Apr 2025 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744897550;
	bh=V1S1GJyyaPKc5WlQHH6dvbANae1PE9R0hv4uT70GtFQ=;
	h=Subject:To:Cc:From:Date:From;
	b=NGf6X0Flm+lMM0XaRTVBva5QjI+8xAGzZ999Wq9gglFPUb7bYRw3t8vqMNvEm8lqX
	 21jtjmjaVwiiV/mWNxIZLWjSN/yydu09WPyUqqWRY94JgmaZhNuWvF7pDAvJDKnUAg
	 Hue6dWCH/ZXyliicr1FLfzsKvM2t0ribLKHz8h8s=
Subject: FAILED: patch "[PATCH] PCI: Fix reference leak in pci_register_host_bridge()" failed to apply to 6.1-stable tree
To: make24@iscas.ac.cn,bhelgaas@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:44:05 +0200
Message-ID: <2025041705-salt-purgatory-1536@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 804443c1f27883926de94c849d91f5b7d7d696e9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041705-salt-purgatory-1536@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 804443c1f27883926de94c849d91f5b7d7d696e9 Mon Sep 17 00:00:00 2001
From: Ma Ke <make24@iscas.ac.cn>
Date: Tue, 25 Feb 2025 10:14:40 +0800
Subject: [PATCH] PCI: Fix reference leak in pci_register_host_bridge()

If device_register() fails, call put_device() to give up the reference to
avoid a memory leak, per the comment at device_register().

Found by code review.

Link: https://lore.kernel.org/r/20250225021440.3130264-1-make24@iscas.ac.cn
Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
[bhelgaas: squash Dan Carpenter's double free fix from
https://lore.kernel.org/r/db806a6c-a91b-4e5a-a84b-6b7e01bdac85@stanley.mountain]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 5f04b8d9c736..dc37a3c0a977 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -953,6 +953,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	resource_size_t offset, next_offset;
 	LIST_HEAD(resources);
 	struct resource *res, *next_res;
+	bool bus_registered = false;
 	char addr[64], *fmt;
 	const char *name;
 	int err;
@@ -1017,6 +1018,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	name = dev_name(&bus->dev);
 
 	err = device_register(&bus->dev);
+	bus_registered = true;
 	if (err)
 		goto unregister;
 
@@ -1103,12 +1105,15 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 unregister:
 	put_device(&bridge->dev);
 	device_del(&bridge->dev);
-
 free:
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	pci_bus_release_domain_nr(parent, bus->domain_nr);
 #endif
-	kfree(bus);
+	if (bus_registered)
+		put_device(&bus->dev);
+	else
+		kfree(bus);
+
 	return err;
 }
 


