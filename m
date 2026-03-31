Return-Path: <stable+bounces-231462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFv0Fjz3y2kGNAYAu9opvQ
	(envelope-from <stable+bounces-231462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:33:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7E036CBE0
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D5A88301F428
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB343F9F5E;
	Tue, 31 Mar 2026 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc3HX7L4"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FEA3FF895
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973759; cv=none; b=NqYFORSoTqzFloRLxMyJdR128E/Kxh2hE7n57C9VI5EI6NcJ+8P7BwxA4TirBhD6Dff1+qnl/dm3IwATXRFMlLu+UU1qt9mMSNlBxH7Oehu9GxaKBdmRWLkJmChcoCXlLGEFlnJfhnVxRVJzAhAT51U4NzfFzlSc7+46zafTNrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973759; c=relaxed/simple;
	bh=pWhATMrXS5+kJCnHa+IordNd5D4ph2EQ4BfxubEUmSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9h1flLrGc75Vqv1MLYZmbsQCAlovR8k7NPKNqE71y651uIhy3yhnesTpk5YuMkklpZK+DoMtaJcv+CBpjubdRp6Y3Uv+E0Xapib912DECQjdI3BJJv7Q21UOUr982v66WGM+akSjO5vx2cpSsL/ilWQo1X+bJ9fw4bF+kAOAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc3HX7L4; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12776bebe9fso1325431c88.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 09:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774973757; x=1775578557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rZBhlRLYU65z72BBEjtivUZpgR4C0BvXMtceQv6bjFA=;
        b=nc3HX7L4AmLhKdLicjHTgl+7vY+0hlikiNdcxGrLNk3UKSh+1k0gedHNugrBg2DvAy
         bEGZAe8GN4gStP3hzEHL6LVoJfE3K3TH3L8Njd3JyfhE6ic+VaWVHrHGkielB/w1Y6aa
         IwiZBx35oNZeAuI1pazCHrOQQaY5gBzBBneFDDc0TfxTzBPfKtcV0qkAq4LjJt5nYPF3
         7JbDlzmBS/mqAtPrxRRrm3vySqoJB3U2Iauv25caZDJSJ+Xk0KRG5j4+Q5Ae3p4a7VBD
         +jB4sXz3CdGC5BP35w3vgtjAL+kPoUkjL8evlyunilGd6VquoRXh4WbtTcXDsKyzuLu7
         Iifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973757; x=1775578557;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZBhlRLYU65z72BBEjtivUZpgR4C0BvXMtceQv6bjFA=;
        b=XXrhDuLvM0Cv6LfSYM7AV+KbDQfzM6mvAthx/COEt9kI70VWi/mN84cMWcFsd9kU+W
         wIgyrrxOj+Fl9kvoQgdXKnzgt8e3yTRkXjpMlCnnHAIDPW4D1qKgouDQHUx02xwWtZBq
         wD3hxfh0/XJLriLS8bYr5iYK8YusbP4LHYpCYZwegwMvW8ruQlHk3CEyQP+GwhdXT9Gn
         tJULhvyvw2gErv36QtSadKElT/WV/dlFKBLiA+Haf2xYOA+B1nQeJOTsxCr7A8cPRAZp
         g/72qz1Fv2m+aITrgXn7z+58RMILibfH+L6KOt/8yeVpAM6/0bwElmdDmWrPG1Wt/Vv3
         72Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUqa8ypPX73f6oZzAbTXrVPAJCCpEYUiNZLtoN/rYv/gfx/jU6EdW9sBsHARLBLlpvrtcJaeek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQupbhlJJ4knX/4mBv4vLedk6wpDoilaFQhpAXSvzZgAgi2PGE
	FFnRRe3kIuXVwte1ttDB/f0BVEDRbWFaTZjNPrTVBuRs39U8UPgUQl8E
X-Gm-Gg: ATEYQzxPlpt9NLjuiK5pK2MHghyqD5sXIRrrt/LSGyvmU1tmmIq7tOGcAQb3HeeK8Uo
	I/L7Cly+5aL9Dxu8pw8FpSbovmrpmGHDJYF5SFHVP8X0NL1d5dLrxbmCfLeZGKx/JKQnVLKAxOx
	Np+7I7pEAFJxsfLUNhM2vaipz0esfUJBxOffAk6TpRWL18i0qz57LCIi7IUnUI/M1OnA7yu4KNQ
	4CFaZhXYBG5SAK6GUJZK2g4HeMWgTqPhCD5qhmXUrfy94GpffVEAIkBrGwe41UxYFcr55ewlO5k
	1dgO0xhbkno7jqgP0WLjFgJiygxj+jOOgZU2DhdB+3PGEw7Ky/O3RcQXEkgs0PiT1XzYUl3Y8LF
	epFm1tzU260h80YvKOovZDA3UDbfP1OGO0Xakn+ddoOHnxaO3zOkrTEFC1AAHIFTur94X5uOvsn
	L8P+wKM/6bVrotOvdj4r0QPBjmGAjfuafjZjnLGrAoQClqu0VwP8sO+r4utqEc/zczztWUr9YI6
	2Tm
X-Received: by 2002:a05:7022:e19:b0:12a:68cc:3efb with SMTP id a92af1059eb24-12be643856fmr66976c88.16.1774973756726;
        Tue, 31 Mar 2026 09:15:56 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-218.user3p.v-tal.net.br. [177.4.161.218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab970da7fsm11494127c88.0.2026.03.31.09.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 09:15:56 -0700 (PDT)
Message-ID: <a5537802-ca5d-417d-9fb4-18e0b0d21467@gmail.com>
Date: Tue, 31 Mar 2026 13:15:51 -0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: aoa: i2sbus: clear stale prepared state
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260330-aoa-i2sbus-clear-stale-active-v1-1-47a6c0a3ac9e@gmail.com>
 <878qb8rs48.wl-tiwai@suse.de>
From: =?UTF-8?Q?C=C3=A1ssio_Gabriel_Monteiro_Pires?=
 <cassiogabrielcontato@gmail.com>
Content-Language: en-US
In-Reply-To: <878qb8rs48.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-231462-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D7E036CBE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 11:27, Takashi Iwai wrote:
> Do we need to clear the active flag here?  It must have been cleared
> by hw_params call.  Or is it the case for errors?

Yes, that assignment was meant for the error / re-prepare case.

For the normal reconfiguration path, hw_params() already clears
pi->active.

My intent there was to avoid carrying over a previously successful
prepared state if prepare() is called again without a preceding
hw_params(), and that new prepare() attempt fails before completion.

That said, I can drop the clear at the beginning of
i2sbus_pcm_prepare() and keep the state reset in hw_params() and
hw_free(), since that is sufficient for the stale-state issue this
patch is addressing.

What you think?

-- 
Thanks,
Cássio


