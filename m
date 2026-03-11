Return-Path: <stable+bounces-224615-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PZDEjfCsGlSmwIAu9opvQ
	(envelope-from <stable+bounces-224615-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:15:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC6E25A492
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87D663055F94
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D5B26ED5D;
	Wed, 11 Mar 2026 01:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bVMDtzyP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396334CDD
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773191730; cv=none; b=p2AnISk1b79vgJaCkvdCdsMPW9TH3P9niRVuk+2VA5IjAA9+j8mF6eVYnvYLsgbreSpD1ZbytckP7APVcRUxXRm9OeWxGkFcJZZ9RqnmaIw91/3+peW1TYPixcaOkaDDoit+AChVe+vMnhzYM+R3rIjuHtIZVONThAoeIMEG4K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773191730; c=relaxed/simple;
	bh=e5WdPqbigc0gFpaeKgAYvqcpgYmUc6LxRC8JbxuQJaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JH31sMu23aYDTilLwt6uAvUp4OhYE88HuhDzUYzU1r4jH83+TNXcOSqwifqUDjnCjam2aDp07ZYBxsG5DLEgYnWS50HVjjsViO2MimcYbzPuU0QvpG8udzl5czB7CZY23WKx5osi5+hqNGrAOEzKK0a/lZWVcZDoLbXv14hBQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bVMDtzyP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-482f454be5bso4936575e9.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773191728; x=1773796528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xXhD2GoMczx/1OfEQmMSJ076ACkSGZw8MD7r/tb1zlo=;
        b=bVMDtzyPXkgA74UQuurziBFhnt5k42xKig7NAON4eqfua54IiDSIP/8K6zqcVAZYdX
         L87QOh/OhJEAdV3XR/LB84xlX7+PIFMGQneKdTM4qQ/km2kTHPx2Fg7jQj7x617ymQXB
         5eiOGRl2lstZD9PfkJS29WiIUHy7Y5UHRMLcIkNiPMwE88V0RL16CvWX5qDdJdxPW0xW
         hdtCbSr0yYRBt4xxEcLBS1Li+ClXvMgSal6Y6nd6LhDAouTDstApsdzJ/DM51a6sG02f
         xi1cW9AbsR1FPArm5utMPvFOmXeS+WzqUuOkSeUMn7MOrVwbMS93cKj4g6jb41LtrR9+
         8mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773191728; x=1773796528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXhD2GoMczx/1OfEQmMSJ076ACkSGZw8MD7r/tb1zlo=;
        b=TDTx6CWuInc44XUR+ZpuD6IPPL0p+O9r2vH2kHp6cOiYF+Y6nu3Sppt9nRTLsnY2Kw
         JvedEu9OQ11OtkDvdY/aDqJB6tQ5Zal2t723IlY3HZDac2CMMpaLYvSia9u+wAD2YzPM
         nb5bFMwxNmvjQ2sy6MAoSxMxcLnxPQMeyFm+YUJwWQI4c+k3GXW6vq6cjBHUlQ8ddz1O
         +Q4GfPsu2MjNoPmulj+mhL2OziKgRL8vrgfNF3UCXe0uk7iIDTyF99kUTS1M7j2Ky/jL
         CtZ0aibD76LuCn8fAgtpymImj6UmVg9ElDOLMMXUG8kdSpiTj1+b9JEKp9npPgXXztHr
         6sOA==
X-Forwarded-Encrypted: i=1; AJvYcCVpn9E3tDCOMFhFSEOsQ1mUz+PAbYdF60KKaapu06do2ne6Mw8u1mvFcLgNJghogsj8g7SFXSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqQsWFMeG2dbVXR1gSIHhi1vrKGL7BAqTNj9L9FJYAFHbjg71+
	v8S6V//xXHNlkwpVet4hJJ9Bv9EeDvTTUYG3ZilTPbysD7nHG8K5fNA=
X-Gm-Gg: ATEYQzx5017b8BLc+B0ACTKFUO0tHyzvEvJyniudwGOx9Audss7QrQQhGHQ9uJkyp5L
	svE/uRFWUakQ69bkow0eAEgOiti2tRRnTIkImONge3K3JsRuNzvyyMs5QEhGgqrKxHjA4v/ZXMT
	5TGvqp38nCKOTjmhafgEgvxvNe+eTJLlD88cEM6es29nyPH2xmd5rx70jgto90ZjayKFpWsc1Tk
	3MROtYTmi+95GoG/l/MchIs8DWmDlGWwut5PhJsgfEZ81IHO5UZrj25/uc1NKdtdQ3IYPJ0Fub3
	C9uReYpK+/OePzeTH60GnDhz408+diF3qHvZCkgk5GV0S80nYSRSx7JXbCGRz20Cnq0EHEJzK8N
	D1AIUSuYb/+wShTktLLiHIOXljIbyO0rfE1RxkJKa8SX36Y67u8Tqzb2NAuI6uuKlS3NK1I3pjY
	bobOUH960hvnPHS1fiEJaxtc3loB8iZpZHJMOljEbqWb/ZRQ67x7pj02yP3psIcxwPOQAMObaDP
	8M=
X-Received: by 2002:a05:6000:1446:b0:439:b775:fca2 with SMTP id ffacd0b85a97d-439f8c0643emr1267352f8f.24.1773191727593;
        Tue, 10 Mar 2026 18:15:27 -0700 (PDT)
Received: from [192.168.1.3] (p5b057cc4.dip0.t-ipconnect.de. [91.5.124.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm2091105f8f.16.2026.03.10.18.15.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 18:15:27 -0700 (PDT)
Message-ID: <45265f4c-99fc-497b-8ec6-e0c45d413b13@googlemail.com>
Date: Wed, 11 Mar 2026 02:15:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <cover.1773140654.git.sashal@kernel.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8FC6E25A492
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224615-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.717];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]
X-Rspamd-Action: no action

Am 10.03.2026 um 12:05 schrieb Sasha Levin:
> 
> This is the start of the stable review cycle for the 6.19.7 release.
> There are 311 patches in this series, all will be posted as a response
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

