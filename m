Return-Path: <stable+bounces-219931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFePKkVSoWkfsAQAu9opvQ
	(envelope-from <stable+bounces-219931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:13:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 506321B450E
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 09:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17E2E301AAA1
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D844E37C0FB;
	Fri, 27 Feb 2026 08:13:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88A036D4E2;
	Fri, 27 Feb 2026 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180031; cv=none; b=sIsEzePwoWRd805ppsf9KoxQgF0O1svytMAFbTr5q68zVedUc2v91NhMVz7CBBzIWWMMMfC8HXqH3gZHpLmr9wyWvj4NXaoxH9Ne6ruOrN1+aMlUpaH1QIyIA3V/BwdcZEijGczCFBmbh/msdJ4FK5ouFVb4i/zBDakK8UysvKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180031; c=relaxed/simple;
	bh=TZeE1/AQsZ/MM1GeMaZlFeaNItZ/Cit9CPL7hTpqKS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIR4iYaD7QA0DLT270XtnqokYITmOqZ6MiSKe/4B2W1UQqAtw20sgQe/LUXY/+twHwJ7M3JrRzZ5KXaMcKeWaTAEc2QHbbwOyYg0ZFYOTyf7vJvXmQGOfOpV7zAx+7JEyydE5DihtKg5zYrwXkEWLU8bArknWXSZA0P/Emw5Gjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7844660336; Fri, 27 Feb 2026 09:13:46 +0100 (CET)
Date: Fri, 27 Feb 2026 09:13:46 +0100
From: Florian Westphal <fw@strlen.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	regressions@lists.linux.dev,
	"Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Subject: Re: [REGRESSION] 6.19.4 stable netfilter / nftables
Message-ID: <aaFSOkhkjowYB2YJ@strlen.de>
References: <a529a6a9a2755d45765f20b58c5c11e2f790eacb.camel@sapience.com>
 <45f03b0b-fe8f-4942-bad1-3fbde03d4be1@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45f03b0b-fe8f-4942-bad1-3fbde03d4be1@leemhuis.info>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219931-lists,stable=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 506321B450E
X-Rspamd-Action: no action

Thorsten Leemhuis <regressions@leemhuis.info> wrote:
> On 2/27/26 04:46, Genes Lists wrote:
> > I have a problem with nftables not working on 6.19.4 
> 
> Thx for the report. A problem that from a brief look seems to be similar
> ist already discussed and was bisected in this thread:
> 
> https://lore.kernel.org/all/bb9ab61c-3bed-4c3d-baf0-0bce4e142292@moonlit-rail.com/

Thanks for this pointer.

Can someone check if 'git cherry-pick f175b46d9134f708358b5404730c6dfa200fbf3c'
makes things work again post 6.19.4?

Its a missing indirect dependency.

