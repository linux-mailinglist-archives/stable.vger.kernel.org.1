Return-Path: <stable+bounces-259629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIqBLPa+HWpidQkAu9opvQ
	(envelope-from <stable+bounces-259629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 19:18:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3B36232CC
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 19:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C22EA303BB38
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F13E3DCDAB;
	Mon,  1 Jun 2026 17:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJmzWUdR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33ED3DCD9C
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780334071; cv=none; b=G1a+Xl+BS2uMCYsaWe4WYP7laBRQsu7e8Wfj/pEPVP8j/Dqb//wKbhepBFNyY9khFnplJzdVNccI7zGOqP/W6GBVoXk1VLNP2vL73P6CN80Zv4sYNKiDA/ImG0rybaUyM76RPKFJwo/k9d0zehd0YM77AKvEBUM2M6M6ZzRjZ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780334071; c=relaxed/simple;
	bh=Arcw7RDu6YnvHHrozBQqErDjIv0rUN+ZLgIh1ITCFS0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hX4t925trnBhpMaIH9EnWhFpH4xU5JDfIjiPtTUFx+0jYE+BYaiNbhu//QcnWK7FG8UUN7M/2+89IOUr6s8tRmGMyGqrUCB5k4wrytNdgsI7qaOi6bMgST21DF8FvAgOtB7+wfjYmXR+YSAv15RyGVOmIuICuW0PrrBFRihrFgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJmzWUdR; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-96395a77d04so1341114241.2
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780334070; x=1780938870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+RyRi+i9cRJsqRIFBEtxCh34w8MgyXpxo3mgchnEBr8=;
        b=KJmzWUdRhY0ScpGxo7OxQKBUi5wXkvAhipaqgDeoIjWreVAeTz8y61hdmwOI/jkPxk
         BlxEdBWSAE/MnGpTQ/zhlsmJcc7dbhnocWIkLZdDZ7IX7HgkLkVYexN4q7nTobmdM76O
         qx9XB3alfA/a9Bh9HT7ydWaNU2kjLhU+smIKPjWPzVcqKEKLRf2DYJUyHgsPj2UKMqRH
         M0/+643+2iz4qayfIKo9LJiwgbeSbd4ob2csjOfQx+YSyHRT3k3B8c4JbzfFqxsYG/PU
         3FXDgDHimKKn1060AL6eOCZXgU8YV7mmZirkNkJlJErAWvPHd8/S973cRRe7gP8nIKu2
         iShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780334070; x=1780938870;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RyRi+i9cRJsqRIFBEtxCh34w8MgyXpxo3mgchnEBr8=;
        b=l76DxrYuOYZjZdHdVY/f77I/ApoCnsT/vb0gr1Omd4EHvTMUyUd+a7rLcN/C90dnrQ
         87FypQvEyawOx6sn+SFz+Z5KScaWSN+DdR7GKrblL/VFmgEZcZfQbnkYknDM2yQ32/NC
         cLP/v/xr0YKDFdWYic7wNCmL2gZzRDLrx9Qs+d+tYeUmwKf+CyRInxC5i9Z+NYSeovrw
         2E4XaJTV0+bEdgwU8UguucfvPDkpJWrCKDnhSr38MDX/r45DnspxaipE37ck87mONFZo
         UK9tv3bDpjpLNBkSuji2Vx9r21B3DLWAdndYZEKFQi4IwJqQ2GvSXrP2sy8F5yeuQcf+
         X3gw==
X-Forwarded-Encrypted: i=1; AFNElJ/oGDw3yEkIaGR5fYNVTPuuSLrwN+J99ABCAnKGbNOTLQJ0BZEnQjamXcfJLJ8UphVeYjY9eeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6b5+RVZybI+WsZEJSbjlWs2JSfp8GMjDCYISSl3XxjyYBfH+B
	mVPJIqrxnkTY6ZnBS8VT0cphA5YbBJk02wJZX+J5Utogkc2NZMMj6/hLFtOYtQ==
X-Gm-Gg: Acq92OFTDke/xIqwK4HSlLgl7syWcxEXwDMZ/TldwlqBnF+CcReqti4IHKmDUdPBB0B
	c0oKc4jX8ILGuOcRmaIvOtK04DS8NbZPvxVzhPL2F4ruCyBC9Njmi5BNQ5zkf0vXlnRbDvJews6
	hqTiEEuuIxfl0WfIULiPrvgqXCiyJFazZ68tKgz2Ss/4nfxj5OUjikYbllUi6bM7z9rUGgwkEmH
	tNZfgdIDngdFmU9oEyHJTycQoE6EEb3Xi4k4U3NGL0P/FtQ+NYZjgUWtLn77zAocXpaEtleKFH5
	8e1C/Suz4J3XGHZrIteABop+fgKJF56JQAvsg5gEobQrYxRmDd0UAEE2A1pPy0mhnPA5SYJMoWD
	JnoEn51GfPLnF/7xfJteiV7QeHbnkMG9J1rYCu+1+SUTy/t4LNz6oLjdxHg+ii/eZzsYoXAGpQa
	91OVCJAiRIdjx23vn790n8UThYCXkJL2cKP9egVjVuLQFLCrcvuyrAi3lZO7Gz
X-Received: by 2002:a05:6102:9d8:b0:62f:4553:7a28 with SMTP id ada2fe7eead31-6c69e741a2fmr5254418137.21.1780334069540;
        Mon, 01 Jun 2026 10:14:29 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea061e87sm97982576d6.12.2026.06.01.10.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 10:14:28 -0700 (PDT)
Message-ID: <893c1c66-bcce-40d9-95e5-42adee11b6ef@gmail.com>
Date: Mon, 1 Jun 2026 10:14:25 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 5.15 000/776] 5.15.209-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260530160240.228940103@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259629-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ffainelli@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,broadcom.com:email]
X-Rspamd-Queue-Id: BD3B36232CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/30/2026 8:55 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.209 release.
> There are 776 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 01 Jun 2026 16:01:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.209-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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


