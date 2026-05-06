Return-Path: <stable+bounces-244358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDEUCM4O+2mbVQMAu9opvQ
	(envelope-from <stable+bounces-244358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:50:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A584D8ED5
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CB8A30936EB
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 09:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08AA3EB7E1;
	Wed,  6 May 2026 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="BlLTgGQd"
X-Original-To: stable@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1F73E958C;
	Wed,  6 May 2026 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060638; cv=none; b=tyGDijMWwA550zydFghFpQHPsZrnYSNc+hi8uitYssm3F6ZIY/VwAT31N+gbvjaB1UUQpG+KD37LGjBhL5bNz19G92i9SME5G3d+FFYIi+QkZoql/iSxIwDwj8us4uFtCHysZLvlDa4jeWxkyR67XcXecdiSNLtX+SEqdX0J1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060638; c=relaxed/simple;
	bh=RIN7YXqXvgh2MdA7eJYTnfvp7/z4cdn5ni4CU/qLi/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMYEc80sDxH7GPrtnu0T9vaOpD/wRiMZRLyznLs8BlbouwHMb/Vt3Wu6uTUb827kbrBajd+URqC4PIWNjbxsT59lLZTvaQO6X+dG1Raho8SEuQO9XK0q+TLLs1viY1pb0zy6YLiZ/oOJW0dv1NxDAHt9mzn6/gKUipL2FlFQ1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=BlLTgGQd; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g9Vnf6lPYzlgd7G;
	Wed,  6 May 2026 09:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778060623; x=1780652624; bh=1LBEh0gXi9dp9n7zJVBhVS8a
	OkHdRkSIbKvK+ex01T4=; b=BlLTgGQd2ohpnnhQ9iA1uf7NcFP7Jifk3isld384
	nDJE3QwFmzEqzNXiPdO6/R+wdB3XTDiG/zckrvWhCdLWu02frLNZbFCnVdeZ9f4y
	EqdSsOT7082FgqqRDm34ViE4vXatdvPEU21cjPLVp292UWrCS07/k64/i+M07Rxf
	DI7v6Y5eArBMR5AgHRWvIPaJskfu93pubyvGfvunwPhX+dDiKsUPukFRo65Nv2+g
	45yRTWhFpvNGsyL7gguVW0KVqhTtzJai9yeUnXjjzWXw6GehiZ3JvDmllds5Q8LP
	FbevXaAJ78mnW8as8ioevCAQWt0+lq/PO/XCFDR8aAXx5g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Swzqo4UsmoAs; Wed,  6 May 2026 09:43:43 +0000 (UTC)
Received: from [10.211.9.52] (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g9VnM6bfczlfwHS;
	Wed,  6 May 2026 09:43:34 +0000 (UTC)
Message-ID: <713ba2ae-e322-4e56-b0b8-89766f7f65c1@acm.org>
Date: Wed, 6 May 2026 11:43:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org, clrkwllms@kernel.org,
 rostedt@goodmis.org, ming.lei@redhat.com, muchun.song@linux.dev,
 mkhalfella@purestorage.com, chris.friesen@windriver.com,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-rt-users@vger.kernel.org, stable@vger.kernel.org,
 ionut_n2001@yahoo.com, sunlightlinux@gmail.com
References: <cover.1778048987.git.ionut.nechita@windriver.com>
 <406f424c0a718bf492d40c206983e355e600945a.1778048987.git.ionut.nechita@windriver.com>
 <50187fa5-03a9-4ca3-bcaf-a36ed75bda2c@acm.org>
 <20260506074758.8zEg1ZBh@linutronix.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260506074758.8zEg1ZBh@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 92A584D8ED5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[windriver.com,kernel.dk,vger.kernel.org,kernel.org,goodmis.org,redhat.com,linux.dev,purestorage.com,lists.linux.dev,yahoo.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-244358-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid]

On 5/6/26 9:47 AM, Sebastian Andrzej Siewior wrote:
> On 2026-05-06 09:14:33 [+0200], Bart Van Assche wrote:
>> If the atomic_inc() in blk_mq_quiesce_queue_nowait() is protected by
>> hctx->queue->queue_lock then the above code doesn't have to be modified.
> 
> But wouldn't the atomic_inc + barrier avoid the need to have the lock?
> Isn't this a normal pattern? If the lock is kept, we could use
> non-atomic ops here then. But this avoids having the lock.

I strongly prefer a spinlock + non-atomic variables rather than using an
atomic variable and barriers because algorithms that use a spinlock are
easier to verify.

Thanks,

Bart.

