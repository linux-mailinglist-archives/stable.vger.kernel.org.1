Return-Path: <stable+bounces-222945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCQ1Bks7p2mofwAAu9opvQ
	(envelope-from <stable+bounces-222945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:49:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E561F65AE
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4085530AD914
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C3F379EE8;
	Tue,  3 Mar 2026 19:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F3vw4zR2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D637C934
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567304; cv=none; b=ogxd9+kpIl7/8NqbBPte7d/EFpxuUaSJbf20q0g1FrxSpImWdj1GAxIIxLZBE2Ey0UH/lExOfxCJOyozflbupjnA0WWPABMTrIRYxAHTSay42ItZUhmWYcTlAu6cWp67GJqvxryi1Djt9uztfIJwHFPsJbVvNRb0aQ11WPpk8ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567304; c=relaxed/simple;
	bh=+kS1tojwy5YTkToST9q4TaJiuiAS4cNfh2tQs+GWMjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twn3FkYvz+4FO8fU4wbb7PHhuSrRv/1/EImL3kKjgOgogWme9sPa/FNXvSJknGKKdUcdFlhN3+TOiJP1vnyXv1z4defdf9p8ouWTbcjNj3Fsni7Z4KlrwHPQVNqeofFKAqOuPtJlJQMuyTSNLoOw1i0pXRGp0KhaNuJ2QZwzN5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F3vw4zR2; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d4bc9e48bbso2900586a34.2
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 11:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1772567301; x=1773172101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b07Vclzg3TIWwnrPPGwmBhx/Iqioy6Bog2ICdVToJUg=;
        b=F3vw4zR2P2S1mhhyk4PeEzwIwFjONtm73Jo3Wq1vV06whNtUNkWB18jwYZrhF/s8RP
         uuCPzB+72XNd8QrBW5mef7MumePsjN6ew2xZcw9iPix5dyiNRn9NCAkx1mbLB8FgXvz6
         AqgrEvrqiognxMP4TRfFYYTSgt7TtGJcluePw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772567301; x=1773172101;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b07Vclzg3TIWwnrPPGwmBhx/Iqioy6Bog2ICdVToJUg=;
        b=JQt3pPA601/q7CAefpEwO2a+OJX/KOCTMZ2ityXJH0zB+7IqvVQa0a/ExcWSv80GmY
         el1LogRVmQJoxiBA/JmPv1oyhBmgc6IW+0h5bSI3yDmKZOXOkGfn+Tr02XsFMfI8W0aW
         eQxO7HCvaO6/lhrPo4GWmDSCNICxfZBJdoqBBavbuHCb9+jcRFLYjsbFJRwtGhQA7rEo
         TaoLz11m/S/9El+AIqMChC/ecqvd8N0JOeCc4Xz1Zu57jnNIJVSSkTTNkNAqTB93S7rM
         Z9A8nrGlvsUjrov+gBewlR1tC5yBoFSam2yoZNT1uujfbPdnEuCxb3DrNvhcRueUDRLg
         AGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL/Y9hgcnedPKpgXVBT+q1cHkyrSbuGQJ5UblWzbrPpkwePcID46ZCCaKRqOw1JlrGzE/YjPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqwAvhCcu5wZLoZWTKeWK7GtqAetMBGfaJyZI1HEXLSo9qbJUV
	vRt5lbaQixNx8XiSEmZXWyLneCxRrPXY+Y0T6nGefw7RKjPFZXkIHLgImB1AszQdy1o=
X-Gm-Gg: ATEYQzy68cBYTJ0ThZ2DV7ySy2UnAfKjbzvD/zmAgFMLkFo9JrL4KPSEDMkMdeBggNp
	DErhetAiSRBsf4hRZL/Dn2LnJXESENbLJfjk+hAFmSSKfNLvSCZHwyifa5xNxqjKKNd0045nrM7
	MhR8t1LF5b8/0kg+QLr+JUPwm3zjgyvaLnFoVvZk5FBwAahYkClDhpQjKoZM0NL8zB2Xs8CxiHd
	aXZdJlj5Csylea7WAXyfHEil/keGtw4A05GgzeTDIxhFjT3JCGcEfTfXnwIOXNUAg9dcbQLr21e
	cH104U9S9M2h37Jrk3EtINAqYVu+7KfUgRoVtZanQ7wijJPJW8+UgO9/qRVGb3qrdaNeq7Nq2Zk
	0QhoXfcXKyQxBAkEvRgYxtH5eg5esOxe/jGYaHUn1JF1pkmCNwJSOGbYcXmWOs78ZPb7XBmIQwt
	fLoYVc/i7nKJ83mVl9T9q/xzXWtucElt+ElVk=
X-Received: by 2002:a05:6830:3881:b0:7c9:5959:8de with SMTP id 46e09a7af769-7d591b21cf7mr12648060a34.9.1772567300764;
        Tue, 03 Mar 2026 11:48:20 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d586226d14sm13867933a34.0.2026.03.03.11.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 11:48:20 -0800 (PST)
Message-ID: <a4b92e9a-d3a3-4e31-92da-248035b051eb@linuxfoundation.org>
Date: Tue, 3 Mar 2026 12:48:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/164] 5.15.202-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260228181458.1600528-1-sashal@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260228181458.1600528-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A4E561F65AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-222945-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skhan@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Action: no action

On 2/28/26 11:14, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.15.202 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar  2 06:14:56 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.15.y&id2=v5.15.201
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

