Return-Path: <stable+bounces-51634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE59070D6
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A2DA1C23DC7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B101369B0;
	Thu, 13 Jun 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y57cwYlP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2B1877;
	Thu, 13 Jun 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281871; cv=none; b=IydRPJwDLe4UBKwpqvdUnsIkQTkMoju9zxHNi+FD4Cc+nrLA5tW6FAWAHeXrvm5B0IoyvEX/y4hviArg2V4AL/wiguSsp4G8ShYepgnj5WHsHJZD2I0R7SFz8creec8jB+c7IJbNSRfjzsAx30HWSDtlH+zfw+NVR/1KkO/LhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281871; c=relaxed/simple;
	bh=0muVcc54F1SwqoN8EF8tKzQ5dEX/7DENTTRVr9+OneA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8rn7sMs/kcnECwW/xWC8F0BGEr3wNLBD0eEqRYSbv59qeTLPw6SIZJiTuKFc7mRnPMVNmZ1ScC/q6JK5rDv9wJJ2WGNMzmi22AZbv3uaiZQwBTu2ndd5gW5/JidV0XF8AlOYYMgWpclXcpsZQzX9lcjZv1PuVwzBkoxTo+5Zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y57cwYlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4612AC2BBFC;
	Thu, 13 Jun 2024 12:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281871;
	bh=0muVcc54F1SwqoN8EF8tKzQ5dEX/7DENTTRVr9+OneA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y57cwYlPEhvw4mvEdF27tQ5pvsJZO9CBHWwCjCHHPfz3HiqkcOR1tLje3XhJoRZY4
	 ltBPCTfAJm4LCs/t6LMsJVAzJzIpkKtPFmtBGBHT5an2hvLn3MTF7N/BvVUQgpZGl0
	 VsmL3Wox/WgWMsm5Ri5lgPho64qrctVuZB8ZhWtE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guixiong Wei <weiguixiong@bytedance.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 053/402] x86/boot: Ignore relocations in .notes sections in walk_relocs() too
Date: Thu, 13 Jun 2024 13:30:10 +0200
Message-ID: <20240613113304.206193906@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guixiong Wei <weiguixiong@bytedance.com>

[ Upstream commit 76e9762d66373354b45c33b60e9a53ef2a3c5ff2 ]

Commit:

  aaa8736370db ("x86, relocs: Ignore relocations in .notes section")

... only started ignoring the .notes sections in print_absolute_relocs(),
but the same logic should also by applied in walk_relocs() to avoid
such relocations.

[ mingo: Fixed various typos in the changelog, removed extra curly braces from the code. ]

Fixes: aaa8736370db ("x86, relocs: Ignore relocations in .notes section")
Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
Fixes: da1a679cde9b ("Add /sys/kernel/notes")
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20240317150547.24910-1-weiguixiong@bytedance.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/tools/relocs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 3167228ca1746..d7549953bb797 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -692,6 +692,15 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+
+		/*
+		 * Do not perform relocations in .notes sections; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE)
+			continue;
+
 		sh_symtab = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
-- 
2.43.0




