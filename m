Return-Path: <stable+bounces-247398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI5LJxe/BmqMnQIAu9opvQ
	(envelope-from <stable+bounces-247398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:37:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD2354A0AE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56293302207C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDCA381AE6;
	Fri, 15 May 2026 06:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5h7kY8s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B250374186
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827027; cv=none; b=sIFdcaxZrEF7JbnCRrk+RPbKnHlnBF8mN5hlzQlyV8pxsEe4CxnheupewxfQ1UZ6SkBjIFE6MsoX+c/FM+zUZxvxtAxXcYO5akeF7yW3ntOjP9gpgCcXvzFr5Sv23wJF/1tqmlRPmD6M6AM1WDbDbE8bqne0bpYgFWdCEQ6EeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827027; c=relaxed/simple;
	bh=tvtvFPGKkpQTwAD8lmfKAc+gAy+SL7wFxJR7w3kBenw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkzS+iIcrVob2lQ3L65tZsABRahvW5056sCY6SnCm7Cgs3GPfS6CJXI3jPYcM0R0pvRzODVeL3AOyMebZT9lywB8kE4gEHWbq4PNPGZlFJLsyBb2paDNDvxcwxSIchnenuz0yedA6TpmuhUD9cDTXNsVirPahyHXzAwIF94fYoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5h7kY8s; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-83d5bbef760so3577673b3a.1
        for <stable@vger.kernel.org>; Thu, 14 May 2026 23:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778827025; x=1779431825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V06xJjffWErV/nU/vA2XdMoltp0T4JkWcKHj/WNq9eM=;
        b=i5h7kY8sP6cqIn0bTXjze2swHpV6H7AhDAJYkol0Q4XaybrnT94ju6NwaQrlQYXJo4
         Y36w2dJAXmyVeCpwmjp0olIjDFfI7U2HLOwG6BnfwikD1j7BsdJB3XkU1sVSWCSULNiB
         j2foKKjAqSvT6ShSy+67J4KKFSS7OMEF9EP1qYbJDM5bQQ9m49R9XjeqEQWrdl+mG9eH
         swMg16ChOX5Cf+cL+kck1aKtvkcRhj2Hn2qm90PZi5zjgchBZXSYp4M6tkFROX6uoX+o
         JWzcEnAieIqjwBOYUXHpouXOliER6NwV/IdxqJQmcFLR1kaqFQkA+GGlFEafssOS51HZ
         7xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827025; x=1779431825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V06xJjffWErV/nU/vA2XdMoltp0T4JkWcKHj/WNq9eM=;
        b=WLSJle7YDkY4sNSjs7J4vOym2nGkhBqF8kTjR8ES0Yi73FHAe4vuIR2FcUiuGi0Kgb
         7xfNgOKSBy8bgGYj9FxcJQLYLNAd6lTrmIo1zquggMTd/aDf35TWz03fMTu0B3vOpPOs
         8kACF4lnQQP4ivu07RFUKUtEvmHLCC6tWnDyX/NXAqHQhrit6VWttQh80q3ruQGKp1w8
         O6Qby16SzQVx9U5u79xlidFTkxZfOHHomtrRFcF37L1CpUMxVP1Vgo+5I/sWdoVnZIWK
         Ev/7UM8rR+lKigqKXxRvgbTFd8x63/xNw8OhmcFNfCDW/fSqZYvK2yphYGGZnQMChyjt
         LETg==
X-Forwarded-Encrypted: i=1; AFNElJ9k0gS7A8P2AO75PMeb1/XDofCBWgj7zMHYXWF0rWOABsOWTbcBsNPtgYU5sXkwNi0i9i+rx/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0JaNwRzC79N9cMStIvV9XjbtJ+GKAE8ZRw/9w1FqAZZAoJPl
	1r6aFIl6AwcW5yqKexQw+PSKRnEWPJEHmijF0SYhAzUbyuZ5BCYy1FiB
X-Gm-Gg: Acq92OGHEqYyylG0NZssC/rrRPbcYMEU4RTQKkYdQ2Dq0l+WYe6UhfalwZ8e/GU8HVl
	WWZW8JrhqpTlW8Kx7Birs1bKc8IjuJk09PlFhI0YxICA8xUM4XhCJ6KQ8a1vmFTQindzDf95ijX
	gpP7KfglxItEWUuPuGXBHASP6qSWD7SBdD0PWQpPy+Wa5jWhKzqIoTRBVnDBufGj/BjLjFMgFrt
	ICe0QLgUgewLkeJZW8uSstMGQv12e/qJnO5nRr3i84DlCtAymgnNiF8I4U/lXViYbUzDysZXYmy
	AqFmUG2rdw25M3rqOiey+XP1R/Nm5wiBQZG9EyqZGaS1ArYn2ZobjdkNXWL4rObw6IJzZuq+4cF
	6xMKPwpOsfUffsuyzeHUSFDBiM6w7nkBxQDz10TiWbN7YIINcWI7ISMBMatAeUPgq0YE6CM0dfE
	67SkDirdOXv8qubUoChXEmMna2NWwQ2Gcj3pdtShJa8nuss7Uwc3dsQA==
X-Received: by 2002:a05:6a00:1908:b0:834:df57:9d67 with SMTP id d2e1a72fcca58-83f33cf0bddmr2953546b3a.32.1778827024470;
        Thu, 14 May 2026 23:37:04 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b1f5sm4936974b3a.31.2026.05.14.23.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 23:37:03 -0700 (PDT)
Date: Fri, 15 May 2026 15:36:59 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Sultan Alsawaf <sultan@kerneltoast.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, mhal@rbox.co, jiayuan.chen@linux.dev,
	steffen.klassert@secunet.com, ben@decadent.org.uk,
	herbert@gondor.apana.org.au, dsahern@kernel.org, sd@queasysnail.net,
	netdev@vger.kernel.org, stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <aga_C6fXL0dZdDzb@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
 <aga8lH0sgneYCCgY@sultan-box>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aga8lH0sgneYCCgY@sultan-box>
X-Rspamd-Queue-Id: 3AD2354A0AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247398-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,linux.dev,secunet.com,decadent.org.uk,gondor.apana.org.au,queasysnail.net,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 11:26:28PM -0700, Sultan Alsawaf wrote:
> On Fri, May 15, 2026 at 02:55:35PM +0900, Hyunwoo Kim wrote:
> > Changes in v4:
> > - Include the tcp_clone_payload() propagation suggested by Sabrina.
> > - Drop the skb_try_coalesce() change; addressed by commit f84eca581739.
> > - v3: https://lore.kernel.org/all/agW4vC0r8QOUKtRT@v4bel/
> > 
> > Changes in v3:
> > - Include the skb_gro_receive() audit patch suggested by Sultan
> > - v2: https://lore.kernel.org/all/agToIEDI4TaTNLRb@v4bel/
> > 
> > Changes in v2:
> > - Also propagate SHARED_FRAG in skb_try_coalesce() and skb_shift()
> > - v1: https://lore.kernel.org/all/agRfuVOeMI5pbHhY@v4bel/
> 
> Hi Hyunwoo,
> 
> Per your ask to me to use AI for exploring relevant paths [1], I've attached my
> findings from a pretty thorough day of hunting for these with Claude.
> 
> None of the findings appear to be currently exploitable.
> 
> Please let me know if you have any questions, and I hope you find this helpful.
> 
> [1] https://lore.kernel.org/all/agWUdie1xBvBu22I@v4bel/
> 
> Thanks,
> Sultan

Thank you so much. This is a really useful report; I'll take it and dig 
further from there.

Thanks again!


Best regards,
Hyunwoo Kim


> Line numbers below are against netdev commit 5db89c99566fc ("net: ifb: report
> ethtool stats over num_tx_queues").
> 
> We audited the netdev tree for remaining sites where frag descriptors are
> transferred between skbs without propagating SKBFL_SHARED_FRAG.  Hyunwoo Kim's
> v4 fix covers __pskb_copy_fclone, skb_shift, skb_gro_receive,
> skb_gro_receive_list, and tcp_clone_payload; the standalone f84eca5817390
> covers skb_try_coalesce.  Several other sites in newer code have the same class
> of bug.
> 
> None of these are currently reachable for page-cache corruption, since each one
> is blocked by independent guards (cloned skbs, TX-only paths, or data copying).
> They should still be fixed for defense-in-depth: skb_copy_header() doesn't
> propagate shinfo->flags, so every frag-transfer helper that allocates new
> shinfo needs its own propagation line.  This guarantees the bug class will
> recur whenever someone writes a new helper without realizing it.
> 
> --- Findings ---
> 
> 1. unix_stream_sendmsg() -- net/unix/af_unix.c:2461
> 
>    Calls skb_splice_from_iter() with MSG_SPLICE_PAGES but never sets
>    SKBFL_SHARED_FRAG.  It's the only skb_splice_from_iter() caller that
>    doesn't do so; compare with tcp_sendmsg_locked() at tcp.c:1371,
>    ip_append_data() at ip_output.c:1237, and ip6_append_data() at
>    ip6_output.c:1801.
> 
>    Not reachable since AF_UNIX skbs don't enter the network stack.  When
>    forwarded via splice (unix -> pipe -> tcp), the destination protocol's
>    sendmsg sets the flag independently.
> 
>    Fix: add the same flag-set after skb_splice_from_iter(), matching the TCP
>    pattern.
> 
> 2. iptfs_consume_frags() -- net/xfrm/xfrm_iptfs.c:2152
> 
>    memcpy() of the frag array plus iptfs_skb_head_to_frag() conversion.  Zero
>    references to SKBFL_SHARED_FRAG in the entire 2700-line file.
> 
>    Not reachable due to three independent guards: the fragmentation path copies
>    data into linear via skb_copy_seq_read() + skb_put() (no page-cache frag
>    references in the result), the share_ok guard blocks aggregation for TCP
>    skbs (since tcp_stream_alloc_skb() uses alloc_skb_fclone() which doesn't
>    set head_frag), and simple aggregation fails because the base skb is a TCP
>    clone.
> 
> 3. iptfs_skb_add_frags() -- net/xfrm/xfrm_iptfs.c:458
> 
>    *tofrag = *frag + __skb_frag_ref() without flag propagation.  The frag walk
>    struct doesn't carry source flags.
> 
>    RX path frags come from NIC RX buffers (not page cache).  TX path has the
>    same guards as iptfs_consume_frags().
> 
> 4. tcp_clone_payload() -- net/ipv4/tcp_output.c:2607
>    **Now fixed in v4** (suggested by Sabrina Dubroca).
> 
>    skb_frag_page_copy() / skb_frag_off_copy() / skb_frag_size_set() +
>    skb_frag_ref() from write-queue skbs to a new MTU probe skb.  No flag
>    propagation.
> 
>    TX-only (called by tcp_mtu_probe()).  The probe skb goes to
>    tcp_transmit_skb() which clones it before sending.  Can't reach ESP input.
> 
> 5. skb_zerocopy() -- net/core/skbuff.c:3843
> 
>    Frag descriptor assignment + skb_frag_ref().  Calls skb_zerocopy_clone()
>    which handles the zerocopy uarg but not SKBFL_SHARED_FRAG.
> 
>    All callers (nfnetlink_queue, openvswitch) send the copy to userspace via
>    netlink.  The original skb continues through the stack with its flags
>    intact.
> 
> 6. chcr_ktls_copy_record_in_skb() -- drivers/.../chcr_ktls.c:1654
> 
>    Frag descriptor assignment from TLS record + __skb_frag_ref().  No flag
>    propagation.
> 
>    TX-only, hardware-specific (Chelsio T6 kTLS offload).
> 
> 7. esp_output_head() -- net/ipv4/esp4.c:426
> 
>    The output-side skip_cow checks !skb_cloned() but never checks
>    !skb_has_shared_frag().  Compare with esp_input() at line 877 which does
>    check it (CVE-2026-43284).  The first skip_cow path (tailen <=
>    skb_tailroom) keeps inplace=true, so AEAD encrypt would write ciphertext
>    over source SG entries including frag pages.
> 
>    Not reachable in practice: kretprobe tracing on a booted 7.1.0-rc3 kernel
>    confirmed esp_output_head() always returns nfrags >= 2 (the inplace=false
>    second branch), never nfrags=1.  For paged skbs from splice, the tailroom
>    is insufficient for the ESP trailer.  The inplace=false path allocates
>    separate output pages, so frag data is only read as source, never written.
> 
>    esp_output_head() should still add the !skb_has_shared_frag() check to
>    match esp_input(), since a future change to skb allocation sizing could
>    make the first skip_cow path reachable.
> 
> --- Root cause ---
> 
> skb_copy_header() copies gso_size / gso_segs / gso_type from old shinfo to
> new, but it never copies shinfo->flags.  As a result, every frag-transfer
> helper that allocates new shinfo needs its own explicit flag propagation.  This
> is easy to miss when writing new helpers, which is how we ended up with seven
> independent instances of the same bug.
> 
> A potential long-term fix would be to propagate SKBFL_SHARED_FRAG (and
> SKBFL_PURE_ZEROCOPY) inside skb_copy_header() itself, matching how skb_split()
> already handles both flags.  This would eliminate the bug class at the source
> rather than playing whack-a-mole with each new helper.


