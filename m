Return-Path: <stable+bounces-230116-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOkXCc1ywmmncwQAu9opvQ
	(envelope-from <stable+bounces-230116-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:17:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDEF307252
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B583305FDAB
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3863EAC9E;
	Tue, 24 Mar 2026 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="DMjlCU1q"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09133EAC90
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350305; cv=pass; b=P57341B2acPO6AlsRfBsqtILGsePoB+EqgvWpZJ7odCdNFDWdWeye3g6kcsrsuMKVU20cTIDVpYdpQ74V+/g6xRDDpo7ZPaANENrnKgOrRbW+N5TI5Qa6a4+nqRtML28/IwqSxd3nnUiHzfTWhHGUhUtcSJluX/6JD2626MK5JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350305; c=relaxed/simple;
	bh=DmlJkHAT3FaEHvQNFxzSJKU8eAly0RnenTEM62bTSVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0mtJ/ruyCmKMZmJ6kJvtwo/rJ0QZWe5vwkFCRlqcfTL3hQLSkdvJBo0iqpKVHGR9DeBdTPAOObgXxY8M5x0T5kmOBayEdMjuwR4WY3strcuCQ267cO89qM0Mi4INP/QM2oQW8hi4r/HI/xwyAwBW1CWNYyUdMDaWWtciHhc2lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=DMjlCU1q; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2c0c955a481so5164421eec.1
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 04:05:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774350303; cv=none;
        d=google.com; s=arc-20240605;
        b=QRydUw8Yj0t7aaW87U6ElUnQGrQQ11chX/y4OpQOS5S4dmgaE7kH5N0SF/Nd0EIo6o
         9vIbnPb+tkV56zf3yGN3beTdqjYxwDblVplyBkA1BwCthCTrSu/N4x2q0W/KYXxMUcJD
         Sjg4xh1GJ81dR8GNANmhuJzV2OgqkVwbgzrS4O9pV8lNjM6/GMCRBiIOt0m0V4z7gVyC
         e76U0Lx1lnAHCEtFBNinOOkF+BuJo0iy5/u6XglIXyQDAW+VAfbdvJevcTZnRAEy4ysp
         NlZlO1fzuX/0o8pbGCmt6R13IE5UlV1L9FUS+a1QNrFwrmkZdBSVZDc+XuqqxhhuzmsS
         hruQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jxq/aet/8lEOzabqR4jPUvMy9ol0c4adzGEzqsQ7nhE=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=K1UmNFpLEFb7mRwTpg+/6pQYxmpKbzpHL3r+X0R8orAS8biGbR4uliOWWCqDN20anG
         la3tP9+KjkQwFpldJVYKBK28o9ACU2C3wqVyFN/8vUCR4YQcg7cKxKHhbxQ5LAqaYXmt
         I4tUS9QzCCvKIBFfYx0HYnBaelUjxI+T4BrE8IFNGXiPmygpKnXP1hiu2y7WogBPfnqx
         FuvUqEMyrdM/PCzC7fv5rYKevXq2XOx6EfVYZmR3q9zdQU76Z/NBeNWJPVOvlopAfBpJ
         J6pmbcOeZF11Svzap/PLcCrXyl9UZ/ZhUxiUF+HUOFKa3SGXBRHulQzqSyFzPZZk5OLe
         dwog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1774350303; x=1774955103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jxq/aet/8lEOzabqR4jPUvMy9ol0c4adzGEzqsQ7nhE=;
        b=DMjlCU1qKs04X3W4OHx9GJZtnCQirAk41eE0rBYhdwG8+UVPjJt7KYSjJhTKZs4Kje
         QIs/4C56bACeBFHoAPx8AQIYhqIZp5+Wi9HLUaFFMbkSEbLG6qlJPPDYF5QjKI/jcusV
         jrOQ1E928O7IBwk5aMD7gCAGoC73hxDO2AG9MimXm1w84p2Mc00/YdLaVB692X09I+Ds
         tA9NjwUBRgonE2yTbU6LOzLSBrvrVsHFCl16QW738/LhRB0cFhxgYuOMnUTMjcwzytAW
         xXuHyA6ubw4+bPDEDv4E0BBmZgZnG7XjL6QhsWSRgJ0NPJ5RCK1wdR8ikg+DGLlQ/NBs
         jCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774350303; x=1774955103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jxq/aet/8lEOzabqR4jPUvMy9ol0c4adzGEzqsQ7nhE=;
        b=orFuI7S98CauKx/CgOve0f7Ef0cL1rU8QEKpAl+Zp72RHOzaHTEEZGcA53r/9l32g/
         hdb9Vo2DDWb9OqGC1N0vsXY0ZuJTET0M3RnkZjuyeN1H98DXRob1ADdroX+Gmkvu2R/A
         wUuBW7rzRJd2Ql2NiMdgs52Ay1oqNgCgCHXYm6AF3fnJM4eWBgYUjcogoobR1iEN7v4V
         ChoI+N2+097/r65Q8VnO78WOyO0OHOzUiBOAm1Hcz8PELIMkoDUQu6iRPBHKbZXPZGyf
         zQmdlayCxnEzLcB3r4NDwa0DSPCkchveWFKAzzAvhNoLppy7kdg8ZczoqZOT1AY65OKH
         UY+A==
X-Gm-Message-State: AOJu0YyZsNujtSy8w7GV1ZTkZepO2pr7ceuQTyX89ZW499z5/Xp99jO2
	tpP+Yc2rvcr6OBE8R7rvTPfLnf9SrDwOj4TEkfUXx9I+WlRrclYEmWSXfe7zHIqj44sB0XclO0b
	GncOw4vUxnY7kH8CtrUqYmKW81Nb4B6q8lFpjMAez7g==
X-Gm-Gg: ATEYQzwjlMqDgNGIjqr6fxHn7Hj4ZL695z3JpLfoS+rSPKWj+8XrvhMpcyfE+GGRJ5P
	bv/cLyi4BjBEEyJEBm/8rZDy4QAd7aEfo1RU6B085xBpgC4j43jWjEL8NIGHF7w4lRV9OwlUBJF
	KweZwayyj3l9gIrZayO2fyWEdH2uHBzFxNjRYh2WbJFzDJbbtFUG2VW/UNSso6nBs2DO3nI9hOD
	HX2qUAL4gJp1ohhdYqkxxtTAK8At4KZDECDcsXpWyWEvhto7NAb7cfmVy+k+ntwISNj6f1aIXyf
	bnyokF/b
X-Received: by 2002:a05:7022:31a:b0:127:33e0:ea44 with SMTP id
 a92af1059eb24-12a726cfa13mr7698243c88.29.1774350302261; Tue, 24 Mar 2026
 04:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323134504.575022936@linuxfoundation.org>
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 24 Mar 2026 20:04:46 +0900
X-Gm-Features: AaiRm53QC1bDu7jJYOzMw-m1ql3o8Nj7l5BNcjGmDunSCA26e1BRNDCkTqFzcQY
Message-ID: <CAKL4bV42XtCM+xj+wWQhEPNirVPQ-GPfA_TsVfjhqrZqP9-hTg@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/220] 6.19.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230116-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,thinkpadx1gen10j0764:email]
X-Rspamd-Queue-Id: 1EDEF307252
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

On Mon, Mar 23, 2026 at 10:59=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.10 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.19.10-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.10-rc1rv-g5cf3b8242cca
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Tue Mar 24 19:05:43 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

