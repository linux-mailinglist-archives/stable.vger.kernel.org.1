Return-Path: <stable+bounces-235469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFxBOvjl12n8UQgAu9opvQ
	(envelope-from <stable+bounces-235469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:46:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 016473CE432
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D20303012A92
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 17:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600723CFF58;
	Thu,  9 Apr 2026 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Yw/RNd"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3D42D3EC1
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756781; cv=none; b=K6p0ABfkv0II5zUkQqhIkg8L7GA671HG7H9GQsnV17mD6Hns+Jokn47V2A990ge1fXy7kqc6j2HTX5pLEONOXW5+/XL6rpSXsB03XKAlzPOgTVSwnjdmIdoUOgq2m0QNiyt2/jLK1u7/7mlvi4HFI0CUbO3Q6gyQ3YfkZ66/eJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756781; c=relaxed/simple;
	bh=57a7xxfAJFhR3+ynBeRHV1UtRucLAcay9csuJzC7Wu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N8nV9IP7ILn2lajsdiL7SJQL+homLC4H3ZfNA6O2vwPQhiQvsI46ilYVE60hmeC8nlSBWrqKpHi4E7MJhobkhDdPJX68Vc80y9YHv2o76uryXYQwDZumAkjJpbjXe4vLE+B54r97Bk178jXBNpxz2C0gw22snxdd4GpGLKJI8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7Yw/RNd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82ce09b4197so631486b3a.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 10:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775756778; x=1776361578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7dkiOk7ru+pz2NgaxSgxh8nzfjv/NflXfPpkd0541XQ=;
        b=S7Yw/RNdSTtnXfxebbkYT3F2etm5GJxkopzH+as0Ga4uvPbElmSdqVsvtrxkf8lHPY
         53nN779zC5/Dj/wevhlh/ka0ZjPLkR1N8vN3YmmiZr3Ow5vOdsEkQW7mBhyEAsFKnvOt
         SFC9Qr6UsqhM25wtqgcVqXutms7nIRnct5B5fDrT3sSI2DXCMgFxZPPrZxYjrgCihQxA
         5UJNB9L9wSAgb5bPgMTyFmm5/MO83Bn67wFV6MoMSOkupvv5BZhzZ+uSBwqoVaxknKLN
         n1/1a8xFJ+4ABrENMp1YnFNBFZNvSI98QDTWxukphAzeIiOr8hy7akpoyuab9j+rQq0N
         JEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775756778; x=1776361578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dkiOk7ru+pz2NgaxSgxh8nzfjv/NflXfPpkd0541XQ=;
        b=IxD8aWzSTgTEirUJbLxRMlGIbc8DKQNlK6sLOiQSlGUahKfpkQdQkiwrTHkkcuXvu6
         q+mZjoPZVHcQ5rniaYavO/50MeADmG7s9XNh1Pw+vQKvaUwlD5iuhiYKb/AYeAwEcdHc
         eX+dfZrNWIYIJh8DEoyEbN4IJ8emPa5rl0J7sLm6jMcQd2jsyx/rLz8DL8aSdDv6ma95
         A2jZx1I5pDcBs/dbcaF83MGgfNXC/SHxUA1Ud+V9LtfMs9iffSCfw3TOte9YcHHbhtfi
         WwLdaRAOauRtgpILJZcq48bCDRQN0CkIbfdRhQnLDSke3ebcLf0hdwDuzphsg3A84OVj
         ezhg==
X-Forwarded-Encrypted: i=1; AJvYcCXWRUnv5zYlLtdh/EmS3ZApFQxeUFZ9IWSYQ/+e9iXToDzrgGPS9LiSNUxMVtj3ffWBx7GDIDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBzHI15WynZaIOX34BIraiT1/kWwcvFOZsKAhTXRFE+zg49tNj
	MXXIK4vDTygBCz1ZN5nUzozlOhU5yPWXji2Ywt+LzM6L5HSBVd9gtTaR
X-Gm-Gg: AeBDievE/756bJG5UqeUNsZO39RAqJbinOB1B4SoVhO1gZQMEvxDv7FMkctYtmuOg+e
	RURr66KKonIApmHa95zQ4h5jZ/YYqAYvFRjGHtdCVtu/4Je2hZuGIgNLXX3r5heRqwmSGU8nz16
	wzsKCxLE/civbHhiXfZQefaqLgZaGA5GSTjTdbrDQChHgsyvOC0XqZxyBzYq4Yce8wAFYDmO0fW
	QQZtSUMciMVu1sjaANS6MQaeACm4AT9c4S7uWMq571ROP7XYT50cAPs82rohYGuBRo1BKyKUj/G
	cgJimTepzsYWNv3bFFPu77Cvz+eqZZ7Xfehly1t4R7vlYKBbxMyvCNbEqkbPYiqYluX99aDG/Tr
	IPLzB3Mcwx96SnwVFdlaPSXHQ32LrRu28iuPViLOzSNLBjyz9m4SICw5C/w21RJcirDl0fakR9A
	O292gqHiuCc35IH3ghlgoOyGGV3qcS3ZtqsR2wNUhAs0o4D1BBVQ==
X-Received: by 2002:a05:6a00:ace:b0:829:9ea2:3e17 with SMTP id d2e1a72fcca58-82f0c12f8c1mr151735b3a.9.1775756777968;
        Thu, 09 Apr 2026 10:46:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee4bsm57712b3a.2.2026.04.09.10.46.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 10:46:16 -0700 (PDT)
Message-ID: <2b8c4d81-e85a-4297-b064-e159cf41dc6f@gmail.com>
Date: Thu, 9 Apr 2026 10:46:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/312] 6.1.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260408175933.715315542@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-235469-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 016473CE432
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 10:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.168 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.168-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

