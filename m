Return-Path: <stable+bounces-234967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDYCCXGk1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:54:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6963C1EB7
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4850B3020E89
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B788355F30;
	Wed,  8 Apr 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBnkPF0y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F825A321;
	Wed,  8 Apr 2026 18:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674227; cv=none; b=hJmhmGM9JrJ8WUOAO5TU8t1U1P+kBFuFGZSim4Tysidwqp+/ADQBMQGLFuJxQ5YqpttJ0xNaYzBGFNRqFxCSgNGJmP9FHWxFEvqdZpXOfWs0PljRiyuvwxawmAbqCyugjQPsiYMttQyDLRrsAiG6zSVPQIPG1pxpRU7+CoBeZnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674227; c=relaxed/simple;
	bh=ovbFBkR8KQMl+4jMRATitREmvavxwU1huB6J+fAyQVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGgEHijZDwoaQM6DuopittipFiSKYMFUmX5ky4IdEygClKbf2kybOunOA4T2XoHTBnxWQFfzphY81eWmtwRJZk0tkbLy/D2IMRY8cqkDABI5BvJsutkzoiSBS4pxqeYEKPX8ywlP5PnvDpThRRNNHYthQD15YrqmJni6m90RxlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZBnkPF0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B82C19421;
	Wed,  8 Apr 2026 18:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674226;
	bh=ovbFBkR8KQMl+4jMRATitREmvavxwU1huB6J+fAyQVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBnkPF0yp9epYcd2dINO8s6nHl17H2sWByyr+zMa6wXnnxC8MseYOtlhTRzObG8Ii
	 J8b717qbUF7CmZDF5KadVwzDwdaY+aKt8RwOaWOzb9bOGOTq4by09LB32rcvZb08d0
	 jAE8aAL9VRsqZUCruU4TcRMEpyBuHCQbW5HeHSPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 016/311] objtool: Fix Clang jump table detection
Date: Wed,  8 Apr 2026 20:00:16 +0200
Message-ID: <20260408175940.018703250@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234967-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB6963C1EB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 4e5019216402ad0b4a84cff457b662d26803f103 ]

With Clang, there can be a conditional forward jump between the load of
the jump table address and the indirect branch.

Fixes the following warning:

  vmlinux.o: warning: objtool: ___bpf_prog_run+0x1c5: sibling call from callable instruction with modified stack frame

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/a426d669-58bb-4be1-9eaa-6f3d83109e2d@app.fastmail.com
Link: https://patch.msgid.link/7d8600caed08901b6679767488acd639f6df9688.1773071992.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 30609aed5d37e..2f63f938d0890 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2144,12 +2144,11 @@ static void mark_func_jump_tables(struct objtool_file *file,
 			last = insn;
 
 		/*
-		 * Store back-pointers for unconditional forward jumps such
+		 * Store back-pointers for forward jumps such
 		 * that find_jump_table() can back-track using those and
 		 * avoid some potentially confusing code.
 		 */
-		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
-		    insn->offset > last->offset &&
+		if (insn->jump_dest &&
 		    insn->jump_dest->offset > insn->offset &&
 		    !insn->jump_dest->first_jump_src) {
 
-- 
2.53.0




