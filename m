Return-Path: <stable+bounces-216318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PNsNpPIj2l9TgEAu9opvQ
	(envelope-from <stable+bounces-216318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:57:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CABF13A33F
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8912830233D4
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 00:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B724DF59;
	Sat, 14 Feb 2026 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="nLXxsvDX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1141F471F
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 00:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030665; cv=pass; b=Vlt+8BpcxdtcqnnAmvGax3YWArndMWrOdQCm7KcQcHmQ+JHoLYUu87Jb0k34cJn3h8+CQ5Kv3rd8iqb+WGyIKecC22ux2NUjhjTxj6k9CJ43QlnYFAQyoipPIWIkAecLXEBW4KKu9YX8QZgSvfLL05JuEOvWOabUnJ9w/A4CxPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030665; c=relaxed/simple;
	bh=sHr1Cl/Gl9fpAr8sKGi8KjHqbPHHwCS/wUW/pNi/eTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CeO8sNSXlgCwSIRBWNT5dJDlYCNWkIXrWnppp7jJTd+x5PyLyxcrXcOEoGQBu+0ljUfSKesGbE0mPDmAd4leMET57GKXhT2eVlpMsjM9H+mJjVGZ6w00Yb6L2HosQbMLL2ZgFD+QHsqgN8gOudkWmZztiref1WPoOEQA9BBrgCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=nLXxsvDX; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-89577f866d6so20907576d6.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:57:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771030662; cv=none;
        d=google.com; s=arc-20240605;
        b=LzLNfeZiTAROW50egGMDK2RcbA5u5xvaUx0GLnuuzg1x2ogyP1Pkv+Znl8tr3aRXSZ
         Hur+jlb3d7i5+k0m0Fz0C9MLVWggTGkxT9QLf6ZoA2R7+93+gvr3aK/oXu1aFrIegDq4
         9PCAQEkaMnwmA1U88Nxk6LKnkGfoNbt0+PentdLS+koFkzDrI7u0J0l8nHZXAh9seOH4
         lal2AnXyhU4j6oepDmxDqI1Vl0j+hpXl9wuTFsPPQwdB8+wDSDgLss5K8P+uaGHEsBC3
         T19NpRc24cOawfYV+Q64W7J3471O+UmSarteAjJtiiYZ+2GJMOxftQNWn8Q35Fw+btd+
         HAOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SU6MnRDhwPzTEBvQJvMDhOJ2GyLQFBxvyqaP+MaDgQg=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=IDlwxzmoOaU8i2RqmBqlrTRId1TpIL5dK0heiqqx9R0QnPlUAbpWQnd71GUaWVdS0+
         uoo/ogEl7lHh4236SpwWv+8MXK+2AkuGx+D4/pzOUmpsURLfUvcJVARpvfgkGHJs2fWQ
         f83ov2fkfxYiDKX6N3bUurr+jUIEo1/xMDth9V0MtCD+mjtgzC5hMU+KJr//9P8UG8kt
         m84J6zqJHb/1qvQV1Br82I+S+wf5YdRTLmCCTRdDswnMK4qnJ6/weMCF68eoSu9orKX3
         nNhb9m/c+HidblFnefp439sJ9bZZed5RrRPV+yNKreCIDd6MmvHgC0kG2y5qhZjg4RR6
         pD+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1771030662; x=1771635462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SU6MnRDhwPzTEBvQJvMDhOJ2GyLQFBxvyqaP+MaDgQg=;
        b=nLXxsvDXfwwnXXIBhtpLK8r3SzWE81XYud1eYX3p6xDVaZjKy5S3iQ8Bs6BRsDc5cb
         o8u8Dr4ZNivx3RSjJrWL2Cvzdmm6a7NqHOwISMX2OENEzkgtumDSwDTwh6Q/5XgKxt6q
         Jvt3aVVVc5i/ZABLeeywi/VnGo+is84U5HzLq8WXYkicPVFHUmI/mZt+GZyhDYyajNCO
         i6VSqFNRPiI1M5WRQCE/6C6CKkTSGsuTFytLbYFcFxbjxW47NKOPfVM39mt754Dahwu0
         gyiUgHHzzmjO90cA4/RFbr9HzaYFZpE9p6o0ZBMVo/huLGPzghKKd4iCAlKczRWpQb3w
         DcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771030662; x=1771635462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SU6MnRDhwPzTEBvQJvMDhOJ2GyLQFBxvyqaP+MaDgQg=;
        b=GReUPN40lzvfuh4MySsFNWx3EAXxXunsTEV6gOf3Ud3HJTOqMhb5qqGDNmZwYiBkcN
         TDxZYyZ9QX/bwp1/zJJERty4I6MhfeZnnM+PyPxYNaqSwCdDWiAaCxjrIJiyOYHpxEPe
         tNtd1gvFsCCbIXPZYe8cLDtxqt4IVXrzhc4rKuClvAllryb35y6wraNTWFOdPBAdr+3M
         5X1+um6HpbHsHo9m0qAdmsNIPZkTabexmClPPcsrjAqXQg+J0rKZ78BBUtvvOT27fpUK
         GqY3DL/48hWpg+8Q/yQdlrJRKgHq7CIWUyjTxIo3fib0pDONw2yV+7GXSFOn0RhD7py3
         Ir2g==
X-Gm-Message-State: AOJu0YyLc4unBjoUu5k4Rq2P9z8fLRJzEskG0tVuVOAfjShUGPZPbUfG
	XorL4ZI+HBv0E5nXP9hGuIsrmsWIZF5LoYCe50J0g6PhW4fJqlWOUMcXEpdHKMFM0jKUH9ZYz3k
	WrgVozJXn2FB7buuPszzaEdSqgq10CRchRMjUSP9Tlw==
X-Gm-Gg: AZuq6aImQmy4Sd0lChjTTZ8/BubAHFe9pX8H+JslWd7scNimh2+sfRl2F8Ebnb3RQOL
	Tok9BpK6GPUcDVEkDK77SN+drE93KeC1sQhepzWVzEvyZ70LpFe4x9niTWrZ/HipqiV0IhMusgd
	j7hE48GmlbwHxOxRUBeklTCrWgDjAkiz98ebtpvcs8vQJ6O0RqWRtCzQ4Np+hxVIPHpS5ogAuMy
	/PRSpTaEKv/vTvoe23LSLuQOCwrhli2lZp7WmpPkNh3NuLZGw1M21w/HSZ3SeQhwISdT10xZa3g
	JLswnUnu
X-Received: by 2002:a05:6214:f2f:b0:895:496f:1a71 with SMTP id
 6a1803df08f44-8973f3270admr30874566d6.28.1771030661914; Fri, 13 Feb 2026
 16:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213134708.885500854@linuxfoundation.org>
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Fri, 13 Feb 2026 19:57:30 -0500
X-Gm-Features: AZwV_QhayJbInj89dprU9BzQFB3-jRrbL_KUJPSMlYjl_XfLKIdFgNNjVeSQGuo
Message-ID: <CAOBMUvgi+=sneGYgUKCoJMhZwd2x55ih9tZa2_LX=Y67pMSEJw@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/49] 6.18.11-rc1 review
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ciq.com,reject];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216318-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ciq.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ciq.com:email,ciq.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9CABF13A33F
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 8:52=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.11 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Intel Core i7-10810U

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

