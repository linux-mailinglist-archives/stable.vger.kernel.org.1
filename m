Return-Path: <stable+bounces-227227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDtUO3yju2kLmAIAu9opvQ
	(envelope-from <stable+bounces-227227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:19:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539E2C72FD
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F21DB306EC97
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 07:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB99330B2E;
	Thu, 19 Mar 2026 07:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="cOYlKD5f"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1642EC08C
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904762; cv=pass; b=CBrG7RcTIsyikSDvLuhv4F29HC9WDA9BKjklOdEXgMa+jRPSIqJJtD3HNJdb6BDSAsmeBm08+AyO3gevJs7nV73XD2I984CU3kQl47Qtb1AdZCyKlpjlGeKXVU4s8Kov/Bw7A5W4lhYz2p/mV/OR+YZplx33vgHOZGXQRXepZR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904762; c=relaxed/simple;
	bh=Ess8UgzNaW/EIxirEyq7C8jN6f+gM036d2+Xn+xAiV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWAwKrX4oMmFx1czkdzj3fE+bKoUdQoTyKAjwE6QL5LKCEk26KiDJwLC5X4OoCyOfJQY9uLLaVVFCShH5yrnWEPWCvpKNIkHHplk8g4XXwFKKnyeVxOQDNrhjtGzwDbRAAyRkVOyuFILXIWxFbYNmv4VVGj5UzHeoQdt/OKNlLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=cOYlKD5f; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128d7db88b9so917850c88.0
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 00:19:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773904759; cv=none;
        d=google.com; s=arc-20240605;
        b=AWMzixK7+/oRwmkk4MJEz33iLbw34PE1RXuUPx8dBe5QctTZV8HuAUSPxsf9gWKcp+
         7YZkz0WlaqdRaXiUODJ75TklZ1hZCArBxASyH6Au/ZwgpKtTMPysB0W3gmyjoBtIyoHg
         0p3iPv4UX2pTuQPlixM+yzel5iG6o0mp3u1+HGciGKTO5NfRQ1HKULbkZ3r7J3fOGQps
         9Uw7FcKtrll2uah8F6nttfIgWVAIn2hISITglV7ctB61LhGx6Qn8W9y7TreWX19Ffu+j
         S/GQp/BxeCwDOr47fn73BUSAndpCwYJZqghiACPDlRolj23t7zx8bhgGCdtCwd2TmiaE
         r9xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1l/IMVVtSfWuUyVYPnAu5GRDB9eD9+5LvhqvP+t2DrU=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=OvZo7BtEhh94NF2qAQmZBAfwZR2CXupZn4fEnBeVXaoAl64YAKFL0IAM/UBDHYL4vO
         KFyROOtMLYbua+vCSSz4YeRTikzLJeF5EmvCkEBB86ZrVxpVY2e2SNnTcB/eHe8NqqD3
         tjPqMvVElhOV3W6PSBynUK3Es2jrqtqvElhfZcrI71QhqKRw+Kq1egK5N+J0A6kPcaoH
         INBcniPskOzrbuBt2BzDU+j2SZZ+2wPRu7sug60u/+iUL0Cx3MvpJWA3Rsa0zM6MVM+B
         enzGbTW31WdqLNvBpI04IxcaOwtdBRb3XLDotCE9lSsVhl1M53phw3KuolSqMfQqsFBR
         4yRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1773904759; x=1774509559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l/IMVVtSfWuUyVYPnAu5GRDB9eD9+5LvhqvP+t2DrU=;
        b=cOYlKD5fjSleAvSlIyDaS9rgizp74LuDiQEoOIBm4BB7BKk/QHQ0uSmou+Q0m1PCxh
         R2mSbB3zrw8YyCcAh4ljFi7F8HEk1eqi/el4zhUeKciAczjBqUvyhzdj2J8ye1lcZfDr
         RtBe5hW1I7H4HpxoZs5xsL0dzKThbML5a5aHwTgpBd8fCrzHfzIR0Scg7oOSZdTinmJs
         DajHif1uMzr6LgyxeabV53N8XNP4Uq+MN3dq+orxfFEETIgEYdOYX9dKdPRdQScmPakY
         l+VytePke0IRFNsxrML8NqlyUGTEEtSincvckLAQQJi/Pzxgn/a+tPffWUHzBamVfyG5
         NopA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773904759; x=1774509559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1l/IMVVtSfWuUyVYPnAu5GRDB9eD9+5LvhqvP+t2DrU=;
        b=eSA+f8VoSjHv6jE9a1cdP7eC41NUe6XQ9A6bsdT5ThdggwA9BWam7sXRuFl37YY0Dl
         w8wT+oZF9SCTs53Sd9qtlpWvr6xDKGT4pguijIa1+ru6aDM65OArBjK9fJ28YxiwfWUQ
         7XF388xQoXryj9Sy280zDVcZL/GhOAHEHfzC2/Ci37LG4ulJn24dJRJ9EkQIyJksJdrq
         QX51vdUHRIIUDMuWpPEg4Nh0JokR4IyDcecZNzT5NN/+2pYu75u177C25kwvbhy5Clg2
         GBHZq2cqrEGXkXyYjo3RtNbvyedLbfwMPyJ3kU0NvBuiLrPM8LPdo1bSCtv7qwM6z8+r
         KXRA==
X-Gm-Message-State: AOJu0YzOkL1hRdofyIdkevghYrD2KrlNJx+zCH/6A1Y1lKTegH44OmMF
	ioBpKX6zytXm/dII73nF4XxXBw4pLndEhWF4F8LmeSu2YW9UMDimrhzcsuNyiTZt4MmHjj1qTmL
	JE/KU4VJ2Jl3kHohWrVU9HSPmrnhrzRJN3D3inlueKg==
X-Gm-Gg: ATEYQzxqfjiltx8jWNhvyC6RtG427LylOkgCvNoe4dnhK0F99oAFzC2qJZiRXXI2BYa
	+r/UjMw8k3YeEgvU2y09xap/ppYAqAFL2V1Lk1TajYy4dcgwg1WG2xMuYNO8Gk2WrJUIPzDNeGG
	FSv2hjB7WY4E9MlAjifK0gxG5aA+b0+7eZMCfFewKQQOG7ayqD7A6muk3u1IuyuFGya5inZyUaG
	eoFN66gyad+2POrBG6SYtcRo65ZJwBtqTJRXXaSjqBDFeZYy+wBckp43aZQ0GN5F+6AMEhfCU+J
	UOr2fhJg
X-Received: by 2002:a05:7022:4387:b0:119:e56b:98b1 with SMTP id
 a92af1059eb24-129a710b318mr3124030c88.24.1773904759139; Thu, 19 Mar 2026
 00:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318122547.233850204@linuxfoundation.org>
In-Reply-To: <20260318122547.233850204@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 19 Mar 2026 16:19:02 +0900
X-Gm-Features: AaiRm538NfcS2nSWnnd6YoZ0SN9yUH9Nu9tWCxpdQAUJqOjdqqRIGvM2oxef_xE
Message-ID: <CAKL4bV4hCfaHMUuU1xx_=3fkOAS8Y-6wtZHY7Prgi096SLoqcw@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/379] 6.19.9-rc2 review
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227227-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.694];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5539E2C72FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

On Wed, Mar 18, 2026 at 9:30=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.9 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Mar 2026 12:24:39 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.9-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.19.9-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.9-rc2rv-g08e4691d3bc0
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Thu Mar 19 15:47:54 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

