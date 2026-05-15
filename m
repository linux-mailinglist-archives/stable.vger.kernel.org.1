Return-Path: <stable+bounces-247393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADcEJH61BmqKnAIAu9opvQ
	(envelope-from <stable+bounces-247393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:56:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E11549CD6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFA66304047A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 05:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6B337205C;
	Fri, 15 May 2026 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BjrMy0uD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hFIMa14h"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E52FDC30
	for <stable@vger.kernel.org>; Fri, 15 May 2026 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778824554; cv=none; b=hwI5UYtQ0ndPGOzefNKM9n1btUOzZq/p/h26BlnAipytmdSnN3rK33aVuGaTkejXfYFO7OAFT/SSCoJrVYuFh7mYU1qe4ehKzbvN+RGxk2nxCT3RXD/sSpMyB8VvAO7+JHaa2u84/1rB4uq1GFqtDslol0ZDXlnz2GMZUbVJElU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778824554; c=relaxed/simple;
	bh=1MEoq/+Bl8h83PNxOiADkgsQL9itEMDG08tWgOa1OOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYnxAZ7V1tsH+HyoX0bFCk433Qgop64gp6dSboaoIkbudiXncVqUakmQvgirP5PWbt50JW6mZT8DcVPeA+rloFY2R3+Xc3tvWqCZnWcKQiDAWb40GSETtgKpd4VoXuz211Kkte1k9FF2Ae2CBnNZTpYmp4EIRJj5ulVnWX+nXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=BjrMy0uD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hFIMa14h; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B6861D00085;
	Fri, 15 May 2026 01:55:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 15 May 2026 01:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778824552; x=1778910952; bh=zmOUE+BT97
	RaH0kXmC2AcS7xL+lL1aggr2c+rAyTCqs=; b=BjrMy0uDpgC1EViwZFMvEO6Xlv
	J2/844ROT3AdChbPE0u/Zm7gzDm/GAubIECT5cxRi+4zz0yggZ2pr7bPHEs87OSn
	A7D5YADwjbEIPkSfcCtwJvBBWokaIC8SfwPS/xEmP9kkVovN085Mm/GEw/f03LBd
	ZIxOvvc8m+ay9Fcs3kiRLro3SgqT446HVr6SV075xjRoMa7P4yqLPdeg/Z7Qf9RB
	0mhZr60QTCHB+PKBEz7ptWzqWe1p7u/5UJBVyn060XzVjSb1flqvOtAv9HR6csR+
	tceT/I/Z2eVUmYQn8Nd6W9UIwd81723RczPmmUMOGym9rAMwfVTUjSICo2lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778824552; x=1778910952; bh=zmOUE+BT97RaH0kXmC2AcS7xL+lL1aggr2c
	+rAyTCqs=; b=hFIMa14hki8307cMiLUEKCafJUbxk7Bk9V8nv8D6l36D+ImNF6H
	qH/EDArDhmEECZ5WWqubS5C4Q8aIOCq+FVcA5G5uSzcv46x2bZRz2oIRasItKrSK
	VmWq69mTG/zezOcYqilixjH1eK+OpNYH/q6DvwuaoI3DaL+6ppj96V1mZ/mafavr
	mpmtIT2szJZhxDv5q/5NRlzSD7Cqc3qXwT0Um4QbKSpcBuPnYP4NHNfrgJnRdz0P
	6D5/BXlkZOMjnB8FeiCxmNN/flVkdkSdx2+KQujDsDBHZ6hP6PfmsLW9Wg/QCDaz
	CnLLs/tkRSwTMWwGwGmGqlyYXCxTRCixNug==
X-ME-Sender: <xms:Z7UGaq-8pLnqlz9jK3rSgA3K9PZFRCR02KYBz3HHzJxKNBgmezIjnw>
    <xme:Z7UGakAA66PBGkOFeEcyREP5SPU0iaHNVsbzfvkk94ABtXl9WJpg35VnbKRdKsGUD
    zRkDKaSV9qAvBnK_qwKeP68EgXv6ByuQvt5fqniVPJd97dP>
X-ME-Received: <xmr:Z7UGanRqvg4k59MJNSyJmbBRADxL1tVCG6vBY-TZhIIDUtZRezLJPpZl7GkiewyEBNM_2ENTG7IFHzS9U7MuDNEriw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvdevvd
    eljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlvghonhgrrhguihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshhtrggslhgvse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhgrghriigrrhgvsehrvggu
    hhgrthdrtghomh
X-ME-Proxy: <xmx:Z7UGajuq16SfBUBjWMSiIjT_OfTlcxtHS5l6_QI_6h-zaT8BtE2lUA>
    <xmx:aLUGar3zMBlmdTtQ1OUJRj2TCmBq__cYK71tbL04-PJF4ps9-6hlbQ>
    <xmx:aLUGasWZ3UvUj8bk4TTBrL5Rmgnyp9EY2PLsuQZD35Rer9s6ysuTQw>
    <xmx:aLUGauJSYehN2kIdcA5DMJ508JZ6VXKSkcqVG2cc62dND_-RWNmNwA>
    <xmx:aLUGaj268Sl1G1C8sKlSD9L-Psr4FfV3yDUNw7y-eOSQAiSi39Pkrn22>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 01:55:51 -0400 (EDT)
Date: Fri, 15 May 2026 07:55:57 +0200
From: Greg KH <greg@kroah.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: vsock/virtio: fix MSG_PEEK ignoring skb offset when calculating
 bytes to copy
Message-ID: <2026051539-residence-unspoken-abff@gregkh>
References: <agXKLQjMytKNo3kZ@leonardi-redhat>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agXKLQjMytKNo3kZ@leonardi-redhat>
X-Rspamd-Queue-Id: E8E11549CD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm3,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247393-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,kroah.com:dkim]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 03:25:29PM +0200, Luigi Leonardi wrote:
> Hi stable maintainers,
> 
> I'd like to ask you to include the following patch to stable:
> 
> 080f22f5d30233faf3d83be3098f35b8be9b7a00 ("vsock/virtio: fix MSG_PEEK
> ignoring skb offset when calculating bytes to copy")
> 
> This fixes a bug in virtio-vsock, that leads to an EFAULT when the user
> performs a partial recv followed by a peek that requests more bytes than
> are available.
> 
> Please apply it to
> - 6.12.y
> - 6.18.y
> 
> 7.0.y already has it.

I don't see it in 7.0.y, what commit id is it in there?

thanks,

greg k-h

