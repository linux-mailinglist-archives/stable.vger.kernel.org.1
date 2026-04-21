Return-Path: <stable+bounces-240205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAovLx2r52kM/AEAu9opvQ
	(envelope-from <stable+bounces-240205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:51:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E5143D996
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 407C230707C8
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 16:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAC037756E;
	Tue, 21 Apr 2026 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C93qoYuf"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28919303A04
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790049; cv=none; b=J4t3FBVM/kDBDKlvVD+1F0OgNPG/rq3EBdycUsyt4z99w/pfNE4R43U6tm/rd+rDSS3ulhxO+vkfD8dOZzwXMbz6aiGPohHpX1b5HaD4VejN6QoJClE/8jzGoFhz2IgFwyVAEnlUY04K4Y3u7sNxD0ARCnUr+HuAWDpMWcg9DCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790049; c=relaxed/simple;
	bh=jbTcbnwcv6C/KtX2jxldMnJqhsn56C8Z+WJw2C1s9ZA=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=DrZxQ0QWbQ54f+ba46xqg4NYxV7D3b1hLkgJD9bv28Oc1f5v8yvyAftOQSVtqdM9zAacWZys2OrptkqDPkgO+An8dGIUFsuRwSdzgR7ETpHiNlWfpgpc/Ag7ztpJva2Ka14A9ZxC7xyzbATNvKAcLKqUeuBTQLuBNSTzNlwszE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C93qoYuf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso19385525e9.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776790046; x=1777394846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jbTcbnwcv6C/KtX2jxldMnJqhsn56C8Z+WJw2C1s9ZA=;
        b=C93qoYufHNKlM9k+gCRlMNx68oZVkN57+leHdy26eSu30c+3AUluLXG98NUPIcGz1G
         ImySi/1Vq0t3Tk92LYrQrGEC+x8VTMrYc2tzQ9ka/slMP1ZgXrah/ZmEcp9lK/vlwkTd
         QnQogb/Fq5xtYfo0Aj985ZUZxnJRwkB9uEzOODjstmn+Jqca/YiDR1N/LyMPeuuYWGWM
         LfTXgn7QLvEP623j69Scs8UFCWrAYo3/MjZAd4hp1e9P6agA9YHKN8Dr2Jm2OizH4ozr
         kgsIOF9iSM1iAp1daB3axAqOqN4UhK6lhnJyxM1vBDs9Dsy6Ufwf146mEpPjJUme1jxc
         PeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790046; x=1777394846;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbTcbnwcv6C/KtX2jxldMnJqhsn56C8Z+WJw2C1s9ZA=;
        b=HGfA9GRXByEEll99AvPs5tR0aNaLtjd/X5rVm5dcPMlx3UzXhrcxDYPtNp4mCSflRL
         XK2wGr+mgYIZ9tsz6/Q+OC9W3USCXsXRyiQtPIPPaaYndp9MKSVbLIeWkRoR9DDSqCjc
         oxImy9BA2L1QXxESuebtIZE7b/VX+jMMNsbFVaJ8ivl+3W//KF2KIE+ZByg9eR1cppmd
         5gMk0mygC65jihNPXNTtEU4whPUOXeN+YYqVGKh3h1/NUcvbzgsHsMO5SQ3DWEQ+ct40
         HKwChHMzWxzedS5VyzGNLqXj8xWwIVjliuNLZ3n7ZhVhX+qBGLeeic+jVMZaWlptRFtv
         r/lg==
X-Forwarded-Encrypted: i=1; AFNElJ8JlID5E/zJHj7jUqRtembaZUx+OBBjLG31Mxrz0Zs1OFxpWuZ58zDNVcztHna+HBWhAPzgEy4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HSYygfOveAHS3ZGMmT0vEVi8NTow6RhLHBlIlj5W+dQEBMPm
	QOoAAiKB50q1GDR8Mvc/RNGtokQqkkHOuXlE4FtXdhDFCXVbOhA8PIIH
X-Gm-Gg: AeBDiesw3ljAYkkqet8pbRjgJoAOq7btxI0pVx4aWzJ8BPFAgOLdmbJ5vI7/kRlsFX/
	anIDNdnVhEf3gNImJbw1d9pPlGAhQV3FwTWifjHROOnKxCiaQ5U0r9tDVa/Hqz2oB4OUC+wEWob
	Utrdi4VxzN70tuDng7EXYEII5pyBT+jabBjVvKQVresQ/ym/0XTMk4xhaV6WKPQSzXqVtLCwhcL
	T6aUyp5R4bdAwtwYCw4J2+xptcd4HrHYIbcdYefiGGjFzjj1K9cM3zLuamNnOB8JU7It5hWRuXB
	gDpTQicyuDdJTFZtjwe1moMWlAMs48bPQn40vOe2BFBQ6scyUZKbkHqY+2Elm2SXvSv6tWxzqBj
	J2k2AKnTKsz9NlZObi8ZRe6gCjwq2JNcdi2Xk5FSk89/BvW/mE0AKuzHRjx3PtF0kvR9/jPdcfy
	lkAHQoHtK4h8VvWYRKAlSE7F7Gc6+wJDGwG3ohBQpn/XetqCY=
X-Received: by 2002:a05:600c:1f94:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-4891c2d2213mr130924665e9.5.1776790046173;
        Tue, 21 Apr 2026 09:47:26 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:23ee:1cd8:1171:2646:73c1:cff8:b7c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a06f3sm138096905e9.22.2026.04.21.09.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 09:47:25 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:47:25 +0100
From: Josh Law <joshlaw48@gmail.com>
To: gregkh@linuxfoundation.org
CC: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org
Subject: Re: [PATCH 7.0 00/76] 7.0.1-rc1 review
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
Message-ID: <68FC4979-9D28-4F62-9839-1B9C9A7CFA9F@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-240205-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshlaw48@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43E5143D996
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested on Geobook 1E, no issues, lib/ tests pass

Tested-by: Josh Law <joshlaw48@gmail.com>

