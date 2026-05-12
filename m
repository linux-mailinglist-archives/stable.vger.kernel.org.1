Return-Path: <stable+bounces-246674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GbkEPCSA2pz7gEAu9opvQ
	(envelope-from <stable+bounces-246674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:52:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F852997E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 723563054A14
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEA13C345A;
	Tue, 12 May 2026 20:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKDuELNx"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FF43C7E15
	for <stable@vger.kernel.org>; Tue, 12 May 2026 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619087; cv=none; b=Y1ruNDWCuRsTRNLYLz2yrNR/rK/AqtNbYag/auwET9Q1hxCYjMixJHtcXuCLLR6F/Cw6PQrrqwcAJJqYSeCoVeUF/Tv2a70UMq07bOZGwBoV105QpCF4dWjT6fmjQni1GeFJ349gD57N4QnLtl0uDMIattrPz/eACyRq+EVAgxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619087; c=relaxed/simple;
	bh=J5gmNSPNQxxcqs8XDR9P+NOgy6ibnVJAuMTAtqZpUZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovQAGLI3wgbEMHCvJ/OK7EUbuDwD+uorchM7QDBTvQtFmEEMZ2HG8SiKT6/PkIcLsFIEUckYUNb8MiO2RCupqXFnoK828MmDM7rt9ZIYti151J1m2yZvEeczlEw+t8BnIfbbb7BOqdNgkcsytRX/LVmgd3kw5L2UgoZtCJkk/WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKDuELNx; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-90d2acb9936so119630485a.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 13:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778619082; x=1779223882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpARctubxx8lA4XtZtvDCBF0ktNsLEKbeHjau0kupPc=;
        b=YKDuELNxPRrDXZRddMTCvxBXg7tuOMXxHNohdJP86e9wVCAjhJQf0FWbA8tMPE3TEk
         lRKj2tBaUEN1lrjuK/HrsJpEHPlT1YZqUJWK0puHJjVn+g5/GnI/oa3YI6/Al2df2f1E
         r0bJ17t477l3849Whf3YPA8IrqxYJspTaGMQb7MQdIKZzrpoKOArn25n5m3k8PYXX2cH
         TzKA58WKiCi9QSfjOBAjypwkiKq8tZK/+NXaggA94FUI+2Q1XYAfRksslU0WhItrrQqr
         +hYrX93WSpcUo1MOOaLU1iyk43fL2Nn8GZSBJEyWbFPNoqiveHZJH/KlL6lWwkllAUgq
         rFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778619082; x=1779223882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RpARctubxx8lA4XtZtvDCBF0ktNsLEKbeHjau0kupPc=;
        b=A/eqO27LBZl4ZRJns31d831W9RSsVGxOg0p2jc9TvesgRwlHKXUqwlKpRo1cbvGF4D
         cB8spTdQKpsuLeQWKt1gSUtKVImIMjGBuPj8B8PjSbVxa/zzl+8ez+wuoYCGqT5nnDNt
         ZawhYOblK9gIII5SH927Mnpp6wO00x0HGx4/uF/qOeW+vnBixkTCq5tjk/itUg5jhOZ0
         iG1VbwRnI5bCMDF2pSH2ZOTB7z9uwaWsVrH787604aJvGZJNAK8cBp3OpysmHn0AvLbT
         gnNEs25z5o5noiMRWvss0y+F+Dk1VJnzqf/QItdgtoQrP5g4bQDCfSbyujnM/pUKocSU
         +NEw==
X-Forwarded-Encrypted: i=1; AFNElJ9mOmVnEc2uZkD6Nsjq4pg285ZL+fEXXLtVaXEl3WrG5CQ5doVkSd3GjIeUwTlahVYJDEo1w0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxItriB/n9SfnREB3eM+90zgzzcJu2BKEdmI7ULGykDfI38vqZs
	z1XzhQKqGko76W3lefWy4vReslZo/e4N+aJV5zC8dNJpxE/j6jtzQJJ8
X-Gm-Gg: Acq92OGuaYGzEsyOczCJD03P8IpdviInqKt4lft+0B1Q+0IOM7aWwFiGDBmnbcE3tYA
	bJuDGmgQ2Fo6oxOgApytOhnL7rPvbfAqH5a+4OAy2KEqLk9UoJWTLAsORjZEbTH/4e0kF2biNZQ
	JewsDV2kV+VLqXaXKoW0pCb1u7+g+AcJQiMvoJgWST3++1Op2I6knLpEvg6wEsQPZXAz5Zxbljo
	TK7C4W2JFw2k/DL/zPzY5K8pk7goi7XG0Ptcnx5O6lGANHXyhITGjSEA+QT8Z1vqSRviOVliQBh
	gPZmEgCma+YwsdA6I0aJjm+BiUn8ggEQ+ifNlODX8EeLEpy1LDl4rDtJAjGRWw1s6ykJMGKGHjF
	Ohhs9B5j3S/vSEQRSnN/cLurN/yVgU0oRuExS3nQdNX4QSaqBelTHT2W7GlJeaB58O/KHLgWHv0
	464stbfVTWybme0Fvt5ZedmjAZVE+8vd78ROuOE+EumVovM5i/OTTfCa9lbXPDuFd9gstXDyqMd
	7pN/PW1XL5un11wwm5o7ljo6yiV7AQo8ymSPPw8LKw=
X-Received: by 2002:a05:620a:7003:b0:8eb:10d4:a46c with SMTP id af79cd13be357-90facf9e383mr9443985a.35.1778619082195;
        Tue, 12 May 2026 13:51:22 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9eed0sm1490734285a.19.2026.05.12.13.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 13:51:21 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Maciej Zenczykowski <maze@google.com>,
	Kees Cook <kees@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] ipv4: ah: harden ah_output options-copy guard against ihl < 5
