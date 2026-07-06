Return-Path: <stable+bounces-272132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eQvEHDZFS2rWOQEAu9opvQ
	(envelope-from <stable+bounces-272132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 08:03:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC4B70CC2A
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 08:03:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=Pt4y8l2L;
	dmarc=pass (policy=none) header.from=infradead.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272132-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272132-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9E0DA30091C2
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 06:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0280E3B42F3;
	Mon,  6 Jul 2026 06:03:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9392C11EF;
	Mon,  6 Jul 2026 06:03:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317807; cv=none; b=c0GfeDaWWifoZ7b+hcl0fAhG1TAZMC8bjH4mNAivgVyggduZ332mpFjBc0MsVN8wrbJwW5GuPKXGKTg3IswPDGuUB3dPe0qtiq4Vz8+/IuSth12djnapultrnXFdPSb0OwTrn1x1Sotv+zlN+IxAq4AZve/QT6+A7/1Dfl+IYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317807; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXr3nJTspJk7wZnds2pDAZaANGuY9JT1fY5JkkMCLVYIWiZNOqiaowNMpCApVGxkuk+MpUfOaBF0mfN3Ylq+yRzUJsfge/NSHfEwQxZCl3O9RzYwQA9PzOg3Hrxlxk5QiFAWNEkIBak2NUW6YIXsyslS+JSx6/7e1Bl1eWtmid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Pt4y8l2L; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Pt4y8l2L5HQ4suCEaTRj0+NmeM
	STvtaZmQxqiiZLFhag1jUpe37KDxCuft0TzqybGngtSwqegc+gnBhMZjiW1rKOTw3Ceq8jw0FZMmc
	hoHJQSF/Cb8iNRp7I7jAw4UuWQ3Ukqu29VoB5NIDuX0i0lnArr+/w204+aXqg8fSfEg+iEBUI55c6
	TKpHkbz3nyXWEdhIfE4cZlhEvaWPStLBGaR1mA+KWUlYwDBNG4AQ1lg4wc6DWQGtIWr5fnrZE13hm
	n9PvY7Q1JQ2RHTfLQN3VeW01c4nYggVovlJ2GnwAgkaMDTQeBPScsqCSyxiaGxOGCcdXFqKi0BRcr
	ztxA9isw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgcQL-0000000BZ0q-3Rvm;
	Mon, 06 Jul 2026 06:03:21 +0000
Date: Sun, 5 Jul 2026 23:03:21 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] xfs: fail recovery on a committed log item with no
 regions
Message-ID: <aktFKamLw1z5sgNW@infradead.org>
References: <20260702162000.3548359-1-bestswngs@gmail.com>
 <20260702162000.3548359-4-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702162000.3548359-4-bestswngs@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272132-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:linux-xfs@vger.kernel.org,m:cem@kernel.org,m:djwong@kernel.org,m:bfoster@redhat.com,m:hch@infradead.org,m:xmei5@asu.edu,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[hch@infradead.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DC4B70CC2A

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


