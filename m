Return-Path: <stable+bounces-240137-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD8sNKZu52ke8AEAu9opvQ
	(envelope-from <stable+bounces-240137-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:33:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B643AA7E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31CEB3024458
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7901D63F3;
	Tue, 21 Apr 2026 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvSLwSzH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD773C7DEB
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774657; cv=none; b=dHvU8gClE4BGhqIUhBmk/E8btdkdbhEPgs1unJbxCuGbrLmcc5Ud5rb3Wkb2n379N2VzPlX6YeLd/r48VRKriGzP/5+EtTRS5K9Zh9zk3xASHxdpny3QrciqnvFPmWMzQ/qCv/7PRIj+qKE9MruX4ezxWC//O8bmvMnLtoE8vlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774657; c=relaxed/simple;
	bh=XwOo9xRWLW6tG6sZmBXLKlDtnsoM7zgsn7Qwt0pNS28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZ8+f5o1qTH0cdCLYFDUufTqyzJWuP97iQkfzRLmxNIuhQMidyT9hDRnPgG6aya52uNhwNY39ThWAiwzR0WyJOL4FQk0pInG3uOaze2liA4Ck/E9dAjQdrFHQGKy9/w1dFMAWhHROaExS+IR76yAaH/y5djC30Yn74yjiu+tT3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tvSLwSzH; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488d2079582so48619915e9.2
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 05:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776774653; x=1777379453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwOo9xRWLW6tG6sZmBXLKlDtnsoM7zgsn7Qwt0pNS28=;
        b=tvSLwSzHCKdfV6c/9rHZB6dAGWvjzThqsVk67t+ifAJ3C1+V4sHpnuig4JzG+p2Qeh
         ZWvzPMx1SRfbt9ESbHlmycq+TIk5j1fVNXx7EpzJaOV7kXZ/ge/KtdwsLXSOK0PyICIO
         yoXJvE/6TRbBsASwXmmuQhnoEJ7C/a5vCHLZOxTXMLrxjwoWbPcC8BM+OZW4ksuMASyG
         qWRkFZRCT5FzcQJ9o0fS1WLuqd5w/8bezfCCMT+UawnOvHPfGlIS2o0eL7AZiyJl9pAZ
         nif1/Vzm1JWnrcWwCnO4IoFc3yB1HMmQaCxiZcDD+LDWbwFVM+fSByZycMZIdJlnbe2p
         g95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776774653; x=1777379453;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XwOo9xRWLW6tG6sZmBXLKlDtnsoM7zgsn7Qwt0pNS28=;
        b=i6c+iJz0Yt6A6mgNHQjl4qAFfxoacjtDgrscM6CTBsxqMDdWeG69BUesPC6IMrGiD2
         X5rPEpYHT+v4LbUGmwro8sEdX+/ZBSxJSF3MSs7NgH6VVhOZ52VBLMlzeB9QeZSqXboF
         U457Jf26i9+L3ZoYPCtOwYcKdDxty9FzDlTVA1dh+cegyo7Zbmyl2IL8zhYR76z470mh
         Y0Nb3i2LS5sE88QHRseXNHG5jpN7wGBzb4wjCtX0JeMZni3JDwHjG+eqtKeM+LBVMRpB
         Tvv6ZoSBDubH3ISEgRcnHhVSTFtE7/HUWvqEP/uRGliTGRhUcYf52mKQ0f1IY+dJ2zmT
         rmug==
X-Forwarded-Encrypted: i=1; AFNElJ/gNsNwthXj5c6RzuQNX06dKEisJeuVjI2ztWw+tkyMye0R9Mu5KP1QZCSM7jY2xkbNIhrtWR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHvOC9jkdZelwaKhkMZvPbAQO55RVC/BFfTgAgb9DEb1EDzqLq
	1hspSKn0je0x98rrF9fKVDSYqGf8Q8et3e5JFvC6UN00S6rUfidqhDUBRkB0ikRrhLM=
X-Gm-Gg: AeBDiesNu2g2/wTvdkESssp3zDAHl5F0/2ojd0OPRlQkB5YMOiY8my3aBOQ/S1Z8Aot
	xR18J6uUa1Wt2ysLbJ3cAYQFY8+joqNh8quA+hWP5GhNs27NU8YTVKfcCFVsFVjDsQ+jswuExkL
	sRTZhhUbFQAk217oXiec5mD7GdHhpCc2ez85qkKXnEnLoDyDTeqH1NaiUWu75+6ewez2z0X/6X7
	KJtFQzUe5CURhx6p8pJJVhT6Vb4KKOohRAUqXBR2F51xnOk0G7Hu5XMZNKvEg7e0cj5vcAoA3Wj
	N6OjefYAxkrWGwJ3WH4mm1IlwbW3+1oqHB83sfvK3zXb16YpyaedODZKtUo3o5jyVAH2Q814NAU
	S1p3PqjY/RXCk0WK1fy33Um1j8aRxEotYwbit9i2zfkSIys1v0jXx3NBQp88xOcbXY8yMkEKMHg
	LmW7gDw6SM1yKfWgwWHPiBiK4eaGBnatbx5UvnEFwjSp8=
X-Received: by 2002:a05:600c:350e:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-488fb788231mr265072705e9.25.1776774652851;
        Tue, 21 Apr 2026 05:30:52 -0700 (PDT)
Received: from [10.11.12.108] ([86.127.43.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891b46cffasm179118705e9.13.2026.04.21.05.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 05:30:52 -0700 (PDT)
Message-ID: <ef1cc3d7-a710-4b90-9ff9-bbc27bb28bbd@linaro.org>
Date: Tue, 21 Apr 2026 15:30:47 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: debugfs: fix out-of-bounds read in
 spi_nor_params_show()
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
 <87jyu07olj.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87jyu07olj.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240137-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:dkim,linaro.org:mid]
X-Rspamd-Queue-Id: 455B643AA7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/21/26 10:35 AM, Miquel Raynal wrote:
>> We shall assign a CVE to this. I'll look into how next week.
> They are assigned automatically to every fix, no?

Indeed, it seems there's a dedicated team assigning CVEs to
security bugs, I didn't know:
https://docs.kernel.org/process/cve.html

Cheers,
ta

