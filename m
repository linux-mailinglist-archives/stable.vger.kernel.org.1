Return-Path: <stable+bounces-35243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D49AD894312
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC1528128B
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F5F481C6;
	Mon,  1 Apr 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nO0rx4/r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DE2BA3F;
	Mon,  1 Apr 2024 16:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990763; cv=none; b=WhNrV3b4ZrLTEpejIxjlo/uHSHI/9Fajc/UaslwJQTDogtxrxtfFbUMM0xDRRh4eQzFbjdBG2MJ50hwlr7FyRMYipgIUDk8XkBM86yl+9B15ZI321mP3d41SrnR4JxfFRzNhSItUQ83Bk1ETo98KeaHRZr30EgZPF39+SgbYGXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990763; c=relaxed/simple;
	bh=s25PX7IvRsGFy7Ux0MoNvvzcxEHbYgURDKyx6Q/bG9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xv/ceSCMm4oAm/TnHff+6+z9WTHy7TJgIHUgat9PJ6zbg1r8xJrzO88ifuCFrviTy4ZYIt9aGoM2bzlK7sYR0hjhZTcjnzJgzErLUGZ1LzxsPSxYVWjNGbry7XAGQFV2uFM/oiL37s70VDfOqnwKEzUWvqjuXGMqcNwjkhZtS2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nO0rx4/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4751AC433C7;
	Mon,  1 Apr 2024 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711990762;
	bh=s25PX7IvRsGFy7Ux0MoNvvzcxEHbYgURDKyx6Q/bG9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nO0rx4/rLK4Q8VqJkiyZJb6GPVeRrSpIzc9R4LuG0Yhfe4A9oKAHY1an3IUyrGwU7
	 BfEmPV9RMuM80AnYEnMJK0GoXhqO7LywZtbJPsny6j8x8hgf5NmJ9gb5HQxUhgiLCo
	 Nm8U2EMgX7ONNFBdYA2f9RiTZqiekiQ/APz3/k8E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Danilo Krummrich <dakr@redhat.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 019/272] pci_iounmap(): Fix MMIO mapping leak
Date: Mon,  1 Apr 2024 17:43:29 +0200
Message-ID: <20240401152530.919710307@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152530.237785232@linuxfoundation.org>
References: <20240401152530.237785232@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit 7626913652cc786c238e2dd7d8740b17d41b2637 ]

The #ifdef ARCH_HAS_GENERIC_IOPORT_MAP accidentally also guards iounmap(),
which means MMIO mappings are leaked.

Move the guard so we call iounmap() for MMIO mappings.

Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of it all")
Link: https://lore.kernel.org/r/20240131090023.12331-2-pstanner@redhat.com
Reported-by: Danilo Krummrich <dakr@redhat.com>
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: <stable@vger.kernel.org> # v5.15+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/pci_iomap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index ce39ce9f3526e..2829ddb0e316b 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -170,8 +170,8 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 
 	if (addr >= start && addr < start + IO_SPACE_LIMIT)
 		return;
-	iounmap(p);
 #endif
+	iounmap(p);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
-- 
2.43.0




