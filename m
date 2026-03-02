Return-Path: <stable+bounces-222673-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG+oEOzTpWmvHAAAu9opvQ
	(envelope-from <stable+bounces-222673-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:16:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEE31DE50F
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 19:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA08D30364CE
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 18:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653AB337BA6;
	Mon,  2 Mar 2026 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fLk/ibSW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF233B951
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475360; cv=none; b=LHejAWj1Ivlvo1qj37NuiWqRNpgiz6wfiCiyuZI/KwniElCII01cpynalgetyGaNNozgDmM2Dxn/w71JSw/KOzwEiF9bd9t/baEbtvXavRR3qT8CAo9I97AuG87saxehJydfjGL2SHhwP2tRh0GaTxhB8FOJfuwpZb1bZDPlViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475360; c=relaxed/simple;
	bh=rPMb0I7pZ3vyAA8bY5JVNGz19lHwfYEeVajqxiFUkpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEheWoh03uhsIq/lsqs2iqqYrpFXRz5WLVRhcSS1UwjbwFi1LbxNHbwny8pP/iffL761f4vmkEZsoFOk0wReGM/zCDU2iy/wzK2q3Z0ryJpgDKkNv5gvWvpxjg4v+eDSQc94xKCR/NaYCLABao37/aXkg/FGY1eb4dANFydHo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fLk/ibSW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48371119eacso59807295e9.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 10:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772475355; x=1773080155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXuSNcy75SqjYK5Ug8/mqeLaTdYOof3KHvJM2rsZ7tY=;
        b=fLk/ibSWw6wO7cKFCl1FkeSpSNN4nlHcLQ82pC1MnLvevNLlRPHqYo0KwnVk4vPekN
         2ujFL/wfvr9XF2AGmZy3RJDuZ+pM1XqEHbkyK8MgLYRkaD7Oq0I4ZDwdEIf5ELnTKEma
         dE7R8ucpALIo2Psztx/UWRckifHUlRW0hwHAGaynTfcroM8cH+VDXPdQIrmorkTgRKsd
         qo8ilqFfaE5W7GWZz+DtJtBfOJZ3cEy3eUwWwRYkReLjHFgBAnxI3BBMNHqcSc0lNH0F
         b9uSzyKipJAtBkkGvs2N98Y3qG9ZObF8q/DidR44pmDjenz44VNGj0vQCHhm2b+nivVL
         DlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772475355; x=1773080155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXuSNcy75SqjYK5Ug8/mqeLaTdYOof3KHvJM2rsZ7tY=;
        b=xLZclrvEmS8v3QjpiHIHxB0wVtaLnjZ9b9gTfYcDgyF5kSCIGpAhY8FLd3/zjp9lfh
         IDXt5rtHePS4RY7O/48Egtf6W4/HkChgMHMAbzI+0MgBtBjVNrmYaELDzicvu40QSIZe
         QSPNdurl5Quqvaa/Qhq6rI3svVpYKrSHF7hWsMVirW0t5jA1v62xCIxPVXVaxw0E6lx0
         xESUuJn+MU/mccH+kSNbC2QtlqflGZc8BIkA+obGklS303egjZkCSCQ9WLq4mJ9Oa6e0
         zOQpeAAUrQ4r5uhMzhgVPYewrgaSIxSNqT1p+8X2y/BwOuNlKOuE4RSXqS5hhGy+dTsL
         esxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVil/764IHZCagnd7wHPnbj7CqtTpN3/9SOX/Kxvx1Ls483F7Iz6QVnf3CH+uU7FbTvOzfvSxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxciGkNBOT01b1GnFBlWUbsTxLUUhqOL5x6qm/vKSVPLe3uSD0H
	bGPN72/5DNYEEov4OTGqRLlQe6Oo2pVN/paDTvHdzG/8WuOP1oylHiU=
X-Gm-Gg: ATEYQzyoglcaaWzTFSVRZq5qunRkQ2OLoZgILcQbpcBmHq4wkFvrL2OXXUFpUbr0Wh4
	Wiq8Nz1WtyHwYBkHPFXRr5vnR37bTuiF3YPdr/QhNaaJg2Udpto56gsnmJzqfPO31R4Pig4fVR6
	8/O7zDqruEmOjcWSYpZakNHO25aVN+W5tx2ZCVDkqRwKOte4TJhd5zuE943C4BA3PSj5kesmCc2
	1VvqBGcgApXkcYMBGa3+AtiVpWpCUPpt6VsS3U4Obu0MHyFvI9sbVb+uhrS4rnV1lqumZuvUpmv
	5BLq2fgJC0FRbfInDNmc6hCtN/nQCT61NdMPXx9ytkz8mh055ywuiKub2BoJqP7vGWO42PR85TH
	1oy8Jye5tkvQJJDrun/dEtPYd5GZMsBOmUwufgsEsj6oe9JoNC0GPrwEpWkEX2SJTxc30aAyZRg
	WqxyfGYy4D5ub+jdP0sPjkJfxI/Pv8AKFvKxiRtZRxpWMyR08p7D+O8OzjEU7xU7nFn661EaliU
	g==
X-Received: by 2002:a05:600c:1393:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483c9c1f8fcmr224424305e9.26.1772475355218;
        Mon, 02 Mar 2026 10:15:55 -0800 (PST)
Received: from [192.168.1.3] (p5b2b433d.dip0.t-ipconnect.de. [91.43.67.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b4a121sm291923475e9.8.2026.03.02.10.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 10:15:54 -0800 (PST)
Message-ID: <ae51335d-39b5-4b33-8b3a-be89a6aa3b1f@googlemail.com>
Date: Mon, 2 Mar 2026 19:15:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/533] 6.1.165-rc2 review
Content-Language: de-DE
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260302160943.2522184-1-sashal@kernel.org>
 <66461c13-1bb3-473c-b57f-adba9db4f756@googlemail.com> <aaXNiwFkUEy8SaTm@laps>
 <abe2fb5f-61b3-4597-b27b-c6c61f5efc7d@googlemail.com> <aaXSVaGrwY-k80m5@laps>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <aaXSVaGrwY-k80m5@laps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ACEE31DE50F
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
	TAGGED_FROM(0.00)[bounces-222673-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,googlemail.com:dkim,googlemail.com:mid,peters-netzplatz.de:url]
X-Rspamd-Action: no action

Am 02.03.2026 um 19:09 schrieb Sasha Levin:
> On Mon, Mar 02, 2026 at 06:57:53PM +0100, Peter Schneider wrote:
>> Am 02.03.2026 um 18:48 schrieb Sasha Levin:
>> [...]
>>
>>> I'll drop it and push the -rc2 branch again for all affected kernels.
>>>
>>
>> Wouldn't it better to push a -rc3 branch then, so as to not create confusion? (I'm confused now... 🤔🙄)
>>
>> Or did you actually mean rc3?
>>
>> Also, the causing patch ("x86/kexec: add a sanity check on previous kernel's ima kexec buffer") is in all others 6.x.y 
>> -rc2s from today, so maybe Harshit should quickly check to which 6.x.y stable branches this patch was meant to be 
>> backported/included?
> 
> I just force pushed a new -rc2, and dropped the offending patch from all
> branches for now.
> 
> This one will end up being a slightly bigger release, and we can revisit this
> commit and any others we had to drop for the next cycle.
> 

Ok, great, thanks! Will pull all 6.x branches again and retest...

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

