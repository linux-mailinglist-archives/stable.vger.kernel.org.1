Return-Path: <stable+bounces-256622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNmQCsmJGWoJxggAu9opvQ
	(envelope-from <stable+bounces-256622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:42:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C412F6025FF
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95163307A862
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C83C3E1231;
	Fri, 29 May 2026 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tJEZq8rs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A83B3E1688
	for <stable@vger.kernel.org>; Fri, 29 May 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058488; cv=none; b=HIxq8DV9UyMgTWijZCSxIWI59LY2Am4PEr4W6QRSebbcdMDhOwTGGG5n2z3LbdlahUMUvWDhyCUq7nGLJ8lgf9+O2tPzlRx9h1Vd+ZygzzuBj6PUnPazCfgu4FHtvt5YBB69VEFKrJTlItnEJU1ib4BJeY1E5OTKWkJCyYOwoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058488; c=relaxed/simple;
	bh=YiDK6n2b1QGMLZO4K1qXgkhW0GAIX7vsmRnLupBxlRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0i8ceTPJ23LUbIcpqJWCwVU519g0rGDQTXIZtx8P8K2L9lDRDyn2yrlD+s05WL97imL1bQf/7F5Qc+Lmzf5e22lINtYOLDEy0Kr1S5fnS68C/xFicR18GhZ8ke+UmQ4EWEg+lKC8WvDJM0HMk1nOYNtcUcNs7D4YyRiU7PevXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=tJEZq8rs; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso45336575e9.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 05:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1780058485; x=1780663285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QJtaZBNX7TDfrNfEwglPi8SAZdfZecurqD9zImFlbIQ=;
        b=tJEZq8rsZ4F6d9Ha9S863eWwjjeoRj0DLDF3GCKC5mDmJLvT3/b2MlE9aJwkDMekII
         wJxrOrX3deumxy3TgeNNyY29Z57AmVqZ2fMO4mTTZDs3IVqo5j7wfZHGzsSeaLlonrVl
         +hB+29ZaL7RwzqJ1bb4Q/qtg4Br8Dl7ruAQLdCI0Q0m9DvogW+IHjjOtz4bzDRWmEIGQ
         lwew7DsghkjTkSw40oMyXT3w+PgHGpPMhT1GSh4mp5FYF9rrg9Xnj/E9qfr5vm7fzWjJ
         VheYNWWmAKKgxotMI6W/tB7yzgrE6Tj3eeDqWjbyWS1r+pbldYZIgmbkGLvdJGR8c5ut
         TYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780058485; x=1780663285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJtaZBNX7TDfrNfEwglPi8SAZdfZecurqD9zImFlbIQ=;
        b=JkXBl2GnKH0JEnT0we+PbI+mgiy5sGapgef0f7+7uH/gWVlh8nQam8+hh9gegGCX13
         5g6XOnRINQE52h+kBnhZiqOv40HVeInvXt+JVqblfrX0TW0OwN9yjggp44A4tQYGObbq
         NQZevGzIoLmvdC7DUYk+CfSMeSv0hLtPhc/1DxgUZd1fccIzs2NbRMHP08uE0BwnmaUi
         cV0VLFleuTtvrhjgxdRZ7YlnbeRrXCs3IhFLstI42AvIYhXXgmALoxH2InpcgZ616723
         o3/FQXaCjcCQXMblwf/RkDn1ViYxCmfMIhUKcPaxZAnHfReuDujQRxJy5+HOpkdpUUNi
         i32g==
X-Forwarded-Encrypted: i=1; AFNElJ8N4vcQg06pwilAck7ezH6f5+kJS2KUvayWKDMODywgGw+cW77VLZvSYDJp2ugz28qP78o2CBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnRDMm4Ih3DNzn1INUDbO+vDIlmVad15Gb9jQkl+pm6TJISsqd
	9l8hLeWZwd++9nyOvtMQfggVZbEdcwJn19mr0SDTUb0NI6/NaoBPdyM=
X-Gm-Gg: Acq92OGCJV26kaKWqcYC6Y61YVqOk0OsqRlFH5+ZEPCLPqqwv6tJuSE397UOF0wQntS
	E354sO/inXimiNys/Zfu2hqEyPG8K7STOCr7dseFtWuCEHT7qZMqQv26JPQMVmqPNlL3IlloXip
	SEVR4jNiH44Sa1mSRlxwNX2ZQCD6/D2S0+eaZO3vLVQLtvE1M8XW8dSl8uRHenptArNwUzz5/A1
	LaAngv8+9dRjDq6ptpbfoiu2ZDR8Nmrw6f0/K88+KvV0O5TfcUTHrOQT0uSp3y5YSw4kHHk3yXs
	slKI3GgseMltcaXhrMeAJQpUWxFoRFQKPcpYxzSDnLS44GjjOC2D1aWPS3H4pnDndg2ieeRUkOa
	x4dT8DynGj827uj3fEiOk/VQQayHip0Ix4H6wxgn9LPoZZ2mFUg2urGUx8BZUQBVHmQjx2KgEMn
	72NewduLN3clHWEyxJEku/kl+OD+2Bl9UNcTrggr6Cf/HpyxfgjpL0DYHMMKx5kjhnRnOO72TFS
	Hi+PMydGjQabw==
X-Received: by 2002:a05:600c:a40c:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-4909c0ba8bdmr29887095e9.20.1780058484793;
        Fri, 29 May 2026 05:41:24 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4ac5.dip0.t-ipconnect.de. [91.43.74.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3559645sm3319328f8f.26.2026.05.29.05.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 05:41:24 -0700 (PDT)
Message-ID: <cf7c08ee-ee23-4ddf-af38-f51c1e3196fc@googlemail.com>
Date: Fri, 29 May 2026 14:41:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260528194646.819809818@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256622-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,googlemail.com:mid,googlemail.com:dkim,mailvelope.com:url]
X-Rspamd-Queue-Id: C412F6025FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 28.05.2026 um 21:42 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.0.11 release.
> There are 461 patches in this series, all will be posted as a response
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

