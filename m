Return-Path: <stable+bounces-211255-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA4hDORYcmkpiwAAu9opvQ
	(envelope-from <stable+bounces-211255-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:05:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C45306ABCE
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 18:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AF8A30C9D5C
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C94DC550;
	Thu, 22 Jan 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eKJVRuKY"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554284DC543
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097100; cv=none; b=aVTzUaYNERkFWeQdD2F4v0itwTY9hJOtf3lGwtYiEsXzRcrfzvbp0xrv+bS/HkQpF+qgzp+0ybtXZ/1yaLJQs1xVCRLck3Ay1FHiWtwFSEvfRPXt6sYrsvdYOtdlW/+csoJEryIjBq4BseorG6HsRswsIdo9jYOs7Nixy4OAg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097100; c=relaxed/simple;
	bh=rmvs0wUA6Vknh3KvKwpYhY7VCf5Gt2lC67JAUIj8J/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5P3+NLGBAI+o8Tz1QnOoUXKMWn+zIrBJETDkbfwE1UuabLwLa+A8fx/Cy5a0Y9VKRVd79ERG8u6ChADZ7T84NyU4OjMLxSn7yJ03V16mM2KtKyRCjeNGK2MtfZxOr7y0jFb5pRAK0mrhVruysTFWZIleURuiGfbAAWnMgCLuwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=eKJVRuKY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47edffe5540so13018805e9.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 07:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1769097092; x=1769701892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c19nhZZPPkZH3viVYUA+n7Wk9ieUTEkhR5Y9vgtGhyU=;
        b=eKJVRuKYhuGzK/wYG5UV/2DD/ca06JodpTuKKhxS53sgILwKcKY17S+5QPqKX5Ekr4
         MSsRDtNE6iFhL61wU1jtpK7FoLIcpL0cfiOctUsVeCSpGh+jFe4NVDmTuyeKbgXTxFQK
         9taxhn54dlNLn2j+6IIOjfLxpob6HEpico4upPCNWJmbF/0v6dPrWw9oMvMZHeakIO2K
         UkAGYRpKUqilJ5NrxmDYWgGXPtdbn7O3qAqaR/N25Q+Suemxn3ZuLCV3XMxSPr31Ao+t
         Tm80dlPiyW/37Aw1bE2GmsxfPmnt0Pdx58p15E+hSxQyuV7+s8FMGHZ7h6qABDPQKq7N
         f9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097092; x=1769701892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c19nhZZPPkZH3viVYUA+n7Wk9ieUTEkhR5Y9vgtGhyU=;
        b=REBqVRaaURYctf9YP1mx3tZzAYdN1EOnK5/b3eGaSUGRzQR+NB++k3DkkyHt9pQJQs
         ihC7drfVKLdD6OWYVnmB91cbmveOGx4nZJl6DL9pp8NBocLyZJrSEtoEG1d96V2oe+YX
         kMk8YXfroQrz+HIr6ybvwf/PTUS+6+Xd/8gIA7+GZw44jKOXNom3PS2HEKXwfaUzyo30
         2R+P7buPjlRJRtEu8eP4iPLMoJrLcc0H14SknZLpycB4+KKWerzinvsUZMkJc3chEj/g
         ZBfhP8TaF6u6LbkvpmQ4pUawevR3j++tfoidO7DQ9pozJbBfqFS1x7dRt8Fxyb7acz4+
         /2NA==
X-Forwarded-Encrypted: i=1; AJvYcCWTNgiX3Lypakf08iD4K9zFcBbxU5p2BvNmVMNHbUB/mUXOPnzf7YXyZxYt5yvUUSKeKxVTtOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdlvpGfbho5jkkXi+q1lSoHOrxTy6GLL6bSUvK0BzxCyraHno
	WqS7QcxPp1gAomqbwZhkRIKZzGEvUKjfxr5RHC08nKbRKxH+un8029k=
X-Gm-Gg: AZuq6aJz2wR/PglMNihsXUNoKSz1jryLHlMa/+eU0hGAoi9U68iHoJJF2g2FgsSxFkh
	po4tv+gmFdFwVd3AVSJ4oJSWL9wTvv5nthVHDK/boGUdCAQVJt7PljkULEnfDIaQqON6q4wspjQ
	tqSiMM4Dpt899JqGIoo6MMfgmfOUgk/674znqvzubgS+IRIPa0Ety8v64uOCrDichLqf4OrnjBr
	hq5/X7Wm2wr2X5mNiZTqzpBUiLkf9tj2Izc7JqkXoCiQzm5dZPThHLIM326SywLsn7SWZ5QAUIP
	safvFUte+rJ0wKw17AwLTTpbA5bTaqldROOVEA8eJuI3XRYN8sBCK4M1RFp7kg6EdO9yx+ftqI9
	GWSSu4BWk/UOsBXrzYDysvYOBRs0cNBu450RyrM/T01wC/3BZhMXMntGvfuelVdnwKYZrvVdC+Q
	R2se+VTJiU3y077t4GBAeNSADnKxyb56+dpolL6xwo+dnXI8E+fLXd0ZyGxe7jPbk=
X-Received: by 2002:a05:600c:3e10:b0:477:9814:6882 with SMTP id 5b1f17b1804b1-4804c947a33mr1434825e9.5.1769097092144;
        Thu, 22 Jan 2026 07:51:32 -0800 (PST)
Received: from [192.168.1.3] (p5b2b44b4.dip0.t-ipconnect.de. [91.43.68.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704b4e6sm77029785e9.7.2026.01.22.07.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 07:51:31 -0800 (PST)
Message-ID: <a45313d2-2033-4783-92a4-b0ec2786cd29@googlemail.com>
Date: Thu, 22 Jan 2026 16:51:30 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 000/198] 6.18.7-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260121181418.537774329@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211255-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:mid,googlemail.com:dkim,peters-netzplatz.de:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C45306ABCE
X-Rspamd-Action: no action

Am 21.01.2026 um 19:13 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.7 release.
> There are 198 patches in this series, all will be posted as a response
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

