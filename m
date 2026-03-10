Return-Path: <stable+bounces-223743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHwdIy6Nr2n4aQIAu9opvQ
	(envelope-from <stable+bounces-223743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:17:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09329244B1C
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81D4530233C8
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 03:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA62EA480;
	Tue, 10 Mar 2026 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DrXJm1vI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631AE1A9F88
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 03:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112616; cv=none; b=LrTvWTc3huydguAjmna7X8lo7PO3Xl3tXsJoemUJfs+X79dJ6qIaSGay+NXcPRjNziEcyWpqRILTVgdPJIW6e2DUaGdyAWYj3dc/aZM1zHB+YE9fjrPM7k9bTM9PPz+//tqYPXacNyoThoE+wTIhipQa39tPBG83PaadmdF2DFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112616; c=relaxed/simple;
	bh=kypLUIpa+hG/hxMKpxLiGtUToGhjkCNpD5x/99R8CXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MftbPQu0b6avZO8GaSLRiNYFLrbwYbbEocEUCxbwRWzF/ZW5D/q/p2zR/Gc+CXTBtJsDF68UP4Ni/sLKnOrews35jjqy08W2zquh+68hJVK39iN+cFtGGaCe3GWKrd9YP2EErqixNpE5foMiPtj9xgtPOxkn4mHHCA/LSMwfWLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DrXJm1vI; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48374014a77so146194465e9.3
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 20:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773112614; x=1773717414; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kypLUIpa+hG/hxMKpxLiGtUToGhjkCNpD5x/99R8CXo=;
        b=DrXJm1vImIGWv+eb6mA7pEzAsKVKljF+uo4V4uFIdBYVDnS3kjQOAHrvqXfjWo9E7B
         TINDlPXBQofvsUuPAA2ZGMZlJ1564X7v77cjkLBeHVpieRIC4nhYsHh67mCZgEejG+RD
         1k4ybl3vaPdyz8Td2wD+VtBsByiZbTJoTjV30NfqmXLDxjYgZ4Jbew1a+1RqsrjZ3tGI
         9pnhnJLi0tp0G5uEd1JVwc0w09NIeLTGgajW2+oiFzbCIQeRTkHJI1jcQQpFkcl2Fl8D
         /XPfe4DbpYHWad0rf9Z5ZOyRhBqInrjevCftb9T2bV7ncCffTqVrEnzpaDQc4jlEE48c
         havw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773112614; x=1773717414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kypLUIpa+hG/hxMKpxLiGtUToGhjkCNpD5x/99R8CXo=;
        b=lChcjAmtx3deJT2BBXPTfAQY8b+h0qiUYwmu8Pso8nJANHDhT4lfPh6+N1ZHFKf22P
         FdRavq4oJeHp0H3A9eCVPUWNCtrSLZ/pDoRJcqr2U49d74MxxGMBSrgRFyJMBecVCe8s
         rMgoVcfo5IAP9zcfkbdCOcrk1PsDXLERiScJ5k8H8LO/QPagvuHU2Vd4tkCz/qMnaArA
         bZksXeHr9vVC3nrdyVEuOZd/F3l8V5K2WXhRR6VKUqjdW07LRYm4xP4xuwcXePCLVThO
         KcVdzzx9uofUPE2bWzDoxy2tL61iqMaV+1wd+SwhYlbc7gIjRT6U1yzzGX16L0XNiPmg
         IXiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYgG/FwItpNpwfmOuZALIWltr1Ah8uzHVKBssSdkqz8irnu5R1KHJbotOUDWpz1v68KzbzGOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFEQw50KEEminiHEXq0OE9kNgIyuBfPJ4bcVUSiWxpZWGfU4dp
	4yq+hLs+4d60HPLaaRNumGvSKxlHomhHltpEzYvg0XlN9PU4CSTSw0OULBtisVDp5o0=
X-Gm-Gg: ATEYQzzkqG50QTu2bfcje9/IlHpVE6127V8dflyXPcBF8flOE/Lh8jezH/ue+hz3Izg
	SpCitSEk2/l2O4o9acvSotm9VaNFVpjhZtQCFjfsFGGBiKP29ynn2qfV1cLq3LE3wVzpbd8YDww
	wCHeEhZdUMx8RUgFrgsRfy24VOExvT4H7BbVhLpRAdTRKGyd8Ls0ejfeieKgSie6ZUC9UHXph8t
	tZRxvjts0Bafu7SQy6T4KJplOE88wK+2HyP3++UkM3rL2JWmvDgXPslYHUvzjgTb0lbu5uTJKuw
	RHg/ae06WP7+8DRL9pf6ega15nWB9wAyzT3LjrZRbJ1K1zKWupqJUCj4gz02R6ktV24+Dv6bpew
	wg9vapLb/OkBJSPHERmFJA4qZb71mwSKOb1t8Pn6e5WQbHZU3ky6+DWrwIKryxSNRmlanB9s3a0
	8fdtrFVCe0ofDL7sQSfA==
X-Received: by 2002:a05:600c:1f13:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-48540dbd6ecmr46089435e9.3.1773112613741;
        Mon, 09 Mar 2026 20:16:53 -0700 (PDT)
Received: from u94a ([2401:e180:8d01:1fb3:e42c:360:78fd:1fec])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f8481c1sm12689470eec.15.2026.03.09.20.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 20:16:52 -0700 (PDT)
Date: Tue, 10 Mar 2026 11:16:37 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, 
	lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Patches not posted as reply to stable-rc reviews (was "Re: [PATCH
 6.18 000/757] 6.18.16-rc2 review")
Message-ID: <iy7dogrbld3h5ygezzkhp3sebokfibu5suegpidlsrmp2ibfwd@fvstv7j7dcfm>
References: <20260302160853.2519610-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302160853.2519610-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 09329244B1C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223743-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shung-hsi.yu@suse.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.com:dkim]
X-Rspamd-Action: no action

Hi Sasha,

On Mon, Mar 02, 2026 at 11:08:53AM -0500, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 757 patches in this series, all will be posted as a response
> to this one...

It seems that patches were not posted as response. It was for 6.19, but
not for the rest (6.18, 6.12, 6.6, 6.1, 5.15, and 5.10).

[...]

