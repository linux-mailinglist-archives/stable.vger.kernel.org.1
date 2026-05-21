Return-Path: <stable+bounces-253622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEruAllAD2qcIQYAu9opvQ
	(envelope-from <stable+bounces-253622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:26:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 781B25AA340
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46B6F32C21C4
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FE53B8BD8;
	Thu, 21 May 2026 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="j1tyKYl+"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30B43C7693;
	Thu, 21 May 2026 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779383665; cv=none; b=Q2JhbR/VdZZUkhZOsX7GH3GLOcgjeWUd/QmMbZSqtL1G7nAUdqcQpWdoLdCIVK+/HxyeSLYEcOs+67e1voT9Yytkro22BFxcgiQEC8XhlQ1T5VCHQ+6l2trCcJWbkpL0TZp+jcTRcRuIZbwc4NJuWPUO6T5ZI9PIlIrtqVehndk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779383665; c=relaxed/simple;
	bh=1JfhlI9j9Ev8vm/JRmww/78tVWL7ZzROTXoUdT9ttM8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sypu+dvjaDCHYCNnBLf/0ket1DSHGx+kydWSfJSE7GkaTHLYRXf1HOFm2AS4LGFXvAR9bI4FaLBqNFnbUlUCzlCh2WcrXiuizraaHU0hlqx5Z3EiSEoqYY4kz1t6BghbuxYgr3vmWdZlBno5N7Onr+ffo8Jo7lERqjrhvJBi6yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=j1tyKYl+; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gLw4Q18rGz6DnQ;
	Thu, 21 May 2026 19:14:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1779383654;
	bh=1JfhlI9j9Ev8vm/JRmww/78tVWL7ZzROTXoUdT9ttM8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=j1tyKYl+Q6sDQvzpfpJk9+MGfBdZWHnZIzXfRvjBaKOrQvPJzViUJhx6jb1cM2sHA
	 ukZBDSd7g0qYwkYKj3nLZ5+a/ejwer8Tnjmlv6DmkgL0Q3lSiQbiV+Q8JZUqroNoXa
	 SQ31JX05O7jZCiw7mOjT/9fCVCfAlLije+dwb7uXcYWIC8xnXY3hU2fBwwO5j49/v3
	 caOu96ZGsS+H4cczi4G66e/VhpGcP/DbI+nJtsoNLlrWUJ0GXe6OVAN7CWcM3YQkLI
	 INo+/kfQUUQWrgdiHLJAXog7/o6TCTjB/aa2IJMj+vA4bYfqipxVF1QEhS2wJzwzEL
	 +dMACApiUKJCQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gLw3s24N0z4xVY;
	Thu, 21 May 2026 19:13:45 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gLw3r07b6z8sWT;
	Thu, 21 May 2026 19:13:43 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 4BFF761835;
	Thu, 21 May 2026 19:13:43 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <d5495e4c-7fc1-4747-a876-3adb27a13537@leemhuis.info>
Date: Thu, 21 May 2026 19:13:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 August Wikerfors <git@augustwikerfors.se>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh>
 <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh>
 <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh>
 <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
 <e666c332-e2aa-4525-a208-a4a08742d2e0@augustwikerfors.se>
 <2026052026-barber-espresso-1d9a@gregkh>
 <CABBYNZJ4woc+unpYN6_dzMLtxhFVUd5+ccv2+EQbDMkYuXQ12A@mail.gmail.com>
 <2026052047-silica-grub-0bb2@gregkh>
 <CABBYNZKnrqHyASMOah795i9eteY7S5AfN3tCWssSRgqBXZwRMw@mail.gmail.com>
 <CAHk-=whwq2_iaf7pTuzVXEcJmng_exwae_bKtgSDdm4BQivGHg@mail.gmail.com>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAHk-=whwq2_iaf7pTuzVXEcJmng_exwae_bKtgSDdm4BQivGHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177938362370.2111016.2361743921988470192@mxe9fb.netcup.net>
X-NC-CID: 9iTMYurzv0DZJzvTeWRcZIDP+x4QYv4LApIwPs2dxn/9YprpU54=
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253622-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,augustwikerfors.se,vger.kernel.org,kernel.org,davemloft.net,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,leemhuis.info:mid,leemhuis.info:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 781B25AA340
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 21:32, Linus Torvalds wrote:
> On Wed, 20 May 2026 at 08:53, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>> Just never rebase any public tree please.
>> I guess the alternative is to do merges, right?
> No. Back-merges are bad too, unless they have a really damn solid
> reason for them, and some "keep up with other peoples work" is not
> that.
> 
> The primary model should be that you care about your own work, and
> make sure that that is as stable as possible. Do *NOT* try to chase
> other people's work. Not with merges, not with rebases. [...]
> [...]
> Sometimes you have to rebase because of a mistake. Sometimes you need
> to do back-merges. But you should damn well have *reasons* for both
> that aren't "that's just how we work".

Speaking of mistakes, one happens occasionally that you afaics did not
cover here. And it's one where I'd be interested in your opinion (and
maybe Greg's from the stable perspective, too):

How to deal with cases where one fix was merged to a public -next branch
for merging in the next cycle (and thus was mixed up with many
non-fixes) but then turns out should be mainlined this cycle?

I notice such situations a few times per month. I just had exactly that
case for a patch fixing a 7.0 regression. And the answer I got was round
about "sorry, the fix is already in our -next tree, we thus can't merge
it this cycle"[1]. And that seemed wrong to me, which is why I argued
for cherry-picking in that case, but it seems I was not convincing.

And yes, I understand that cherry-picking causes pain (especially for
the stable team) and thus is best avoided -- but mistakes like that will
always happen, so it might be best to know what to do in that case.

> [...]

Ciao, Thorsten

[1] it's for a regression introduced in the 7.0 cycle:
https://lore.kernel.org/all/29a93dc3d9d24b3a809310694ffc5d34@realtek.com/
-- the tree in question afaics is not even in -next, as I can't see the
fix there

