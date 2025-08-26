Return-Path: <stable+bounces-174621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46177B36410
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5201C209FC
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7673019A3;
	Tue, 26 Aug 2025 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="r3+VQ1pM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA72857D2
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214877; cv=none; b=b2+LSJyC9LuvtfqYB63a1QtDVj5t8nWhJcvuOsQMqh5vrbKFUQCV239KVKw+/gIOoAlglekuIsR1XDYCOzmEQi+r9DfwRvaB6PUXoqG9MuVHaKXMLV/kOl5wkFc+VaRH0izEAXo91eoiKdA+PKuWeRcvNAJ71IAmZfPHiDOZgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214877; c=relaxed/simple;
	bh=xPc5VouSLZAk6rtzQm+iCZVTSD4C5Pa1mhNOLz1cBgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYVAqsgsQ72eoZV2vermSTUJDboZyAvzxiFl0uynApPtDnExne3rKAFvHGKKTwKwPVxN0nnVZD4SkXpKf4QxJGDeLYiVOOAYtd3/2WoBPCQh0YIofk+VnOEo8knCkWkE6P+bQqwlaJqlo5oqGQ4jSHhq2kaDiYVHXbRLbNZiQGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=r3+VQ1pM; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4c3d8bd21eso10043a12.2
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 06:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1756214874; x=1756819674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVZs1Yt4B+M7h5+3RE2O89FKpxSDOyOXZc0rIy9h7QY=;
        b=r3+VQ1pMj/yH7w+RPZsZSLj9fEOcw4gGSEO3pFN22urfgv3MtFWaQqv7AycfwSkWKk
         Y7hPE+k/q2SNsbFMwkDCB+8uoaGMNDqgQs1alS+iBrROAVNeLaMVvwMIN0nVs3Oa0I2I
         0Xnx3N5GQOFmBTqhC5a1fowVvRsQEclI9Ms0J0v8VMNzWHx14Z0ZXCgh0lxZ+k7l/3Dz
         Imz4ZmFJEyvoKotmMGYtnwR8PZz/TWFzfq+BNF4M7Dusc627FgZItZVMwVJrnR5IpBS/
         eguI1CvlZAYLniECnAlZYNYzre4KAdkWojWtIvDwBweR2tBJ9RgUHoQHvXEq52ff8Cxx
         nw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214874; x=1756819674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVZs1Yt4B+M7h5+3RE2O89FKpxSDOyOXZc0rIy9h7QY=;
        b=JrcUxJm2jIk66dc1+5XDKtGTwRar+fW6VVJifjRYy3UGojxLEg1kLDO2vceJUHHmCP
         NFXXfA+ByEPq2yKjxmW3e9oDm3vHSriuqxnaez3ate7wN/+1X/Ag8Eg2cgqafsn2PjNU
         /FvKaB1GWn8i5HbUlxwjfoc2RXc6a2OrrFgX5xXYauRVPU+fDt9ifBc1mTUr/s0tHQdW
         VSO07yYvSMlHgTvVWjiDWL4ttHzpH3kCjE136kSpvozhhgN9+hTKM6fsSKSb4vO2OMcO
         1885YZktSXDY2HuC+XecSIy+qUumEbhDuYAaJ44fGZhVDgH6gDhZmUzXnFCeyQ46bnoq
         IQ5g==
X-Gm-Message-State: AOJu0YxfhkzXmcBVtrxCB3KMt9a2s3YjFTSI1osPp5ej/ufl0Z/ThKIu
	P7rZ134QF7OdK+0CuyGB9fgUmzWudF1jTlM7p8lQkCXHrYo7MhzXPMOzwWDgk77dG8i1GMwtbcP
	BRKzG9egXKlmIW4eWz780G6jpApbiWAWtm0/gHk7RQg==
X-Gm-Gg: ASbGncuTwPlv37g8tk+/Dvovg5u0XaSZaPQbwJ8Gz5uS0q3EZMIYAlKdiV7Jbae6+Fw
	hJp/4WgQfrTwS506o9osDTh/f8MF4Rslgzu7ojUMtuqccCv/uH+jm/xnJl4cgLUK/yvo15M+iHb
	JJZS976CyGLBO6XrvAP/MEsiLDARZ7zrBUuDxJ+bBIY1mgIgdsUYBQoeHQ55Rwjjw3qUZvrk1bT
	DezKaQ=
X-Google-Smtp-Source: AGHT+IE2SVk4t97EhOugJmDZ3uaQs0E4tn3j9laRwvd64gm7WJAI+S2PXD6GkLMAVmz/RilHosSphia3Mhafwg0GRug=
X-Received: by 2002:a17:902:db0a:b0:246:f123:ccdd with SMTP id
 d9443c01a7336-246f123d18dmr59187785ad.8.1756214873982; Tue, 26 Aug 2025
 06:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826110937.289866482@linuxfoundation.org>
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 26 Aug 2025 22:27:38 +0900
X-Gm-Features: Ac12FXzRfFlBpNNsy7AVluxhNzcPDiGjNZum3e6mUgmwnrD5CHykobV1b5JZI_0
Message-ID: <CAKL4bV6_QsjosQHz-vVzwKBN2Zu=vc7QwEM0djuipP=g77d3_A@mail.gmail.com>
Subject: Re: [PATCH 6.16 000/457] 6.16.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Aug 26, 2025 at 8:14=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.16.4 release.
> There are 457 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 28 Aug 2025 11:08:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.16.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.16.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.16.4-rc1rv-g2894c4c9dabd
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20250813, GNU ld (GNU
Binutils) 2.45.0) #1 SMP PREEMPT_DYNAMIC Tue Aug 26 21:54:15 JST 2025

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

