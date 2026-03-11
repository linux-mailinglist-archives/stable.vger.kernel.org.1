Return-Path: <stable+bounces-224636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIaTN+HXsGnLngIAu9opvQ
	(envelope-from <stable+bounces-224636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:48:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFB825B23A
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 03:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D10C310180B
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67261131E49;
	Wed, 11 Mar 2026 02:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="FmwrMhvp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45690175A63
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 02:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773197184; cv=pass; b=X3Jq7GQGgMeDBgnEmLestJN0W7F4CHxvBpdYHDT7mI32ykHAsJp2c0fBOjrtgx3c15WuhxSNukNtEX1lOLdMTiHMtJPChzbAzd1oHoZ3XT3vH2x8WmuOLA+mUmpBa3QS6CboChPa6+yWzJYJplw4hwfz86469r05d/9oajVwpaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773197184; c=relaxed/simple;
	bh=w1PwotnzP5teLIRNxoAl8PpppmkyqFPGpwFrDOn3A7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnlJf6rZNm6Sq/oLkj+qIotEYGnNWaC8NHo8UnrdUjwK/HPicrcJrP7AgDKRUsg3NOJJjx4tFd19ON/G8AmZFPiBaaaB0eb2OAMavYSBWe/rAeqHFVQu36fxe2HJf+WJ6T5nY6AoInQYEZ01hI7t7T+lkMMwQwIRfQboGKHPGT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=FmwrMhvp; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-128d2e3074fso4760181c88.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 19:46:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773197181; cv=none;
        d=google.com; s=arc-20240605;
        b=MnpQVrQqyqfDLV8OiohCqyv0G2k9ZGKIZAkh3hIMPWrH3uci0zwQBwSBAZxOrAT0LE
         +FepjsWptm27rGpIP3/K9NQhM/p4yGmvyl+TjUeUjtfEhCVpk8e4UTKt5dcBxNIKUMZ1
         N+9inP4PVNd4Bl2/fTgDIoj/dyYATVrRp67Y+p6dMnOR1GqclN0ryLCwJeG1etJU+Mgo
         0QR3Zaa7YlyK5nxkSY5/V/d57HbCYfByP3QiRVrQbD6iOlJfmOzJ8hUhyRamuMy+VvMu
         HOR3yGetYqocC+en9QLzbPdm8XRv30AwQNdjCa0hpwwQeM7LOZfyjEZnz2NgOXSDfpAI
         717Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGXFndNWrLHH4Yf7sDqSezTLxh6DdvmScvJRMGduF2w=;
        fh=PZdIp7C5VmAjRNRMGEg+3pWTQoKev5//oNWB9vqb+QA=;
        b=JICFLNVejFJ9/MNKCQdv1w1l7HZ3PUm7eAcJEKwDEoaOHx1ggYDruSHA99tLCS25jd
         MnAIgpBnzAmiFAidVQJgQINF2vz6/hxVLwYCdp8kVzwrIqFQg/H5zuzau52ub3j6MWS3
         y2ozQbPmwVFDWCRYrv/SwYDH/h3MqSNGXM4oFMkXD6hRxL3RMKaUpuRGb8oNJDU9owiW
         q1AyXHRijc9z9oOvtStqnIyuh3LpHXWidpCMaSvMq+7MhePl4dr2B9q6gP48czL6QyOG
         XG5IcVTojXWVQCrWvcf45Oj4BBs7YZAk95DVqELJG3nk9St/BNZu7GG2Yke4p2hW9/WD
         VyJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1773197181; x=1773801981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGXFndNWrLHH4Yf7sDqSezTLxh6DdvmScvJRMGduF2w=;
        b=FmwrMhvpvW0TOmMUVJen75HYXkoO9VCfgfGRDiMZxccMNNJHsWvcCV4aj5x+32DJaV
         dzLuo1jxbOryGn9VqW6jd60UoczQJJWRuw5i9tLj/n+wG58L97yYiY9+hjlVewSHFKrX
         69bwBJ0lxOIUO9puKL1NFtnkTJPtIlfGNGOIY4DJszxH2BHyeex1Uwpo66MkDRdooeVX
         NeLaGJgDBJDIGiPLtL0uQy9SsUGsuaPl1v6Ky+U96FCSWweW3B3u5cvmxVCPXPL5UvYL
         Ul8OMTVOPcj6AcKH2zyUTTEPqBKyxQor6dY4CQ9CQgXKy4Ajeurq8Eg8NVFq4rsYM7la
         sReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773197181; x=1773801981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGXFndNWrLHH4Yf7sDqSezTLxh6DdvmScvJRMGduF2w=;
        b=BfDR1958fTN1xZjEkX8SODjJlTaGSoNZHh9pCf/4EUK+OPsy83y5cmyag5dzgSd9AU
         LE+OvYlaXW/aLaAtGV6m6x6G90tQ63K+n4cCqetzNFEbCjFwYkMspBfcQtxduwjqBEsm
         ykMzhYq3KYVs3TUj4hWQ1WPvFfz3cumu0HjvP/69jAbOluefxnvZPveDL7UZS/iZDJLJ
         Ilvl3kvNoRiiMBbzilPSS96T+Rud8BbX1hPnuTDX2t5B41M3OdNRuErBKq4EfhSYQUgV
         5fhuj8LhXwcYo9NEYfw/+QlvEroZvN92hBBN4a4dq9/61PzN0Wn+NdNHhA39F/wNbbZy
         M/6w==
X-Forwarded-Encrypted: i=1; AJvYcCXy1WNk/XFEzmqzRjURtyJV68f22DutOEu2xw7bJSArb5j0BJm49igOr3P89Z9pZAtDPs1nM3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfGrL6nC+MUspUiQ/n7IJDBXJd7f3ddOOHjkZZGwYWmLxusSs
	IriaQvHmeheeKzfysXv/Gi2tMdoQEi9McWNJj5zcTpMPlnzSZM/kJlQT0ydXNHlEWnpy3rOEiKE
	bZRboutREoP7b4KxvFJhweiQoy5Kxsr1E0TSpEDyCWg==
X-Gm-Gg: ATEYQzyCtYLL+qpSTzEMBDGYfwrNl+GDzw0Iz4EF5xxGg3Y4LI6oLLL1XEh+ht9p0rF
	P2kS5QvBsBiAI1EOABt8/p/00BRjx2chIBD3cnVynLZUANO3agtVGwnp90GfHHTvWcYpTkIvAks
	zQXXbZph1fn99YQ7C9YlDa9+xEvUj7gvFSTyYitzpFbBckO3n09/gE6ePLg0ZUF7O1ReBU5ySzJ
	mVB4Q6qg0AKsCt+TRmRbmEQ1fPR/P8ecuu3fV/VN7rgkZfzfVcJ+I0wq4h6BTwMcSNFbZTLmmVf
	i6whG35c9EqJi8W5Uaw=
X-Received: by 2002:a05:7022:252c:b0:128:d23d:81a2 with SMTP id
 a92af1059eb24-128e784c1b5mr460921c88.29.1773197181161; Tue, 10 Mar 2026
 19:46:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773140654.git.sashal@kernel.org>
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 11 Mar 2026 11:46:05 +0900
X-Gm-Features: AaiRm51yvjGv8hoDc6UinmFg7p_FLu2aytRrBfEiWRAIiUZhBwBpxpS1mK1d6XU
Message-ID: <CAKL4bV6uaqAEDrjL6kUvHfn2yp7wmwS5dH+YK4nbcvoufDz-1Q@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4DFB825B23A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224636-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,futuring-girl.com:dkim,futuring-girl.com:email,thinkpadx1gen10j0764:email]
X-Rspamd-Action: no action

Hi Sasha

On Tue, Mar 10, 2026 at 8:11=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
>
> This is the start of the stable review cycle for the 6.19.7 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 12 11:04:16 AM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/rawdiff/?id=3Dlinux-6.19.y&id2=3Dv6.19.6
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha
>

6.19.7-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.7-rc1rv-g2867504d9c53
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Wed Mar 11 11:06:57 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

