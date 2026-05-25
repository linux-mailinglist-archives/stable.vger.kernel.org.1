Return-Path: <stable+bounces-254167-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDRCNKVoFGr5NAcAu9opvQ
	(envelope-from <stable+bounces-254167-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:20:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE545CC328
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EAC3302FB52
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A73F411F;
	Mon, 25 May 2026 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po4hqblZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0939F3F4117
	for <stable@vger.kernel.org>; Mon, 25 May 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722305; cv=none; b=eGpt7w+pGSiSdUkzXMBFpYuWQO5IP9Y3H7Vu+I23VIaBn21b0FV06oYAHe8nM6+rkkbkMR8++2qQSN0uLZPLdYwqztrrAXnGgoofeUqhuBQABbSJbutoN4fGq+2BL/ulKeVsGc7L+2L6BOPcQNAWbrMPvOYggboq6o/VDOUBn/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722305; c=relaxed/simple;
	bh=RrEqVF+8xKgB6XVFvEeQqJQjcR+TR2wOKi3CXTAfdsQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UjlDKPwWbUieQG1MRot4oz2qS5jyf1XGLbwCkDzAZLJdbIEfIgkfZtVNXSHgEDpQEWrTIYxT/nEvI8JUwLBa3dzLjR+EWHnXGVkkzvkF0lkncr66DWyx4ehUsQWft4qnVlPaw7aF1uQj7o8Osfm5S2jdeVeJYv+IqqDLNwPdfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Po4hqblZ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7cb343d343fso89150737b3.2
        for <stable@vger.kernel.org>; Mon, 25 May 2026 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779722303; x=1780327103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJgfyL6MECDYmfEnLLSB0agIRcEUB1GBMWOs44zbde4=;
        b=Po4hqblZ60rhzEvXZ5SfvAAH9lXG+njQtyC/7PPqoR3IY6ZpcrwDk8FNKZg/yFwwDt
         oGW+ZjkN6kUXLUlzhwltziwFLxrFFy+syW2o132g7NpVibIgY2Yfjru6JndiTpAjDVGn
         /lt2miy5PLO7X2lfe0n4wP2yT1jCF8tlOnJCYOvk8Z/4/gLC7o3tiEA2SmY3bu4lVyn4
         2ZgkefgmrrA4KE0R3LUm+IAgoMJoizEx+uMw9lRyo/cQFm90uqurEFrqWAcuCZAEuQem
         Rf+5QCODThx/wgepsvJTJl1EfMgKT3YYHwm0VNt4grHt7JQcd9Xfigjcel5FGH7qJpLz
         mTrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779722303; x=1780327103;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJgfyL6MECDYmfEnLLSB0agIRcEUB1GBMWOs44zbde4=;
        b=iDHYTk6v6rYSAVBWMx/63hl3gDJQRWar2pdw7GeZgBC3F5fk4luWTg7Z5REbYVL7DS
         xYDi3nsEb4DtZ7T3Pk5TSuqPLD3huGtJtwCmGuyhofi2Uu9MPF8XowkeCuh7ZAib/gZ1
         u2iJxvhOjkckDzQZBue+s9oH2juDvEsk79vTF2zvMHpHH8E0J5oNWwnqfwABa1ftJKfS
         d+Gtkesj6IuZ8qV4ukoDuf1k2nfhDhw8DbYIId3mYo1oXAL8eJJIS7IRIO85vvEOryI5
         BzuhO0YMP8dhnDBlUgZ/pAbQHXOEWCGJ9fnMWE8DIu//G3GmeDVfWsT3TJgfXQ/mkKFN
         TVXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/fwv/D3rHPwboxDHCzD6E047rDlIWB5YiGdqibMvUf8q/uBYOx91itEfAVpcFLdkuiX9w1Mpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwortNdWHiiB+PNwdjgHCWGA4a+x1K+sf1fjfKregSNhpz38lcF
	Z0avkpN/rKCm9N7D50rkUbdrxKBzi93AWDIa+cKsEEBhLlH2Z/vkBAJ4
X-Gm-Gg: Acq92OEcOA8BIW27KdPtlrJeb3+fr6QElI6mhWQfsRtQqeWXZkyrWbgPITMnQV3a/Ug
	YsSituhwSoPzeKOpfDXjk+BkMoOWH+r0kJ+uMWj41Xsfdv85E64WA5LComXKwo5khCHGFm28pna
	sXjAuZ89BqR9DZXh39XmyZAzi9u2qsKSV8VT5I8MvtL4EleiNaqwzCejFSwv9i7xx7kcvYNid8S
	DlZSWieiSl6rRnwPeDGkVdnGhfrEQ2BGYTgzsgm+W+KC1pcpmcu5jOrDIsavmP63LGLmXFXP6Kj
	+SU9fSAIUlJPYDWoaVHeC5gwH24F0ydgKCRchL46HMEDAiHUtTvaWDQl6ty1q4HRSsT9Evjh54Y
	Op5sfdkw0xtTRpMhQHxOlrdRIyn07FzxqRL7w20zfSVHcWeLXqsQ1tak2OVPBmjzITzzL2Yem9y
	joUu2oPaq4bry4TLT1aXX+AEvo5ifAKvim9dCAAzbAhPXXmfJAeXjJYvzq8xP4crXY4v2l1WcMH
	kgqdSg=
X-Received: by 2002:a05:690c:6908:b0:7bd:8ce4:92c with SMTP id 00721157ae682-7d335fbccdamr167856177b3.31.1779722302763;
        Mon, 25 May 2026 08:18:22 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38be2dc84sm47407027b3.29.2026.05.25.08.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 08:18:21 -0700 (PDT)
Date: Mon, 25 May 2026 11:18:21 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 lazyming <minhnguyen.080505@gmail.com>, 
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
 stable@vger.kernel.org, 
 asml.silence@gmail.com, 
 achender@kernel.org, 
 mst@redhat.com, 
 jasowang@redhat.com
Message-ID: <willemdebruijn.kernel.1ddcb33fec832@gmail.com>
In-Reply-To: <willemdebruijn.kernel.27d7990b24613@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
 <willemdebruijn.kernel.10f46164d2a79@gmail.com>
 <willemdebruijn.kernel.27d7990b24613@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254167-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,1wt.eu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.418];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2DE545CC328
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > lazyming wrote:
> > > pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> > > the old skb_shared_info header into a new buffer via memcpy(), which
> > > includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
> > 
> > These functions are not supposed to maintain zerocopy frags.
> > 
> > Both call skb_orphan_frags.
> > 
> > I think what may need to happen is to invert the order of that call
> > and the memcpy. Current code:
> > 
> >         memcpy((struct skb_shared_info *)(data + size),
> >                skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
> >         if (skb_orphan_frags(skb, gfp_mask)) {
> >                 skb_kfree_head(data);
> >                 return -ENOMEM;
> >         }
> 
> Never mind. This actually corresponds to the first Sashiko report you
> mentioned: if zerocopy skbs are converted, then the memcpy prior to
> that call will have stale state.
> 
> For skbs where skb_orphan_frags does not do a deep copy, we do need to
> take this extra reference.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Not sure the potential preexisting issue is reachable.

Vhost-net and other zerocopy that predates MSG_ZEROCOPY does not
refcount ubuf_info. Instead it calls skb_copy_ubufs on skb_clone.

So if such an skb reaches pskb_expand_head, it should be guaranteed to
not be a clone. Same for the carve methods added later.

But, the commit that added zerocopy, commit a6686f2f382b
("skbuff: skb supports zero-copy buffers"), included this 
pksb_expand_head call to skb_copy_ubufs from the start. That implies
that was expected to be reachable. I just don't see how yet.

If it is reachable, then all that is needed is to clear shinfo->flags.
Or more neatly,

    skb_shinfo(skb)->flags &= ~SKBFL_ALL_ZEROCOPY;

