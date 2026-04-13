Return-Path: <stable+bounces-235994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOTxAorT3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:29:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D963EB4E0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB35B3039FDE
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159A63C1978;
	Mon, 13 Apr 2026 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="Nu0Z2fK2"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518AA3BD237;
	Mon, 13 Apr 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079525; cv=none; b=MwzzZiW+U/FWeprNyU5/TlwY5kbc09ivs5v+H2E/BI5a/qPpSC5V+TByDkCehriD3kZ6dj8R1brN/z/H2WrsDaye9YM8VJJVNxon3imxMWxuztMaQagJ1Lhomted5q8mMr/f+fHk1LY7kzx3n41zIM79xQ6Fyzf22cwbVX+spbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079525; c=relaxed/simple;
	bh=sBsy7wiURkqL+0vpLzA9Y4+lOXzxczT1/17y/eMNeeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h2NUATqh260RYMoR5ybcL//e1fEMaaYbQvmIeWAkrJD7xPbYBgovyzxd9Z/PMsT0z6mwXu2FV5KYNecPcADgx8lDDUXa90B3twqaGyYSel/4//Bij56BFZB+lrxd4Mx1405cjsIetymZB9AV/ZXecYBldaoB/c1BN+hAHYpjyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=Nu0Z2fK2; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4fvPwk3wXpz44RF;
	Mon, 13 Apr 2026 13:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1776078966;
	bh=sBsy7wiURkqL+0vpLzA9Y4+lOXzxczT1/17y/eMNeeg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Nu0Z2fK2qdcLAra+sPdOu3GnffrczwsWk2/6Ws8yzq/WG0B8868SWtjgb2qjMBquN
	 Gijdw29i5boobMXtZCXobaXET/14kj5Q3M6AGc0NrSucWh43rR6jU3h3oRYZT6LSSV
	 a2zAvLS+lZMp3/fQrtYdhCIlauR2jeeGxe/Smq0C1ueTYL/P+cVU+c/idqhhhKD7+6
	 fqpSGoVp1NRsOYzUwE8cpktmTRRQx4UReYL2e17F/9NTE0/t5dK/k954hI/byOwmXP
	 7URR5jEuWDxFA0nxDQfovWoFo+Bq9orEoDpeOcfAXLTk9qNlqGj5RYO5S6vFqAWtmy
	 L62Xx/7onYOfg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4fvPwk39y5z44NQ;
	Mon, 13 Apr 2026 13:16:06 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fvPwj5GqSz8sgW;
	Mon, 13 Apr 2026 13:16:05 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id ED1D6632D3;
	Mon, 13 Apr 2026 13:16:04 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <e21c9e47-36e2-4f15-a7a5-af239a0abb89@leemhuis.info>
Date: Mon, 13 Apr 2026 13:16:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] failure to reconnect on SMB server restart with
 custom TCP port (not 445): Host is down (at least since 6.6.95)
To: Henrique Carvalho <henrique.carvalho@suse.com>,
 Shyam Prasad N <nspmangalore@gmail.com>
Cc: "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
 Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org
References: <20260310235642.6d9798f4@plasteblaster>
 <c66p7dr6vlujvnwczbnrmqx7monkdgdnm4rwewm76aibn7jza3@d3uik74dei72>
 <CANT5p=q2Lv4pSvEm5EWcM73b7NZsbt1kYEFJtjaAZRS6Gz_OjQ@mail.gmail.com>
 <42utcrhajix2x3feckj7ap373osq65sgfz6ximnaj4rasszret@ymhf44ddz2wh>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <42utcrhajix2x3feckj7ap373osq65sgfz6ximnaj4rasszret@ymhf44ddz2wh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177607896533.133677.5958693862348892053@mxe9fb.netcup.net>
X-NC-CID: p2st6aj6lJATH9pglzrLnOICtj3C/5s4Klt+kHiVVKr+zXdjuRc=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TAGGED_FROM(0.00)[bounces-235994-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[suse.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 70D963EB4E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 16:03, Henrique Carvalho wrote:
>
> Sure, I read the comment in the code and the MS-SMB2 protocol. The
> protocol states that "client MUST ignore [Port] on receipt". Since we
> are not using p->Port, I don'se see how this is a protocol violation.
> 
> We're using the port that was selected on mount and copied over to
> server->dstaddr, so that when server->dstaddr is overwridden,
> server->dstaddr keeps the user selected port.
> 
> Now, even if we only fix that for primary channels, the secondary
> channels will still get the wrong port when they are overwridden, no? So
> I don't see how that fixes the issue.
> 
> Apologies if I'm missing something.

Lo! What happened to this? I saw that Henrique posted "smb: client:
preserve destination port when parsing server interfaces" a month ago at
https://lore.kernel.org/all/20260311160856.635916-1-henrique.carvalho@suse.com/
which looks like a fix[1] for this regression, but unless I'm missing
something (which very well might be the case) it still is waiting for
review, as I can't see it in -next.

Ciao, Thorsten

[1] not totally sure, lacks a reported-by and link or closes tag
pointing to the report. A stable tag would also be great to ensure the
fix is backported.

