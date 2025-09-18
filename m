Return-Path: <stable+bounces-168317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24163B23479
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6685A3B4583
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949C26A0EB;
	Tue, 12 Aug 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lXPBc0pL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB26361FFE;
	Tue, 12 Aug 2025 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755023774; cv=none; b=OZrKF5M4SBPxza8qkn1VJN1nes+wp0yRyTRR7I2u/I/DxHLqgmNF2BhMSN0gz59wip+nJeXudxSmUZ9zzIYF8HS7hy6QU3Ei30EhNWdCVazTRLTsqwcb6PxIX+v/3ARbBek8b4SCMg6ZD4/dMaqeFvtj7rwY8teI2QOrz90TK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755023774; c=relaxed/simple;
	bh=NZ9NfTGdvgmKvE8q/1YL/8qlbhAqK+ZSOiuViwyv0tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JM4aVj4L2KFsD5Ohx8KL4bcHGvj8ZFJrmJFZg5LwI+QcLOMMwYG1SKpDO4jMN6QZOO3569lh3D8hxNl0lvEp1D47Dcy1HgsihZpbHhbKxT91dLHxuVv9S9HIkkC3LLxUQaxDPIwHuR3295XPE2bSVYH3jztyVlB4Gl0jG2jS0Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lXPBc0pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47331C4CEF0;
	Tue, 12 Aug 2025 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755023774;
	bh=NZ9NfTGdvgmKvE8q/1YL/8qlbhAqK+ZSOiuViwyv0tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXPBc0pLBCSR7aFLeyj4Ax5rhz7Nm3ZSiSKez21aKalejvSDR6gIJsCsNev7Gotzl
	 OcPZs1I9f092p+WEuSd3kUFy4/02Ok0gaEsbj40sUVojV1clSyH/+UFKnv2OKNOWkE
	 kREtNuaBPg8+1336k6JSjz75ums4YHyWPl5MDZUg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Rutland <mark.rutland@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 178/627] kselftest/arm64: Fix check for setting new VLs in sve-ptrace
Date: Tue, 12 Aug 2025 19:27:53 +0200
Message-ID: <20250812173426.047848494@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173419.303046420@linuxfoundation.org>
References: <20250812173419.303046420@linuxfoundation.org>
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




