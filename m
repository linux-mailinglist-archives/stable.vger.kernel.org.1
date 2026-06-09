Return-Path: <stable+bounces-262274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7DvcOOz8J2rC6gIAu9opvQ
	(envelope-from <stable+bounces-262274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 13:45:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC2065F9B9
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 13:45:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=XCEMkPMv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262274-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262274-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A1EE307473D
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C17F4028D2;
	Tue,  9 Jun 2026 11:39:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1E402B8D
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 11:39:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005180; cv=none; b=ssIMUK22qMThRl+GVnWyTv/b1DMpIJweM2kn9cVKVUt7Z1xd0c104pmJtN+D9ohbyfO0VqcgsZuP5mbq1G+2GyJOyzgkE+HiX76d1VCfBmTF6tTc9pFfBwEGIdf0rxCWqqX9iN39AGTpDBFy8aGOt/rDORgE/UEpTJSNMoGVdvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005180; c=relaxed/simple;
	bh=v0oNpovBDxYRdhN70lC1jLW3FFZoFv0QmeL6FwC8CHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIftYyW3DGzWGJDSc0Xz21+s0iDE53XlWLWvSbxzK9foWHSTUzPOP17hy+/KEXTMOJebDCmwWqmEoSTSkhzC+/vH7UW3x6iwxtPU8f8FbZtzfazsWDlmc8sS6W8BxwfxA2Ze0iDPLDxf+Tn9kb1zWuptDTOzD8ozvMohuuYxT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCEMkPMv; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781005176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qm+Sbk9IuXXgtzP+mHXUfGC0wxxue4TlT/GMvB7XuWg=;
	b=XCEMkPMvBU5XDjajsabNSt7N1PNrjIFAs12K1vuUlmU4hTUXDzxE5us5MRA3baLxtIX+RI
	LeWid/uhkd+U7nTgEIFXbSTYvjbYdUPrvkcyv/043JDN27Ww3tVrAVDPjHJzBOnuanqJe7
	lPk8ymZr1wqOo0bDCWKc0bbby5I5o3U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-48CTobu6OxeHHoJTXJMuVg-1; Tue,
 09 Jun 2026 07:39:33 -0400
X-MC-Unique: 48CTobu6OxeHHoJTXJMuVg-1
X-Mimecast-MFC-AGG-ID: 48CTobu6OxeHHoJTXJMuVg_1781005172
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E435F1944AA6;
	Tue,  9 Jun 2026 11:39:31 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.rdu2.dc.redhat.com [10.11.142.86])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 81FDC3008B37;
	Tue,  9 Jun 2026 11:39:30 +0000 (UTC)
Date: Tue, 9 Jun 2026 13:39:27 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Steffen Lindner <steffen.lindner@de.abb.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.18.y 1/2] hsr: Implement more robust duplicate discard
 for PRP
Message-ID: <aif7b2qPzEGJx-EV@thinkpad>
References: <2026052838-cleat-rewrite-24c4@gregkh>
 <20260529232406.1883397-1-sashal@kernel.org>
 <20260601075222.hFB8WzTJ@linutronix.de>
 <aifbzVmhiThTVLj7@thinkpad>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aifbzVmhiThTVLj7@thinkpad>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262274-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[fmaurer@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:sashal@kernel.org,m:stable@vger.kernel.org,m:steffen.lindner@de.abb.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDC2065F9B9

On Tue, Jun 09, 2026 at 11:24:34AM +0200, Felix Maurer wrote:
> I don't really know the guidelines around the stable trees. Do we want
> such (heavily modfied) patches so that others can be applied?

I only now saw the patches Sasha posted for the older stable trees (like
[1] for 6.12.y). I think we should do the same thing for 6.18.y as well
and not backport the rather big 415e6367512b ("hsr: Implement more
robust duplicate discard for PRP").

Thanks,
   Felix

[1]: https://lore.kernel.org/stable/20260529233922.1913663-1-sashal@kernel.org/


