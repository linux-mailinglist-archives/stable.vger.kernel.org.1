Return-Path: <stable+bounces-180546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37884B8555E
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 16:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5071468171
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 14:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CAE2FBDEB;
	Thu, 18 Sep 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="R5dHzP/U"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB79B302CD1
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206826; cv=none; b=R09zttuNdPfCOpbGArEbuF+Yzy7id32jBdo85A7sJ9scxy1+458K864BYq/Smd43xkBVATBDu++MV+ssOr8lGS3eShIFkykJZOsUqQw0jZDPOXs8oVhmNKhixb0YCLUyv+9hUQnap6fwAmjt32Xf3PhC6oPL2MHvmq2sJBCO7Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206826; c=relaxed/simple;
	bh=tifRwdG0cup/GwpjdX6d2kTze0RGw/mxSxR2cHl7XPc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZQUP7R3u+hHrj4axn6fOoD4llamvEsHJXl4yUf8Bsjp3vhVLjeuEQcxHNzGEb21mwHXotfV7D+O+9OkZVWvXS8jE9nWyUVF62Bv33o/2xgTBLsTU5euGDmDxfZYEHp9PejWYh+Kowg45uRwM+CYJ7wn4mbuJAlPn6jhhseVk/9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=R5dHzP/U; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45f2313dd86so9520005e9.2
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1758206822; x=1758811622; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=37D42GXffjAW9iYbAp7WEI4f33KeURcYQYqpxtmTp+Y=;
        b=R5dHzP/Uhrfm2jyILT6fxoAzH61nnPfRNnDcz3XB8z1styjfacM9wcZrqSVWluord6
         ocd2KWLX5iXA+RwyScF9aaGlRtI5ZQV1axQMF5R4j4ZKj9gGbEXrmziKM1ATo09NsnDW
         MKawupjIChAMc/7ybpRZ70If2XJwrT/NhUWpVd7S0SBFMJ7MP6Q1zLl3TKMGz8a18A47
         /Q1EyX7HwGoqJDyw0M8qQBm6jJyOxTwaCoFbDbBotweaGZ9U4u8XJTv7dj2VEFYMnqNd
         4XwX5zvChMqK/9bTollBbnPry8LKYxOZOaXQIFjbEdL9KEsLCru6Tl08plvJPc4aUoNJ
         oOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758206822; x=1758811622;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37D42GXffjAW9iYbAp7WEI4f33KeURcYQYqpxtmTp+Y=;
        b=hzvSViHE0IENzmNqraSSP7psMGUCchLOGIYuZZhV5tlsiemMzztYIkuuyngb+ms3E+
         auWC0ipAl3NLHq5qhgnDibDeU860WosRDbq2nBz+TofDXzFI4uGgJn+XzoY7g57mHWab
         w99Qc1d/RoZvAFl8pmbfrsF14jgmGII9UpFDLGo6u/QuwqeT5Wi0hP2ZethWVdFUvUpt
         VHUpqGGfcS6kkX4EODGg3IE0WcWlM2AZ3Pdf1xVCOLdIfyW2JXKO8XGje6US9IslNfCO
         hnXPKAKJnucWbda9P5C26XHdGBMfljW+NdP9sbusMFGgjUSF1SdzeQZnnWMP5SvSRN0+
         u4vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOIRT2tqa4/6TB9Q943h7nTod5D0jP9zb9c53IESr21j7Qz1mF/0xerEnOMzHidaESb5rzZ+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBa2B98ObGEprCE4GT6ARl+0DN3uqgkR0hV3nFr2W7edrIn3OX
	pSPwH3mrrd0uIeM3wB+byexixEuJuWAJakYhoDUEo8R7IAJ3ulSChB8cSCWurQdzPwE=
X-Gm-Gg: ASbGncvIynyJhSmACtneF5/1JvdFfFc0P2Xh6b50FWKk/YgMeNHFNIp90KWUXiJvsem
	89bL0ko2eCAYH3PRYtmMHmnRA8PYKqreUnhJMH6nhKfb9PFp8Air/hBSt0+BBJCfmO0WMo6L5kb
	qcBWkvdu5YWoO8CzTOQVtMbdWwIiWYWF5A4YP8fO90s1mn8OK6J3v5bJi5/FnrXk3cromf32cO+
	SfCB5j82NnoIirB08NYMxVt1p23TXxhC42tb+HRCPNCxb22NCdeAYHCTkegfQCxdRy3PH8j8Tdm
	Ih32c9bKVHrvWh6+1ZrcT3EkNU818l2C+s1WVYRVv+p+TtMQ86qNJonkXMjGdBO8kLIggk0exfb
	cjFDu9oUVIGVeUMe3KezpMZZceXFDo5Ersn4mdCWOoH8Px/bpEMn/z5zo0S/wTfrxRUy01F3UvB
	z3LobG66J137zsVdk=
