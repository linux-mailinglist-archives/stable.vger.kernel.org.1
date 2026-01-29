Return-Path: <stable+bounces-212740-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFPBCu4Ge2maAgIAu9opvQ
	(envelope-from <stable+bounces-212740-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:06:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A603AC6A1
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 08:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74EF23016D18
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7173783B2;
	Thu, 29 Jan 2026 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YxYs3RSL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457783793D9
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670378; cv=none; b=leWxvj1r5X6i+h0KYlBDDRq0lH+r6CvUp/yEVBEa1nKdIwSAcy/U35Umydvg6PFg1aeXNvKAldYUlaTg0hVTC07twQI3ZNx2fIXHsyZ+YXoeNBseT8hVI5iQFE7vT2ajbtEC9m26LME24DlevwYziiJBHT5gRHpDqYMTwjniHfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670378; c=relaxed/simple;
	bh=NiH2eoG7zgP8DoTvCiby5vxkPXXj50mzFtxKUu0S+9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChKcXCl/+9GRSPUBsAnaLDqT+T6W+Yu2nQSFrRmDDRSQxwx9wUtl5IsgIEH+/Og82uCw30idFkwvoNo1bzFdEF33GL3lMlhVl/+uj4g4c9yzBpbfOd6mvePrzXGq99Qb6WN9vopcKDxQZICQVWLYr2A/0qYB0PaPEb2x+UiYtSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YxYs3RSL; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so5572245e9.3
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 23:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769670376; x=1770275176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D1fDF63EvGuoA50Iy5jKQKMvTWmanzhkAdtgMnNPQ6c=;
        b=YxYs3RSLTkXAZI+1aVM979EVIBkoAk3DoD2NagOpK+sTCZtcdw7fwZD/MWL1Osappc
         2wkT5V7pU27b+izw6xjOiSpuMT3ax74KLM4IjUiBS90PdeXSX8usuw4nXlw6QyjHnvBP
         Kdt8CYjGLqMIGJqGySQXKeUMiN87fhcBjDdP0O66zVEnsSZmhuui/t6ymc1ln2jeWgUE
         M8KRIOX7zweemlPdRD7+aLKLzsyGER21Hi4b8rkYZ9Y+i2nFseTQ18QPejguNKe22/3f
         WVQa8H9RcW78FnMG3M5Yy27dCd7rRKM/wYGI5TSMMgbsJuGkWNYzy1EsXr2n5yCrfzPa
         Y01A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769670376; x=1770275176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1fDF63EvGuoA50Iy5jKQKMvTWmanzhkAdtgMnNPQ6c=;
        b=w9OQ8yOhZ5dsgEtUV5pyucbmECcET8XfDx79PPr+95TqbCB2x0ZBCx7gmUSU1C8Y4c
         BUQS06RKCTWdGNExak3cNIFa0d7u3mJwnKVv+ougXCd/opSfIw54xwZDs/4hUgnmsVs+
         AztyAtQXGBSCXqe4aUbhOS3Jz3+VnzwUtnSH2LwLSn6PYGWFTtKfXn5FnxNuAPi5qZXc
         LhZe2ZbMYJBVf8gQhXhM3XfCuH3aAhzGAAsjD0AhdsDEj3LdURcGRZsiq1Ds6KY9L5rB
         K1c8ecin6ZigDj/uGrBRNGZ1Rqz2BrWmRmY1balljzBIjWOidEZWxuN2oJW7vjxoQ1mL
         zXZw==
X-Forwarded-Encrypted: i=1; AJvYcCXq0Ujg8EvRV/F7UAF2x1pdyI7h7e3useTGkwPHwGgujVV9irfbh3XKE0Vbb+5J6UqsZ0bVqdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcd7CdrqpC6ITlD8oMKdO3CBrbKBu0pRxkOMDn3ZtHMpfUq3/c
	nd9Y3XfkmWaqHLPzw51b6GBMRWB26LUwQQMS/K+tzVD4BF8ANqTKDFSn0Yww
X-Gm-Gg: AZuq6aLMMfUjuRAvVLsj27v4CVVFUbK6V4ltdtcuvqaUfB/oBGni1K7Y/KRyuxm4HYW
	VPed8oqT06cw8NL57bq4B453mDi3zykPQCfPGcv1PWoS/Mdq9Ita0QmumYtL0Zb6pEqNfIj8NoX
	CHEWAKaEi1nE8iSWcSAoicuZzqZM0XEUAeSj0S+98u23atrW/UVlayVS0zK57A/WWwqB3d5znZZ
	KeYYTVPJYJtZ03mw3mDUs+1w3y4vwJnmiXPDWSsr08p9vRHuC3JwjCWYFx/oIkZ1IDTZcN3/EqZ
	7LCkXpzHkziB+CmPr96OxV2easrPnXtDv5Za+QkYHd7Rg52qg5gdd3L1nwyMq0XbC7HMrN7yQkK
	7WzgB3ank95oNuwkf3kygP+bUpiUH6Gt09BcFmXPBuYsUbOxxTB27OQEh7sZnWH/Zgtw4u3hhnG
	FDAhr2+RECxk9+voVEUIMw/ccsBIIS9cEsa12F3Qv4w093KS1kbMhsGORdX+KS+g==
X-Received: by 2002:a05:600c:1554:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-48069c1c2f4mr97740075e9.12.1769670375441;
        Wed, 28 Jan 2026 23:06:15 -0800 (PST)
Received: from [192.168.1.3] (p5b057921.dip0.t-ipconnect.de. [91.5.121.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e13235f5sm11662842f8f.29.2026.01.28.23.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 23:06:15 -0800 (PST)
Message-ID: <7678fadc-e8d7-477d-a422-6e4aff345026@googlemail.com>
Date: Thu, 29 Jan 2026 08:06:14 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/227] 6.18.8-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260128145344.331957407@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-212740-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailvelope.com:url,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url]
X-Rspamd-Queue-Id: 9A603AC6A1
X-Rspamd-Action: no action

Am 28.01.2026 um 16:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.8 release.
> There are 227 patches in this series, all will be posted as a response
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

