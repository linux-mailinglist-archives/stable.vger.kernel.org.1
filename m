Return-Path: <stable+bounces-230777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICbLAn+zx2mZawUAu9opvQ
	(envelope-from <stable+bounces-230777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 11:54:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5B34E1E1
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 11:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B0C430138BE
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 10:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF14386569;
	Sat, 28 Mar 2026 10:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UlspkpdY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f230.google.com (mail-pl1-f230.google.com [209.85.214.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9368337268D
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774695278; cv=none; b=lP/H4DNVHfP5lewUTuZzuC8bItzBQeu/iystfM7X3VBXNfkPgAD4MWMpDAGOL5Zn9dsBrhvhQXO5CzHnX8WOWAdGjUqVNZUnOn9+IUbYq99An0uRmI+3LeHDJj0tND7XEXGJy1DDe3uL93pAtprI+UCAfLodIcIdVOKAXj7guOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774695278; c=relaxed/simple;
	bh=PspH/X4KJAHkqtDhj/K1jV42/wju9Xfv45eoFPuzSFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NofrvBWUj0TRwI8IQ+m58UAg1IJfuiJGPcZdEPHYWzkEKlOsZWcCtoJw/BwfiOtD4hGfxYRAT7zPCNoM56O2VPaJ6AKFZlwaaFHnWu1lkZXbzXddBk5IyTm9/Y1tD290/5VfxUMQk4vXVV1HpOU6qIOaoK4tw6ouQS7uujZaQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UlspkpdY; arc=none smtp.client-ip=209.85.214.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f230.google.com with SMTP id d9443c01a7336-2adff872068so12291805ad.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 03:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774695276; x=1775300076;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ofaDT6oEuKpoTRxG6lwEX7XMq+tIFsfO197Yw+XEcu8=;
        b=GXgwRWP3OKElj/qDOL03U/c34+ri67wUAqFWsHafqii0NGtHAb2laDbCaivFj4Lmur
         GeuP3UBOQ/2p7mHUBk33GmUvYxxFCubwVkhzGAG+px1ZOPnEjLGs/jyyctk2ByE0IRqy
         /2GTnSyDO/4e+orzAvRog900pSoDn6km4zaS8PGcm/R3pp/eIWWSu1F30ei1m8Wc8fqQ
         aEREeFLJctDMsi8jT0kneWhNv7m2CjpgThO4hR61SiAUJXOme+ZBtRPlLOnqFn7Fui5z
         EjfnKdIC0DNdDGWEbiIfgNTtdpNk/Py9E0oSaN1B3yPCB3ThqzZeBY1wnRLRMlT21fTm
         AP5A==
X-Forwarded-Encrypted: i=1; AJvYcCXHH3QCLqC5rAWUN5Z/LjDTAZoEgL99HQzJm5/D4OwY6sMo2qCbaUbbQYTcw/Gy+MdHJCeQa9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSb5/d1rLW2UfOrmqm27muPmGRRoR2dpeI69gzah3jx62Cwh5
	wSVaZdHLo1vaYOmwuDK7MUJIr4i9x3cjUwIKBGs//6R+DwoARTmngYpvXz8zqvRz7OYhJvX+dNy
	HQCRy+zmLv1XAPHl7G/5P6Om/mkgZ8Li4lyQZevcFzxuL0Ci5/xkILT7bRKM4FgQCpuyRpie0Vk
	7hbV87da+C1vVImRb4QYMpArK039CoF0Styq09P4ZFpGE8gTsnE9kwVM1SuXHNnTI+nKhRNfce+
	kBnyt+dInFYZIQP+ZL/
X-Gm-Gg: ATEYQzy1PAmZSyo4L+L7+S8joL2ViiiYuFksPgz9sdCq6w1dQ+qWAMdyiqP5WeWoCgg
	EZdsR/IVePJj804UQLYN9VapETpIyZS4/2hUmNM/+SsqLErEvNdNKRnogqcUNbcTkm7vGsB0/I3
	KSRCR9ICgfR0zQWLzdayoxP0iVoGjH7q/HMVuTc/Bqxxc4XmyVFwE4v+X3RWo85H7NgGa9I6qHX
	91+DLRHZrYl7jZrCgg5JCvh5YekFqZoqNntnTRzbklD9JPQcDJdzg05Tz7QF/E51PBPtzJax1ZP
	JyhdgFeD4anNIKoXqsGTE82m//SNxW332/Aal14x4YAIujNfaiMeGk5JVCW1exaB4Aruoi32HnK
	JOzcMSmWSuPcAMZw+yb8vIB7eF6ddGq80C2nJSFSs75UU90rXOlsJtcLI70rUnWHup/SJSMeGCr
	UZNiRwF6Ha
X-Received: by 2002:a17:902:ccd1:b0:2b0:5b4e:3704 with SMTP id d9443c01a7336-2b0cdcc9267mr56881115ad.36.1774695275720;
        Sat, 28 Mar 2026 03:54:35 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b242769068sm2103475ad.47.2026.03.28.03.54.35
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:54:35 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9360e9f43bso389422966b.3
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 03:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774695273; x=1775300073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ofaDT6oEuKpoTRxG6lwEX7XMq+tIFsfO197Yw+XEcu8=;
        b=UlspkpdY+zBWLNr99upvLJ/qKgWjdJleYmDzINwWbPA6XvkvxgZBjFok+G5B1Mihq/
         AeK3aCYlIVdXUtmB6+F0NMPokApC00SzoZDTK8BTPHsjfF7iVY5fpbsNKyzPvBC4QXGI
         qfNyA63o6Wu3xrKDLLiu58zMkK5YDbi1ze+2k=
X-Forwarded-Encrypted: i=1; AJvYcCWVG6R0kqCL056JYWtWBntyGxRhad1LIZ2Bjvzqy7QkaSrGt271+bblZTmd83gvxnoxyz60UaE=@vger.kernel.org
X-Received: by 2002:a17:907:c70f:b0:b98:5b2:77fe with SMTP id a640c23a62f3a-b9b50301ec3mr363013266b.3.1774695273434;
        Sat, 28 Mar 2026 03:54:33 -0700 (PDT)
X-Received: by 2002:a17:907:c70f:b0:b98:5b2:77fe with SMTP id a640c23a62f3a-b9b50301ec3mr363010966b.3.1774695272862;
        Sat, 28 Mar 2026 03:54:32 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b801bf80fsm56205866b.0.2026.03.28.03.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2026 03:54:32 -0700 (PDT)
Message-ID: <ccd8a143-7467-4b3b-96b7-e5c3e0a2fe0a@broadcom.com>
Date: Sat, 28 Mar 2026 11:54:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] wifi: brcmfmac: fix use-after-free when
 rescheduling brcmf_btcoex_info work
To: Robert Garcia <rob_garcia@163.com>, stable@vger.kernel.org,
 Duoming Zhou <duoming@zju.edu.cn>
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo <kvalo@kernel.org>,
 Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Pieter-Paul Giesberts <pieterpg@broadcom.com>,
 Piotr Haber <phaber@broadcom.com>, "John W . Linville"
 <linville@tuxdriver.com>, linux-wireless@vger.kernel.org,
 brcm80211-dev-list.pdl@broadcom.com, SHA-cyfmac-dev-list@infineon.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260312031429.3432419-1-rob_garcia@163.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <20260312031429.3432419-1-rob_garcia@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230777-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[163.com,vger.kernel.org,zju.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arend.vanspriel@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 66B5B34E1E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 12/03/2026 04:14, Robert Garcia wrote:
> From: Duoming Zhou <duoming@zju.edu.cn>
> 
> [ Upstream commit 9cb83d4be0b9b697eae93d321e0da999f9cdfcfc ]
> 
> The brcmf_btcoex_detach() only shuts down the btcoex timer, if the
> flag timer_on is false. However, the brcmf_btcoex_timerfunc(), which
> runs as timer handler, sets timer_on to false. This creates critical
> race conditions:

[...]

> To resolve the race conditions, drop the conditional check and call
> timer_shutdown_sync() directly. It can deactivate the timer reliably,
> regardless of its current state. Once stopped, the timer_on state is
> then set to false.
> 
> Fixes: 61730d4dfffc ("brcmfmac: support critical protocol API for DHCP")
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> Link: https://patch.msgid.link/20250822050839.4413-1-duoming@zju.edu.cn
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> [ Keep del_timer_sync() instead of timer_shutdown_sync() here. ]
> Signed-off-by: Robert Garcia <rob_garcia@163.com>

What tree should this go to. This looks like a stable patch so probably 
it should have been CCed to stable@vger.kernel.org?

Regards,
Arend

