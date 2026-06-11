Return-Path: <stable+bounces-262609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aKkwN/EyKmrSjwMAu9opvQ
	(envelope-from <stable+bounces-262609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 06:00:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C4466E1BC
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 06:00:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mFyMNwu1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262609-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262609-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=debian.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04DCF30799D3
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 04:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D28D331ECF;
	Thu, 11 Jun 2026 03:59:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263333A711
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 03:59:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150399; cv=none; b=X1+KRZabKVyqSgEilr5WpkKmQB80SHaGE+LeYB2eHb7ih6uf/eWD9kaJkhLzejPlKR/vmVvbrr4IKqlDwpXP1Q0q4oT7TfOoBpLMMPwWucQOFHR5E+PhRkW1fz6X8oQDiJNqiq6GB+w/Eb1JbmMCdZ1T4LFtRJuXuLfKMzMN9Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150399; c=relaxed/simple;
	bh=nHF9LM8burr1lsSdRpM1P3HYYhnScoG75MzY96OVd0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gk8Cmxw0yrrNYBHzu9VnlikPCGI+uR5S2hWv8oCG2smvngHeuL5I1BR7MbRRzKnvDmzlxg5FjyQ8pGYbBlEsojSF1wewumd1yFXued03XLfXFGZpRlMLZj9rlgJn14FZKVhJ0HBpRbDAw5obunXJdlcg+sFwNN4eyF4W6qlo/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFyMNwu1; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso86089895e9.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 20:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781150394; x=1781755194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3S0Q1kzf05akPzeu5LM91RiWi2C1eOHyWy39OHCceE=;
        b=mFyMNwu1DmVYXksCRSJ+x+yHbJowy0MZiOBZ/yZnrPl5SMOvrKt7H2OnWciGQlU6Fc
         Sx/1UkLo35tSad4fFhVMSlsPMBEE7qtAfwQHQ+UL8rjf8TJbO6/9vwkMcWpvvp5p2HRJ
         VlelbLKRE1k6EfrmqIQzcwOVStL/JcrvA0xz8Bed3r79Rkes0u5edmOJmLITa0tOpV+H
         yKO1K0ah8cqwHMSF5mNNUbINsXd5qKkYrICvSQ9eR5+J6fghwNCp/VlGvUODThuZwfyu
         5waEkjUOZ5d8C64ONDSYbS905l5sC/G5vadqw4Zuc1ty7zN+7KKBm+M/O1fc6GobqkXz
         F6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781150394; x=1781755194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E3S0Q1kzf05akPzeu5LM91RiWi2C1eOHyWy39OHCceE=;
        b=jxAPaL9GGpJt0Suz/0U8aHrBSU3BE7hyYGI5pGabzkt0bzKn1TBs1OE0QuMhD10aM9
         IBKTJRkcEtj9Ecs2zhtDeWSOp5dJp8nXlq3FIwKXKy88XRWLjgGcObGSwTezBwR1bhoC
         JiK7ER97qC46PEJ45vx9YSJEde+kFE0zPSyI1nf2NZaiq9aTO+NGF+Zoex5MujngjBoy
         zouXbjQ1QQYfjZGadh4cOA7epsLIlBMlPCjnrQRNpdggVsT7kUSvq8sPbihWJ5sdIjOm
         eEAB9wy6S7JKRjHY5C4w6H7pPa6LZQSbQDXUm1vBLFlfxrdk4BSe5PFGaX7/RoU5PoO1
         iRWA==
X-Gm-Message-State: AOJu0Yxopzxb6Mung7Z1Q3iENYskLMqI+nMiEXhoFLFCVge5VNMYw7dN
	00P/8fElisdIa9qHIkpTNZ8I69q2rA5l46iGndtohPG4nC51tbGKDLxo
X-Gm-Gg: Acq92OF8yhXrTj6Oy7Ge4H55hcIHYSy69ujIY2R//jTtJ2+2Rhhj0M7bmxdS8pFIgJP
	/MlYIfCFEamEeRyE2gFoL3MU/uhcnYX40tJy7E8Povxt/q7LMn1VMHdl3vQL5KsdQQgtXWp1H5V
	LCOdjj9m2GU/AS1QhmFAh0bYwe/5wl3w47UcT4Al2jBp2YyAaWOM8uHkBx57e0DGyjaaf0eYVrC
	m10vHMoyPVnbt5BVvqUxtKK6MTWTriwtTg6LIIWR4oZN2o5tkJLKnNsr/2daWodbXpjE20C0gjD
	l9irFkVl1Y9XdgWp14XQaF0cRI13klnvFAJoDBa9aXzdVXbcu3bUcvJXlsTT0qgVzqnsWwhE5PV
	N99UaqdfY51dzDqV+7dkClpHAx9ePGZ22ZyacR5PFGIXV/usv6mKQXMzeQVycoiRXOVTtibtRNr
	ZSHst0a2HgdZXohAV4Go4zOW0J47yqlkBCN20wQpE4gZGa0hXUlPhOdulxIIbcYxscx5R0LZ0GN
	OaSESyt
X-Received: by 2002:a05:600c:a013:b0:490:bd66:e526 with SMTP id 5b1f17b1804b1-490e5645531mr6940695e9.32.1781150394169;
        Wed, 10 Jun 2026 20:59:54 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm133807643f8f.27.2026.06.10.20.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 20:59:53 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 11B86BE2EE7; Thu, 11 Jun 2026 05:59:52 +0200 (CEST)
Date: Thu, 11 Jun 2026 05:59:52 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Minh Nguyen <minhnguyen.080505@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Please apply 98d0912e9f84 ("net: skbuff: fix missing zerocopy
 reference in pskb_carve helpers") to 6.1.y
Message-ID: <aioyuCnSKlch1wdv@eldamar.lan>
References: <aihmk7GjOP0e0miV@eldamar.lan>
 <20260610-stable-reply-0009@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610-stable-reply-0009@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262609-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,gmail.com,google.com,redhat.com,decadent.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:minhnguyen.080505@gmail.com,m:willemb@google.com,m:pabeni@redhat.com,m:ben@decadent.org.uk,m:minhnguyen080505@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[carnil@debian.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carnil@debian.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82C4466E1BC

Hi Sasha,

On Wed, Jun 10, 2026 at 08:45:25PM -0400, Sasha Levin wrote:
> On Mon, Jun 09, 2026 at 09:16:35PM +0200, Salvatore Bonaccorso wrote:
> > Please apply 98d0912e9f84 ("net: skbuff: fix missing zerocopy
> > reference in pskb_carve helpers") to 6.1.y
> 
> Agreed this is needed. It's already queued in the newer trees (7.0,
> 6.18 and 6.12 all carry it), but 6.6, 6.1, 5.15 and 5.10 are all
> affected and still missing it.

Yes I know that, sorry my wording in the backport request was not
quite optimal to understand. I knew it was already included in 7.0.12,
6.18.35 and 6.12.93. When looking why it was not picked for the older
series I noticed might just have been the context change, which I
tested down to 6.1.y and proposed the adjusted backported commit.

I realize that the commit for 6.6.y needs to be as well slightly
different.

What I have *not* done was to test if it goes clean as well back to
5.15 and 5.10. It will need likely more work as there is no
net_zcopy_get() in 5.10.y.

Sasha, do you want me to send as well an explicit 6.6.y one? Or will
you pick the change already for 6.6.y and 6.1.y? 

Regards,
Salvatore

