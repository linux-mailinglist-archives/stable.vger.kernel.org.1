Return-Path: <stable+bounces-248961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8L7xCR3NB2oRJQMAu9opvQ
	(envelope-from <stable+bounces-248961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 03:49:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C05F7559D17
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 03:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A1813009F49
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 01:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B828126158B;
	Sat, 16 May 2026 01:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i8LyHmu/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C32239085
	for <stable@vger.kernel.org>; Sat, 16 May 2026 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778896152; cv=none; b=Ox/BW/OkcaPdmQwuDKRua12R8ZPP5sXqiRbSdcCIowu3MR8a/9rVXzU8cVTApGpLZohOKa92jBwKO1ZafIQtdvz6PjTfqSauhqwOHjEd2TFHBV0rjsWRUu/uJDTD6XtRRhhL0AAb0n5ZBMCFq8bv3y0xvH4ncCO8kkQPBN0Z1K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778896152; c=relaxed/simple;
	bh=x3HusSs63/SheGN+SpDKAof+n1fySvBPmjTura8Q35Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gTfn8MTv8H8+1KHfjvmUwAbNUORlJBpNcyJNXjH1czYwQZxFYGDu9WV6Lmm0i3jROhQxZDlq2VxPyJNiDphuwe/tF/eCVaOrZ/3cDxUpec1LxxXKbqeV+t0tbl8P+u7n7TTv3DEGZfdRC5xEmy3cZUZVhg83EWa39iMsgh1NagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=i8LyHmu/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so5545195e9.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 18:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778896149; x=1779500949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=shX0sal4G18TasCZZFTwC/x0WsI5k3GpFQPE1No8c5M=;
        b=i8LyHmu/2gOUTb9GYS48kdKswnwRRsP1NmNxh3/uRAR+7OiCmg8MswbBr0P+KL4x3z
         ZZTecS263eJ3LQEpEWNapbEQG95Wr6uM2/V/6m2OhKSmJIqtoDjgAPYMuV2HGwN2wX8C
         Kah2eI1DWG1722X7ivH6jX4mWAq3UQ2bUuD+BJAaXf2NKr64tnoAP7ieH79htw6UaLIu
         kvgTTaRj66ggqXaHAFQzh2VYgDDObTewt6OTXLkuwTrkRk45dEjvBQBM5WvGqQN0J0Qc
         foIGlybOnKrRZvhQ60M+X1Ex4dN3MWrDapZFr6jxCFPUMX86FyX4i58JJ6bdCxR6Yl4K
         fW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778896149; x=1779500949;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shX0sal4G18TasCZZFTwC/x0WsI5k3GpFQPE1No8c5M=;
        b=XvE2k4n6EST3/DrTnRRLR3OVu9UQnlZwXfpN/GEO0ajDHr2ucK9MtTycBxtGMleoVw
         911x2z+Jn9X4Zr/xygRlKvu2aDFRMm1oX3c/vd3cIsmPO56xBv1dztTaPrJbf7rg3FMb
         QpAkQjGUXbp6uAMN56FL9qOn/cA+O+K8kHLKhIMgGHjN2ujcHpTWVILiysANZe4b2AFK
         XPlndwXrXsVNu6LIXtf5pf11rkCXI0DS/t23Zq0dkfbWZId/ftnpXPI4RNFF/1JPxjzd
         fqlVi3gxYZvaiWTIHDOYwz7n1fjR3DgGk4A2FfhTJnTF8/GfzFr/KyyJXt0222Hsm9Gs
         8mUw==
X-Forwarded-Encrypted: i=1; AFNElJ9ddNLeJTy1WXOsqGigLkKSRIxbEgdzXaAjnANzq4DCJ4zs3EgyCZE5+51y24LZ0czpcWaUjus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzvepNEDvkiNqReojgBNOdSKPLhpp0EYTUWnlGqRD7rdd82mOd
	AGbgKbCK5Sy8MKVphwPuCVUeYj67zWcxVWCtPc5fiubCX4jBeT0DB+8=
X-Gm-Gg: Acq92OHRxivKm+Vdh6zyjTnb6dpmS8Puk0IXajhoELoKIMAVPXec+cNEkZGzOcjrb3o
	IYWH9Y2FMBT/BG63eLJxynwywG6Zl78MWU2c6pXucV1xV5zgCWpR6vo3QMxxG8UBs+KEj8G0SVK
	MqXfippWi/eP5Utwv12zgc4i6CcNZl2TRMVg3vLb9jgOxOVOmwaRUgmRLH1vEPUM2+tYokn87+i
	KpjDGjv1zRDPL3+3MZ3b+1pctYoTw65oaUbRSDGcMnVTSpAchSNJnmIQ0FVbHLCAC1rdHE4DZDT
	isuCdE/IsB5dfDperXNh8zS6u+9RYjnmK8aYx7n89eDn1hqSvL3eSsaLJ7byx+nsSZY6FKAze8N
	6cU5B1t4cnXydYY3uBEnA1u9MiEr1oTnX7adzqdTBbZ4kJErWbpeT1BoV/tXek80Or+U0bOFXwO
	TWAW1RKKEysgUZ3BbIN3kDoCBiQQA5ABm14S5v6dL46W3HSHKNacVpxIIOO0T0iGzasEW2bmSVl
	7kg7FF1dTf5xA==
X-Received: by 2002:a05:600c:c116:b0:48f:e230:2a22 with SMTP id 5b1f17b1804b1-48fe6632e84mr69865725e9.33.1778896149200;
        Fri, 15 May 2026 18:49:09 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4b92.dip0.t-ipconnect.de. [91.43.75.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537ccf5sm96975305e9.14.2026.05.15.18.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 18:49:08 -0700 (PDT)
Message-ID: <c4352f1e-c30c-47f0-853d-41ecef2861b6@googlemail.com>
Date: Sat, 16 May 2026 03:49:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.0 000/201] 7.0.9-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260515154658.538039039@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C05F7559D17
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
	TAGGED_FROM(0.00)[bounces-248961-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,mailvelope.com:url,peters-netzplatz.de:url]
X-Rspamd-Action: no action

Am 15.05.2026 um 17:46 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.0.9 release.
> There are 201 patches in this series, all will be posted as a response
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

