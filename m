Return-Path: <stable+bounces-242024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NWSJfz48mnzwAEAu9opvQ
	(envelope-from <stable+bounces-242024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:38:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56D49E282
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 08:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBF5930376B1
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 06:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7051E8320;
	Thu, 30 Apr 2026 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJK1YTct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6033783B4;
	Thu, 30 Apr 2026 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777531076; cv=none; b=ARad8XhDMwzpZrJLa6SOYADrNEg+AplM6TvE2aDhrWP2WUcK8/RNzlSCz6C3QoY1uV52TB/8Ep5nf5gCs7bPCv13aXrD/LbEAiR81Ub8MEEB2CEmgZr6XlPppNJU8rMU1wLrNKygj4zkgjyDkH8i/9sCq7o/Rqp2caat2rzDkRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777531076; c=relaxed/simple;
	bh=MtdvDNBZf7D25wdl3A2GvDJjG3yRz7P/qNzSC7Cn+3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtvBNH8NkY+Wk4Ru5Tkh1RseLD2/HH7DYFw3kmtVAVX8QkVZUp3rmyVp8xReF/IceIs4qAo5FZY0yQtPlRSJ2tsP4VQvx4yc7SszeLLTHll8DH8Ef3pE4xQiTRfK+k4hSyWrgDF5iqt+KluBBcD43y2Cv9N9LEgub/30YzisKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJK1YTct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C83BC2BCB8;
	Thu, 30 Apr 2026 06:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777531076;
	bh=MtdvDNBZf7D25wdl3A2GvDJjG3yRz7P/qNzSC7Cn+3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJK1YTcteWskA1mXD4iPYaxJ3YbJbrwXNZi6EZwpyDolNikzotScgCUJ/V2IHd5Io
	 8N7hab8jmhobUeGMgYvfOOOw7MtptyQxM+Pei/iLzf7hc6sWzIwDjD1QwA1vxYdPzi
	 nVc672+zs4ZN9k4M2rFsWDvXv8gfN/KDvMRUediWKdf8+92u9fuxE04FZ3EBtbKPBB
	 jI/CQb1r6RpC8zf/W2+rFhbqNo44MNu1ap91Y5w9FOr2vPrFwnR+LeEFeUIRzwKS1P
	 X4XIl6lTulG1gWnmMDbuTXJfCqeCCMuQhk4FVW3XwHQX76miWb6Cu+NnuttmOFJ58U
	 M6vpimqs1IShQ==
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	syzbot+d23888375c2737c17ba5@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 5.15 8/9] crypto: af_alg - Fix page reassignment overflow in af_alg_pull_tsgl
Date: Wed, 29 Apr 2026 23:36:03 -0700
Message-ID: <20260430063604.173525-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430063604.173525-1-ebiggers@kernel.org>
References: <20260430063604.173525-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D56D49E282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-242024-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,d23888375c2737c17ba5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]

From: Herbert Xu <herbert@gondor.apana.org.au>

commit 31d00156e50ecad37f2cb6cbf04aaa9a260505ef upstream.

When page reassignment was added to af_alg_pull_tsgl the original
loop wasn't updated so it may try to reassign one more page than
necessary.

Add the check to the reassignment so that this does not happen.

Also update the comment which still refers to the obsolete offset
argument.

Reported-by: syzbot+d23888375c2737c17ba5@syzkaller.appspotmail.com
Fixes: e870456d8e7c ("crypto: algif_skcipher - overhaul memory management")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/af_alg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 4f667a503277..8f7cf57da8f6 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -595,12 +595,12 @@ void af_alg_pull_tsgl(struct sock *sk, size_t used, struct scatterlist *dst)
 
 			/*
 			 * Assumption: caller created af_alg_count_tsgl(len)
 			 * SG entries in dst.
 			 */
-			if (dst) {
-				/* reassign page to dst after offset */
+			if (dst && plen) {
+				/* reassign page to dst */
 				get_page(page);
 				sg_set_page(dst + j, page, plen, sg[i].offset);
 				j++;
 			}
 
-- 
2.54.0


