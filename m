Return-Path: <stable+bounces-237426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDOSGnYh3Wn4aAkAu9opvQ
	(envelope-from <stable+bounces-237426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:01:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DE43F085F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4FF9304A653
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE6433123B;
	Mon, 13 Apr 2026 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y8cGeE6N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F610318ED2;
	Mon, 13 Apr 2026 16:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099427; cv=none; b=OsGogJWxxN0ymimjGs7wNX0czRtkjz2vmfswsFeSfUAPyYFrlmR1pln1v6D0GpWswdiAnU1cl8VskAvbrrIbTu2yaFOOA05emumsg26rfmpX4yfcROe75gQvcZPQntsbYp3fYSf2XXP7cKiZI5o9HUHIerxYGD4wM6pIHw3Me5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099427; c=relaxed/simple;
	bh=XraGSiQ678NJo1eRtFpFE9cFPf+GZQH3hR37aM6FYZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSwLXK1UC4ch8SS/L8HHMXfhLXPZ+cIfMCwu6sgeZ0g0m/I/lLW2q/kM71a7AtT2BPwbsZ9uRDaMGTqCB6rZN3eY7OqGqSkPv/xi2iIaiGpkUNtMyHBOxHKshEaG++ZM0VLSss5KtFBscR5lkXTlHzfgTQuiGdRRnHpW2zbCqJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y8cGeE6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC5DC2BCAF;
	Mon, 13 Apr 2026 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099426;
	bh=XraGSiQ678NJo1eRtFpFE9cFPf+GZQH3hR37aM6FYZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y8cGeE6NK19ZKg0tfnibwC86Ox6T0NfQ2IVQUh1fzxs/XMO3YI58ogJ3qrJvfE+L2
	 z2/PXQ0iNm9ysY4toI8WW5yUxoJCQsfJnW07jxsOeCeiKmJybO9RhGLfwmr9DusRNG
	 ee8LU5Kt7iALrSURouV6P+DK1tllm2xehV5XKDtk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Amery Hung <ameryhung@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 335/491] bpf: Fix regsafe() for pointers to packet
Date: Mon, 13 Apr 2026 17:59:40 +0200
Message-ID: <20260413155831.582185876@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,iogearbox.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-237426-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,iogearbox.net:email]
X-Rspamd-Queue-Id: 24DE43F085F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexei Starovoitov <ast@kernel.org>

[ Upstream commit a8502a79e832b861e99218cbd2d8f4312d62e225 ]

In case rold->reg->range == BEYOND_PKT_END && rcur->reg->range == N
regsafe() may return true which may lead to current state with
valid packet range not being explored. Fix the bug.

Fixes: 6d94e741a8ff ("bpf: Support for pointers beyond pkt_end.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/20260331204228.26726-1-alexei.starovoitov@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/verifier.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a2ccbd97e8dd2..e6cf29b117e1a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9459,8 +9459,13 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
 		 * since someone could have accessed through (ptr - k), or
 		 * even done ptr -= k in a register, to get a safe access.
 		 */
-		if (rold->range > rcur->range)
+		if (rold->range < 0 || rcur->range < 0) {
+			/* special case for [BEYOND|AT]_PKT_END */
+			if (rold->range != rcur->range)
+				return false;
+		} else if (rold->range > rcur->range) {
 			return false;
+		}
 		/* If the offsets don't match, we can't trust our alignment;
 		 * nor can we be sure that we won't fall out of range.
 		 */
-- 
2.53.0




