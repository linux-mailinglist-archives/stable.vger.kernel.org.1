Return-Path: <stable+bounces-246784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKrRHdgyBGqNFQIAu9opvQ
	(envelope-from <stable+bounces-246784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:14:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E88C952F693
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 10:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58DE030166C5
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 08:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BEF3D34A6;
	Wed, 13 May 2026 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlnNXDoU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF453D811C
	for <stable@vger.kernel.org>; Wed, 13 May 2026 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778660038; cv=none; b=L1d78oF7PH5G1ZJ4wKbbd7OJTUQkLqAMLGzQPAfUigoZZ7wymklesZlkMeI1fYvJutHdOMOgeda2w5IdWD5FCKbJzwhKzpe1dbAjOBWMs6osWIlsyoXCx4aM10fIZhbeIESZYpaFt2fDsU3fGcbNDo1ScdzonNTYhVlOsVWmfx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778660038; c=relaxed/simple;
	bh=kmni9OLhg4Pd5n62/ER2xoJKPdcU2TOdP1z0TI3HiTM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=c5/BhqdIgb1/kRwlEgAbe89csNfGAXrpG79u8FHEwQMTvkFjXfYC3GxmXyHJnAftd1Sc7rzETwwYGfPu7E6U+sIl//k6Mtzl/LfnxGh443MI3WYmHPE09lbzwwR6m2813hpzw+4w/Kueb83/XIwsSGwftCdr7YJjcKPMm9g/xIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IlnNXDoU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778660030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7jMVBsE7V/XEqCjzIOK4vL1Dn6WnzW8J5Vfp3OVDYBM=;
	b=IlnNXDoUJHWk7nttXeDbUO7BYFnOfMPFVROKDBQ7H6143v3HU6KUMNGsgHzr05Kf0uDoxW
	z0JyYUQ6WF+of5l3/4c9QpLjgV9aGUhWj9nYuMg7+VirPyyjmw3NoTtnJfm+kcrt1Jh2sB
	06xV9c0HrGowi2/JdJsX9YYOB/Iz17c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-oKIoDh_dMDOuYwnVtVm4_A-1; Wed,
 13 May 2026 04:13:47 -0400
X-MC-Unique: oKIoDh_dMDOuYwnVtVm4_A-1
X-Mimecast-MFC-AGG-ID: oKIoDh_dMDOuYwnVtVm4_A_1778660025
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F37CD19560B2;
	Wed, 13 May 2026 08:13:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.48.83])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAE4B1800349;
	Wed, 13 May 2026 08:13:40 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1354628.1778659274@warthog.procyon.org.uk>
References: <1354628.1778659274@warthog.procyon.org.uk> <437CCB8A-5333-4349-B120-A103B1F0E617@auristor.com> <20260511160753.607296-1-dhowells@redhat.com> <20260511160753.607296-3-dhowells@redhat.com>
To: Jeffrey Altman <jaltman@auristor.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Hyunwoo Kim <imv4bel@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
    linux-kernel@vger.kernel.org, Jiayuan Chen <jiayuan.chen@linux.dev>,
    stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] rxrpc: Fix DATA decrypt vs splice() by copying data to buffer in recvmsg
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1354985.1778660019.1@warthog.procyon.org.uk>
Date: Wed, 13 May 2026 09:13:39 +0100
Message-ID: <1354986.1778660019@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: E88C952F693
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,auristor.com,kernel.org,davemloft.net,google.com,lists.infradead.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-246784-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

David Howells <dhowells@redhat.com> wrote:

> > > + kfree(call->rx_dec_buffer);
> > 
> > It might be better to avoid deallocating the buffer on the error
> > path and permit it to be freed during normal call (or call channel)
> > deallocation.
> 
> Hmmm.  But I then need some other way to note that the buffer is no longer
> occupied by valid data.  I suppose I could set ->rx_dec_offset to USHRT_MAX.

Actually, I'm not sure that just freeing the buffer is all that bad.

If skb_copy_bits() fails (ie. EFAULT), then the sk_buff is unrecoverably
broken somehow and the app will may have to abandon the call.  Possibly the
call should be aborted directly here.  The case really shouldn't happen and
probably merits a pr_warn().

If ->verify_packet() fails with ENOMEM, then it's retryable.  Releasing the
buffer temporarily might help the system.

If ->verify_packet() fails with anything else, then the call should have been
aborted.

David


