Return-Path: <stable+bounces-211515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +u2pKKwNd2nSbQEAu9opvQ
	(envelope-from <stable+bounces-211515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 07:46:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E0849DE
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 07:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C59E03001308
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 06:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531A52848BE;
	Mon, 26 Jan 2026 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="C7C0DXDH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE7021ABC9
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769409961; cv=none; b=ce7Q9nEl9mCWFbN3u20qkD7OaiKlSW6/s1iV35UA78NbyzEU5xtVCPwwmB0KAN1rHs0E+0IE4q6f4mBg+y83Pt8VEJZkULYomUgZKpjxsing7qr3Foj0Is/LJYdxkMoT8EsBClKrNrb+bOyt39W+cZ7gR0g+HDNX4iST00ASIGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769409961; c=relaxed/simple;
	bh=JB/axX11zdQ+sxdWsG/pqjEhrEKk8oyrUvLdkh1+Qkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D4chJz2rdLtuZjdnpeyZ5gVwXq46PGozoLWhYfa5aE3fR8DELK3bg3eo8ZgZV5SosFpkMFrUD7+7zTJ6cgP68b45bnsOFSiII2eDXxUvnZVGTfgp2BFs8mCrbKnw4FJwkzqOaaZZ38oF8tY7xLsW7E+bzWbqUIcIzHQYASA6QSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=C7C0DXDH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4801bbbdb4aso34416035e9.1
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 22:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769409957; x=1770014757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mpMpYkua0RQ6ZXsZQylHzyFg1nGJQ4rz1XBQLuEa4tU=;
        b=C7C0DXDHm2e8NDUifMbej+/UicCP7h2myNMX2BOvBIYfp6KXkyuTCSszUEi2ClWq5X
         dwT6Gc17VtNYHlVA4WEiG5ZDcfUIHu670gwH6l5oLgmQYycObPHKEz+R/msSB1Qp9N34
         +Bov0XJu3AR7MQZ6xs2XtP4hj7V6b/FmBJaHqKPbnji/8msjpdRsi9UJ0rzTfCrbMm8H
         gslpY8hmXmxRcyEW42iTksLn/1S/6WCC8+ntgSa7LX9ofc/8N8D/KKbX8hxn92OWUWVF
         IkeFjzlDuB9z3QWFiNNftdB98jAHqGuf/juv2t/3hkYKRzRa7PZNDaWY4pM34k1E9VFq
         JyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769409957; x=1770014757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpMpYkua0RQ6ZXsZQylHzyFg1nGJQ4rz1XBQLuEa4tU=;
        b=ESFq9wa81co29wHQebWjf+NTYXfeanXZmwvR+DVo7mtzX0LhnfSA6lCbfq70426ocb
         JODiwWVjgTi9D9RVapLEvGUpnCnWJfR4hG/EoIwQT+Jqki0X8d6IQeAeVXQPi6F5P7E/
         Vf1sOyEvR8D/ckfYciN+AARquz3iIQAdymVqRRFH6D6Z88ih6goUYNsOd1ml9FRsM6rA
         rCDy1uF+vkTnktHh8oSQ3wFAT14WeIYB0jp3YC5EwnquSub1kyx1Bq6arHQuDi+4BvJN
         JJ/i5RKq4TUM+sSWfe2u+P1uuH88AXOy9lal0YFnxyU5TYVxY9s9IONtBIYUcw5T3FZ9
         P0VQ==
X-Gm-Message-State: AOJu0YwN8dtGi/XfBlhAXVi1GE0D93AfyM1slfx3FmBaQ4xbLBQxnYEX
	SljsginMlskkUcAMccf7jBqYkoYB75GpT6PdCk06GhKBA6EWmq7XeCSGONuMUNpF1f7tfEyJP6c
	RAQ/p
X-Gm-Gg: AZuq6aLHIdYGhWE40uQy9/1nOaYp55yiYkN1l9HIm0oMYCQZV/n1uayAt/oWIjK+TvB
	kdLYy/W2Xp3/OROIdEJ9WfooJIxFw8jTPkios88YBnSiCDFkDdiS4pBb0DQUEI20KiQORU2F0ZM
	f2oXi4Dyc7JR/5/+sQrzBkoC5aIxfbXt5H3hJcSzQKug5HWbxgniqZFQaB4QOMUHX/nvIT20Eaf
	lRELXUNA/QqrwcFF9284Z31HA+J/rTTmEdyqRrpkWQm/CUSk9ML39mZwfEqgGfLDa1YyQXhZxL5
	ybzoU/1mZGe8sEs5JktBsqF64SN59JrlaEZ7EeoIRRqGISqyYpfrhhtKSUjz+Fn3hSHMCVNUQ9L
	0+9BRLe+TD93166O7h1MlkKGqZLFspdkH/5NK6HcRwqFbLCOuBRmBVoDtoPzo2QDE4UGXd4TSq1
	jtSPfzv1zTa5fUC8NCbpXASVwfcLTKK8w5XBz9xNBb
X-Received: by 2002:a05:600c:c097:b0:47f:1332:e5f with SMTP id 5b1f17b1804b1-4805ce4352emr46395665e9.12.1769409956845;
        Sun, 25 Jan 2026 22:45:56 -0800 (PST)
Received: from localhost (27-240-121-17.adsl.fetnet.net. [27.240.121.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-480470c1dc6sm303071755e9.10.2026.01.25.22.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 22:45:56 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Yinhao Hu <dddddd@hust.edu.cn>,
	Kaiyan Mei <M202472210@hust.edu.cn>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.12 6.6 6.1 1/1] bpf: Do not let BPF test infra emit invalid GSO types to stack
Date: Mon, 26 Jan 2026 14:45:48 +0800
Message-ID: <20260126064550.16952-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211515-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.com:email,suse.com:dkim,suse.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Queue-Id: 237E0849DE
X-Rspamd-Action: no action

From: Daniel Borkmann <daniel@iogearbox.net>

commit 04a899573fb87273a656f178b5f920c505f68875 upstream.

Yinhao et al. reported that their fuzzer tool was able to trigger a
skb_warn_bad_offload() from netif_skb_features() -> gso_features_check().
When a BPF program - triggered via BPF test infra - pushes the packet
to the loopback device via bpf_clone_redirect() then mentioned offload
warning can be seen. GSO-related features are then rightfully disabled.

We get into this situation due to convert___skb_to_skb() setting
gso_segs and gso_size but not gso_type. Technically, it makes sense
that this warning triggers since the GSO properties are malformed due
to the gso_type. Potentially, the gso_type could be marked non-trustworthy
through setting it at least to SKB_GSO_DODGY without any other specific
assumptions, but that also feels wrong given we should not go further
into the GSO engine in the first place.

The checks were added in 121d57af308d ("gso: validate gso_type in GSO
handlers") because there were malicious (syzbot) senders that combine
a protocol with a non-matching gso_type. If we would want to drop such
packets, gso_features_check() currently only returns feature flags via
netif_skb_features(), so one location for potentially dropping such skbs
could be validate_xmit_unreadable_skb(), but then otoh it would be
an additional check in the fast-path for a very corner case. Given
bpf_clone_redirect() is the only place where BPF test infra could emit
such packets, lets reject them right there.

Fixes: 850a88cc4096 ("bpf: Expose __sk_buff wire_len/gso_segs to BPF_PROG_TEST_RUN")
Fixes: cf62089b0edd ("bpf: Add gso_size to __sk_buff")
Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Link: https://patch.msgid.link/20251020075441.127980-1-daniel@iogearbox.net
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
Could possibly be backported further back to 5.15 and 5.10, but I doubt
anyone actively test them with Syzkaller.
---
 net/bpf/test_run.c | 5 +++++
 net/core/filter.c  | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index ab8d21372b7d..9cbdfb9fd674 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1047,6 +1047,11 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 
 	if (__skb->gso_segs > GSO_MAX_SEGS)
 		return -EINVAL;
+
+	/* Currently GSO type is zero/unset. If this gets extended with
+	 * a small list of accepted GSO types in future, the filter for
+	 * an unset GSO type in bpf_clone_redirect() can be lifted.
+	 */
 	skb_shinfo(skb)->gso_segs = __skb->gso_segs;
 	skb_shinfo(skb)->gso_size = __skb->gso_size;
 	skb_shinfo(skb)->hwtstamps.hwtstamp = __skb->hwtstamp;
diff --git a/net/core/filter.c b/net/core/filter.c
index dff4a008aba8..305c38636b32 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2444,6 +2444,13 @@ BPF_CALL_3(bpf_clone_redirect, struct sk_buff *, skb, u32, ifindex, u64, flags)
 	if (unlikely(flags & (~(BPF_F_INGRESS) | BPF_F_REDIRECT_INTERNAL)))
 		return -EINVAL;
 
+	/* BPF test infra's convert___skb_to_skb() can create type-less
+	 * GSO packets. gso_features_check() will detect this as a bad
+	 * offload. However, lets not leak them out in the first place.
+	 */
+	if (unlikely(skb_is_gso(skb) && !skb_shinfo(skb)->gso_type))
+		return -EBADMSG;
+
 	dev = dev_get_by_index_rcu(dev_net(skb->dev), ifindex);
 	if (unlikely(!dev))
 		return -EINVAL;
-- 
2.52.0


