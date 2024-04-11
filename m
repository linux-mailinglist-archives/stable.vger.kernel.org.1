Return-Path: <stable+bounces-39023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E2A8A1182
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB6A6B26145
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAA8145B13;
	Thu, 11 Apr 2024 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oUID9Amm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1156BB29;
	Thu, 11 Apr 2024 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832289; cv=none; b=irnHkN0q94ofUMXFJi/suIlVdYR7h+KuqEeYPTcwgEOu4NOi6JeiLavJn3RGlQjrmENNSZa8xebnb3UIv2lNYAU+Tn+AbJjzhVDT33xoYLv13b9eEg9PXlQyARTcfraJ8YZVf+aiZ2KUJKby0msWFR4sMdS6sXYb9YZOAEY4y6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832289; c=relaxed/simple;
	bh=eRXSwxHjmOLn0x0Y4vZ5hUAjQCRCjwFspH5QqM9XD64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlUq0XZOVjmYFta9Hk0rmmKz21MQ8LqA/x/yrE61YgaPwg3e3OCW3fJy9PueyiVl5rvkcdX2ZroJcWcVQgfqfuJsQ5E5LQndnwgyBrftlCMkCx6MwtkOHVcx+Vz5KpNV1WHQRbM8SL7KKRW2pJsN+R1OzvBcKIlMiUvScO2awAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oUID9Amm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C30CC433C7;
	Thu, 11 Apr 2024 10:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832289;
	bh=eRXSwxHjmOLn0x0Y4vZ5hUAjQCRCjwFspH5QqM9XD64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUID9Amm+Dsc6t7YxSaC9VC8/uhke0McgDOV+4d9dJ+uTl7rh4rXRC2SFXC0WEfcO
	 dkrQei5+DlK223+BGE+uc2ZyVPdh2szcG62l3t0n7puuS5J9Pz8aSMgPQRWybkiKJ0
	 jYsrClV9cFh5rQ1qWfZkpExgttgsRNtQEYQeGyf0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.10 293/294] x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk
Date: Thu, 11 Apr 2024 11:57:36 +0200
Message-ID: <20240411095444.355094653@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov (AMD) <bp@alien8.de>

commit b377c66ae3509ccea596512d6afb4777711c4870 upstream.

srso_alias_untrain_ret() is special code, even if it is a dummy
which is called in the !SRSO case, so annotate it like its real
counterpart, to address the following objtool splat:

  vmlinux.o: warning: objtool: .export_symbol+0x2b290: data relocation to !ENDBR: srso_alias_untrain_ret+0x0

Fixes: 4535e1a4174c ("x86/bugs: Fix the SRSO mitigation on Zen3/4")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20240405144637.17908-1-bp@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/lib/retpoline.S |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -258,6 +258,7 @@ SYM_CODE_START(__x86_return_thunk)
 	UNWIND_HINT_FUNC
 	ANNOTATE_NOENDBR
 	ANNOTATE_UNRET_SAFE
+	ANNOTATE_NOENDBR
 	ret
 	int3
 SYM_CODE_END(__x86_return_thunk)



