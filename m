Return-Path: <stable+bounces-246696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA3QDt2uA2rT8wEAu9opvQ
	(envelope-from <stable+bounces-246696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:51:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9AC52B1EA
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85FCF30956BB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A39B36F913;
	Tue, 12 May 2026 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="W6uf35G3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D338236F
	for <stable@vger.kernel.org>; Tue, 12 May 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778626075; cv=none; b=AJ5Koia7qSaqfdxmSBRtr2VHVlBPnJy0rbs24f30xFEfTCfU4cJblfQ07uIk3pkk70w3H8uCloyEYmqlQzFAE3JnqAhw5K4d17BoiI+ENlUHt7/4+6Qhp0vRg5VxzsofqYT+T/QHT1YSSntv1GHPc/hj9XqCa2P7Nr6l60hqTF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778626075; c=relaxed/simple;
	bh=zfpFbvjNu8Qz8JiQuWtUBPET2Js7reg1cMZWRxqrmuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irczXryqFma23GJdxEjtEmtWBLzpB7+gJIhxe//ffPaTBcqh8P2UEtyn/JCyVOIywtYt4OtFpHK9A20VtSGy1Wgqd2RT9frvjHU8wtWpRZN3VoTjIS7CXKS3ZXnDAPfz9X4pWayuezFnEg/T+rb2zOVsVfUDQrFKHVnjMwtkcvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=W6uf35G3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so38139695e9.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 15:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778626072; x=1779230872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZBq3xod0iZ+2KYlXZD+8zZsLf/sBfNo4uGCP/2E34QY=;
        b=W6uf35G3ZH+0izXGwdvbi04G84j3QpYbS/Nootvj+Gx1Y8ln0LlHcDJf1RYK31gFmD
         J66PI6+Ng3phZuNUi4FwVRTaE71nJTkpXpZawWDPCJasXy8K+DjcWxiD3wOFDlEHV8ag
         NPvotpWe7HTQlD8cmT2GgnhHw6nJOs8baA/nEleJMVTDhbCaSKlsVFW3lJ2IzvRDyiQv
         SU0zi0nGQ/8GIFVR3Uu7voiGNHrTpY/itvNxvlapBkGrFJ29yomk+qEv7RJgCan9StHt
         aBO2/jErmvLG4Li3VxAdiLPZcLh4btNMjW5Yg5gK9Tibw2Z+OBXuxwtOyqYAanZ/RMo2
         UjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778626072; x=1779230872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBq3xod0iZ+2KYlXZD+8zZsLf/sBfNo4uGCP/2E34QY=;
        b=TLjDFPMe2oFusA6Xs9jv4kRNrFSH59rbPTtSMxQqr+/qpEShdHFO1HubYmHOqT7AW6
         EmklWK5+JWLxa6btpnDOucm4AcDnp6qBf1T882dFK94YzLenIIeKc9BHU+245CMkct09
         3P/zmri7Mpu7eKO8j5L+nZQznRuRCOBS/D89ofWJrjsydss+j7RSxWI+V5RgqEur7i0U
         B465OvaHm14jUCcD9Z1sepPg6D8vSQoiJAyP1vnXZQWCMRTRPVxTMVKnm6dyBcG+DuOJ
         z46+9qKd0gfPeIaVK/CMadsalwQyYw1HNiik9Rs+uPgeWV+bLNJR/K57BGiiY+rsMZwt
         F9LA==
X-Forwarded-Encrypted: i=1; AFNElJ/k/nh8FUQpbaQ6ciw/Okka+XbaWaQqGMCDuAts5FBIeWplIzzZqw7ipoxoaWngKPvnK409DXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHDQ7JT340wDLpJWZZ2QRfq/MjNT1ZIvrNkCvhe0BUZu+ojeI3
	YfoHaNFMS6ZXow9uU2ulnMpngWDfJZ87WjLXvkYT2HN/0a7ywDWRfA8=
X-Gm-Gg: Acq92OGwie2u21L1M4JUZqbaUCIGRl1l3Ggwe0WfC7xbCsf9ZZsYKfeK6hD4STEGoXt
	BOsXTZ6jrxYV6KXrueaLlv8saFNQfaYdyXxi3E5tKK90eDbQ8c/H8i4EWqLtAkop9Op388T1xJK
	6gYb+h5no/f2W9g51bpcO3poXoBC6ACJ5b+Np3T582Pqlih6K2Qlomx/YofXO9wAaOBUdFDp8WK
	FYxZTiTTEnmDBLT1TUkJP/vlfG6jJLKyHdm53BvrldK7eodVdFcldDc1biD1Mix7D4Qi7U9E274
	ehwMxYs6i/8AcjCseB7oBuFCbetnoH6A5N3jtYkNLjS1K0/j8GmjIKS3kOqcAQXEIBDes6vvdYq
	5iCDXioFAv0rpj9LJRkvM40Qj+fdwqClqCdjd13zuBP9XLLkSZqJNyWC9ksUq0ih4y73MS/EYYH
	37nVPz23FTOwlVSKjMPB4SvFAQacM0VO7kDIv9QkUGO4hUiK+WibpA5CuhItwGwDj47zDVX1klO
	hI3xrekShO0EQ==
X-Received: by 2002:a05:600c:4ed1:b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48fc9a41e96mr8792015e9.21.1778626072062;
        Tue, 12 May 2026 15:47:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b05786a.dip0.t-ipconnect.de. [91.5.120.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d27d31sm46408225e9.8.2026.05.12.15.47.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 15:47:51 -0700 (PDT)
Message-ID: <d6770326-38d4-449e-a3a5-ed43400726c5@googlemail.com>
Date: Wed, 13 May 2026 00:47:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/270] 6.18.30-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260512173938.452574370@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC9AC52B1EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246696-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailvelope.com:url,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url]
X-Rspamd-Action: no action

Am 12.05.2026 um 19:36 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.30 release.
> There are 270 patches in this series, all will be posted as a response
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

