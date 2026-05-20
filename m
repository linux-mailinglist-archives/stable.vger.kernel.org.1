Return-Path: <stable+bounces-251822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOAMHGb0DWry4wUAu9opvQ
	(envelope-from <stable+bounces-251822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:50:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAC8594B53
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D676D3106EA9
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C33EFD3D;
	Wed, 20 May 2026 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGIiOCnp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85F36D9EA
	for <stable@vger.kernel.org>; Wed, 20 May 2026 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298979; cv=none; b=dmDJea1qwYWeP9ixGPrEjvFG1mGLhEpRXq27oI1gzaT0s5dnBFu94BAh7Yp9hjFYAqIGSF8NVkpHhKvT8wgAJyVoG8+2Rkexq6htI7B9IdEw7H4QsINKmXtvHuYY+l8+Jqfkov5Ej4y2OTtovdQdFV2x6gqLWK93msj+hw8YHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298979; c=relaxed/simple;
	bh=5LhrUVjkTVqEBIpSGIvDaNsaVk5wW6tsrMk1Hi9fI2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g/DcjFQ5hkGtNILZBEDFmfnaiW4GsO/iFkSYzSJPfd6xkkeHp5XS6nAgWnYiUvVFL8ZgkJ2GNv9qx3FZX3xJkQ02jnqZgB+XWwcYPeEiSW/1YFCxVZNUAARCfapen6qBZDdV9qFbXedwq32lF8oLb4fQws3zkum6r1jKeAIUwy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGIiOCnp; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-135e88b8e55so4115687c88.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779298976; x=1779903776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OW/DtWdlDcypcrOJke35ovA01mlOr73W7ESIIJo93wk=;
        b=PGIiOCnpQc3mj9dsp+XUU6Psc1UTtq1XlUMaw2axI1lUNSN0gkQgeWC+T6f9fdyXeN
         3iaV37eGuas3WT7+zaZwbCjC9bXYh0OsLD2xtcPTIy1tuZ/TwV31Ijj9e+E/KdoMSNOG
         NMgASR0gSIL9vQ2TJ74xCt2IjkwnaDbDlXVoxEf5cpGlJTb2jMl5ZtWcwz0zv4rchxAq
         sAfTOV/K98qIBVFQX7eHOr1UdJPYIzrdKzIyMsiaXD81XDZY8fY+p9cKpxYyKAQz99gf
         2xoBLVKmrE7tJPuyGnjUlERJCn+vXkWzwRmAUTtTSYYGoPLhxXJqtCc/Hq0ntws+Ck8m
         eS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298976; x=1779903776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OW/DtWdlDcypcrOJke35ovA01mlOr73W7ESIIJo93wk=;
        b=TeUhPTf0YDw3fYaBk/+WfAZXN57dVXPmy3W6uvYoCQ+VLfOiLO5Tu2Hbvi2ARsbpYb
         w1QN8jbyBGBsZNm7Hl0Cz8iV2xhB7nJqQyIq/wMq/BMfpnt1UGzet6hXLMrw7T/Z1eeY
         CIYF5W1T5zuTauJVTPjC9Et2YXK1MDttXiLgod+rxjDqw3JnU4quo+A1YUL6tbm9yPwQ
         W0XnMVaY6Y8i4CcjBGDTAkaGUAK+JY8RngtgEyRNKVda/Aqfu93xfysrCFRbtdlyCNyz
         Vf+nsBn4IIMQ46sfN250h402NJk4ovmDJ58/LRgCCNWK97EbrnrMUwDR0e8fra5Ttd0j
         bkMA==
X-Forwarded-Encrypted: i=1; AFNElJ9N9HHQ1hUHxNBeCOPWqgoUY0dSeth8uypnj0yQDxH77NgJvHggcHW5ovoogDtupyJYh/CnmJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTh9YIED6TfD0jbvtscH5lyltyrIkAuostpZ15NrG5PW3JP4kA
	kSd2qQByJUdPMd7vtI85FhLINEDiZ2gjL0iPdZLZlhrF/nQtJpi4F1Nb
X-Gm-Gg: Acq92OH3zKiL5xLwtRO/r9Lrilv32oh+gT3xgxmlTjk6v2D5zUeTDqfuSGjRG1VKt1U
	KJoH61K0yeV+kCvQWbeEfHg8eGreZ+zmZ+qpEEOvwh9x17tL6EQcI84O/jZWbds3mLKmEAnOLpD
	PsGn/Jj3yswE6nbesT2KOv3Jtg3tL0QO4rtfcGLvdc2UHqGhYiGG0U/7RkB3+GQ/bJq+oQMV8fD
	CkJpoNJe69AwkV+eRcrjL085eJ8LdO6fEMI/5hkvsdRYxJSEF0Qg/l1XplnyaACl8ND5BP4KGHd
	F1Zr3g/iEsC7CbA69yCpZoATgcDtT/enlGDR6GfqmTms7f9hjwWvmlfgm5LvCK9R1ygsIO/hJYD
	1byfB2bVuro5xSR3sa39EU28+lv806VZpg8XbIhCNRZMn+iUCXvIbtFwVN1Q5hzRg+WlBvmh0Zz
	P/B9IbwXbfBPCRB3nJJXSDtEWLCU+Av+RGPIO0RNDMiXM8ochtQw==
X-Received: by 2002:a05:7022:6b9a:b0:12d:de3e:86aa with SMTP id a92af1059eb24-13505642857mr11363047c88.40.1779298975818;
        Wed, 20 May 2026 10:42:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbcb9ed3sm27488430c88.1.2026.05.20.10.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 10:42:55 -0700 (PDT)
Message-ID: <cc909bc6-42a3-4d35-8c97-fb31ff3840f1@gmail.com>
Date: Wed, 20 May 2026 10:42:53 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/957] 6.18.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260520162134.554764788@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251822-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Queue-Id: 0AAC8594B53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 09:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.32 release.
> There are 957 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 May 2026 16:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.32-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
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

