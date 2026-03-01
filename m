Return-Path: <stable+bounces-222389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HHSK3ago2noIgUAu9opvQ
	(envelope-from <stable+bounces-222389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:12:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E997C1CD40C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C530301FA84
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E363730B514;
	Sun,  1 Mar 2026 02:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FgpSzswl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42C273D77
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330802; cv=none; b=SX/2RPxL+3Ih3y2rpLZw/Rd6IxQDmLg5ZPen3auYgko7Wz61QLxiP0heZ82OJC55XFfMHc3tzzKuXpQS/w1Pna+GDrn4sCec65Uv0JaV9VXn7dttpBD8hBbBIE95Uj3URBKjMW3EDK4QthQ8fwinEZWrRqR3wTcFusToXBsc2eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330802; c=relaxed/simple;
	bh=5WaUFU3bGZiPd41PvlAvIlK6JQaJ4z8q5ub2AgYB65g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biHa0rOVZvwL6ZhonPo5kS7tiLMSEPmxKyhYUhmAZpPQu+WLdcUA0kKYKtObZ0ihrqg8bUe7TNCNQ9xEtHrDKtRtUlrF9RRppJjVT9fgaLek6xtjxY5zNByDgh/VkbDaQxbCTkRzYSYkV27HX+moINfE3rpuoZyoTEVk3gueXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=FgpSzswl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48375f1defeso23745875e9.0
        for <stable@vger.kernel.org>; Sat, 28 Feb 2026 18:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772330797; x=1772935597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1RCAALCUk9Fp/MgQGMAl9mSO6ME2yBDRqbMEN1gfDt0=;
        b=FgpSzswlBKqVXpYTjAX+k+K0xU+CzhPwVGjo34Uxnp+tCoJ9qUGKI30vVG7C4G8LzG
         iSMQgxQtqkzfDp0le/SMlHy+HblfJSSmMxdqM61t5CBqGoqm18EEWSGDK3sqOX6QHg/R
         bfNNTBnIy572QuU78sf6DO9R0ewKyWxV3Sacf9iMoKaAY/dGKn1EfDBYkCfz9uJn24P+
         ILobuFboNi4S9PVzLWxCbkKlOWYmUVR5yzizoa85ZzAwoyBFXyKw9H1282pmLeu2jrIL
         e01Md4TM+yj9JKp5vUqh9l5H0krINk9l7dGLxkatoCWbqUUeD8sTxAnIz5KQSejD4ONq
         rWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772330797; x=1772935597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RCAALCUk9Fp/MgQGMAl9mSO6ME2yBDRqbMEN1gfDt0=;
        b=Qtrg/H0YLV3hYX5Cc5vtUb8OCtlJa+8mf+SqhIZThfM1+p6ETIU4837ozAfC9JslCw
         MinKIx3e5Rqra4n2O+Ph4sTpeYQwIx0E3fbDI9u72ombH1hi0iS3OP+UQf/5+WnkNky6
         j++6XzAfqJmVxruujCrO46dflfyy4edIBn6v5HleUjBkEWvIJFeHIQnhHt2L9IJAgGpB
         L1zjnApmxnHz7iYeyTl7kro6czQgUWS+Yn9lJV4QltKqC/lDRPlgekcz8muo6VXSdTay
         X7sAOv4kqZDRt7OJOA90hi7yXvVHvx3s0zMF7MCSRX9JOuax9ZJEcVmJgKPEFM/M4IkZ
         wJcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwbEvuUyi6xdE5y8B0mFAwU0f6Weko/nN9j5fchbgwXxY2FgKeFZKFOjrUkqkIdu/fmKtyqPE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp9NzwE0BszzPDd2m9mqomwdSoFrcNobPx23U5F4v1bUF71RhG
	LK9k87Yqx1bACm+LUNKnmYcu4fAH3dS8pXwR//3sm8u+oEbxKGBm39o=
X-Gm-Gg: ATEYQzwOtvL6XkDlw09xwJ//twjJI/mRZLM6H345BZKi1/EfUksScColxbtL+6YDsvC
	TgR+2YB8CCdYnKckpz/RQ2uZ2p2xGhvfRc/xZY5wBBEaZLdEIPgzYVrEDVH6n9NOfZYTc9vnzDx
	8spsVcYPkDFJrLAe5ENs34Y0H8gHHAak8DwBuSPKrR4boflMxav6Vzw2WZEsyfcKRB2aGDxY1su
	umKa8afvcroF9d8dZJKRoyzaHflW/788iO5RZ6A32hjbyeebLa1JxQnyXY5WDLweFofZlziObPC
	IsVUZM4FpZq7Ndu2JbH2OwMqH8jV4ozgwDTmm92/COpZpDWPi77nBjOH5BGiNUbCr+em3v8x1p6
	vvX/v2Civ5hxy+cKjKKRoYhT/CyyU3kGte5NpJ5K6SFMEQnfRKHCq/+Nj5/iTpbyiZiatNcl1xL
	e0BkqTPzmzA14KtOOU63iMZvXU3VnKnsy9WvwiNicNbyHSQjZzUycEOO0cQ73fbibr1Xfb9slUe
	g1B
X-Received: by 2002:a05:600c:6388:b0:480:4a90:1af2 with SMTP id 5b1f17b1804b1-483c9c2c2damr139958575e9.35.1772330796525;
        Sat, 28 Feb 2026 18:06:36 -0800 (PST)
Received: from [192.168.1.3] (p5b2acadf.dip0.t-ipconnect.de. [91.42.202.223])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm326947105e9.14.2026.02.28.18.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 18:06:36 -0800 (PST)
Message-ID: <a71fa783-743a-4bb0-89e7-5ef1beab3255@googlemail.com>
Date: Sun, 1 Mar 2026 03:06:35 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/752] 6.18.16-rc1 review
Content-Language: de-DE
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260228174736.1542240-1-sashal@kernel.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260228174736.1542240-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222389-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,mailvelope.com:url,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: E997C1CD40C
X-Rspamd-Action: no action

Am 28.02.2026 um 18:47 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 752 patches in this series, all will be posted as a response
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

