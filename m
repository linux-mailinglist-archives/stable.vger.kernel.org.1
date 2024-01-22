Return-Path: <stable+bounces-14158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD56837FB9
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B5A1F2A3AD
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6A364CE2;
	Tue, 23 Jan 2024 00:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PRwTQLL2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E359964A80;
	Tue, 23 Jan 2024 00:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971319; cv=none; b=p5U35Sc+n0FTN8iZ+lKSsIrhYhEv1HmpMEKVBR+ZW3qN5pFaJn/hnET0Hiius6GWgHsIPVVPTxxgZmkumINY+MGSDLjkdxmkm2sO9pUE0eI44ncmOLq9E5uslsXQE2KUPRZjCbDQdRWhF3WmKB02INLc7UzNE7WfyPotoYwRHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971319; c=relaxed/simple;
	bh=VIqk3OPkCpBgndo6IuoqFczPc1esLEG0ig53irdKeJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3ntWrw0uppnNOv7qeqiGucoriCl9laDJqe98xlPiCrp6UZbIfCMX4a7RZVJH/IkgpRyWfLoTh+UKy6w8a5PUXKNTprI0RBVeUtqxHmxaFqpd5lox6DunxsTuRHYb2AVOXfIT5duxV0fzgozF4dZ4uDOeWEpi9/hfS7UYUizXkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PRwTQLL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D59C433F1;
	Tue, 23 Jan 2024 00:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705971318;
	bh=VIqk3OPkCpBgndo6IuoqFczPc1esLEG0ig53irdKeJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRwTQLL2LI/HBYqwcE4QSrABtt15+1o7USN3/WWwHwWfxJ/YCUrRz3uTLKBLuERVM
	 +tY2F98RcfvSdu9hcNvlejwAhuOOIN6Tog1Uqnt+ib7sBtvqcJjKvuw0qGDMBNwrlz
	 sYHk5f6aoG396xrlQj8F1AV3m82o0eepfwHQsE2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hao Sun <sunhao.th@gmail.com>,
	Andrei Matei <andreimatei1@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 124/286] bpf: Fix verification of indirect var-off stack access
Date: Mon, 22 Jan 2024 15:57:10 -0800
Message-ID: <20240122235736.904800839@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235732.009174833@linuxfoundation.org>
References: <20240122235732.009174833@linuxfoundation.org>
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

From: Andrei Matei <andreimatei1@gmail.com>

[ Upstream commit a833a17aeac73b33f79433d7cee68d5cafd71e4f ]

This patch fixes a bug around the verification of possibly-zero-sized
stack accesses. When the access was done through a var-offset stack
pointer, check_stack_access_within_bounds was incorrectly computing the
maximum-offset of a zero-sized read to be the same as the register's min
offset. Instead, we have to take in account the register's maximum
possible value. The patch also simplifies how the max offset is checked;
the check is now simpler than for min offset.

The bug was allowing accesses to erroneously pass the
check_stack_access_within_bounds() checks, only to later crash in
check_stack_range_initialized() when all the possibly-affected stack
slots are iterated (this time with a correct max offset).
check_stack_range_initialized() is relying on
check_stack_access_within_bounds() for its accesses to the
stack-tracking vector to be within bounds; in the case of zero-sized
accesses, we were essentially only verifying that the lowest possible
slot was within bounds. We would crash when the max-offset of the stack
pointer was >= 0 (which shouldn't pass verification, and hopefully is
not something anyone's code attempts to do in practice).

Thanks Hao for reporting!

Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20231207041150.229139-2-andreimatei1@gmail.com

Closes: https://lore.kernel.org/bpf/CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddfd33703f4d..fce2345f600f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3926,10 +3926,7 @@ static int check_stack_access_within_bounds(
 
 	if (tnum_is_const(reg->var_off)) {
 		min_off = reg->var_off.value + off;
-		if (access_size > 0)
-			max_off = min_off + access_size - 1;
-		else
-			max_off = min_off;
+		max_off = min_off + access_size;
 	} else {
 		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
 		    reg->smin_value <= -BPF_MAX_VAR_OFF) {
@@ -3938,15 +3935,12 @@ static int check_stack_access_within_bounds(
 			return -EACCES;
 		}
 		min_off = reg->smin_value + off;
-		if (access_size > 0)
-			max_off = reg->smax_value + off + access_size - 1;
-		else
-			max_off = min_off;
+		max_off = reg->smax_value + off + access_size;
 	}
 
 	err = check_stack_slot_within_bounds(min_off, state, type);
-	if (!err)
-		err = check_stack_slot_within_bounds(max_off, state, type);
+	if (!err && max_off > 0)
+		err = -EINVAL; /* out of stack access into non-negative offsets */
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
-- 
2.43.0




