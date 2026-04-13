Return-Path: <stable+bounces-237647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDg5LhpI3WmmbwkAu9opvQ
	(envelope-from <stable+bounces-237647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:46:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C283F2E37
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 21:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF440301A0B1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835D3E3C63;
	Mon, 13 Apr 2026 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qLzeqtpc"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1333E317F
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109588; cv=none; b=kQRj8U6fsLUWvP7DSmOD5groxtfTcPzh7l/6rxStB2eDbb1nIkzDojJolRDbyUK1ZOKpHxhAgivLcv3+S4ceOP6UWP6+DcBphQP5vT2NlCcVfohqC2DLzjpaN7RpsUrjVOs4pkfsFuBUjcHdMeIwvIbXCyYTNd3ljVyBvRWUt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109588; c=relaxed/simple;
	bh=D139xaGYpUi9QRFDetZiOer9ZoIVw6aVW4Oy/TXive4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slJmLkB5c+8ma6nfYnluynLpo5WrAn4v4VWzfsL1CLo/pcYapH+jty+lQrtYbB/vfLgiaTYTExrB1h7Dm7e68ZFme7QPLX0yBFFB8Rg13obN3ggxI889xXbWYOu5dBXlVN9HPJ6pJEi2NmaPKc2FiWr1TrmjMmuUMchwPL3W9/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qLzeqtpc; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cfdac74050so495486185a.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 12:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776109585; x=1776714385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VdT+8U+PGmUwf4YyNr64WRDdCMWR2tgC3OsakcPNdk=;
        b=qLzeqtpcZZQa6TXc15noSwMiinDLvzgAXLM2tncIu9WzazLWKE/fKialo3oZhG5XLB
         ZJLXkjWrSH4epQ346AsKt8rj5gQOHL5Qo8lzSnlGqeFPvB7aU8v3uG7h0U8OBh48OwvI
         gf4LusXF5xG5b0FW8hP06bexEIgpdRj5M+cPx2C2NIP6/zqJaN0z7qSJy32gIIfGC6w8
         NtHoSRO3JIgS1qG1hmS7v5mx6EqkybvaA0iWUIRRqLHGpB6QT3Zvhyg80xQc3heVTnw8
         7l0XtqCerHdwPHXb7bCaIQ1cO7zheC4EMb1qtQrGBkCOqi09NduSHnB7y0G2UdHZjLg4
         33ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776109585; x=1776714385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2VdT+8U+PGmUwf4YyNr64WRDdCMWR2tgC3OsakcPNdk=;
        b=qfKQKjwlfzmNmWPn4Jmr3QAhjWB7Qapayl3A6m/WwVHlAfQpZ6qsNC3ngVJ+oIGLWK
         LV1bC69leP1ug/IfKvYsE3yNi5Am2stPxdxJXgd82CzmTahXqvUONdWSTGfIQwfZclmv
         BjIf94dZQvJE4xaFQ7JOhyNHUWaXMLH7ZH30LwXJiZp0NouKAsgb87su9Tsw8YrG1k6L
         bPdiBYI//iWsVgvayfcXn3RAj4WZiMtehigQ8ADCCdi+qn+4EDg5wScY4/gyumYmKEzx
         NKqcd8aoGVLk4mpMCXNNk0wgJXIUWDURfy1U9kxkp1T1mm5NTrHiq45a8uQoQxoKbpS5
         tsHw==
X-Forwarded-Encrypted: i=1; AFNElJ+jjCfthxPGmteQGGFCLTwRf+krWpFavIA7ISHtBTCW+hwku82e/F/fBsP4vFSRZdCvQH/nQwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KoE+RDHUB5NuCA6T3uhHxvJYSRpllssm5fXah7494HnjZLck
	5mSapFrpnhS+cUPtLNbzEVgOUFEdkwLuwgfnIyQHhd6OjA35GFodrqyW
X-Gm-Gg: AeBDiesfjl2J5FOC8itaavXXoF5GkB2VfQjwOzefBvFWhCTUg4GwekpW/wtkVKJl3Aw
	71NWUDLLWPG9MdvJzRrde8xfE33P7XTyULkB9zXcXWdjAaEiaoCcesZNgMwDjvQYz3pOqke+Fp1
	dDgVdTGOWQFfbVz1w6Xu8eZal72S34cDQsd5aHZ4gwOK9lJpmJle+daHxr8ObJkLyjawQi+9duH
	Qnjsq+/0Z1wyk5cHJQ5fuZw+ovG9aBP4XzJrcpc7a+kBIsspCOrFoeGNwxQXeTZ7AVOfIPjovLZ
	Zqy6o88VRUB4NHYsBRzqjV+y8/IJWedDZ/NjAL5OqmL5CjIOkYdWpUy8dM0faiMnLsN0OHc6EiW
	dayynKe2KtbTKjceUAOqmGubKE76MHLZl4Mswf1ih9iHdE9QKVcEqQx8azOf2WsIPl+9MwSCpeD
	y7860yNOKKBddMqksEg9t9/9e7YYABaMGtY0QAQrbJvUFxTXSpVQ==
X-Received: by 2002:a05:620a:17ab:b0:8d6:5ba5:167c with SMTP id af79cd13be357-8ddcce2b73bmr2174121885a.2.1776109585254;
        Mon, 13 Apr 2026 12:46:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb992eddfsm931398685a.44.2026.04.13.12.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 12:46:24 -0700 (PDT)
Message-ID: <30777582-00e8-40f7-9606-de4aef01444d@gmail.com>
Date: Mon, 13 Apr 2026 12:46:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 00/86] 6.19.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260413155731.568515178@linuxfoundation.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237647-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59C283F2E37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 08:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.13 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
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

