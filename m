Return-Path: <stable+bounces-170298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0790CB2A367
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FD41B263E0
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF7B31A055;
	Mon, 18 Aug 2025 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XkqBmgpo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28220126A;
	Mon, 18 Aug 2025 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522183; cv=none; b=L4fLiTkhiYyOqXfXpENdoFnfsBsxVztz0zkHpiqA9jg2txoGJARxg18PgZRGvas9Nr6jxBaf+EH7BzKhSZGLtOJ3Hcqu3iZbftH0WuMlRK7IZLCACUYHDs1ZM2fUfhzIQA3SrA8xe6G2um5A+/9yhQhks3k5ulsKwf6ygxpZSbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522183; c=relaxed/simple;
	bh=cMle9pzfz21fhlZiqiEXE618EgQbz+p3q4ADfLhoEH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAG0+4x57HeQ7Q/sGD4yUO51j5Psapg5DjCbTkZUlrwyy7BE/5aXII8qjWG8hKE9zCIp8Ij7MFWzu3/uHu7kAEwcOlSt31kLNqphb7kz6Ndi7za4Rzucpo6XrfKW5Exe95vUs3+JsRjAjwbnrpsgZDrrsiRXlnLGxiQuQvgPZA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XkqBmgpo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21EAC113D0;
	Mon, 18 Aug 2025 13:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522183;
	bh=cMle9pzfz21fhlZiqiEXE618EgQbz+p3q4ADfLhoEH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XkqBmgpoeVti0QFb2HjBqEwo5dqsyqUrksvqFZ3k6xYDVDZ8XEgfD4vRRJVZy6U1s
	 bmZuOh5r8KROw9GhmPxAdYivnf1tcMEz6D1MVAVC1VsqhEod7ydSIl38BpAWZmgTTe
	 MNIxhkSQronK6nBzT30AHfxiXRR6O5v/PtlbeMvk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Breno Leitao <leitao@debian.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>,
	Song Liu <song@kernel.org>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 240/444] arm64: stacktrace: Check kretprobe_find_ret_addr() return value
Date: Mon, 18 Aug 2025 14:44:26 +0200
Message-ID: <20250818124457.827064887@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit beecfd6a88a675e20987e70ec532ba734b230fa4 ]

If kretprobe_find_ret_addr() fails to find the original return address,
it returns 0. Check for this case so that a reliable stacktrace won't
silently ignore it.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrea della Porta <andrea.porta@suse.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Song Liu <song@kernel.org>
Cc: Will Deacon <will@kernel.org>
Reviewed-and-tested-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20250521111000.2237470-2-mark.rutland@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/stacktrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 2729faaee4b4..1d60a08a2184 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -123,6 +123,8 @@ kunwind_recover_return_address(struct kunwind_state *state)
 		orig_pc = kretprobe_find_ret_addr(state->task,
 						  (void *)state->common.fp,
 						  &state->kr_cur);
+		if (!orig_pc)
+			return -EINVAL;
 		state->common.pc = orig_pc;
 	}
 #endif /* CONFIG_KRETPROBES */
-- 
2.39.5




