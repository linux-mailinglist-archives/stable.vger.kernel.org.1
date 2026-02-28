Return-Path: <stable+bounces-220179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAKNBNkvo2nb+AQAu9opvQ
	(envelope-from <stable+bounces-220179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:11:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 829121C583E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF943322329D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001374B8DFF;
	Sat, 28 Feb 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2w6WLug"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59464B8DFA;
	Sat, 28 Feb 2026 17:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300086; cv=none; b=ABKQhYJ8dQ8jIGzhyG1psMmieMhGLTdeshBPGXZVl/s3sqRsEtJEzVfkHYh/iMBz2NkdWhBCVJT2vhn0XCuUtTXj0b5FBnd7JU7iIf+tN/cOcTqOA9qpWlyoPGpWAE6UkvfdkOJeYbrOXCtTPZa0WJxfv+ewHsTG/OCHJ2j3N5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300086; c=relaxed/simple;
	bh=n4I3ZRd9nos2v/LrmTbU4sUnLQMETJn5sEgj8BQmspU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LN2JxOTTo2qeu1IgMPOM38lZQSIQaB1JG9TaAvKJjd+SOpw34BQ8LsyeSvnj9dZyjP+9xIs/szRWsdfuG21dgr0dfYUZ9OOa4x46xxK+YoxxSsHlit9Fjpa7405pHAvrEe8UaPNCsdkiOBCqAvSSDDXIRtAAwIJ/49ekbAt8HLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2w6WLug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A166C2BCAF;
	Sat, 28 Feb 2026 17:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300086;
	bh=n4I3ZRd9nos2v/LrmTbU4sUnLQMETJn5sEgj8BQmspU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a2w6WLugSYu41Ap68YbTOsmiYsh2FAJY2XuXRN+GuMQ3cJoBYURIXxRd9fcn6frUT
	 VgFDoUTZpcZJ01X0X0dFUtMqUStaY9/BwiDasgnqJ6/ed1vCVGosfmKDTQyC/cPobr
	 Zc94oCWdMpIy6a0N1JAXDtgvoseZCIQOmlwhMSE9kI1Z8oJUtTDPcHYU6g6PrjSjAP
	 mvbnw+B2aavsOld7a+Q58WJeLyH4tH9LmYzNlLKq3j9wkIV+slZHKFtgVJKBP+Elg0
	 Ws/iA5dmTZcK+SH9lPfUMYLb+xXFK/sOm0CDK/qe3YBGCz78nYKRirGi9ibR0wT/D1
	 sbqHQZeI1DqTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 101/844] bpf: Properly mark live registers for indirect jumps
Date: Sat, 28 Feb 2026 12:20:14 -0500
Message-ID: <20260228173244.1509663-102-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220179-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 829121C583E
X-Rspamd-Action: no action

From: Anton Protopopov <a.s.protopopov@gmail.com>

[ Upstream commit d1aab1ca576c90192ba961094d51b0be6355a4d6 ]

For a `gotox rX` instruction the rX register should be marked as used
in the compute_insn_live_regs() function. Fix this.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Link: https://lore.kernel.org/r/20260114162544.83253-2-a.s.protopopov@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1999b8d244f64..783d984d7884d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24852,6 +24852,12 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 	case BPF_JMP32:
 		switch (code) {
 		case BPF_JA:
+			def = 0;
+			if (BPF_SRC(insn->code) == BPF_X)
+				use = dst;
+			else
+				use = 0;
+			break;
 		case BPF_JCOND:
 			def = 0;
 			use = 0;
-- 
2.51.0


