Return-Path: <stable+bounces-254028-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAAbJxv/EmrK5wYAu9opvQ
	(envelope-from <stable+bounces-254028-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:37:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F095C2949
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 15:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F4573003827
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 13:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73220396D2E;
	Sun, 24 May 2026 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djlXhBzD"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06252395AE3
	for <stable@vger.kernel.org>; Sun, 24 May 2026 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779629848; cv=none; b=PmdJnzz7eN/mphelPwuFqEIbsaSf5e34sTAMSPlKHx+1QKJdzx7DC5LKmPkV3ZL7rqe3q3kpQ1l7lox/P9bUr0KOf0PYXEMy+keWuNjSDDbv9qOtTsT0IL//vsPBJVj+vxZ5taXL7AohnKMolX+Bbz9e003sNpvqzHIIPdPEfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779629848; c=relaxed/simple;
	bh=P7flB7wlJlTemBMOJ1CJhIGMof7wEnYxAdHRWvkO2pE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=j1dcKkd45/eyYBiEZ0wdZKc5BJoOmKhd5rBnKiuWUAz9LywbwipYUY0Uqw7QmUlJhUxTCZp4bbSpa6cx81kYpYWNmdjByIz8tH/6AVukAFZ98EG4S8X9fBniE3tHNDESJAlZjlsXHb0FP0cTV5lc8KM0Ev4JH5VU+NFeP4kGwRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djlXhBzD; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6530287803cso8825384d50.1
        for <stable@vger.kernel.org>; Sun, 24 May 2026 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779629846; x=1780234646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YzZR/UW8yRfScwxVy4k+9Cx7IebnzhqtMNHTkpEuco=;
        b=djlXhBzDweCzyq4p7iDDi1cLfxZyGhDt1ZNBnvkn+i8WQa1UVt6N9w9M1Y86PTYwxC
         GLznfND7Jq/u35m69RY520XAg25CrHu/d4RG5rbIJWnShGT2V2prC10is7aq6K26OxjT
         GFV4adNaVtfcKk4Urz4yCJF0Gswyk3PQ5fT70vUygD6/wOEzbC/2ePFM3K+3VIRRksq8
         218A8S2lr/PyGGQOTo8OAqOmyX/D69DzgREWRmgluI8Nnv+754FpXp8GRX+HgnDsRH3u
         xeZCQXFVuZCNQlKfcl6nybchf6/qzh2aGnlKUyEfQYMyhrvxG2kd2xdERuviZS7mKs7d
         GL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779629846; x=1780234646;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YzZR/UW8yRfScwxVy4k+9Cx7IebnzhqtMNHTkpEuco=;
        b=dCleWGivL/oHBeHJOkivJS2M4E/07n8qVFDFWkXRvkIPJcvOEsp4jDWFDHnL7uTjRw
         q8JU8RZ0NK7cjyommVLwlW59Rse/CuXdjh52VwSDKKGjxxniVW+X6fTMqPfWh4CYZIeI
         /FY5jVbiUZtz68QTkxy1Nnh+Hc/nG0+DtHRooOGeg9e4etRuNI4joSkjpAKMExIQlbwW
         8e37h9kwqaQwV3V3m/y34jxLexC96eoenQLV4J7Gx+5TAZ2UvZyz6gADliI5M220t+bi
         sMVmwiTxuFN7wner+o6CLYisdSZytL9/yQlcHedHSvnyZO5+N0AFSlTnA0O7sNlTF2Uq
         M0xA==
X-Forwarded-Encrypted: i=1; AFNElJ9bIQksfaMYJA2f6BxRyGH4KAhQrnmKaTt4/fmO4KpPXj37diHhwY8CLSANgpAJ8fyyMqfxWe4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5K6bqmgmCLbMpDEqKquoFN2p61D/DJ4cvGZ2i0wx5UdRNudoD
	jpMD8fDg0E8fZS79/GKbBG59JVrBoyDSd3X4yx8W1sccHgfhzntHLYFG
X-Gm-Gg: Acq92OEGaJgWev/UFcScJoJ2am6P4f5xZJ8wtp7n2+h1PWvRlsNZsl4k/mP+sYCAu5S
	1LB0tAclB6+yNj9LslBXvXVUd6doxpND1Xsw+zQZ2vrMX+b9ihoLamqIXbHvUNsEdZgT4Wi3VBJ
	CXI9WWl6WBWPgPxK2QiEawTwHmZTxagbAz5VweO/1xKiMLno9Qj4lltwlrex2QLeQbg25JgV9u4
	VKanK6lraCK3IThmTLzDAoY32SEbGJcPpfKc3aZBNO+xJGHWLhCwoaxKq4b84sHITfqjjETRc84
	StAvep/+d1xsN6NDuk153XFgnuJuKYZevecgvMgF852mG2YkQoWJM19jkw2HR/r12XqLeQ5AOSo
	Q/c5jqqCm8g6d6do7+FdfMJeqj4mbCJvY2MGsrtb6mZhUoAhpiHTx8IyIG1BiSrqHGXfFLPxqOI
	C7qvNq3L8iDPTobAqoyPWJIzFEFH4zrh9KfiHuDKU0PVkPGES4K3/Jl0VF2RIFlS+Jon1Bqo6tA
	MZzQv4=
X-Received: by 2002:a53:c04e:0:20b0:65c:65aa:df7c with SMTP id 956f58d0204a3-65ec98ea7d8mr8460898d50.33.1779629845849;
        Sun, 24 May 2026 06:37:25 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65ecfdf4bd7sm3163017d50.19.2026.05.24.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 06:37:24 -0700 (PDT)
Date: Sun, 24 May 2026 09:37:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: lazyming <minhnguyen.080505@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 w@1wt.eu, 
 security@kernel.org, 
 linux-kernel@vger.kernel.org, 
 lazyming <minhnguyen.080505@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.10f46164d2a79@gmail.com>
In-Reply-To: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
Subject: Re: [PATCH net] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254028-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,1wt.eu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.369];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 47F095C2949
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

lazyming wrote:
> pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> the old skb_shared_info header into a new buffer via memcpy(), which
> includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.

These functions are not supposed to maintain zerocopy frags.

Both call skb_orphan_frags.

I think what may need to happen is to invert the order of that call
and the memcpy. Current code:

        memcpy((struct skb_shared_info *)(data + size),
               skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
        if (skb_orphan_frags(skb, gfp_mask)) {
                skb_kfree_head(data);
                return -ENOMEM;
        }


> Neither function calls net_zcopy_get() for the new shinfo, creating an
> unaccounted holder: every skb_shared_info with destructor_arg set will
> call skb_zcopy_clear() once when freed, but the corresponding
> net_zcopy_get() was never called for the new copy. Repeated calls
> drive uarg->refcnt to zero prematurely, freeing ubuf_info_msgzc while
> TX skbs still hold live destructor_arg pointers.

