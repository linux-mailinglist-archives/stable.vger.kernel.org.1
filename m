Return-Path: <stable+bounces-248951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JtCLe6vB2pBCgMAu9opvQ
	(envelope-from <stable+bounces-248951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 01:44:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E7E55968D
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 01:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC35730067A2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 23:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F5D3F86ED;
	Fri, 15 May 2026 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S+lMgV+u"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7373F870F
	for <stable@vger.kernel.org>; Fri, 15 May 2026 23:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888681; cv=none; b=r8jDvAIB/CL0g+v+KCNI+LYoffUxKMer2cpKLqR+ubmQ6sFiM9QNXPJgNOqUMzjDLvxHfjFILALIKWLWrfTAHXOl1Z4XZwlIDLLUhwld171ffLkAW9WMwZPWkj9NeathGqtqZ15sX7JLlgi+mfg59IWC7Bz2dPt55z+Ifw/hxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888681; c=relaxed/simple;
	bh=+oBfv3Oyi1cE8l+4UZm36ckNGUo0fRZSHoWm8MIjkeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SdUkoPdDK71+7sj+sT+Njg2RDsCG+Yr9+46oBK9BuiquDQpbUP3MOeXnEl5fCBO12Cf5UdVR4l7PAKDozDXU6qhvWijKN08YHkWMAJNj9qMrLS8fUxae/lkWIUq07b+O/1WniFZVg27r9dWEeAB6dddy67JiL/6Jxx8GuT/NZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=S+lMgV+u; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-453903ee4adso227803f8f.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 16:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778888679; x=1779493479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uI/ZMRMMIVV0KXP0JmfSEWHkKDeeO/qgX38oN12IgDM=;
        b=S+lMgV+uxL/zAyRCAr8lRYJCLLceVrAGvqdCyrtFJmqXNQ7rApVDIao3eRzDueNwey
         HNqcjVuUSrY/EuuZEfoU1zExjUVEULpr4L1VM7qlsiY1TY2VKtfMNcTPg4y4L6IZAt+a
         wagL+5FiTVHb5tCC76VvzffyB5iItPWPSTStLDqfAOr+yVc9mwLmR7DCvEYUTzUgLvLN
         jk8CYmXGQN6K2A0zvkKM8/pTEvrJWpvd+l2HqPXUP//w7XEFdcrxgUf4fTSiZNWxaX61
         DawrmCQTl5d8rlCh3eP6GaITOGdgZ8nPI93sqDxZei0I2J9NlV7MzLrJwq+FQiir7na5
         eJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888679; x=1779493479;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uI/ZMRMMIVV0KXP0JmfSEWHkKDeeO/qgX38oN12IgDM=;
        b=M32aIK1U2nyY8BwtLsTbdai9/B+vnO3UvAXEN4dI10Ajd5RlGRagSbO3PjnT4/8rlP
         33qMcwiB6NO/NHsmcLuDv+Zn+xf0G4Cddsf0dYXVj9kApU28hYYldGq02Qmtbu+J8Km2
         wIkTSX9z5DxRLvMlDpPfo3sSrXnJ7/lLDxUm74Zj24t202xcPXgmanTjYYy4yhwWl18n
         LpLijJNxbrhKFYKypAzDYy34QzYJxwHtkkuUJXNa9TJP28inY/1AaKgPKEzWNSAHUxZ7
         1GAEws1NqScQqZr47lYq6X+NLxg82ZXfHRLLPPopUjkLkm+/1LZmrYNTmzDMb1pg6Phd
         2Dcg==
X-Forwarded-Encrypted: i=1; AFNElJ/2ABx/BMXFjFt2ekljUCJFi9mBmbUl3Ws7k5qcWdY8ZVo/YQ5N8Wc2qoaFMnu7Fl/948pGrhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh7VioSkLbocObSAWehbiLdZawR44jf6WYm+YE1khNPERsa6x+
	wzLC6NpOcx2ScNUxePZmjkf4kZorbCKFdlWnYYlUiLNwWlQq2JZUmQA=
X-Gm-Gg: Acq92OGIwAhwAYoJJ+8dBq9egIkK8BPUwUACE8JWfwvrd4MTsf9pPeflZEQMr4HyuCe
	mAiOmq8wZPyiTRxQN7Ugvu8wcfw/q9J387IPKzivjAVOzZRp5QS8AslaSEm4FohANrZ/nvPhAa3
	MEM7S+4PdULOcYjiSNl/w5g7CUWMGfX7cp+sP9IyEopfhTQzreWMy/pJblonJuAMRslWFmm+TsU
	MmQwtjRRQL9HD852EZsAXiq2Daax6kUbPFw5KaMpfNp4uIIV7oamk2LknxruE/67doIiGEN8DWH
	hgLFI52b/NiWBEhSzRTJQmhMxhkvaiw6D0FXQEqaigix/8pE3NGYJdA8xU6udsLAQaiKWYI0MFw
	0C2sUIwsu7ABhLDx3hhmRUzMSk3ktULR1euoaI/ZZ0Ol9JNzpYtDR21wGaSSepZ0C0RnONiVan6
	kmg9uS7yZiVzanWSRlSroNBt9DQRri9yw1F52P1najfzKizNK59+wRXhySEybSaUNb3NdcSV41U
	7I=
X-Received: by 2002:a05:6000:4010:b0:43f:df1b:9e07 with SMTP id ffacd0b85a97d-45e5c5a5580mr8303821f8f.42.1778888678705;
        Fri, 15 May 2026 16:44:38 -0700 (PDT)
Received: from [192.168.1.3] (p5b057eb2.dip0.t-ipconnect.de. [91.5.126.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe248dsm17476318f8f.30.2026.05.15.16.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 16:44:38 -0700 (PDT)
Message-ID: <d66c3ef3-23c1-4561-9b52-3304c347bb30@googlemail.com>
Date: Sat, 16 May 2026 01:44:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/144] 6.12.90-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260515154653.469907118@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 59E7E55968D
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248951-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url]
X-Rspamd-Action: no action

Am 15.05.2026 um 17:47 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.90 release.
> There are 144 patches in this series, all will be posted as a response
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

