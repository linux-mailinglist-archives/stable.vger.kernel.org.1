Return-Path: <stable+bounces-80971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719F3990D62
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E171F2460C
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE3B209F29;
	Fri,  4 Oct 2024 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbQTxo6P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEED209F20;
	Fri,  4 Oct 2024 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066386; cv=none; b=t8RooAII5A+d5SRpyaDS0oWi9ZYozejPmN9WPxHWQBNNc2+oe0fFlgA1OMXoe78a9EP43uWewi1rvEGE3QSftQoYlUohbA5Q30egwOrxU2bUDxl6pL1cu7KyhGEZPwbZro3N2OyL1j2uZnVJEFJXDtNYoZdenXUyBC0LGxMeX2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066386; c=relaxed/simple;
	bh=1sspyqVTgvIpKwxU5N9E0sOh0QrLdF27x0qAoEIqpa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crCDn7Pskl1GUml6J6rZ8AqHLYJ3p7jRwnAxAgGEfq3KnNIlgR6od8NpoGEKnZqyJ24LGYa1JhCZYOiM9XZyxI3lNAIx9pJrcvkMkC7+f0zpktZONQIM3yDFXMqCR9UmVJuSU5HpoJZNEPrC7nUhrYRKQJ2lXEHLQJZDJ3yxTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbQTxo6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EEAC4CECD;
	Fri,  4 Oct 2024 18:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066385;
	bh=1sspyqVTgvIpKwxU5N9E0sOh0QrLdF27x0qAoEIqpa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BbQTxo6Py9636iz5d9SGvBcxOTcEBPn0h7MAYgzB4heTNf8m//kp1Cxac4T2T0Qth
	 p7pQUHAYr6yMN1MDm5Rka32s/60ZQA5CXY7F0u2ClpPXCmbDaXV/yMkl0f19aFlYPC
	 wbJnVWe8VfFsAromBG4ry1TCBaxzV4+m5lhS7gYNEIMJhiA77C8jsBmCZidK46njVT
	 jPJUkV8sYMfCmdaQHcZoXGww4kIs+lJbdIoqHstkuEL87oDxNfCmQ9w0fWmS9RyUWQ
	 rrc+aQhgxnkwHypQt3DXfUZvi8oSvfEwyyYtVb46O5C88DUQjdJHjZV0b3smzuBxH9
	 ge+hgGOW6WX4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wentao Guan <guanwentao@uniontech.com>,
	Yuli Wang <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>,
	chenhuacai@kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 45/58] LoongArch: Fix memleak in pci_acpi_scan_root()
Date: Fri,  4 Oct 2024 14:24:18 -0400
Message-ID: <20241004182503.3672477-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit 5016c3a31a6d74eaf2fdfdec673eae8fcf90379e ]

Add kfree(root_ops) in this case to avoid memleak of root_ops,
leaks when pci_find_bus() != 0.

Signed-off-by: Yuli Wang <wangyuli@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/pci/acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
index 365f7de771cbb..1da4dc46df43e 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -225,6 +225,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (bus) {
 		memcpy(bus->sysdata, info->cfg, sizeof(struct pci_config_window));
 		kfree(info);
+		kfree(root_ops);
 	} else {
 		struct pci_bus *child;
 
-- 
2.43.0


