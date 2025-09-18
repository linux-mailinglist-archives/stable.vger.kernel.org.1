Return-Path: <stable+bounces-166034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92474B19752
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B964917475B
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED77F188A3A;
	Mon,  4 Aug 2025 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAJJ78cE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7880176FB1;
	Mon,  4 Aug 2025 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267207; cv=none; b=odt6Po8e2BdSssk89/K76cWpjko4qauQLLvCUD3hB/QJlT5jkrYZlMKaeDJUysSbsq5NJgGrsD7rtgSycRvzpCmu3EhBV71mvFzP74xFxeaamuZQLwTOrZEGBu8m5VqKZWdBe9XJvbMxH3fJ/UhBGvO2ZnKrjB9EcVkKO+8KENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267207; c=relaxed/simple;
	bh=6qXWJfM5tOuygGzZfFYbhsCKA+rGbu/F3OzOAuvgZXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pNfDEvlWDn4pud4Ubp5oo5hVT6yEzoRlRyHagQ6eUVeu5xfcE1ucazLGSlSJgk6Z5zkVI02Qtvz58bg97tHTCO6LDaGcr+38o5FEVjGzNdQ1OTwRO7bqHIuCOX4s7QfwrKA/ryR+WwSjZYD57i7qAjSWGu774xSfBFQXHKpq/SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAJJ78cE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5AAC4CEF8;
	Mon,  4 Aug 2025 00:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267207;
	bh=6qXWJfM5tOuygGzZfFYbhsCKA+rGbu/F3OzOAuvgZXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eAJJ78cEQRtwDUe9EEWuYE8akqZYVEMng+ngx5dX55GqFEBxvrpsy9uywShUPAvEQ
	 rGjkvkH1RF77raYllNv4fauv09NX5+nC8Cvmto9iM0qTw9cHtxSRhgA5jTeAR99zgV
	 YACSoLjc1qdHVLyKH2hq/l7cIIVBJZY6xSoR2qWBjvAUvCDK4hnT69V95G5YG0hbNC
	 DoF84/+FXBC/agjUqnGUKq/a92PKAmVLB8flTE3zN14dR+2zvjKcBd2eW2ilx+tspQ
	 Oews1mUDrwDTJhfkczmjsfu3k74f4Z+SP6o0B7soHDcoJG4XFpEQla/xT4UXGnaHfz
	 dG6MskAngw6ag==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	peterz@infradead.org,
	jpoimboe@kernel.org
Subject: [PATCH AUTOSEL 6.16 63/85] x86/bugs: Avoid warning when overriding return thunk
Date: Sun,  3 Aug 2025 20:23:12 -0400
Message-Id: <20250804002335.3613254-63-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002335.3613254-1-sashal@kernel.org>
References: <20250804002335.3613254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

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

LLM Generated explanations, may be completely bogus:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Key Reasons for Backporting:

### 1. **Fixes a Real User-Visible Issue**
The code change shows that the original warning was triggering in
legitimate scenarios:
```c
- if (x86_return_thunk != __x86_return_thunk)
- pr_warn("x86/bugs: return thunk changed\n");
```
This warning would appear in kernel logs whenever multiple CPU
vulnerability mitigations interact, which is a normal and expected
behavior. The false positive warnings could:
- Cause unnecessary alarm for system administrators
- Clutter kernel logs with misleading information
- Potentially mask real issues by creating noise

### 2. **Small, Contained Change**
The commit is minimal and focused:
- Only modifies 3 lines of functional code
- Changes are confined to a single function (`set_return_thunk()`)
- Simply replaces a conditional warning with an unconditional info
  message:
```c
+       pr_info("active return thunk: %ps\n", thunk);
```

### 3. **No Risk of Regression**
The change is safe because:
- It doesn't modify any security logic or mitigation behavior
- The function still sets the return thunk exactly as before
- The new info message provides better visibility into which mitigation
  is active
- The `%ps` format specifier safely prints the function symbol name

### 4. **Addresses Security Mitigation Interactions**
The commit message explicitly states that "ITS and SRSO both can set the
return thunk after retbleed has set it" and that "retbleed is still
mitigated." This is important for stable kernels because:
- Multiple CVE mitigations (Retbleed, SRSO, ITS) need to coexist
- The warning was incorrectly flagging legitimate mitigation sequences
- Stable kernels need these mitigations to work together without false
  alarms

### 5. **Part of Critical Security Infrastructure**
The x86/bugs subsystem handles CPU vulnerability mitigations for:
- CVE-2023-20569 (SRSO)
- CVE-2024-28956 (ITS)
- Retbleed vulnerabilities
These are critical security features that need to function correctly in
stable kernels.

### 6. **Improves Operational Visibility**
The new info message (`pr_info("active return thunk: %ps\n", thunk);`)
actually improves debugging and system monitoring by:
- Showing which specific return thunk is currently active
- Providing better audit trail for security mitigation changes
- Using proper function symbol printing with `%ps`

## Conclusion:
This commit meets all the criteria for stable backporting:
- Fixes a real issue (false positive warnings)
- Minimal risk (3-line change, no logic modifications)
- Improves system behavior without introducing new features
- Addresses interaction between critical security mitigations
- Makes the kernel more reliable and less confusing for operators

The change is particularly important for stable kernels that need to
support multiple CPU vulnerability mitigations simultaneously without
generating misleading warnings.

 arch/x86/kernel/cpu/bugs.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index f4d3abb12317..ea7f94438254 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -115,10 +115,9 @@ void (*x86_return_thunk)(void) __ro_after_init = __x86_return_thunk;
 
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


