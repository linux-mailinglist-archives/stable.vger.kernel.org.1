Return-Path: <stable+bounces-140380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C05DAAA839
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D66D9874F6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F7D3464D2;
	Mon,  5 May 2025 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sft5gvJx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA613464C9;
	Mon,  5 May 2025 22:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484730; cv=none; b=co+3GDGR4Oo3gAHCAjZeiQUzuHmvS+SbQU1NHnlqVyZkHgI7iK/atYQ+CUiidwDROpEowMsEIknck5PmEYFyWBDlKlu1BgaVJ5dcrosjoHC8IzrqXwJ1c29AbphJtm0t0cUAIigkCX4srdYkUKM889tN88wYpnriooyosd3qTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484730; c=relaxed/simple;
	bh=xEIUH3buQBojkVy+7Q31VBRcH2J5ekizN/s09I2B+s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNybKbjXq11azjDRHRpjurrsO0Y60VIq5fLHR5pRXDxSnoGcjAQkF8I3RRQq2bxd3NeD7MwtyveOA1nDwf7nnP5KZ9vd8U4v8c/PvvVFGrz3Nj8I+qAAXHFdEyq69Jr2jGnNLZaqbAkM4lCYW7wD/rF6ayg26EroOEww/sD5qxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sft5gvJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CEEC4CEEF;
	Mon,  5 May 2025 22:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484730;
	bh=xEIUH3buQBojkVy+7Q31VBRcH2J5ekizN/s09I2B+s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sft5gvJxgzDDswjUK1IeF0FscVvcYYhyzTfHj5PhRS/IwHjf45vUdZdwN3xjKVwMr
	 l8lASDuaXG49r6kxCgFfkGHE06Uim6bucFfgH5jYB2WnzSJx/ujuGTqeR6vr4BiBmk
	 umfWUhsf6KJsC4v9dYsK1LMOKgg2y3zPb29/55x3dHqyzsTGopepIoK9cflivKUvSx
	 KppoTyI9eP8/fxwp45bCpaInBo+IeFQbXr6K6hSAk3V4Ay6Zr0MO9cWJM5+s2fcSIU
	 zyLWNNj2izawU0xW7626NNRkXilntmhH/nObCJTGx7U8oJnGI5LELWZVNFVf13TFlY
	 /MRjdZPH+W8ug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 631/642] bpf: abort verification if env->cur_state->loop_entry != NULL
Date: Mon,  5 May 2025 18:14:07 -0400
Message-Id: <20250505221419.2672473-631-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit f3c2d243a36ef23be07bc2bce7c6a5cb6e07d9e3 ]

In addition to warning abort verification with -EFAULT.
If env->cur_state->loop_entry != NULL something is irrecoverably
buggy.

Fixes: bbbc02b7445e ("bpf: copy_verifier_state() should copy 'loop_entry' field")
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250225003838.135319-1-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4392436ba7511..1841467c4f2e5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19265,8 +19265,10 @@ static int do_check(struct bpf_verifier_env *env)
 						return err;
 					break;
 				} else {
-					if (WARN_ON_ONCE(env->cur_state->loop_entry))
-						env->cur_state->loop_entry = NULL;
+					if (WARN_ON_ONCE(env->cur_state->loop_entry)) {
+						verbose(env, "verifier bug: env->cur_state->loop_entry != NULL\n");
+						return -EFAULT;
+					}
 					do_print_state = true;
 					continue;
 				}
-- 
2.39.5


