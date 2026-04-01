Return-Path: <stable+bounces-232862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NBROPCKzWnFegYAu9opvQ
	(envelope-from <stable+bounces-232862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:15:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 171DD380885
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 23:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1F2E30160FD
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 21:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7533B27C7;
	Wed,  1 Apr 2026 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Dw49uwFn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sr1ihcoD"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B498531E822;
	Wed,  1 Apr 2026 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077914; cv=none; b=CC03IZ58/rKNeypvFm/ELftqBVEAbrOoDcsZqITNHsSZS8gfpQj7te7Kxet8DBdpbZq1otIaqdU2du8ZSxbxzjAne8cIjZiE4Wt3p45XjOZRSBNv+EvP2o8urC4l1atssSVytvx0pt20KdyICaLm8vet6zG0JHmKF1UBd60ezjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077914; c=relaxed/simple;
	bh=oVLbWyHiwMgG7ijGJnb7xtyEk3cjMrK18ZH2zDgAi1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWdSM/FaVjdhIpJah1O7TDPHOr/bSS2zVrZv1uFaWB7febJt6w4HRyKCwc0MgsxlzKmOLc+5kJVNCCxCSbACOw5IsAXqwLvWJ6yVW9Xqzcdkmmgs6jVXICoEXACFiEWO6F3BljS/9Iy5EuHPCToQ/xw0Z6PGrG2eoH/c/FzhtPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Dw49uwFn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sr1ihcoD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CDF4714000AD;
	Wed,  1 Apr 2026 17:11:51 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Apr 2026 17:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775077911;
	 x=1775164311; bh=vzO1YrunbG+qyN+RAAWHVxTL97ftzBbUdCL2rIlpQa4=; b=
	Dw49uwFnGdS0voW9XXbIobCqHRHkDnu9GPZBT2bk95XupzvUu0Ooo+fR7WWFggu5
	E2Z8uJTWkbUdqWXKtXmpXtmT2Oo1pTGWj11yZLGJytKnI6M2tbny0FrezZxyIiJx
	28c2HmagtjF/scdfqUa+1Xi8GZPCjtHqW4YqbH6HibD9Ah8sBxjyWNBleuWedVps
	d48KmO+mRRQsQQb1Gut1FV9fCSvZYymY3E37/jKWSCKNSGwrvgWFLOEFb5ln9BcN
	ERE2JnGg6Z71sM9c//8rzZstUQsZQtC6zj/Retf2ViEkXS3PedHuEO3lad7/e8VK
	jy8Pveq4EnS7deWdt+1zNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775077911; x=
	1775164311; bh=vzO1YrunbG+qyN+RAAWHVxTL97ftzBbUdCL2rIlpQa4=; b=s
	r1ihcoDPf6MdphMR0PI2RyE7BTC7YtKErk444NFkeBzvs0kD2HfF4wcUD9jZ6Rdr
	/PQ3K8kV3EnpwVQkQ5Hp0LRrSc8iYlmT1qiz9XYkA42EDR6zSGpVit6u4E+Y7WLE
	HQPXiy6c45CzdBw83fEoRTp5CpVgXbUSremczK4JT+82QbEhf5D3RacjF5eYYtkJ
	n3q9kuiXf0mv3pCVIREhzN/2fLddQuS7WEpp8Rm6XQ/sZW9KwsENOKaeFCawsvYf
	3dWX8x4d/hrfzYBE/Jfx23tVzoD5llB9DbOklOS0sotFNh3ZU47swm7fDtiL3qO8
	O+rI1IscD7W2SGZ21Wkqw==
X-ME-Sender: <xms:F4rNaSNuz3dSmnbjOAEHYUoXRMrNkFcGoTBMhPZzrhVEPFcxolIxig>
    <xme:F4rNaSeBKsgKMSeNr_zvHMIJiq9jx-SpYopCnhPQzUTj-C4prj0iMCs3GY7eJeY78
    Pgr8fi7mZxJ_FuhgmGI9E_zV-wk5ZJLBG1eIEWtf8B7r9qAa4cV>
X-ME-Received: <xmr:F4rNaZXEK4FThLcGMuWJyQOmsXGN_SUBKOLWDpxnE6Yv_66SbHhqkZ4a3pqAEa_qhL2GhjwtcgKXLn2V5cDpSVrFWSunRlFi_wUG05dNJNtDQq6AQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhguucfu
    tghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrghtth
    gvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheeflefg
    vdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvg
    hrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomh
    dprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhi
    nhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhsghirhht
    hhgvlhhmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:F4rNaSjrmMW75fPGtbE-ajDAYeeLATX5A7OSHGwsG6TNsrCMRdF5TQ>
    <xmx:F4rNaQ9Ye1SQeW-m15tzT9YjB1BvV8_lwcT8s6x0FvUU99PBHMyLiQ>
    <xmx:F4rNacY55_AIgCVD1k04o4fmb8rOWjpQ8VDuMM8CYIRwURkbM-zbwQ>
    <xmx:F4rNaf3Xpo-9_L1FXogQ1KYm8FrqVSnn6Ckz5cBeMYZ33ykrUnsWWA>
    <xmx:F4rNaSvXWzIk_YU7V6pL_xc1-oDnRgv-eU8z3J6nc7dNTLUSGV8nSAFr>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 17:11:50 -0400 (EDT)
Message-ID: <33b0c367-d1de-470f-8e26-4c66a54cf48a@bsbernd.com>
Date: Wed, 1 Apr 2026 23:11:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] fuse: fix io-uring background queue stall on request
 completion
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260401184915.747714-1-joannelkoong@gmail.com>
 <278724ec-0c5a-4b3b-b4d7-c5a3c0ceef3b@bsbernd.com>
 <CAJnrk1bH2_hk=mfbk0Ac+9UQV7bPHuD9CseWDhj623um7NmdgQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <CAJnrk1bH2_hk=mfbk0Ac+9UQV7bPHuD9CseWDhj623um7NmdgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bsbernd.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bsbernd.com:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232862-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bsbernd.com:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernd@bsbernd.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bsbernd.com:dkim,bsbernd.com:email,bsbernd.com:mid]
X-Rspamd-Queue-Id: 171DD380885
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/1/26 22:35, Joanne Koong wrote:
> On Wed, Apr 1, 2026 at 12:49 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
> Hi Bernd,
> 
> Thanks for taking a look at this.
>>
>> On 4/1/26 20:49, Joanne Koong wrote:
>>> When a background request completes via the io_uring path, the
>>> background queue gets flushed to dispatch pending background requests,
>>> but this is done before the connection-level background counters
>>> (fc->num_background, fc->active_background) are properly accounted,
>>> which can leave pending background requests stuck in the per-queue
>>> background queue.
>>
>> I don't think it ever gets stuck. In fuse_uring_flush_bg()
>>
>>         while ((fc->active_background < fc->max_background ||
>>                 !queue->active_background) &&
>>
> 
> If the queue already has other background requests in-flight, then
> this check never passes due to the stale fc->active_background value
> and all pending background requests on the queue are stuck until that
> in-flight background request completes, no? I'm rereading my commit
> message, maybe the wording is unclear - do you prefer it to be
> reworded to "which can leave pending background requests in the
> per-queue background queue stalled"?

From my point of view "which might reduce effective queue depth to 1". I
certainly agree with the fix, just not on the word "stalled".


Cheers,
Bernd

