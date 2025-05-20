Return-Path: <stable+bounces-145311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFC5ABDB4D
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DDB8C30FA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9808819F137;
	Tue, 20 May 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RjKnvnE2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D171D8E07;
	Tue, 20 May 2025 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749802; cv=none; b=bZLXR5w6LgLeb+Dv6wbCF4EV9PWbvGnomAzTmGS+7OPCPCwcQNTW0gvfHWOIyEB9C6Kltu5yddGTUdH3yZOjvyYu5KA6WyQlnabWq0JCt6/MxrnnGkt1hCE1VMAZYmLAQJ1O3dJ2jzhrFrhXUoOkKpiqpPiytGOtwucnbxS9Ztg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749802; c=relaxed/simple;
	bh=PMsodrloCm+5PyuoeJwL2HOcfGF8z/y5STpAB+u1JK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASllshPOuJyIiIpqaoHXXXx28nNpOrcdrgREpzaNP7CoppizaaX/lGoBzuGZ/Wf1977ECu6IFVv6ZuB4dYgFXd1hjSoqEyDufyArfHcwJpZssJXIWoY5Dynrsg0Wfkqofrhb5qS3bxb9sCQ7MuR7pkLhdYYbGVn3ePPTheSREGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RjKnvnE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AA5C4CEE9;
	Tue, 20 May 2025 14:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749801;
	bh=PMsodrloCm+5PyuoeJwL2HOcfGF8z/y5STpAB+u1JK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RjKnvnE2dfk3kCUwK1WCtsjdRpuucl7ShbM3vZXL8QASsBcGlGyQroeqMSibd7fOQ
	 9TeProHZoBvhrRyTfs81XhfmNVsvFnmto3gqVACST3sAPHcUFl3CksmWIRUGJxhjos
	 aA0ou38wxAFZAMiZb7LreqONzZAkhDPukff0ytpQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 6.6 065/117] LoongArch: Fix MAX_REG_OFFSET calculation
Date: Tue, 20 May 2025 15:50:30 +0200
Message-ID: <20250520125806.571066255@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125803.981048184@linuxfoundation.org>
References: <20250520125803.981048184@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huacai Chen <chenhuacai@loongson.cn>

commit 90436d234230e9a950ccd87831108b688b27a234 upstream.

Fix MAX_REG_OFFSET calculation, make it point to the last register
in 'struct pt_regs' and not to the marker itself, which could allow
regs_get_register() to return an invalid offset.

Cc: stable@vger.kernel.org
Fixes: 803b0fc5c3f2baa6e5 ("LoongArch: Add process management")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/include/asm/ptrace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/loongarch/include/asm/ptrace.h
+++ b/arch/loongarch/include/asm/ptrace.h
@@ -55,7 +55,7 @@ static inline void instruction_pointer_s
 
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
-#define MAX_REG_OFFSET (offsetof(struct pt_regs, __last))
+#define MAX_REG_OFFSET (offsetof(struct pt_regs, __last) - sizeof(unsigned long))
 
 /**
  * regs_get_register() - get register value from its offset



