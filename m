Return-Path: <stable+bounces-240999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEuWIuiT62m7OgAAu9opvQ
	(envelope-from <stable+bounces-240999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:01:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 122434611C1
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6980230065ED
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28203D6CB6;
	Fri, 24 Apr 2026 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RRZjQYCk"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1353CFF65
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 16:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046501; cv=none; b=nGYi3PbIbS688sBRjNPlYEAvANkeNitvvdKE74w+wPckpBHRKLqrxCUA0cSedJtn1MT14SlFKYSxkpamdRFXwecniLoi9aGerO0FhQmnQ0pMM2hEncVshQxmnklIjk6AxVLL8IMOEnPIaLD2MvQlV4oKpHBSfDcwabvh78usQDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046501; c=relaxed/simple;
	bh=XBrRIOss3UB8Fgcs6nvW4hOYB/mA2XcG3Gnu8tDN7JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6OAu6h7luJ9KRtLAHS1xeydPuagrRAlxg5neDQBx9poORXf9JknF/4JX4MwVXo3K+GOOO08GoSSnD68kUZlAeqkh7T+DXmWrtNd1vH4dilROdmKpcUJBUBLrX2ZldCs8Df88TPigHXc/ftUz1PFLsBPB+5oPW3bCfnl5iVkDwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=RRZjQYCk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so131532505e9.2
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1777046499; x=1777651299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5EePbwPULNZVcoCBgcrmEXYzSzuUctn0Jq6gjLWNAI=;
        b=RRZjQYCkM5Ed2hOKlWNyef8JPDVAq0iSFP4cqN/vt3S42/EXMpBFRZs4lUllageS76
         TM7fNTaEjWJYMdCHXLa5/JVVq8PiELmPeuiII1nXj/nOO2YxldK/dl/nM6w0/AY6MG1t
         dHAwt27wnhiDq2mPvrlMwhACW5wbRwOu4YJndRknhsaPP/Rx7/fG8kM+p5g7acNMtNHw
         3oeb1Vc+5k0BMHjCISrppsnw1HGMVwolIJeqc/RDtQ54rcC7JG9WQeyNBhqo9NonoP+r
         v9vm078F7eanTo4n78dd4KIB5ua4sunE/esexYk/Zv62GPYG/eSJPp9DAZlkr4qcquVM
         UnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777046499; x=1777651299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x5EePbwPULNZVcoCBgcrmEXYzSzuUctn0Jq6gjLWNAI=;
        b=os8CLssCYY/DkBLEakqFp5tJHJ2hT0axknWpj6ymKq7JuYnZjCspk3fZLsW5Osk5+i
         v+N8q5FadDz/Ia57+Hpn1Z3Zfly4mALjNaZiQCYzARtEcMbTIDk/E+J36rqE/HvWVygs
         xLeYTXFW4ftEV7ns1SqpuVfIqhswqlkTASV0hSo5Ts8Xu+v0W6VPyXyORMW6PqG55dig
         1NKGG/ihmf6USnjhL6FQVMByx75c7e3qlnRM6sp7gEX5HQd/CfdKNsnDt2I6Xp1pvcTz
         FYraLKrOArCNflIEYCXnzGwhiMwtxJqO+dB5mne1UzIYUno0e0/JsMJ5CtibpjjrzF0A
         niIA==
X-Forwarded-Encrypted: i=1; AFNElJ9V7JdZGIJO8fEIm4ULpqFxPWkVFUc4ecIZSisaJ+WDW3+9z6lt9cKdEBHltRjCZPknlINNwU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7053RXwDSeQUojMtJkihg/vP/ajljOB1oLbBAxaEi2TBMxgH
	hNxbuaOeZsD9I7EwFA9p2k4Bsvm4KTnyr524E+CweHfFHca4OgGiQlY=
X-Gm-Gg: AeBDieuBF2OsSLUHaKv8ThAKyNNhLY47JoMs12sa9FRPVDYn7s7Gx27NuZlj1HxvUgI
	Ezzf2MNdBN2wMknkaXZ3KMOJFKAjlAbdir1Am+96rbWLX9TOyKc2Rfb8iaO3haycNQaz1zYXpVh
	vVWb/Drenmq3xJj0Pj5awcBGteYkSZC9PNeZWlqbJS+6aW5stwxXN5+9E4O6+YXBm06my2k/VUP
	tYlhoyuQm44WG1jNmib0Y6ud6wMPBhYwH3FoWVyZSvCEA2C3Z6MEEIbhWgyMr56JdVJJrg/sRDl
	xRb+fulLgltm6raCwngQT0iLd1DRqI8+G/SDH21GtTH49Bj+4AhFdmTxXqNDB5cBATBgCTJXDGe
	B1Kwv+mk2fIj/MtNsyya9r8ViCJCBL+FL6Zb8hoLic1iE6nJYZukAO4wOCdg541oEG1GmUXukIE
	O2U4HsAdtxOgIiyOkVt/PjMJ5zDTI0oO/PjNVB31QBYaNS/Tm7O7pvkdFwTAzLnsh7qA12MEdTj
	l0roqr9m1Tz
X-Received: by 2002:a5d:64c3:0:b0:43f:e266:4c9c with SMTP id ffacd0b85a97d-43fe3db2e62mr50645337f8f.3.1777046498497;
        Fri, 24 Apr 2026 09:01:38 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4e21.dip0.t-ipconnect.de. [91.43.78.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a18csm69596790f8f.20.2026.04.24.09.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 09:01:37 -0700 (PDT)
Message-ID: <3649f35e-b190-4369-a90d-20eee8505e1c@googlemail.com>
Date: Fri, 24 Apr 2026 18:01:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.6 000/166] 6.6.136-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260424132532.812258529@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 122434611C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240999-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url,mailvelope.com:url]

Am 24.04.2026 um 15:28 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.6.136 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

