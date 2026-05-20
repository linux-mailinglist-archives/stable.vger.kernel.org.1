Return-Path: <stable+bounces-249889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJUTAyqeDWpO0AUAu9opvQ
	(envelope-from <stable+bounces-249889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:42:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BED58CCE5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 13:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C9A23386DF2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC242F363F;
	Wed, 20 May 2026 11:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vb/k9Oil"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3FB33345A
	for <stable@vger.kernel.org>; Wed, 20 May 2026 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779276741; cv=none; b=L35+IpBn7kupuHseB5/T8OQyVKN0MPDivWmRos0Z1ueadVQ5UXYo0+Xh88r1kZGdL/RXFRi3RO0KwrzQQxjm50k2dMYLdY6KmANhE1E+YrJjLige+wLc59g1XbtwxYab9hGcESVMLdzkKsIWcRPqxcjukwBYwNAgTFNSha/HVa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779276741; c=relaxed/simple;
	bh=f7j4spNpv3upgEXmFzOINpOy3UsguVfzzBtklXLSh34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbZqCqpyAHZp3VbRyV4f+D2eToNjaniVJLrhVYtzz6yWRhom5C2uSL9fslle+n5tEKVhFQ9njtCq9npEUoX3HQh7q/j5pZVD/IaijnymaQkUbFlK3b5AxaUTJjuRznH7uFVAx4PlCPQyUlFyfwSySpEK92BJdxDJr7+gJmW5GoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vb/k9Oil; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDEB1F000E9;
	Wed, 20 May 2026 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779276740;
	bh=3pwqdi6yivL7LbeqLPQVzinI94uEiVJC4y1Szyn6DIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=vb/k9Oil5EEGQJdTCGHjG3VfXrIfR/P8w5x2BpqPE9PaWofytwpf41IImL1POGqlH
	 VPRaqxI2Ie0X9TypcXiajaSnMLi5NsGlhfiruG4SzAgzi8iyaCwXCjdgNxo0SSaQxm
	 lY2943Tru4lJACDJq+MouWVGDpg2REzotXZ4xLeA=
Date: Wed, 20 May 2026 13:32:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kevin Berry <kpberry@google.com>
Cc: xmei5@asu.edu, bestswngs@gmail.com, chenglongtang@google.com,
	joneslee@google.com, pabeni@redhat.com, rnj@google.com,
	stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] net: bonding: fix use-after-free in bond_xmit_broadcast()
Message-ID: <2026052009-vexingly-chokehold-f8f7@gregkh>
References: <CAPpSM+TbMOPL93CkWtrYjYW+T+Q+iWuo+ZhfutYNFOuOCBU5fQ@mail.gmail.com>
 <20260506202842.1788682-1-kpberry@google.com>
 <20260506202842.1788682-2-kpberry@google.com>
 <CAMAJAJFCWdZAhLnKh1gGPf08Pn5XipaXX3Xv_rLNFYpH+WCJzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMAJAJFCWdZAhLnKh1gGPf08Pn5XipaXX3Xv_rLNFYpH+WCJzw@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249889-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[asu.edu,gmail.com,google.com,redhat.com,vger.kernel.org,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 95BED58CCE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:44:22AM -0700, Kevin Berry wrote:
> Hi all,
> 
> Just a quick reminder about the patch for the 6.6 tree above.

I don't see anything "above" here, sorry.

confused,

greg k-h

