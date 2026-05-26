Return-Path: <stable+bounces-254238-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDl+KS4LFWpPSQcAu9opvQ
	(envelope-from <stable+bounces-254238-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:53:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B005D025F
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 04:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9941C303B4D9
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 02:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE36332629;
	Tue, 26 May 2026 02:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b="TEbOSmrq"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A33264E6
	for <stable@vger.kernel.org>; Tue, 26 May 2026 02:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763932; cv=none; b=EfeOcRnY6B6t9dHH719LDiF6czROuCvOWM+e/XgOGhBFOl6k9B4LMLJ5G3oDVl8pISSLP0sHd5LpO5hnXNVZvlIsP0E1sAd6OTbtziG0499dnJ/z45gDMBBCOWX5bTauPdDc0Ra2IIaKD/1Za7klB0vpzEe3S2YKEXy5kTLm1SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763932; c=relaxed/simple;
	bh=o9wMTxhYiDKmflOFYsWj2G5+KhuWu2fGjh/QrAEnzwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3pLU6wV0Tv3KY5h3eRJKjtl+S8Ed3V2Fpz49VJbDoBRJuh7jDx32B8fgNH5MPkLd5Yjdp7FEZHLTITL8R4ygUYh8VQp/Ei3Zgtm/smGh06WwwDzJidafezT+GW2f7vPEECd21gyXwExxNqJVXl0l0BQwra4DXEZKWAf6pTJPIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev; spf=none smtp.mailfrom=northecho.dev; dkim=pass (2048-bit key) header.d=northecho-dev.20251104.gappssmtp.com header.i=@northecho-dev.20251104.gappssmtp.com header.b=TEbOSmrq; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=northecho.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=northecho.dev
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-651ce87d785so946001d50.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 19:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=northecho-dev.20251104.gappssmtp.com; s=20251104; t=1779763928; x=1780368728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=naGseeLsZOt5/A5Mc1MGjXdOC/ihUE1Cs3gNHn6WygY=;
        b=TEbOSmrqKq3smUDcMdEMyNVgqupAbh3DDq0dAoGy9owBXUAEFgnpDhtzgn5FbS062k
         Ks+Ha2gHno4vvvrvN1o2Fwle9wjNrpSOasnJ6UVdCeMtV3dNDNqrs3BpYn9oqvpmKaZ3
         PY3MJ+ItyQ+Z+miQU6l3S3HFbDklKhxRVoh/6CjB/QA0boj4eFh19/k4pPZW7AI877BJ
         RvCwnXWzkO8FG5ZvKLwk04dxb3LX+CRk7ifKP28TIXv/BuW8G5RNzgB5yRTRoMkhYkoY
         XquAleCLQ8+Hods1tjYaHw/tALUfDRh1MCb8QwWjlCskWWQKH69foWgSDGtHWCKXwBeT
         DlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779763928; x=1780368728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naGseeLsZOt5/A5Mc1MGjXdOC/ihUE1Cs3gNHn6WygY=;
        b=LW4tqR0K09Cen5I6j/bvUbeTaZPtPbJkECh/T8KzEMy7PJ2Y2WCImGACri7Zm07Zy/
         kg7TlVlk5cOsWgVHMl3Fh2wbmzoNaR9wgR/WWLTWFLP2TT4psRLO/EbyrkuBbf/llPp9
         CDHvg9lD8CZFJL4VPZ02potDV9UIJimfWsmcfZpWe7YnmurrWFWBZlgIoSRXCBm1+hPx
         WH6T2ABvqCiCMFXLeJMagM9f+0bSoJvW2W2XLSDhfxO4QhFqRDiE4mndHogZfP6saklI
         /Hez+YFZha9Qw41q0YJVZwQupaGD8GYXzT63iFZ6sdtSABzIBU0lOCJDNc3RQ10rVIC2
         +d0g==
X-Forwarded-Encrypted: i=1; AFNElJ+4Uh34TOIUPQqhBCEGP5Q9SYZEPiP9Enq2lqknN0+M45c5fLcAkzs+1AcYGSU92Jj7tNZtZ4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYif4+CAiQPRNzxYKss9yVVDhvkmQ11DnPiCjHNwo+PCEMp5eB
	4zmnRuf5eNgHG7gFv4rairphPsejHRI1D+k8Z83c8kCNTMsCpWatri+c/mW1rDZ7C/FP
X-Gm-Gg: Acq92OFz0ZVLCm0my6IIAikMRoY3TPhBwOzKr3BAb812i1QPhb5KPp6nZZLyTxI/AzG
	Qh7xCF+FVfio6/e3ZNZlX57ur2EAr+5/tgHj2I+d2fTIcJ4FVIheJYHQBLASM+SLnJjOXUl2S9m
	tUOYlWWmzil5FRFvpN1drMvoIdvaGA9AKpeBaYtKLxaNz/pehdqBs2frDhZcMnVvt9VUZnBvTKf
	QYYIlxao778yEcigBIVCHEEND3xarKFHMa6x0qA9N0bbLxZW3pRxaKjD1fZMG3TnUAL1+cVU9Ey
	hr51cRX3J8i1oWiwPvFRtxMqK3QjdMaPIy33nDgLibLWe8PS7zkdKQG+oyxy5krfai9TCkFcex3
	WMnPyNx12TSwiWOzA0UhOEYL+Yk7WJIgBzf2kfuF/UYMvJa5ws8GpSWeY4e2XqWzW0hGLJ7hW5X
	ntOCLrAHCcxptVGaFScE2jZUjUxcG/MTGswMNMT41e7Iw740O3jS8jPbOnIzomDtbpJ7pbHmT7W
	oYjqwps9d3Ils8=
X-Received: by 2002:a05:690c:f:b0:79a:8e00:a5bf with SMTP id 00721157ae682-7d3373a7a95mr124613927b3.1.1779763928408;
        Mon, 25 May 2026 19:52:08 -0700 (PDT)
Received: from kelso.tail8e61da.ts.net (99-10-92-174.lightspeed.rlghnc.sbcglobal.net. [99.10.92.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c33c935sm54938797b3.36.2026.05.25.19.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 19:52:07 -0700 (PDT)
From: Christopher Lusk <clusk@northecho.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v3] net: tls: use sync AEAD for sk_msg BPF sockets
Date: Mon, 25 May 2026 22:51:54 -0400
Message-ID: <20260526025154.60607-1-clusk@northecho.dev>
X-Mailer: git-send-email 2.54.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254238-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[northecho.dev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clusk@northecho.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[northecho-dev.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,northecho.dev:mid,northecho.dev:email]
X-Rspamd-Queue-Id: 51B005D025F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The kTLS TX path can hand an open record to a sk_msg verdict
program before encryption.  If the verdict applies fewer bytes
than the open record contains, tls_push_record() splits
ctx->open_rec into the record being encrypted and a remainder.
The synchronous path reattaches that remainder before continuing.

With an async AEAD provider, crypto_aead_encrypt() can return
-EINPROGRESS after ctx->open_rec has been unhooked but before the
split remainder is reattached.  The remainder is no longer
reachable through ctx->open_rec or ctx->tx_list, silently dropping
transmitted data and leaking the unreachable tls_rec.  The same
composition also entangles the user-page zerocopy lifetime rules
with an async completion path.

A sockmap cannot be attached to a socket after an inet ULP is
installed: sk_psock_init() returns -EINVAL when
inet_csk_has_ulp() is true.  So the supported ordering for
sockmap + kTLS TX is sockmap first, TLS_TX setup second.  When
TLS_TX setup sees an existing sk_psock, allocate the AEAD with
CRYPTO_ALG_ASYNC masked out and latch the TX zerocopy gate
(sw_ctx_tx->async_capable) so the buggy composition becomes
structurally unreachable.  Ordinary kTLS sockets without sk_msg
BPF attached are unaffected and continue to use async-capable
providers.

Fixes: d3b18ad31f93 ("tls: add bpf support to sk_msg handling")
Cc: stable@vger.kernel.org # 4.20+
Signed-off-by: Christopher Lusk <clusk@northecho.dev>
Assisted-by: Codex:gpt-5.5
Assisted-by: Claude:claude-opus-4-7
---

Changes since v2 [1]:
- Per netdev maintainer guidance [2], replace the Option-C
  drain-on-error fix with a setup-time surface narrowing in
  tls_set_sw_offload(): when a sockmap is already attached at
  TLS_TX setup, request a synchronous AEAD (CRYPTO_ALG_ASYNC in
  the allocation mask) and set sw_ctx_tx->async_capable = 1.
  Both moves are needed: latching async_capable alone disables
  zerocopy but tls_do_encryption() can still return -EINPROGRESS
  on the copy path; selecting a sync provider removes that return
  path for sk_msg-attached sockets.
- Drop the selftest from the series per Jakub's note that the
  existing sockmap + TLS coverage at
  tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c exercises
  this configuration [3].  That suite covers sockmap + kTLS
  policy paths broadly; the specific async-pcrypt pass-then-drop
  failure mode from the v2 reproducer was validated for v3 on
  QEMU/KVM with a KASAN+LOCKDEP-instrumented kernel against net
  base 2156a29aecff before send.
- Single-patch series.

Changes since v1:
- v1's remainder-rooting fix was incomplete; Sashiko AI review
  surfaced a real UAF in the v2 follow-up that John Fastabend
  endorsed on the v1 thread [4].  The surface-narrowing approach
  in v3 makes both failure modes unreachable by avoiding the
  async + sk_msg composition entirely rather than patching each
  continuation point.

[1] https://lore.kernel.org/all/20260521025840.976378-1-clusk@northecho.dev/
[2] https://lore.kernel.org/all/20260525133028.58494274@kernel.org/
[3] https://lore.kernel.org/all/20260525133048.2dc6d8d3@kernel.org/
[4] https://lore.kernel.org/all/huduxtn6parzgiaf5cyiyrrvjjvx6jsdedowvrd4nkwmuyeind@j6migjgofh2i/

 net/tls/tls_sw.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 964ebc268..0000000 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2867,7 +2867,20 @@ int tls_set_sw_offload(struct sock *sk, int tx,
 	rec_seq = crypto_info_rec_seq(src_crypto_info, cipher_desc);

 	if (!*aead) {
-		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, 0);
+		u32 mask = 0;
+
+		if (tx) {
+			struct sk_psock *psock;
+
+			psock = sk_psock_get(sk);
+			if (psock) {
+				mask = CRYPTO_ALG_ASYNC;
+				sw_ctx_tx->async_capable = 1;
+				sk_psock_put(sk, psock);
+			}
+		}
+
+		*aead = crypto_alloc_aead(cipher_desc->cipher_name, 0, mask);
 		if (IS_ERR(*aead)) {
 			rc = PTR_ERR(*aead);
 			*aead = NULL;
--
2.54.0

