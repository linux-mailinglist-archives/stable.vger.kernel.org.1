Return-Path: <stable+bounces-147722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA9DAC58E8
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED2F19E00B1
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F200928001E;
	Tue, 27 May 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D1qaoYlN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B427BF8D;
	Tue, 27 May 2025 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748368228; cv=none; b=df/60GHdR4m75bcY9BZuxPghiVpzEYBkdS2ZP+9fAyXGQq526LelYSJKTt3c+JV2+6stpY7D1x+Wk2+ht//yffq2AciGe1AKRbpRPssLOWYEZJfiKYO+vrifsji8rvQUBwL/Ilx/UranlUA6JwfM28VhTePYfCxmXmsomh+jk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748368228; c=relaxed/simple;
	bh=/vENUCXbF8ZVHkWeTr7ExXoRse3r3N4BP4CxuTJAExs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHHFXGrI4qLAoS6COkuD+6DMzeDSQD1Jg5YtiGOVapjUJZZf3+/wIXrx0TjodxOUOl9Iek2Hor6if0PFEsCepOz4ZhWdtYZCmR1Vfnx5Ci2Vx59uxvU4AsDX96TeWBn7huwPhzGmHP25D03E5mWWj6o8WsWTQF0p60IFHozvVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D1qaoYlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA0DC4CEE9;
	Tue, 27 May 2025 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748368228;
	bh=/vENUCXbF8ZVHkWeTr7ExXoRse3r3N4BP4CxuTJAExs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1qaoYlNa9rMr1G1IrmuKoYkls/uy06ai1SMnmfJGdoe3hWk8WFyMNSoyJUyTAKpE
	 DjkCqCZbHPjcHDakmnPza3k+IkQs74RUmAosv4gKwN3Vsi/8+DJED1GQyGorEXnk2A
	 7xv3fHVUI/E/Va30qI+ljOE8cqwRpN1Fpyt+VwAk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 638/783] bpf: abort verification if env->cur_state->loop_entry != NULL
Date: Tue, 27 May 2025 18:27:15 +0200
Message-ID: <20250527162539.127755857@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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




