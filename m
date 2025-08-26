Return-Path: <stable+bounces-175124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8688B366F0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F508E5CEF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E7A350D46;
	Tue, 26 Aug 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DffkvXn8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A7C34A333;
	Tue, 26 Aug 2025 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216203; cv=none; b=uFlbr+TzVYKDQu1tql1HKNJbiWxbNuVuZAojVgVIAoCUisYH7VGFU+Ub0qXtfV3ffRmjQ1sqayWVpHUbZOD6d1z28KcFpIKI3gmDerBE0RTQgiX+p+J89NbLUKhfPWRF/BZspRiB4SgEgyUk0ZJ3YrppcyLgbas5KrHbIoGv2go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216203; c=relaxed/simple;
	bh=yem0bo4X2ODCvlTXqzI1awOh7b4jLVXB+sW0tyON9s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwB36fOFlpC1trX8M8MwTPAoHtYbyAPeMYNRZCimiBkUKSLEdWIa4GOr9ygo+mPL95aSZ1xwsSsk3WLpv7g3ucSB7+pPC/mvYYS3pP5PS7YuE7FJxSwkHViMl7scc6TdrCK07SO3au5xuNRUlJ8qTOQ5K5tXwdvIkbH/UPrZuac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DffkvXn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB965C4CEF1;
	Tue, 26 Aug 2025 13:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216203;
	bh=yem0bo4X2ODCvlTXqzI1awOh7b4jLVXB+sW0tyON9s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DffkvXn8dX73Gh/JvwQG1Tj0MPzIfNKMeZRFA4PyiaKc52VYnviClwCOgAArMfjbF
	 G/dgS1LwT9TOTeEZ+SroV3nAyr1vTBG3h5MbSJwrNF/p74QxukIUkUdSd9ziviAncg
	 uuG2DOy3/5pINcz8z/VKGlifEbLVki2nimW3jqiI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Borislav Petkov <bp@alien8.de>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 323/644] x86/bugs: Avoid warning when overriding return thunk
Date: Tue, 26 Aug 2025 13:06:54 +0200
Message-ID: <20250826110954.390009361@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

[ Upstream commit 9f85fdb9fc5a1bd308a10a0a7d7e34f2712ba58b ]

The purpose of the warning is to prevent an unexpected change to the return
thunk mitigation. However, there are legitimate cases where the return
thunk is intentionally set more than once. For example, ITS and SRSO both
can set the return thunk after retbleed has set it. In both the cases
retbleed is still mitigated.

Replace the warning with an info about the active return thunk.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250611-eibrs-fix-v4-3-5ff86cac6c61@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 261aa716971d..9e313ee9ba66 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -70,10 +70,9 @@ void (*x86_return_thunk)(void) __ro_after_init = &__x86_return_thunk;
 
 static void __init set_return_thunk(void *thunk)
 {
-	if (x86_return_thunk != __x86_return_thunk)
-		pr_warn("x86/bugs: return thunk changed\n");
-
 	x86_return_thunk = thunk;
+
+	pr_info("active return thunk: %ps\n", thunk);
 }
 
 /* Update SPEC_CTRL MSR and its cached copy unconditionally */
-- 
2.39.5




