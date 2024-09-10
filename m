Return-Path: <stable+bounces-75219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4867F973382
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41E91F22F48
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA82192D6C;
	Tue, 10 Sep 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nQqdT65w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B018FC73;
	Tue, 10 Sep 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964094; cv=none; b=bXJhoF/2RxamKSshd6a3hfyl131TMjefhgYzrGUXgrzLi1SbqeU/6r4GRzno4MkeA9GOqwcHIkwnHcgDet3ohVUBtv5VET/1tnxzbwgyeeUbI2GhWVyojR1WfD+q4ePEFAy6e1EbZy8CvdRNTFirK8G/ByWgDVf1Qw7v6frO/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964094; c=relaxed/simple;
	bh=WGdW5pqQ3kc0TYKtekXhtwOa4E8qy825AkjoAXhSEV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IldVlPcincbwkpW7mAVCIQE3cxwjeqDTeKaXyWA/LuUKGoBWvTOs1CHlTu5M1UZuqZWglHKItzgxhavFVcd6z74fLgPU5WozGufN179ZE1Qz8kRw8/Rb5K0BcdPn8XTZpAQymPCGh/MO+OzSoH+WN7+6etPGODtERFROzIisTUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nQqdT65w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77A4C4CEC6;
	Tue, 10 Sep 2024 10:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725964094;
	bh=WGdW5pqQ3kc0TYKtekXhtwOa4E8qy825AkjoAXhSEV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nQqdT65wdjbyW0AaMVSxin5tdQq1Tb5S4knZ/gj1jFZTovmkOOJHS3nD5HFSWxKxN
	 XLUo4MxTB9supZmUYp+onPaLkbqoQ4av8yKIIePuGFOA0oXk2fLQCEEfo95+LnFPvx
	 AIdmXSArohbiCdUR5emqTHvaP2mANtWN4CAMSKoU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Leon Hwang <hffilwlqm@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 066/269] bpf, verifier: Correct tail_call_reachable for bpf prog
Date: Tue, 10 Sep 2024 11:30:53 +0200
Message-ID: <20240910092610.545824362@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092608.225137854@linuxfoundation.org>
References: <20240910092608.225137854@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Hwang <hffilwlqm@gmail.com>

[ Upstream commit 01793ed86b5d7df1e956520b5474940743eb7ed8 ]

It's confusing to inspect 'prog->aux->tail_call_reachable' with drgn[0],
when bpf prog has tail call but 'tail_call_reachable' is false.

This patch corrects 'tail_call_reachable' when bpf prog has tail call.

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
Link: https://lore.kernel.org/r/20240610124224.34673-2-hffilwlqm@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3f1a9cd7fc9e..9d5699942273 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3064,8 +3064,10 @@ static int check_subprogs(struct bpf_verifier_env *env)
 
 		if (code == (BPF_JMP | BPF_CALL) &&
 		    insn[i].src_reg == 0 &&
-		    insn[i].imm == BPF_FUNC_tail_call)
+		    insn[i].imm == BPF_FUNC_tail_call) {
 			subprog[cur_subprog].has_tail_call = true;
+			subprog[cur_subprog].tail_call_reachable = true;
+		}
 		if (BPF_CLASS(code) == BPF_LD &&
 		    (BPF_MODE(code) == BPF_ABS || BPF_MODE(code) == BPF_IND))
 			subprog[cur_subprog].has_ld_abs = true;
-- 
2.43.0




