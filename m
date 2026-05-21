Return-Path: <stable+bounces-253434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGsROSd1Dmpa+wUAu9opvQ
	(envelope-from <stable+bounces-253434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 04:59:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9339959E3F5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 04:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CE33302C026
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 02:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31364383982;
	Thu, 21 May 2026 02:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="I/ycwK4T"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F7936B067
	for <stable@vger.kernel.org>; Thu, 21 May 2026 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332372; cv=none; b=Q0jLA3bp1ItXeEbarUzbx/iwssP3WmRNVhXCiWGDUY4XDAMuix4gxiIL2/UXdIWIh39q5Kba9ztNkDJNoHUnzM4C9NUwnwy7VNDBck8SXXY40r8x0NbK9IE0xEMsYqMXfMBy2r5DVby2bVHCbsIUNEcvJpyN3rXhN512kkqvEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332372; c=relaxed/simple;
	bh=oHsfccn7DDbOn6VBM/zSWqYwTq+d7qUjU4CoIduHDQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBPpO+pq+Dn50FF57BOMfivDg/0p+sNldb/fWLz3XkC3NxQ+TS+j1g1gshx0ZsOFqocLqWRze+mTZzNZ50lPqm/sGfl+qsvVs+d9RPt6v/5y9nQeaw1zZIdm0tBioLamjba+Rdx6hTCPWRG/miLn5MqlLgO0ncqjZvlgS1lwZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=I/ycwK4T; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65e4f6103cbso284103d50.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 19:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1779332370; x=1779937170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XKb2Lqr4W3lw4U2X+TN89zQnTM+iU4ox03eiLP8Puw=;
        b=I/ycwK4TMG9SWoBWs7GGWmpyy/zMgqVJjV8Od4XM4lPIgfZjaXoP77LJx6QdLBYdWt
         jspYHPHHiWy175XjS0m0NYSroj62j1DADFlesGkVd87rJ8+iffHe7cJ4MCPE0dfNWitH
         EMtrDVqOXk3YS90Pc2S0isRAXcb8tXf8wE8bPRqQcmqqKTE5BkQFBAYsmYBjlRUPMeuJ
         BmnT1Z1BA2vYfJuBjG4HJNfaxJXfN7JoBYXN/3hxTaF6U3cEEzJZgSgYri2tydgCF0bR
         +lMbiSVinixoE6mCPLf0n2QtakJQ79NWeMWlFbs62ZWDCptG1gvHAz25ZLk/lcZvRCnK
         KGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779332370; x=1779937170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+XKb2Lqr4W3lw4U2X+TN89zQnTM+iU4ox03eiLP8Puw=;
        b=S2rBr+r9jsco4CjvzWvkPjr71nmwaN5Nj92wSPstF6LnazaJXBm7V2a8Ww/EmBAtJd
         Bm5dt88pkMKgXjtg+XHf6yB3cXTcWhUtcY/A8wvhr+7C58j8RLGVGzrY7bIsPqumVgQr
         pRMbqCPf9tMAFqKanLLU/V2VkT2fA7a4lrCYR7KrwymzPnZMp1CPioHrgkbrqwC1Ospo
         xinVmT7csQ/ZnPzxgkR5Dq+9G1J6dlLbY8VbzOW6gmuYg1UTINt8rQld2S8DgeEDPpa/
         8qLIkFoiTlx48iQKgX/kzxbp8Y4J9urI8Fiu/GmA/sCBPsSgNeoSiNhnJBRFRLC6ucNR
         EIsw==
X-Forwarded-Encrypted: i=1; AFNElJ9gAnxwKBOTw7MlKF+Y7Bf/qWxu9oI8FhKuETaLlg181DtMCtHezcxnzHNGmZMY18E5EjzvG3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF9v+enlI4dJm+LsFq7cv5uVYytw+rlRUeadAnL3UzagTVp7xW
	rUgW58lf6CI9ONeyMRGUDQmzIFYRNZp+PyhFJwS/+DbPsff2+gF+bBIG91c4DIOLx81D
X-Gm-Gg: Acq92OH/ZMH5+ev8kRSrZ9OPu17U5U0KkUw4l0ypQT0oxtNyXQdfjPmwnkH6t0n7H4J
	JTjjkns9+QK466A8BssijlYnuTS/gViL7GrD0XR/6s7t36LTdwxJcVhiHABemML5/4lXb2ZV8H4
	ZHRlp3kcE0QmL65RioVPoS6hk3uDv2tNTsjYOurHlp2A806AENJwao4z6Wg5Ah164+W2WVGuWLW
	XWEjUNUGDHiG7sBqGrhnabcPNAHUoDCHOve8KiBKKtDwSyqqJCrO4nZ2ioF1vz7REuiyfUp8EyV
	sTeY2Vrly/D0biQ2mSclIkVMZZlnfPHLAdewR0pVRiNNj80eoTIbVXA4a/sQ7HTl6IetS6SgCMH
	KFPiPdFClB5VjSS9UmxK5D8Uv39y/LvvlFV18/MS3GMobc7NfD5RPRw5VLU/BrzqjrfvG/aMJY8
	6roYi7Yx6PFWXqAXjtCa6w8Z5vkQhmPgZlcCfo9Le8wixQ+SE0JyYXWAeJQKKUsaM+k71rvMJnE
	4FSDvPPQnPB4KusL4Z/0n3Mxg==
X-Received: by 2002:a05:690e:140d:b0:65c:6ffb:303a with SMTP id 956f58d0204a3-65eae2fdc85mr521328d50.8.1779332369665;
        Wed, 20 May 2026 19:59:29 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d86c850sm10092743d50.1.2026.05.20.19.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:59:29 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: tls: preserve split open record on async encrypt
Date: Wed, 20 May 2026 22:58:39 -0400
Message-ID: <20260521025840.976378-2-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521025840.976378-1-clusk@northecho.dev>
References: <20260521025840.976378-1-clusk@northecho.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[northecho-dev.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-253434-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[northecho.dev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clusk@northecho.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[northecho-dev.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[northecho.dev:mid,northecho.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,northecho-dev.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9339959E3F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the BPF sk_msg verdict sets apply_bytes smaller than the current
open record, tls_push_record() splits ctx->open_rec into the record
being encrypted and a remainder record. The synchronous path reattaches
the remainder to ctx->open_rec before continuing.

If the selected AEAD provider completes asynchronously,
tls_do_encryption() returns -EINPROGRESS after unhooking ctx->open_rec.
tls_push_record() currently returns immediately in that case, before
the split remainder is reattached. The remainder is no longer reachable
through ctx->open_rec or ctx->tx_list, which can silently drop
transmitted data and leak the unreachable tls_rec.

Keep the split remainder rooted even when encryption of the first record
is pending asynchronously, and continue the BPF verdict drain loop after
an async record has been queued. If that loop then hits a later verdict
error, wait for the pending async encryption before returning the error
so zerocopy user pages cannot be released while cryptd still reads them.

Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4-7
---
 net/tls/tls_sw.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268..5b20be5b4 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -840,16 +840,19 @@ static int tls_push_record(struct sock *sk, int flags,
 	rc = tls_do_encryption(sk, tls_ctx, ctx, req,
 			       msg_pl->sg.size + prot->tail_size, i);
 	if (rc < 0) {
-		if (rc != -EINPROGRESS) {
-			tls_err_abort(sk, -EBADMSG);
-			if (split) {
-				tls_ctx->pending_open_record_frags = true;
-				tls_merge_open_record(sk, rec, tmp, orig_end);
-			}
+		if (rc == -EINPROGRESS)
+			goto split_done;
+
+		tls_err_abort(sk, -EBADMSG);
+		if (split) {
+			tls_ctx->pending_open_record_frags = true;
+			tls_merge_open_record(sk, rec, tmp, orig_end);
 		}
 		ctx->async_capable = 1;
 		return rc;
-	} else if (split) {
+	}
+split_done:
+	if (split) {
 		msg_pl = &tmp->msg_plaintext;
 		msg_en = &tmp->msg_encrypted;
 		sk_msg_trim(sk, msg_en, msg_pl->sg.size + prot->overhead_size);
@@ -857,6 +860,11 @@ static int tls_push_record(struct sock *sk, int flags,
 		ctx->open_rec = tmp;
 	}
 
+	if (rc < 0) {
+		ctx->async_capable = 1;
+		return rc;
+	}
+
 	return tls_tx_records(sk, flags);
 }
 
@@ -871,6 +879,8 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	struct sock *sk_redir;
 	struct tls_rec *rec;
 	bool enospc, policy, redir_ingress;
+	bool async = false;
+	int async_err = 0;
 	int err = 0, send;
 	u32 delta = 0;
 
@@ -920,6 +930,10 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 	switch (psock->eval) {
 	case __SK_PASS:
 		err = tls_push_record(sk, flags, record_type);
+		if (err == -EINPROGRESS) {
+			async = true;
+			err = 0;
+		}
 		if (err && err != -EINPROGRESS && sk->sk_err == EBADMSG) {
 			*copied -= sk_msg_free(sk, msg);
 			tls_free_open_rec(sk);
@@ -988,8 +1002,18 @@ static int bpf_exec_tx_verdict(struct sk_msg *msg, struct sock *sk,
 			goto more_data;
 	}
  out_err:
+	if (async && err && err != -EINPROGRESS) {
+		async_err = tls_encrypt_async_wait(ctx);
+		if (test_and_clear_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask)) {
+			/* tx_lock is held; the worker will reschedule if needed. */
+			cancel_delayed_work(&ctx->tx_work.work);
+			tls_tx_records(sk, flags);
+		}
+		if (async_err)
+			err = async_err;
+	}
 	sk_psock_put(sk, psock);
-	return err;
+	return err ?: (async ? -EINPROGRESS : 0);
 }
 
 static int tls_sw_push_pending_record(struct sock *sk, int flags)
-- 
2.54.0


