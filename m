Return-Path: <stable+bounces-262237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HP5fBLXdJ2qM3gIAu9opvQ
	(envelope-from <stable+bounces-262237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 11:32:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FDE65E5D6
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 11:32:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TUQ9h22h;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262237-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262237-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 344DA323C01F
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69226382373;
	Tue,  9 Jun 2026 09:24:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA0E2EEE99
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 09:24:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997083; cv=none; b=F7q1Fpg6H4W6U+1w82cSX+iGyxNWlv1U15XVzTcPhoMOA8WicsRNWDCjm7Cta3K5pZmMoEXL9kmszeOsKMUQFbR0rdNouN3sRa9QhDvE5gG7iH/W3TMM7C16Mo6b4QJzY9bQbsbX+cLwUJry4zk3ToBSyvKY5CgdgrbcsWeL+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997083; c=relaxed/simple;
	bh=hK/NM8PZF9R3IBwEAIWhX+J5Ev2FbPBzI086itUNPRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZD8gUW0uHrSHMAdUtEqNW8LNLWO4ePrkcPeWJilYwHPkk72TPz+53qpx4sb2aK1C7PzKP71cdoofedjR7qlTmbR4sl6SHyV/Cn8p4hHmebAZcntiEeID1nknaJY9T19RQ7KQZbNREbY5s2f/1oVk0+OoJ4662qxS94VeM2VEGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUQ9h22h; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780997080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bn+yJ4BX4ZExpc5KrxMHHLRqVjpa5d+xcR5uDhhXkfQ=;
	b=TUQ9h22hVHvJAFNdB+iJrmZmEfoZIb4VNwXgzD64KwEvFY5MEgHPxy4DAQnMG/T/AxDCHb
	AuF2bvCP08eFteM6iAqEZ5BHDZ5o0y5Qlz99KuIsaBdVYZ0BnLATtgwP/fGZpsM4ysYN3E
	hhYmd273bBwON7Q8lD9W/OyF5C0yq2o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-gqi3h2XpMFC6IB5S6261_g-1; Tue,
 09 Jun 2026 05:24:35 -0400
X-MC-Unique: gqi3h2XpMFC6IB5S6261_g-1
X-Mimecast-MFC-AGG-ID: gqi3h2XpMFC6IB5S6261_g_1780997074
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4089318501C5;
	Tue,  9 Jun 2026 09:24:34 +0000 (UTC)
Received: from thinkpad (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6F9A3653A;
	Tue,  9 Jun 2026 09:24:32 +0000 (UTC)
Date: Tue, 9 Jun 2026 11:24:29 +0200
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Steffen Lindner <steffen.lindner@de.abb.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.18.y 1/2] hsr: Implement more robust duplicate discard
 for PRP
Message-ID: <aifbzVmhiThTVLj7@thinkpad>
References: <2026052838-cleat-rewrite-24c4@gregkh>
 <20260529232406.1883397-1-sashal@kernel.org>
 <20260601075222.hFB8WzTJ@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601075222.hFB8WzTJ@linutronix.de>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:sashal@kernel.org,m:stable@vger.kernel.org,m:steffen.lindner@de.abb.com,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmaurer@redhat.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262237-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linutronix.de:email,abb.com:email,thinkpad:mid,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73FDE65E5D6

On Mon, Jun 01, 2026 at 09:52:22AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-29 19:24:05 [-0400], Sasha Levin wrote:
> > From: Felix Maurer <fmaurer@redhat.com>
> >
> > [ Upstream commit 415e6367512bf8faca93eaaf46fbe23d841b4509 ]
> >
> …
> > Reported-by: Steffen Lindner <steffen.lindner@de.abb.com>
> > Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Tested-by: Steffen Lindner <steffen.lindner@de.abb.com>
> > Link: https://patch.msgid.link/8ce15a996099df2df5b700969a39e7df400e8dbb.1770299429.git.fmaurer@redhat.com
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Stable-dep-of: aaec7096f996 ("net: hsr: defer node table free until after RCU readers")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> This is sort of big. It should not introduce any regressions and if so
> we need to fix them anyway so early exposer might be good. However
> aaec7096f9961 ("net: hsr: defer node table free until after RCU
> readers") should be backported down to v5.10-stable so I wonder if
> taking this huge patch is economic for this two liner fix going down the
> road.

I agree, taking the big commit above down to v5.10 probably isn't a good
idea, just for this fix. It should be easy to build a small version of
415e6367512b ("hsr: Implement more robust duplicate discard for PRP")
that just has the changes needed to apply (a slightly modified version
of) aaec7096f996 ("net: hsr: defer node table free until after RCU
readers"), i.e., the changes that introduce list_del() and thereby fix
that the nodes were just freed before 415e6367512b and not removed from
the list at all (which would be another UAF). That should apply to 6.18
and probably to most releases below as well.

I don't really know the guidelines around the stable trees. Do we want
such (heavily modfied) patches so that others can be applied?

Thanks,
   Felix