X-Google-Smtp-Source: AGHT+IHYrsOd5brbUtJHp6pWROrBl7QN3jfM0a76C9QRJ2hgXJ077DV9G1Iemwpn3n8RIcYFh9WFLg==
X-Received: by 2002:a05:600c:354c:b0:45b:7aae:7a92 with SMTP id 5b1f17b1804b1-46205fa5930mr56047915e9.21.1758206822048;
        Thu, 18 Sep 2025 07:47:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:71:7cc0:9f51:a89f:3777:bbea? ([2a01:e0a:71:7cc0:9f51:a89f:3777:bbea])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf1ad6sm3767288f8f.54.2025.09.18.07.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 07:47:01 -0700 (PDT)
Message-ID: <fae4241e-eb1f-4aea-8a25-b80ffd566547@freebox.fr>
Date: Thu, 18 Sep 2025 16:47:01 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pablo MG <pmartin-gomez@freebox.fr>
Subject: Re: [PATCH wireless] wifi: mac80211: do not permit 40 MHz EHT
 operation on 5/6 GHz
To: Johannes Berg <johannes@sipsolutions.net>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>, stable@vger.kernel.org
References: <20250826202553.a6582f3abf57.Ic670429dc7127f68c818b4290d950ebfb5a0b9e1@changeid>
 <29b001dd-92b5-4afd-a871-f9fbe875e91c@freebox.fr>
 <a17c63c51c621031e2bfac56e63d562895583c60.camel@sipsolutions.net>
Content-Language: en-US
In-Reply-To: <a17c63c51c621031e2bfac56e63d562895583c60.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/08/2025 à 21:39, Johannes Berg a écrit :

> On Tue, 2025-08-26 at 21:02 +0200, Pablo MARTIN-GOMEZ wrote:
>
> This is wrong one way or another.
>
> If we follow the 802.11 standard strictly [I'm going to use annex B's
> items so it is easier to follow], we are implementing EHTP3.3, so a non
> I ... don't think that's a good (correct?) way to phrase it. "Implement
> EHTP3.3" means you have 80 MHz support, which is required unless it's 20
> MHz only STA. Here we're not really implementing 80 MHz support but
> saying that this is a requirement ...
Yes, I admit my email didn't have the proper phrasing and the use of 
Annex B items might have been inadequate and confusing. I was just 
trying to make a point by mail that was somewhat comprehensible. From 
your response, I get that you understood the point I was trying to get 
across, that is all that matters to me.
>> So
>> that means that the strictly compliant approach would be to disallow a
>> 40 MHz STA in the 6 GHz band and downgrade a 40 MHz STA to HT in the
>> 5GHz band.
> Looks like, yes. We should probably do that. These are corner cases
> anyway though, I don't think I've ever actually seen it happen.
For an AP working on the 5 GHz upper band, with DFS, it could end up 
with only 40 MHz bandwidth available after two radar detection. So yes, 
a corner case but still a case.
>> If we follow the 802.11 standard more liberally, we never enforced
>> VHTP3.3 nor HEP3.3, so why begin now with EHTP3.3?
> Nobody found bugs with the other ones? ;-)
>
> Here it comes down to this actually _happening_ due some devices not
> allowing puncturing, and then we can't connect in the right way.
>
> And this doesn't matter to HE, if we connect to an AP with puncturing in
> the 80 MHz as an 80 MHz HE station, then it _must_ have HE not punctured
> so only 40 MHz. Then if the HE actually moves to 80 MHz the puncturing
> in EHT must go away, and the HE is 80 MHz unpunctured which is fine for
> the HE STA, so there isn't even a bug.
>
> The only bug would be if the downgrade happens for reasons other than
> puncturing (e.g. regulatory bands) but this is very unlikely in the
> first place.
>
> So practically, the only issue we had with this is that for EHT and
> puncturing, and then the downgrade to HE basically fixes that issue and
> we can connect with HE even if we pretend we can do 80 MHz because as
> long as the puncturing is there, the AP has to use 20 or 40 MHz
> operation for HE (and lower of course.)
>
>
> I agree though that this isn't really completely correct for HE/VHT if
> the downgrade were to happen for other reasons.
I made purely my remark regarding the standard compliance. If this 
change is the best course of action to fix the issue you describe, don't 
mind me. We'll discuss the compliance at another occasion.
> However, I also don't think this is an argument _against_ fixing this
> issue for EHT. Clearly, for EHT there's the additional practical
> puncturing issue that matters. Yes, the APs rate scaling might be able
> to cope with it eventually, but if we remain connected with EHT and
> pretend we're 80 MHz when we're not, then we could get RUs in the
> unavailable part etc. and I think rate scaling would probably not deal
> with that well. This is true for HE as well, of course, but see above?
>
> johannes

Best regards,

Pablo MG


