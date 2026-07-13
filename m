Return-Path: <stable+bounces-273586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z0HmGnqQVGqSnQMAu9opvQ
	(envelope-from <stable+bounces-273586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 09:15:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AFF747E9B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 09:15:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=QXkWykl8;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273586-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273586-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3F7A301B171
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 07:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4886235F5ED;
	Mon, 13 Jul 2026 07:15:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0652836A0;
	Mon, 13 Jul 2026 07:14:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783926900; cv=none; b=LD/vnxJIj7VziLc1DNEnIGxyCEzLW1vz8Ppif3pEluwhVne2GNxvd02Pt9KhXwonpl4ZsCEAjYf8zJGwGLVLyfpNBJ8oXB5ZA25vKddsNjcwtWsqJNtgDX+KPCxUo3iTDm0zpcg8w8y7Fl7y66m5PIpHjjDSistJq5PB4d67bS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783926900; c=relaxed/simple;
	bh=ft5/eljShbuYhVYHfb0X4qATRaHxv9WlJJ3lqFQIN2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lux58siNrdcTRCq72KYQLMwaPpLvsR+k+UVhkH/hOZEHCK9HT7OYJUOlKSV4zxOeMdoa1OLUbdIURATZQcz1OfOi89d90ShS2Oh48VbZQhnVNZeIrQhWAWeOfAqC+IYr4y3tj+/9cpHtE9qdqYiknvl4vIWeykAQNMEYMt3gJ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=QXkWykl8; arc=none smtp.client-ip=188.68.63.162
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4gzDFF2YLdz41mt;
	Mon, 13 Jul 2026 09:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783926833;
	bh=ft5/eljShbuYhVYHfb0X4qATRaHxv9WlJJ3lqFQIN2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QXkWykl8hifEgutAY/lzyn35YKVwZWQWF3ZaqD7dFUropywiLUD+NzTU9FbrMS8Gb
	 N7TxJzsyM0rLg1s/N6S+evPSuSWcZKd3S72/5H9dIgpUVrYW9zJfbJ/NJReuVi0hiA
	 ZEdzy7+Yr2Yn2lwb9NaTOuQbP8Q03XImk0jOy1ds6DrsPXaCFjrUwgbNgeJU2W9foc
	 IeTnObDohuNHv8HGeUgcPfb760bwn+7YdwIoW7B5laHHhvYjg6ZsQPAN7SCUtJNtAk
	 XCKUKycfalhsqa+m1pOL8dSc8Pd5aec/KxZiGCDjsJndw0jrSY8Hn+zQwBmHhsLsgy
	 IClFEYaqTfVJA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4gzDF31rC6z41vC;
	Mon, 13 Jul 2026 09:13:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gzDDz3Vhbz8tbl;
	Mon, 13 Jul 2026 09:13:39 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 81FD66041D;
	Mon, 13 Jul 2026 09:13:31 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ae5c29aa-3790-479a-bdfb-1b571eaab809@leemhuis.info>
Date: Mon, 13 Jul 2026 09:13:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend] [regression] amdgpu carrizo: no display signal after
 modeset
To: Dianne Skoll <dianne@skoll.ca>, Jaak Ristioja <jaak@ristioja.ee>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Salvatore Bonaccorso <carnil@debian.org>, Chris Park <chris.park@amd.com>,
 Matthew Stewart <matthew.stewart2@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 1139950@bugs.debian.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <9fba2020-24d1-4235-9869-319d4aab3a4c@ristioja.ee>
 <178198613176.3658222.16247101620976737948@eldamar.lan>
 <ajcLuO0YZCoPN7Xw@eldamar.lan> <e4f60b98-9bd8-491a-9703-a5a7a58a4ca0@amd.com>
 <82b5026d-2dcc-4dcd-9094-2ccf70057964@ristioja.ee>
 <6cf6be99-76c3-43b3-854f-96cae180318c@ristioja.ee>
 <20260622153449.453b493e@gato.skoll.ca>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260622153449.453b493e@gato.skoll.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178392681229.3442660.9578169747564647640@mxe9fb.netcup.net>
X-NC-CID: MzLG2tZMKB/ADR25837MhEmuu9VJVl40ek1ivkRoK5XTXQ/26lE=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273586-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dianne@skoll.ca,m:jaak@ristioja.ee,m:mario.limonciello@amd.com,m:carnil@debian.org,m:chris.park@amd.com,m:matthew.stewart2@amd.com,m:daniel.wheeler@amd.com,m:alexander.deucher@amd.com,m:gregkh@linuxfoundation.org,m:harry.wentland@amd.com,m:sunpeng.li@amd.com,m:siqueira@igalia.com,m:christian.koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:1139950@bugs.debian.org,m:regressions@lists.linux.dev,m:stable@vger.kernel.org,m:amd-gfx@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.freedesktop.org:url,vger.kernel.org:from_smtp,ristioja.ee:email];
	FORGED_SENDER(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[amd.com,debian.org,linuxfoundation.org,igalia.com,gmail.com,ffwll.ch,bugs.debian.org,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68AFF747E9B

On 6/22/26 21:34, Dianne Skoll wrote:
> On Mon, 22 Jun 2026 20:46:44 +0300
> Jaak Ristioja <jaak@ristioja.ee> wrote:
> 
>> Reverting commit fee50077656 ("drm/amd/display: Bump the HDMI clock to 
>> 340MHz") on top of v7.1.1 appears to resolve the issue, as I am now able 
>> to get a picture.
> 
> Unfortunately, reverting that commit will *break* it for me with my Dasung
> E-Ink monitor. :(
Jaak, was this ever resolved? It looks like this fell through the
cracks, but maybe I missed something.

If this is still unfixed, I think it likely is best if you report this
to https://gitlab.freedesktop.org/drm/amd/-/work_items/ if you haven't
done so already -- I suspect that is more likely to get the attention of
the amdgpu maintainers. Please drop the link to the ticket here after
submitting the issue.

Ciao, Thorsten

