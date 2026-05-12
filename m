Return-Path: <stable+bounces-246690-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sC6mKtWmA2qw8gEAu9opvQ
	(envelope-from <stable+bounces-246690-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:16:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0901252AC20
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 00:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D58302F390
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ABE396588;
	Tue, 12 May 2026 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="gkZqxFu5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A6037BE80
	for <stable@vger.kernel.org>; Tue, 12 May 2026 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624187; cv=none; b=jC3KoEfXuA9nTrlN/QJFmLKBQIlzwDJln7OdcHKUvKY7j4xZWCQOIMxFWRA9OMk85rEgEoKEnMk6WktrO4qGCKoSpSfkl5AN1u8TZ2PDDtzNreRnYxCQ+PX42zfblyOymSYSTuZTZECHMlsuHFS03eHCFZDCgAKOmQIfpbWwfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624187; c=relaxed/simple;
	bh=zj1XaluJ+aZYRYZxrxeDXCpkk36+AI7qFz8oCqGIYUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nnz652uYt9Q9KLWxPvlWPGFUKq9HcplxtkSBqVCRhYkWxIfTFziEVFmyfbmHj9yoBIt6ZH04ov2OXAjtAWO5nFnR7dNwqOfbH91zaGHhYyXqEFyYxNuoocaNkbgDKpWPAoKN2/tv+NcDnVk2hc+TeJA33jchv2lqySeLfiHieGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=gkZqxFu5; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so38047355e9.3
        for <stable@vger.kernel.org>; Tue, 12 May 2026 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778624184; x=1779228984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bO3QGpH6Gc8wfGrS65yzQutx1IbWc5h3f9czWRt70WQ=;
        b=gkZqxFu5GA14Yty1zKcvWLpjIjHx1RvkB/IVbuuMFFx67D/7tx/kfGWXeIn8CqMTk2
         IIhFN5lRMGjC7SScWcRFIZeGNuiKYOLvg//meUunX+0eJ8MlGZc1G0yCQZVYhg9OAbNn
         4EChrzjTz2q0R4MJjiJtZ4nBVNk5VDLM/4dHybEAMwWrMqwHgAoSElZwdmXuE+dZeEQJ
         rkrESKPUKoQDlbcRHbal73SYDK9uEcdQRFNtWCAMuhOH11aLSNZfgakDHrfOi+nc3W1Z
         MDJOPk9CrpPt+bZAsL6eYvc3U4yaD6V2F8pt6YFnuo1L9AGegCJBeZ6ywsjTgm0dm83J
         RrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624184; x=1779228984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bO3QGpH6Gc8wfGrS65yzQutx1IbWc5h3f9czWRt70WQ=;
        b=Nq558Hy0vsV24eUpR8KjhGY7L2RN905hLbN6XdsrNiutuLAQFSk6qfK7aFmUE/p4/m
         A6CruWMOu7p9In9kfv/0faZULMrWh7IWJoQ+BI+XsGP7rDETMrkvCp6LfslhYI0B8kdT
         LtPcECcCNvLVxIbQQ0qNC3MWY1bBVAjVgOUcVs6xRYEwfNRznFzQSPqwtrOnYAwYuIWZ
         jnRybUJYcrnU80XD3kqLwmQ6knt4qI3bg3gL/xPDJxouOMA+Ks2h6Z6l6yHV3bTIqHHf
         LsVlGPa8wfcVG0wm/hWdxg/Fh2JuTxY+Hx4a6SLjxp9lvfSn2u/1IPhEqNIVzTomNm8Z
         MawA==
X-Forwarded-Encrypted: i=1; AFNElJ+MgxCBU+8Lc8x4fXZ92wWKiEHwEXbh6hsbTYtI400sVX9WJtdTOMonFAqqE+gwSEtSBsPvGG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/OWuwi5ZLGuyPrmCmk75MoatLJ5PaNsjMaBaVALHJAsX7JLhL
	L8f2mAkrTypXQB65EQzZMukwUxwQlNBG9+rF6S6DeQsu2fRyaZNbefg=
X-Gm-Gg: Acq92OFEOpjY8mHb1OZopzy97G3f/ycB2cZ/TmSDgJa0bcKoBZ8syHEgD/U33zpHWtK
	06ZryLkg7njX1ICOHLnRiwtjRMJdjxUgFh6LxU+GWwqp8cb2UdjcZRKFJfYQ0bh4TdUj98PiovK
	TFj/U6vAOLz22d44ky89RL8GTKECpFkSUpGKKlw99LPYqMVPll3T8UGKscdw7H/xpbz0gqF+8S2
	rEQTwQ13IgBNtA4QUGkXnEoVORY2u5x1AhbwBC5ptZrbCWbQ87tMubynBJfta5eTVS/vns4w7Y/
	9kTnD6GcN+qFZ6HVp16+R1A7SJxWRQiI4rPZBO9ogDB7QxGDkmZx9dplq4QYBKki1nQoQXsl7Ha
	xk/DRqshJuaTN9bwpQ7UgqECIeRP3rD+LLFK/8Gv/XoSGGr4BcIoke6p06JZXr9ZnlnKrojqXyq
	Yt8FNer9b8qArVhhXLzbt469eGbuv64qtHB1d193Ej/WlwqrSq00svAmErAmtt52i/4aZrZc7ax
	DA=
X-Received: by 2002:a05:600c:3e16:b0:48e:8741:fd4d with SMTP id 5b1f17b1804b1-48fc9a3bac6mr8208475e9.18.1778624184063;
        Tue, 12 May 2026 15:16:24 -0700 (PDT)
Received: from [192.168.1.3] (p5b05786a.dip0.t-ipconnect.de. [91.5.120.106])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6b071sm35549822f8f.14.2026.05.12.15.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 15:16:23 -0700 (PDT)
Message-ID: <e6310202-f90d-4da5-b7da-9baeb6d8bc1e@googlemail.com>
Date: Wed, 13 May 2026 00:16:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/206] 6.12.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260512173932.810559588@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0901252AC20
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-246690-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Am 12.05.2026 um 19:37 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.88 release.
> There are 206 patches in this series, all will be posted as a response
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

