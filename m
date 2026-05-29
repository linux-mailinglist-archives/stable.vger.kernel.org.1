Return-Path: <stable+bounces-256653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMZ1EL6+GWq0yggAu9opvQ
	(envelope-from <stable+bounces-256653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:28:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D06E60597F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 18:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EEBA3001FEF
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4223DA7F5;
	Fri, 29 May 2026 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xjlGjQBm"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C823469F6
	for <stable@vger.kernel.org>; Fri, 29 May 2026 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780072123; cv=none; b=pjZrXpMJ4YCymZG79rqM8kI5VHrxU35Lw0DkDQMLE4ZIZTAxMH4+PFsEhUujMvoNgO5MIrVTKATcSwTAqqRh/YKBo2UirzT9NMqEtTfAM6zHXMzJSGSX0PlvQAKBtMp5A+yQ8X8qxayxmHrZzcMa6uVVI0xSNvZaB7q9uEt8sIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780072123; c=relaxed/simple;
	bh=gJT3raIRjb+4PiHI6wkOCTwp3cpNLe0MfnR4Z0jMrqY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iyjlIArMI2gC3GnSUTnrzHuEh30NfuYbj53MQ/txsBvBsJHmTOEkM5vhyNThq91xbFALjhqH9hhFmeU/6nYtG2KlbKblZrcvCxTFQXe8d8yIYTWd1IgKnLK5C/4wbILe6/Un21GPR7F9DmX3j395Hldws58yDiOhsx6yCnSGKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xjlGjQBm; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780072118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gJT3raIRjb+4PiHI6wkOCTwp3cpNLe0MfnR4Z0jMrqY=;
	b=xjlGjQBmKF5y84uYtAsFejFz5qjru1Isy5d6nhq/A7noCKI7NCMWs/WO3MeY8Ja6AgTyan
	CCBovkPp+npAOWibn6+0DL53HXD6seuSPEgMKo17SDe4INqz9+uQDXmyKjdOpq9xOoWLcF
	4ALbbELDM3PVa+dcwtEmJvyWa9sWRZg=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 16:28:34 +0000
Message-Id: <DIVAWG4YOJEE.31U4C9AB96AIK@linux.dev>
Cc: <akpm@linux-foundation.org>, <chrisl@kernel.org>, <david@kernel.org>,
 <hannes@cmpxchg.org>, <hughd@google.com>, <jackmanb@google.com>,
 <linux-mm@kvack.org>, <mhocko@suse.com>, <mikhail.v.gavrilov@gmail.com>,
 <npiggin@gmail.com>, <ryncsn@gmail.com>, <stable@vger.kernel.org>,
 <surenb@google.com>, <vbabka@suse.cz>, <willy@infradead.org>,
 <ziy@nvidia.com>, <melotti@google.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in
 free_pages_prepare()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Li Wang" <li.wang@windriver.com>, <sashal@kernel.org>
References: <20260301013838.1699247-1-sashal@kernel.org>
 <20260529050231.1849697-1-li.wang@windriver.com>
In-Reply-To: <20260529050231.1849697-1-li.wang@windriver.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256653-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,cmpxchg.org,google.com,kvack.org,suse.com,gmail.com,vger.kernel.org,suse.cz,infradead.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brendan.jackman@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D06E60597F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 29, 2026 at 5:02 AM UTC, Li Wang wrote:
> From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
>
> [commit ac1ea219590c09572ed5992dc233bbf7bb70fef9 upstream]

Thanks Li!

Sasha, this version also applies to 6.12, can we apply it there too?