Date: Tue, 12 May 2026 16:51:15 -0400
Message-ID: <423b9ce3b45782c09a2fd9c65ad6674a9abb7c72.1778614451.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778614451.git.michael.bommarito@gmail.com>
References: <cover.1778614451.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AE6F852997E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246674-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ah_output() and ah_output_done() copy the IPv4 options area with

    if (top_iph->ihl != 5) {
        memcpy(dst, src, top_iph->ihl * 4 - sizeof(struct iphdr));
    }

The "!= 5" guard correctly excludes the no-options case (ihl == 5)
and allows ihl > 5 where options are present.  It does NOT exclude
ihl < 5.  For ihl in [0, 4], top_iph->ihl * 4 is less than
sizeof(struct iphdr) (20); the subtraction is computed as int,
becomes negative, and is then implicitly converted to size_t at
the memcpy() call.  The resulting length is close to SIZE_MAX and
memcpy walks off the slab allocation backing the skb's network
header.

With the preceding patch ("ipv4: raw: reject IP_HDRINCL packets
with ihl < 5") in place, an ihl < 5 packet from a raw IP_HDRINCL
socket is rejected before it reaches the local-output path.
However, post-LOCAL_OUT hook mangling (nftables payload-set,
NFQUEUE reinject) can still rewrite the IPv4 header after the
raw_send_hdrinc validation has run and deliver an ihl < 5 packet
to ah_output().  Reachability of this path requires CAP_NET_ADMIN
in the relevant netns; it is a smaller class than the original
CAP_NET_RAW path but it is not zero.

Independently of the post-LOCAL_OUT mangling question, the AH
consumer should not contain a memcpy whose size is derived from
an attacker-influenced field without a floor.  Change the guard
to "top_iph->ihl > 5" at all three sites:

  - ah_output_done() (the .complete callback path)
  - ah_output()      (the synchronous options-copy site)
  - ah_output()      (the post-hash restore site)

Behavior for valid packets (ihl in {5, 6, ..., 15}) is unchanged.
For malformed packets with ihl < 5, the options copy is cleanly
skipped; the malformed field no longer becomes a huge memcpy
length.  This is the defense-in-depth half of the series; the
upstream sanity check in the preceding patch is the primary fix.

A mirror-pattern audit found no analogous bug in ah_input(),
ip_clear_mutable_options(), or net/ipv6/ah6.c (IPv6 has a
fixed-length header and no IP_HDRINCL equivalent for crafting an
ihl < 5 ipv6hdr).

Reproduced on UML + KASAN: kernel-mode fault at addr 0x0 with
memcpy_orig at the crash site on a pre-fix kernel.  The AH guard
was verified by forcing the same packets through xfrm: the xfrm
state counter incremented and no KASAN splat or panic occurred.
With the preceding patch in this series, the original raw
IP_HDRINCL path is rejected before AH.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ipv4/ah4.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 4366cbac3f06..8fa31bdf9792 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -137,7 +137,7 @@ static void ah_output_done(void *data, int err)
 	top_iph->tos = iph->tos;
 	top_iph->ttl = iph->ttl;
 	top_iph->frag_off = iph->frag_off;
-	if (top_iph->ihl != 5) {
+	if (top_iph->ihl > 5) {
 		top_iph->daddr = iph->daddr;
 		memcpy(top_iph+1, iph+1, top_iph->ihl*4 - sizeof(struct iphdr));
 	}
@@ -197,7 +197,7 @@ static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
 	iph->ttl = top_iph->ttl;
 	iph->frag_off = top_iph->frag_off;
 
-	if (top_iph->ihl != 5) {
+	if (top_iph->ihl > 5) {
 		iph->daddr = top_iph->daddr;
 		memcpy(iph+1, top_iph+1, top_iph->ihl*4 - sizeof(struct iphdr));
 		err = ip_clear_mutable_options(top_iph, &top_iph->daddr);
@@ -253,7 +253,7 @@ static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
 	top_iph->tos = iph->tos;
 	top_iph->ttl = iph->ttl;
 	top_iph->frag_off = iph->frag_off;
-	if (top_iph->ihl != 5) {
+	if (top_iph->ihl > 5) {
 		top_iph->daddr = iph->daddr;
 		memcpy(top_iph+1, iph+1, top_iph->ihl*4 - sizeof(struct iphdr));
 	}
-- 
2.53.0


