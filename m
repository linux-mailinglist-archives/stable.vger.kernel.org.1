Return-Path: <stable+bounces-233100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA4vARG/zmmDpwYAu9opvQ
	(envelope-from <stable+bounces-233100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 21:10:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006D38D8ED
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 21:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A24F3021EB4
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 19:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639C53CF032;
	Thu,  2 Apr 2026 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYe+bK1z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE337C93D
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156982; cv=none; b=RgqO++NCA1Cd1DdGzF5Y0j8SkmIxexoCVm1qoHG+yU4mpXnbCNRsvlhA9UPSBahxzIY+UmTGdTS5BK6N4CoaKaKUWwGY3pFkeRtgPZNyTeCev9nGFbc32170fUKjn8Y4JECLb+d41Mqb33W5dnc1iN6Me8956LihGGXxvd43SMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156982; c=relaxed/simple;
	bh=Ble75I19hZD8Gq/9mAKEgMNjMa1vv9+HA6IpkVnY8aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=LfbKnf2G75hcoUSiVrBe5KMVw8zg6wbqHYjO0b8dleWfLgeejpPzyEvFewrHb/Reb0sj2KVuyxW8pFqDJOcawiyvnTvFm+MRqRwifInCsVuqxK7MqtsDxqSEzzKHHq112tKvK2ZmooAVATOgDqlU2ao6BERM1NL9YwtGXiAsSHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYe+bK1z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43cf5f6d2eeso72532f8f.0
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775156979; x=1775761779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VEJ7lFc9cMF6zQQYMNGUT3vPQmlpaQbjETLvce8ICzY=;
        b=FYe+bK1zlEiP4Nw35oHm7aBoCl4WRHrvl10YaVxpzsU0PoaT21sdeFBJCK2Cjxh3fg
         AxSL9+iOo81K8pi9KUyNMTqS4mUGl3a/k5ymirW3Gh3ULE+Xe/REGJr0DgaKBG3ivXZv
         ClkTFy3FnYplFySxtQD3sCNgI0GS5H5G/LF69miOFXVr7bmDt3tdcTTQFpWHMsYSZRqL
         3DSGu/nbyBHd0mePA34wVQ89Hl6IhtCExe8erjJ0GCdECXLFpTm+xm48PEyJTWGhZUQo
         o7O0B2hIgP08EBdwsmVfUMa8jIhvY41nZgjymVGnJQt6LPCazMLyraqMarlirZRcyV9L
         OBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775156979; x=1775761779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEJ7lFc9cMF6zQQYMNGUT3vPQmlpaQbjETLvce8ICzY=;
        b=Kgu6SVViaHlqHEhTWkR5a8ahehm4tvpoe5xlwW/UQYPMRJX7HSqd47nZKB8aoqATiE
         uG7ctE80+r7ks4ZfaPRne5UxrChNOkfxI2zZdngTnwuHSZy/P05tMhyWNgoRVUHXUN7T
         Ywm1X6W98aNKN11F2niU9YRWc4vKJ7sZefdXtEQJqDzNy7US15pzCIJHFsm8AbzNmsEt
         OO7jTatmzqzre3KQ6UDaWBOzZKT3AjM50uDafuomlAMDzH/74uJVGyf78xci8Y/2U5/q
         DmUXJ2712wVjYKJ5HrtiPLzP18cvvtEDTLL3YdiYfNjX6dBmvkGzHzUzYATI2u4Dhq9G
         5M4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUmsDNSf9lAAnD4xRjNnvm72zcmP0sKDWZuvzlLIfKzK+zcMLouXsXJuT0la3akTdLILTNIo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOUNXDrLv1khkYJ8hsgh+kYFaHRtmaJbLj7BDyWp7jwY/Qckl
	J4WpUKLUoG1/V6TYMvUPGE7pcVW3BsqJWRRp2qTdOwQCshDAX0cUSTol
X-Gm-Gg: AeBDies4+aWzYRc4X09lx39Nn3ZH72B01mzouTKfmxloenH1hhjRg/LImbBd7egRLqJ
	fYcL2NHIen7KwidULWyFKmYh1EHHVI6O+e5qyHIdmcP+KiVN15aCLRouJGNcHsWIQo84KPqcsVk
	4fO6Go6MI7LlkVZAyWdkUNHJmPY0qk0vftDwRTc+dzV4NvdZp9jvabYnltZQvfgIiV8mz3wjLxz
	1pHenI/Eq/GV6hSCEc0UOdakbq8tcTfsb4oAm4ejBhTi1pghcg9kC73s0aUneNAEnyrDB/fZ4cF
	iEwtERHGvOsws+g/UrpeectlVIa1r5FEEFKMMMgKpq/gfhKDMcSldmj0gPyn30ABpSvrmqxMuNB
	koEXt51wBXBeyG/a76uR/XSlRj6uXYiG0XPjYNvMfHlqXXhtR9DX2e/CRl3FupslSUbqZJfT8YU
	0O/uUu8FBEGaJHI/fpTi2aLMxAqVrbDMKZqwrwVP5AEBKN37fv9nni882UDpO7ryWKbQhAjATtB
	VbifmvHQSjPPbwCaxuOD920SPCkJav6epR6kCc0BC9nR9dZUEn7VuZ29emZK7fvAZJvTHtnIIxw
	jfGusc/8z9fvQ/VdYJ8Q4FthSzVHRBeGsurI/Ne+c8pmj/6mR/p14klKY7FKXCh/7YvAYAJqK/9
	BmTiUDIxCxZaHLVJaiP+B71cerg==
X-Received: by 2002:a05:6000:645:b0:43d:284d:28c with SMTP id ffacd0b85a97d-43d292f53a6mr131577f8f.7.1775156979167;
        Thu, 02 Apr 2026 12:09:39 -0700 (PDT)
Received: from ?IPV6:2a02:1813:4880:5700:9afc:84ff:fee0:5961? (2a02-1813-4880-5700-9afc-84ff-fee0-5961.ip6.access.telenet.be. [2a02:1813:4880:5700:9afc:84ff:fee0:5961])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm8482638f8f.35.2026.04.02.12.09.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 12:09:38 -0700 (PDT)
Message-ID: <d39aabec-f102-4339-b72a-ee138fe0c002@gmail.com>
Date: Thu, 2 Apr 2026 21:09:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
 <0ab3e776-1462-46cb-996c-f4406c84756c@gmail.com>
 <c77392e4-eb70-4f21-b072-e6a6de2f8e59@gmail.com>
 <2026040220-sincere-undaunted-65b5@gregkh>
 <CACU-xRtcWU=RKOfhL+8B2YmYnPN-fxc+TYc4rjaQEFc5qAk1+g@mail.gmail.com>
 <2026040243-dwelled-overdrive-51b3@gregkh>
Content-Language: fr-FR
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
From: =?UTF-8?Q?Fran=C3=A7ois_Valenduc?= <francoisvalenduc@gmail.com>
Autocrypt: addr=francoisvalenduc@gmail.com; keydata=
 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
In-Reply-To: <2026040243-dwelled-overdrive-51b3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-233100-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[francoisvalenduc@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8006D38D8ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Le 2/04/26 à 15:38, Greg Kroah-Hartman a écrit :
> On Thu, Apr 02, 2026 at 03:19:15PM +0200, François Valenduc wrote:
>> It seems there is no difference between the final stable versions and
>> what was posted for review.
>> So I guess I will have the problem in 6.18.21 and 6.19.11. I will try
>> later today.
>> 6.19.10 and 6.18.20 worked just fine.
> If you can track it down to a specific commit, please let us know.
>
> thanks,
>
> greg k-h

In fact this has nothing to do with a kernel problem. This was caused by 
a strange change in dracut which happened at the same time and some 
keyboard layout files were not included anymore.
I would never have noticed if I didn't need an azerty keyboard 🙂 No 
wonder that git bisect was inconclusive.

Sorry for the noise.

François Valenduc


