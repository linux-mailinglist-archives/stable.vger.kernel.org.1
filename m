Return-Path: <stable+bounces-171096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA09FB2A7AD
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A148580A68
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC31E1E48A;
	Mon, 18 Aug 2025 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uaYTsoqL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737A9220F3F;
	Mon, 18 Aug 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524804; cv=none; b=aGZcxY1HmijpCC6rEYEPN3VjlJ4OfYKH14XBBvv2ctdafu86L80+yvfOq2Zqhx7jtslZciXP2lRkBsoh96rRj474bnZFJhz8eRkIbLgipigmRhoEwu+zrru79LCIMzz1BI8IAGgbHZfj15FQShs3vZGt47w4wzlO9y0YXJALK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524804; c=relaxed/simple;
	bh=wH3gfVQrkgTIDYtnN5mtH4Y06Vptp5Yify6imisnLxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rijP2N/jOHMoeE1wpmlwV0SEXDXna853iN6nfad7j/j/Qz3adZo6qhk4+w29mhPYdYK3VZ4kW+5r8HPkYIMhhwCDeNtmQQ1Vv3dJkr/R+I7p6NS26kfOFExIWQd12Q6LqvaFDipQMkSSJ8Z6DLgMwju33XEZaeWHMDhaUZfQanM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uaYTsoqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C67CC4CEEB;
	Mon, 18 Aug 2025 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524803;
	bh=wH3gfVQrkgTIDYtnN5mtH4Y06Vptp5Yify6imisnLxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uaYTsoqLaJWQGUM/NpTnLFWJC0XSx/ICrmP6Mah94cVXzXznWbwqbefaoi94pdema
	 Xrcl3HX20uVhvz82Lep+Wf5KJf0hwHcLVRmZuo8jdNA2vF1p4nz343CI69lU1VfyNv
	 YmudZJhsyYHu82vM6o8QEU1Ia3x8vlVBD8e76IrY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6.16 035/570] PCI: Extend isolated function probing to LoongArch
Date: Mon, 18 Aug 2025 14:40:22 +0200
Message-ID: <20250818124507.164756302@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit a02fd05661d73a8507dd70dd820e9b984490c545 upstream.

Like s390 and the jailhouse hypervisor, LoongArch's PCI architecture allows
passing isolated PCI functions to a guest OS instance. So it is possible
that there is a multi-function device without function 0 for the host or
guest.

Allow probing such functions by adding a IS_ENABLED(CONFIG_LOONGARCH) case
in the hypervisor_isolated_pci_functions() helper.

This is similar to commit 189c6c33ff42 ("PCI: Extend isolated function
probing to s390").

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250624062927.4037734-1-chenhuacai@loongson.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/hypervisor.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -37,6 +37,9 @@ static inline bool hypervisor_isolated_p
 	if (IS_ENABLED(CONFIG_S390))
 		return true;
 
+	if (IS_ENABLED(CONFIG_LOONGARCH))
+		return true;
+
 	return jailhouse_paravirt();
 }
 



