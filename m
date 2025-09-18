Return-Path: <stable+bounces-168912-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3C6B2373F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B627C1882FB9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBA2949E0;
	Tue, 12 Aug 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v0bGNv4F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47226FA77;
	Tue, 12 Aug 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025752; cv=none; b=Gxt7ZloHep9bk9Z4O9bGOyF3vRHkuCliRzwUKDr5+ZP7ZrPU34KEdEpOwjN67G9N8NnWQJYrIx+RYPJBMBn4wAIW+jwXSdOHQciVp43+ii07oNkxTN4e3XKO4L1r5f8m+ROfCPei8VOqcqq7tuiV3GjpW/XS7r9Ib4wJ7zcwaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025752; c=relaxed/simple;
	bh=3nv+aDAEqoXECJ/fxqkTVj3nwG/dxJhbl0W2/Xnwkfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unFFFqMGn1Zfbcjd17RSiyKFXZHQp7Q8a28AKonyHywHWeC4+hlcdOIFOA3BbTaTAjfDBpYAfrMf2gEHl3jl7XBR5x5x+15cfkwJ/7812/dDayiWGa03cOMxudlopRCaxBSM5bg9/u1Kay09JLZtC42+vUIR+9nWbHV+1C6CAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v0bGNv4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894BEC4CEF0;
	Tue, 12 Aug 2025 19:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025752;
	bh=3nv+aDAEqoXECJ/fxqkTVj3nwG/dxJhbl0W2/Xnwkfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v0bGNv4FVnsL+YskIMWNvjqCNYZEKr94gmEA0GY+9wy6mpI6nAZ3lxav9Vdo2bIvJ
	 +qwJ+6k40DxuPcvBqK8Z7DgwumQ1vPegTUHGndOZsq94uTztECXkBkzdJAuxE17Hx1
	 BPHzF57xIaS5LVWCqeJthftFAYZsrb562yP0H3JQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 133/480] kselftest/arm64: Fix check for setting new VLs in sve-ptrace
Date: Tue, 12 Aug 2025 19:45:41 +0200
Message-ID: <20250812174403.018193786@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 867446f090589626497638f70b10be5e61a0b925 ]

The check that the new vector length we set was the expected one was typoed
to an assignment statement which for some reason the compilers didn't spot,
most likely due to the macros involved.

Fixes: a1d7111257cd ("selftests: arm64: More comprehensively test the SVE ptrace interface")
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20250609-kselftest-arm64-ssve-fixups-v2-1-998fcfa6f240@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 577b6e05e860..c499d5789dd5 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -253,7 +253,7 @@ static void ptrace_set_get_vl(pid_t child, const struct vec_type *type,
 		return;
 	}
 
-	ksft_test_result(new_sve->vl = prctl_vl, "Set %s VL %u\n",
+	ksft_test_result(new_sve->vl == prctl_vl, "Set %s VL %u\n",
 			 type->name, vl);
 
 	free(new_sve);
-- 
2.39.5




