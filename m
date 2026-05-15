Return-Path: <stable+bounces-247397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEqVChi9BmqMnQIAu9opvQ
	(envelope-from <stable+bounces-247397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:28:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BA35F549FEE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA7B7301E234
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3326C374186;
	Fri, 15 May 2026 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="LjIPuWvj"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909D327BEC
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778826397; cv=none; b=fAnnGhRWXS0B/CB01XGuwRDFNmlcvSmuGuCTIGrdK1RsiNkYoWIT8mrFGrYhEV+YD5kDfGfOWInTGjJB7qmFzfenkccJ9r/g++O1497RsfAa2I/ReC09t0W5RBD3U2IQsvknA2fCvWqxCc47RHj4V5aXOZ/XnLKY/M4xldjIBaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778826397; c=relaxed/simple;
	bh=HrWB17ptc2l34u6C2LeHIZMPkj0pJCVkd4NnaBC3fpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FT7mTpxpRpXz9qq6UDt/A70STdYP8hQY0JfUjYIgeLfhGDRnM5jWhUO0aFZ3KeS3C/Xd7Ein/5PLgwYXzZGP8zYvNj1iTvXmmFcJIcmgXpcTT0pZfsKSwKsoWuDa1s/VP9TG1oYbE6I+GAnD3Gc5RfRjNCr5fo0AK0djfmfmrSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=LjIPuWvj; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f7020a928eso12455156eec.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1778826394; x=1779431194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLhwzsZNHFhkVlDVAnP1ibUwhUPkO6DQUuy/XcbYiRg=;
        b=LjIPuWvjdz+rIdf8ASDrVPPRDdH+AZfNZdcRnekEvbbgLT0g8kvoKi0e4mu5CeSRtb
         rjw2IAQWwEFhg213If2eh1JwEYURDeLwVo86H4oM7godvvRO+/T7cEx1Jm1IX8N6vDbS
         xnruFnJ4qOufJBDNbpCi9ZqbF0/aO1bGjIClZkc1bDrE/GxN8wArrjiTZz7lOP4bgc/M
         vK3JzWrVgEHwzNC0Id/0Bt+aiUJKzGZ4mAmGMsD8zphPGxg32jVJPtYMT94veUCxyJAn
         TKS/zI3w9O2RCZwak20JPnWSsvcsAwn6OngwZJxCWymZLs7H9xoLQT+2ONZhfn8+ozuV
         +d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778826394; x=1779431194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLhwzsZNHFhkVlDVAnP1ibUwhUPkO6DQUuy/XcbYiRg=;
        b=kWcGm8gpqH4huiT0DlGaws9C3J2XwDOBIWl/ZkuXW91M9VdtzkMi7mRwJdcy5Zq0YX
         viiaWhuT3DgAVcKhXqSSXmsI4zQ3xaIcImdDUxb6+P3OK9t0Vsd8qULJB0qMYNg3nBL+
         3QA4mRMcFNXk0pCcLgPJRjhPeIFOlq96W7rl2x1o3l9K8zE/n32oz06Sqszfm1PX4CsG
         I/FixtOsNO3f4CkGBnYOZcleuZ6TUBi4hAwztknKWwqauzW8JnPjyRykcr8IPGKQNIiY
         9bmc+5dmWv0U+MapDzqDQ2SPxM607+D4VPVTKR+lP8YrrjU4QkM0Vglcyy6e+uJi9xrI
         eZTg==
X-Forwarded-Encrypted: i=1; AFNElJ9owXXPXV56ynwGkfXv1YDWsi25KL0sYfwzXvfDWN/DBu0UYCrXHtUR7ZKyFnSYPOCys6FggoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzroXR4cd8os32Ks51jkWOwmTPiFf080gRUoJVUOGmOzksJe2Ju
	zB0iQK16LAMVTQOFs2JrbfVeeKDzsGJZs+x7U/JNjQJcoKVsRidb1bSaETW8hbkhAPSx
X-Gm-Gg: Acq92OEAlZrfrXIuoxj1qXuv86gOJuK+0y0ueZEYvivL3jC+HjgZcX5SPiBFJQbslNm
	/USWHDTg20gJsuKsYro78xEd2anAt1dB9R7S+Mdx9USsQUw+PcClb6tv5yYeNVOyZ299/1gnJJr
	5mu4DuV4esAe2F2S2BkNgaLp9F8+EImOXhpzzTLP2y+79OOaEfwzbfipjG/sS17eJv83i847mSk
	VxXd7QxhaBEztLssMNwmx/i5rbOKfbwL2qbWbxctM+tH1Jz979cCLM/jiHNu04S+gfIODJEe0mu
	99lBSjzjWlBP+pvGzyq294lhXZCr+vZ6kP+1tn4q6PantV+lcxc61oABEEYesM3XoD/afcSWYGh
	0uFJHt3j7xnhaHaZ9L/hR6dKygsHZlfH8VCWNz8ChmmWShFOVsGT6Cj5gX1gJsPG3026OyfnGd4
	X4vQnwKiomkuUXKuYo4zz8eh7nL78sxPdeL2Ti
X-Received: by 2002:a05:7300:fb83:b0:2de:cc07:e8b with SMTP id 5a478bee46e88-3039818afa7mr1296743eec.1.1778826394381;
        Thu, 14 May 2026 23:26:34 -0700 (PDT)
Received: from sultan-box ([142.147.89.218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcc464sm6242366eec.14.2026.05.14.23.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 23:26:33 -0700 (PDT)
Date: Thu, 14 May 2026 23:26:28 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org, sd@queasysnail.net,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <aga8lH0sgneYCCgY@sultan-box>
References: <aga1VyHpHaUhnGZa@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="kZH1xBYXsb9CWdLM"
Content-Disposition: inline
In-Reply-To: <aga1VyHpHaUhnGZa@v4bel>
X-Rspamd-Queue-Id: BA35F549FEE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kerneltoast.com,reject];
	R_DKIM_ALLOW(-0.20)[kerneltoast.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247397-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,decadent.org.uk,gondor.apana.org.au,queasysnail.net,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kerneltoast.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sultan@kerneltoast.com,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kerneltoast.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


--kZH1xBYXsb9CWdLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2026 at 02:55:35PM +0900, Hyunwoo Kim wrote:
> Changes in v4:
> - Include the tcp_clone_payload() propagation suggested by Sabrina.
> - Drop the skb_try_coalesce() change; addressed by commit f84eca581739.
> - v3: https://lore.kernel.org/all/agW4vC0r8QOUKtRT@v4bel/
> 
> Changes in v3:
> - Include the skb_gro_receive() audit patch suggested by Sultan
> - v2: https://lore.kernel.org/all/agToIEDI4TaTNLRb@v4bel/
> 
> Changes in v2:
> - Also propagate SHARED_FRAG in skb_try_coalesce() and skb_shift()
> - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/

Hi Hyunwoo,

Per your ask to me to use AI for exploring relevant paths [1], I've attached my
findings from a pretty thorough day of hunting for these with Claude.

None of the findings appear to be currently exploitable.

Please let me know if you have any questions, and I hope you find this helpful.

[1] https://lore.kernel.org/all/agWUdie1xBvBu22I@v4bel/

Thanks,
Sultan

--kZH1xBYXsb9CWdLM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=shared-frag-audit.txt

Line numbers below are against netdev commit 5db89c99566fc ("net: ifb: report
ethtool stats over num_tx_queues").

We audited the netdev tree for remaining sites where frag descriptors are
transferred between skbs without propagating SKBFL_SHARED_FRAG.  Hyunwoo Kim's
v4 fix covers __pskb_copy_fclone, skb_shift, skb_gro_receive,
skb_gro_receive_list, and tcp_clone_payload; the standalone f84eca5817390
covers skb_try_coalesce.  Several other sites in newer code have the same class
of bug.

None of these are currently reachable for page-cache corruption, since each one
is blocked by independent guards (cloned skbs, TX-only paths, or data copying).
They should still be fixed for defense-in-depth: skb_copy_header() doesn't
propagate shinfo->flags, so every frag-transfer helper that allocates new
shinfo needs its own propagation line.  This guarantees the bug class will
recur whenever someone writes a new helper without realizing it.

--- Findings ---

1. unix_stream_sendmsg() -- net/unix/af_unix.c:2461

   Calls skb_splice_from_iter() with MSG_SPLICE_PAGES but never sets
   SKBFL_SHARED_FRAG.  It's the only skb_splice_from_iter() caller that
   doesn't do so; compare with tcp_sendmsg_locked() at tcp.c:1371,
   ip_append_data() at ip_output.c:1237, and ip6_append_data() at
   ip6_output.c:1801.

   Not reachable since AF_UNIX skbs don't enter the network stack.  When
   forwarded via splice (unix -> pipe -> tcp), the destination protocol's
   sendmsg sets the flag independently.

   Fix: add the same flag-set after skb_splice_from_iter(), matching the TCP
   pattern.

2. iptfs_consume_frags() -- net/xfrm/xfrm_iptfs.c:2152

   memcpy() of the frag array plus iptfs_skb_head_to_frag() conversion.  Zero
   references to SKBFL_SHARED_FRAG in the entire 2700-line file.

   Not reachable due to three independent guards: the fragmentation path copies
   data into linear via skb_copy_seq_read() + skb_put() (no page-cache frag
   references in the result), the share_ok guard blocks aggregation for TCP
   skbs (since tcp_stream_alloc_skb() uses alloc_skb_fclone() which doesn't
   set head_frag), and simple aggregation fails because the base skb is a TCP
   clone.

3. iptfs_skb_add_frags() -- net/xfrm/xfrm_iptfs.c:458

   *tofrag = *frag + __skb_frag_ref() without flag propagation.  The frag walk
   struct doesn't carry source flags.

   RX path frags come from NIC RX buffers (not page cache).  TX path has the
   same guards as iptfs_consume_frags().

4. tcp_clone_payload() -- net/ipv4/tcp_output.c:2607
   **Now fixed in v4** (suggested by Sabrina Dubroca).

   skb_frag_page_copy() / skb_frag_off_copy() / skb_frag_size_set() +
   skb_frag_ref() from write-queue skbs to a new MTU probe skb.  No flag
   propagation.

   TX-only (called by tcp_mtu_probe()).  The probe skb goes to
   tcp_transmit_skb() which clones it before sending.  Can't reach ESP input.

5. skb_zerocopy() -- net/core/skbuff.c:3843

   Frag descriptor assignment + skb_frag_ref().  Calls skb_zerocopy_clone()
   which handles the zerocopy uarg but not SKBFL_SHARED_FRAG.

   All callers (nfnetlink_queue, openvswitch) send the copy to userspace via
   netlink.  The original skb continues through the stack with its flags
   intact.

6. chcr_ktls_copy_record_in_skb() -- drivers/.../chcr_ktls.c:1654

   Frag descriptor assignment from TLS record + __skb_frag_ref().  No flag
   propagation.

   TX-only, hardware-specific (Chelsio T6 kTLS offload).

7. esp_output_head() -- net/ipv4/esp4.c:426

   The output-side skip_cow checks !skb_cloned() but never checks
   !skb_has_shared_frag().  Compare with esp_input() at line 877 which does
   check it (CVE-2026-43284).  The first skip_cow path (tailen <=
   skb_tailroom) keeps inplace=true, so AEAD encrypt would write ciphertext
   over source SG entries including frag pages.

   Not reachable in practice: kretprobe tracing on a booted 7.1.0-rc3 kernel
   confirmed esp_output_head() always returns nfrags >= 2 (the inplace=false
   second branch), never nfrags=1.  For paged skbs from splice, the tailroom
   is insufficient for the ESP trailer.  The inplace=false path allocates
   separate output pages, so frag data is only read as source, never written.

   esp_output_head() should still add the !skb_has_shared_frag() check to
   match esp_input(), since a future change to skb allocation sizing could
   make the first skip_cow path reachable.

--- Root cause ---

skb_copy_header() copies gso_size / gso_segs / gso_type from old shinfo to
new, but it never copies shinfo->flags.  As a result, every frag-transfer
helper that allocates new shinfo needs its own explicit flag propagation.  This
is easy to miss when writing new helpers, which is how we ended up with seven
independent instances of the same bug.

A potential long-term fix would be to propagate SKBFL_SHARED_FRAG (and
SKBFL_PURE_ZEROCOPY) inside skb_copy_header() itself, matching how skb_split()
already handles both flags.  This would eliminate the bug class at the source
rather than playing whack-a-mole with each new helper.

--kZH1xBYXsb9CWdLM--

