Return-Path: <stable+bounces-223846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGloOYzrr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:59:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8325A248F9E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1819F309326D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3625644CAFB;
	Tue, 10 Mar 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHC9I1dC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B7144D685
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 09:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773136322; cv=none; b=KeX0I5A7FFA+K9brscAo9fM2wrSezY+Uqu+j7MCxWiaFicIfobMbKsvQYdoWxMGf/J1rl4na1XKpDAriO2isngIDmxa51h2RfmPL3jVnh4iOQMDlf2zFHma2o61VpS9zlvZk4fpQfAgB8cRyGBSqm1qKVqEXJ8wV3kCf4aNNFTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773136322; c=relaxed/simple;
	bh=8ysz94gib4MN0k3nl5PPYgdRJBfMJOzqmlFpZ18fESM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJfLc1fGS90aCU6MsVfOQoKL3G/akZ7tpNFdbzciNP3GYtsSbfShBtPcu8LVMxW0rQMnlBqtSJ6RzvRn8B91YJgiKCCZ3Qa6lFq4Pipy45rYLLpd2wigT+43KPJF8GxqnjWS9LoAv3X0H6kkYwa0QkzqEA4sCWNVph9g9MQLO2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHC9I1dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9360DC19423;
	Tue, 10 Mar 2026 09:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773136322;
	bh=8ysz94gib4MN0k3nl5PPYgdRJBfMJOzqmlFpZ18fESM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vHC9I1dCFfL9Y4CseLhfg6SY9WxTe88WXMnVvkIrT/7GDZ1pQ+vA3NV+snMTjwmiP
	 Rhp+h45ydL84Hx8EcGRsuqwnEbT0oaJATK2uU3sxiuTDOLvLITqA1cPaa542lBZ3ki
	 KMlsqCBA+RFbPmMrDMc9iwo+m0rAh4coJ04N6dQN5YcN0ZaZqpYHXzZBf5QoAQih/L
	 ALQmt6sl55G5KNX1YJBteu/+q2X5eseGQ9oqTtJitGXFrkW3TmTTqAibJjwxogCSts
	 2F9h3iLOY0HZBJeKQFvMbYa713Rpzo94DNmLb/pF7dgxOKhuHAGd18Lbsjh/uu28h9
	 woviAaCmuSH2g==
Date: Tue, 10 Mar 2026 05:52:00 -0400
From: Sasha Levin <sashal@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: stable@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: FAILED: Patch "mfd: core: Add locking around 'mfd_of_node_list'"
 failed to apply to 6.12-stable tree
Message-ID: <aa_pwNNEtfaOxkHW@laps>
References: <20260301012249.1679321-1-sashal@kernel.org>
 <CAD=FV=XAGzoRaA2bFT3X=eqiMR93pSUkXyTQk6euzhUR+fUY9w@mail.gmail.com>
 <CAD=FV=XpJE-UkJEH9QrKA3P10h70=+vDuF6gc9xmZroyYKzx9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XpJE-UkJEH9QrKA3P10h70=+vDuF6gc9xmZroyYKzx9g@mail.gmail.com>
X-Rspamd-Queue-Id: 8325A248F9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223846-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 03:50:33PM -0700, Doug Anderson wrote:
>Hi,
>
>On Sun, Mar 1, 2026 at 7:01 PM Doug Anderson <dianders@chromium.org> wrote:
>>
>> Sasha,
>>
>> On Sat, Feb 28, 2026 at 5:22 PM Sasha Levin <sashal@kernel.org> wrote:
>> >
>> > The patch below does not apply to the 6.12-stable tree.
>> > If someone wants it applied there, or to any other stable or longterm
>> > tree, then please email the backport, including the original git commit
>> > id to <stable@vger.kernel.org>.
>> >
>> > Thanks,
>> > Sasha
>> >
>> > ------------------ original commit in Linus's tree ------------------
>> >
>> > From 20117c92bcf9c11afd64d7481d8f94fdf410726e Mon Sep 17 00:00:00 2001
>> > From: Douglas Anderson <dianders@chromium.org>
>> > Date: Wed, 10 Dec 2025 11:30:03 -0800
>> > Subject: [PATCH] mfd: core: Add locking around 'mfd_of_node_list'
>>
>> Can you give any more details? I tried:
>>
>> git checkout v6.12.74
>> git cherry-pick 20117c92bcf9 # ("mfd: core: Add locking around
>> 'mfd_of_node_list'")
>>
>> It seems to apply all the way back to 6.1 cleanly. NOTE: I didn't try
>> building with those older kernels. I can try if need be.
>>
>> -Doug
>
>FWIW, I checked and v6.12.76 has the patch. So does the top of the 6.6
>and 6.1 stable trees. So I guess this was a false positive report?
>...or maybe you tried to apply it twice?

Nope, it was an issue with scripts on my end. Nothing needed for those trees :)

-- 
Thanks,
Sasha

