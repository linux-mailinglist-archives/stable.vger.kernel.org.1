Return-Path: <stable+bounces-228923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAYSNqZqwWnVSwQAu9opvQ
	(envelope-from <stable+bounces-228923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:30:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C5C2F831A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 188E4332A7BF
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BBB3AF66A;
	Mon, 23 Mar 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iRMxsI+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C903AF663;
	Mon, 23 Mar 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277498; cv=none; b=oOreWVwXpY+bQ1zjpT9bwxbNXU61pxD/VpVPOUgYo+Df4A4NvikS3DTYm5H9f1ReznowYomH7sWKgrdd8a4MKpG/d7Lz8ZXdLXg0RHvHgpsGqJkMbHvfEWOkrrYWXo7moU86LMrSV9cTCtPwULDoGv5I55SyjnvULhSQgsm83sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277498; c=relaxed/simple;
	bh=WKAM2A+qOnkiIxFWqFwajFcz0+r6K8okjuCcDnnkirY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV2mJplcz6mTEzt1jksj+ES759XOoQOYfNMESKGtxjxWhy26rv2iO6++lKKF+RkYKOehaeL5bHS+BR1hGYnz/L7BoVjFOnybF3tVidMFilVstXwEGI4RnwkBE7jTJquCkkkszZcJsFDG+BzPVIUUfYHudN6WN58ysdZ8xzeZ/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iRMxsI+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1474CC4CEF7;
	Mon, 23 Mar 2026 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277498;
	bh=WKAM2A+qOnkiIxFWqFwajFcz0+r6K8okjuCcDnnkirY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRMxsI+SKNp9pLQW7rZoM/ssbRlkwF2D2uBzfFtGZZVyWGusK5Y1n25qWF8ODiwK1
	 ybc+BivoD0HqinRzkO6njXOViTfC+46fXompmCAKgcw2bDm/e5S7WOvjejOZJxobzy
	 glZ+CPmqAALiUfFI7HQMu7sVxtEf54sjJbKnoMew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 430/460] nfnetlink_osf: validate individual option lengths in fingerprints
Date: Mon, 23 Mar 2026 14:47:06 +0100
Message-ID: <20260323134537.119730262@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,strlen.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-228923-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,asu.edu:email]
X-Rspamd-Queue-Id: 44C5C2F831A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit dbdfaae9609629a9569362e3b8f33d0a20fd783c ]

nfnl_osf_add_callback() validates opt_num bounds and string
NUL-termination but does not check individual option length fields.
A zero-length option causes nf_osf_match_one() to enter the option
matching loop even when foptsize sums to zero, which matches packets
with no TCP options where ctx->optp is NULL:

 Oops: general protection fault
 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:nf_osf_match_one (net/netfilter/nfnetlink_osf.c:98)
 Call Trace:
  nf_osf_match (net/netfilter/nfnetlink_osf.c:227)
  xt_osf_match_packet (net/netfilter/xt_osf.c:32)
  ipt_do_table (net/ipv4/netfilter/ip_tables.c:293)
  nf_hook_slow (net/netfilter/core.c:623)
  ip_local_deliver (net/ipv4/ip_input.c:262)
  ip_rcv (net/ipv4/ip_input.c:573)

Additionally, an MSS option (kind=2) with length < 4 causes
out-of-bounds reads when nf_osf_match_one() unconditionally accesses
optp[2] and optp[3] for MSS value extraction.  While RFC 9293
section 3.2 specifies that the MSS option is always exactly 4
bytes (Kind=2, Length=4), the check uses "< 4" rather than
"!= 4" because lengths greater than 4 do not cause memory
safety issues -- the buffer is guaranteed to be at least
foptsize bytes by the ctx->optsize == foptsize check.

Reject fingerprints where any option has zero length, or where an MSS
option has length less than 4, at add time rather than trusting these
values in the packet matching hot path.

Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_osf.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index c0fc431991e88..9fc9544d4bc53 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -302,7 +302,9 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
 {
 	struct nf_osf_user_finger *f;
 	struct nf_osf_finger *kf = NULL, *sf;
+	unsigned int tot_opt_len = 0;
 	int err = 0;
+	int i;
 
 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -318,6 +320,17 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
 	if (f->opt_num > ARRAY_SIZE(f->opt))
 		return -EINVAL;
 
+	for (i = 0; i < f->opt_num; i++) {
+		if (!f->opt[i].length || f->opt[i].length > MAX_IPOPTLEN)
+			return -EINVAL;
+		if (f->opt[i].kind == OSFOPT_MSS && f->opt[i].length < 4)
+			return -EINVAL;
+
+		tot_opt_len += f->opt[i].length;
+		if (tot_opt_len > MAX_IPOPTLEN)
+			return -EINVAL;
+	}
+
 	if (!memchr(f->genre, 0, MAXGENRELEN) ||
 	    !memchr(f->subtype, 0, MAXGENRELEN) ||
 	    !memchr(f->version, 0, MAXGENRELEN))
-- 
2.51.0




