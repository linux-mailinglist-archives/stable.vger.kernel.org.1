Return-Path: <stable+bounces-116446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DD2A3665D
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 20:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0341891EA0
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 19:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802731C84D9;
	Fri, 14 Feb 2025 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins-com.20230601.gappssmtp.com header.i=@sladewatkins-com.20230601.gappssmtp.com header.b="CkZjHObf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E41C84C4
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562196; cv=none; b=guuOFVyfj7NI9ZkLmQBIVi56v9pGQ0nPihX3TEkIn6SqukAneFldx7j9hXDgn9KH+JYK8mVo+WPcF7OuimKCR72fNFbOPntSv06m6WxXGq0UiMtIUtMfmgTzq/E4Wtm3V4WqKftaWRgsrCXzhVWRomB+QapFAxx9xBEzbouAB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562196; c=relaxed/simple;
	bh=Q56QkAqSvsIKQBhKc9/nl5EaiJ4PZsSBDuJjpKC1AuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZzBuKNZI5tqFcUuUhdKvWowyes9AmFkMOT2AzabG2ceMSadIHxAbQQeAL4zx7wNxTFakxMmT9JbrHH+TfQq4ym42FWpPd7QWKhkPlgtaJc6MkYXqOc4Z77DKi8s53vBThhqX0kEp/7JMw7QdjVMeJSUaYTOnNodLxhd+KPpCis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins-com.20230601.gappssmtp.com header.i=@sladewatkins-com.20230601.gappssmtp.com header.b=CkZjHObf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaec111762bso554064566b.2
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 11:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins-com.20230601.gappssmtp.com; s=20230601; t=1739562192; x=1740166992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TY0DoOA/s8kkBWd88tL/y1YZXdpMeL10h/GY/yl8oOg=;
        b=CkZjHObf6CNCu0YdKm6iSbEEn+kRFr1EhsE0n6RhBQp2FjNX07d2WyyBztKawFF7CP
         DlHl5URlo2km7DSfNL2oe+Ky4MWA4Gn6/M0Boq2qaoM25WindlcGrLmJi+Au5nABM780
         gmM8yuv6WV16UAs4RjDkAXrMIYLSR8GIc6WnEAFzxwLvuQOohmVn6a6whI5skigRH76+
         adYvJWr+IedJcPJkpKGIOR4Kt0SzKqmCe+/NqjiFUBEKcGNsjalptJwlUROTXEW4hZX9
         ofOi9XA/oUZHPz3BBdvn60qYVW0FI6sECZ0PzNT/A5Zr0/lIolXjc0+PeWi+kkzY0uw/
         Rnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739562192; x=1740166992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TY0DoOA/s8kkBWd88tL/y1YZXdpMeL10h/GY/yl8oOg=;
        b=fhAJrK7tHipEWB3xhJHhXC0opSQNrO4igQv2PovRjSamu9qoW2+zjjRZmM1VaqW52A
         R4mQQDhHzJl4nL4ThDpRb9uX4+MG8OzTBE7/qG6aP2woK2P9cPPJIhK+yZKryyfl9bds
         gzuv4d3G48+e4dXcGoYuRxLs4hcrZN5AqDEeww+6jgcxBJpAuXigK5HfI3FdzMFhrOpk
         0GVYX17cU69sC0r/2iQpvVGeGbg2yLTw8WPYGkE7NvjZkyNP7VHGk5EQjkCX2QfqiTRV
         Kxbhvxbcv0VRG4SS6arFFfazQkDr0EeFXx2bV8TrSB9eqIjDsyyCB1IpPUG8LmKAwP1G
         8gqw==
X-Gm-Message-State: AOJu0YwOzGPL8En6fKHtRcp/hSz2Jtb8uJRIAvjzDDmwY7Lw7l2+N8ve
	xWNnpdoonurpZukzQhYWb/yWYPRLKkxzmA3e0cdiRF1pfMX6kur+Hl9ITAlKMaRQzJpdw202rC8
	gkBUH69sNeoXlf+s2UGoWxc4X91uDXcOH910NFg==
X-Gm-Gg: ASbGncvTCLd6s6gYk9WraVbhdYfNJO2BszdS/NHmgFauj4zvtFDT6TN7kVdwxU6F3HI
	v83HFtMq3ZJor+DpAh9HgwbAI6xOyvmnmFXvBPvYW4UtTCWtTjsh6XSMnCLQF8eGuUIgOupk=
X-Google-Smtp-Source: AGHT+IE1oGc2ZQExbVhQL+yj7D6/9XuOay+H9ZYPuFBGVhs2U2fRcRQf9e/FV030JbpAF4s0bLXtmTSrCHVrj20z6WY=
X-Received: by 2002:a17:907:784b:b0:aba:6055:9f5b with SMTP id
 a640c23a62f3a-abb70c01eadmr33484666b.2.1739562192539; Fri, 14 Feb 2025
 11:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214133845.788244691@linuxfoundation.org>
In-Reply-To: <20250214133845.788244691@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Fri, 14 Feb 2025 14:43:00 -0500
X-Gm-Features: AWEUYZnRv0kmWQ8Wfq4_P-n3RgbAjB3ZTI3Gtrs3oZe14Y2S4Ma3FjndvU69qsQ
Message-ID: <CA+pv=HMHE=uB2ya2_bd43H5H__Nay0nXG6cQH93ueC-R1K7YrA@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/419] 6.12.14-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 8:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.14 release.
> There are 419 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 16 Feb 2025 13:37:21 +0000.
> Anything received after that time might be too late.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

