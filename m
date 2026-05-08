Return-Path: <stable+bounces-244786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fn6F14F/mm7mAAAu9opvQ
	(envelope-from <stable+bounces-244786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 17:46:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC544F8F33
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 17:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F3CC3035B52
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F73F2EFDA6;
	Fri,  8 May 2026 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpmBNfor"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5EF2F1FC9
	for <stable@vger.kernel.org>; Fri,  8 May 2026 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778255161; cv=none; b=hDd3aQuyY/IDaQX0NVW90RRj8aAjtg4gpX+rWG79W/JzjIsWD48rJcmsFQRyMlqcPCy8RVifGi5QDjl0PtuAY91NQpRSApEFHdG+n+6OHPsBvLAu/2y+JznQ/d32CLhKY8VRT2TFHToHTQpsAasRnY+/HzXaeUeHJ4e2etSOH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778255161; c=relaxed/simple;
	bh=oEl33Z/vw9llxa/Yt3MmVWX3MitGrgbvbnrf7MvkUuY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Y87kKvlloyHsaQf9N5uCYM3QAc+GfgwUpPiATR/hQBb8cFe3m81UoK4w/FGs5erNPuwjyFsNYxL/6hXofSAa0JOQlV/yqiwQYDqpSRDf9Nl3pmX2xUQ5JM9daD8TAfJ4qmov9A61FpgtruI4QxEQw99XOkzWUe7rNjpl1OAr9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpmBNfor; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778255158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DoqUW4Ab7C8hyJZDCA7GvuscNtP71DqUE4zEpURuA34=;
	b=RpmBNforbmogulRvA+ws3AY6d84zvPbWMd6p9qBBEoqa7tsRCQxYTfy2mHWIgurpjMNfG2
	P0BdATnDPmdAC1OnXii03Op/Q0aeNJZ1YPto6f6qQfCYunuoYY01BF4EnFEJ8HfU1PN/ST
	/J+ybOhzQ1hmcOR+bpQiBv7lAjyfLo0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-Y9P6IGaIOF6YZO5TtyiREg-1; Fri,
 08 May 2026 11:45:54 -0400
X-MC-Unique: Y9P6IGaIOF6YZO5TtyiREg-1
X-Mimecast-MFC-AGG-ID: Y9P6IGaIOF6YZO5TtyiREg_1778255152
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E0AC180035D;
	Fri,  8 May 2026 15:45:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 91A9F19560A2;
	Fri,  8 May 2026 15:45:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <af2kdW2F1gJ9U-Gg@v4bel>
References: <af2kdW2F1gJ9U-Gg@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
    edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
    horms@kernel.org, qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
    linux-afs@lists.infradead.org, netdev@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when paged frags are present
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <195757.1778255147.1@warthog.procyon.org.uk>
Date: Fri, 08 May 2026 16:45:47 +0100
Message-ID: <195758.1778255147@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: CFC544F8F33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244786-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,warthog.procyon.org.uk:mid]
X-Rspamd-Action: no action

Hyunwoo Kim <imv4bel@gmail.com> wrote:

> The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
> handler in rxrpc_verify_response() copy the skb to a linear one before
> calling into the security ops only when skb_cloned() is true.  An skb
> that is not cloned but still carries externally-owned paged fragments
> (e.g. SKBFL_SHARED_FRAG set by splice() into a UDP socket via
> __ip_append_data, or a chained skb_has_frag_list()) falls through to
> the in-place decryption path, which binds the frag pages directly into
> the AEAD/skcipher SGL via skb_to_sgvec().
> 
> Extend the gate to also unshare when skb_has_frag_list() or
> skb_has_shared_frag() is true.  This catches the splice-loopback vector
> and other externally-shared frag sources while preserving the
> zero-copy fast path for skbs whose frags are kernel-private (e.g. NIC
> page_pool RX, GRO).  The OOM/trace handling already in place is reused.
> 
> Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>

Acked-by: David Howells <dhowells@redhat.com>


