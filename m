Return-Path: <stable+bounces-226373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOKVNBqHuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:53:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D4B2AE9AA
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA4AE30379CD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73293F54B8;
	Tue, 17 Mar 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fc6cG+/s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F03F23B3;
	Tue, 17 Mar 2026 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766411; cv=none; b=nqy1Y8xN5HCO1q+rXcfwO8WrZxW8YBJeUmzYu+WScm/LPk5i3BNwrJY5iS9KhZ5RR1gcYl+6cMK89xapm2ZELIv5j02i1ELorwssm8W/BFdEDAXC5VvXsVwW4NrjzNriQrncJTBxVM0h5/28AcNgSZmHVC2DfIQAxarKVTKnrkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766411; c=relaxed/simple;
	bh=cp7rlxu14zzRgVF3xHKERiOzjiIpUfm4QrOaS7SL8HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g56y5IBvt6k1G5QV4B2Zt6RnoyjEoTpyUFTprG4y73bvN8H4TkuD3I86WIM/yvYs7pAXVy5jiUmcr7Bn5TJWDt0GaP9/SgA2lXGHmw3CCe/64cnURQtpgfKAf1aMg/aVVKU6LBkFLfz8XZhiJCqxJKPYjO0PNJZxv8IzQKVAdpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fc6cG+/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80576C19424;
	Tue, 17 Mar 2026 16:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766411;
	bh=cp7rlxu14zzRgVF3xHKERiOzjiIpUfm4QrOaS7SL8HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fc6cG+/sEGuy2hwlU7sX0JWgAfCbvymWmDU3p+GURpdztn6tyOSEiA7SznQmS15mx
	 PPAwd9nGaIFJwBnOBKn1n/ubOAgmvaO3K3nZI3ijZKxmXOaqcbUjXvimY2gzq3QIO9
	 x5ATN3zpPaqZW+4RpBoH9qBGK+32t3TuAUdbkulk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Olsa <jolsa@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH 6.19 233/378] bpf: Fix kprobe_multi cookies access in show_fdinfo callback
Date: Tue, 17 Mar 2026 17:33:10 +0100
Message-ID: <20260317163015.584287547@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226373-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: A7D4B2AE9AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

commit ad6fface76da42721c15e8fb281570aaa44a2c01 upstream.

We don't check if cookies are available on the kprobe_multi link
before accessing them in show_fdinfo callback, we should.

Cc: stable@vger.kernel.org
Fixes: da7e9c0a7fbc ("bpf: Add show_fdinfo for kprobe_multi")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20260225111249.186230-1-jolsa@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/bpf_trace.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2441,8 +2441,10 @@ static void bpf_kprobe_multi_show_fdinfo
 					 struct seq_file *seq)
 {
 	struct bpf_kprobe_multi_link *kmulti_link;
+	bool has_cookies;
 
 	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	has_cookies = !!kmulti_link->cookies;
 
 	seq_printf(seq,
 		   "kprobe_cnt:\t%u\n"
@@ -2454,7 +2456,7 @@ static void bpf_kprobe_multi_show_fdinfo
 	for (int i = 0; i < kmulti_link->cnt; i++) {
 		seq_printf(seq,
 			   "%llu\t %pS\n",
-			   kmulti_link->cookies[i],
+			   has_cookies ? kmulti_link->cookies[i] : 0,
 			   (void *)kmulti_link->addrs[i]);
 	}
 }



