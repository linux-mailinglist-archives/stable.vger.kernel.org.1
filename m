Return-Path: <stable+bounces-211252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB9YEqk+cmnpfAAAu9opvQ
	(envelope-from <stable+bounces-211252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:13:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2668805
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D4AF30048CF
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45807322C7F;
	Thu, 22 Jan 2026 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="E2lx91nj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14865343203
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094532; cv=pass; b=iUd3eCF1D9MqYqFde6qTvM6EB4IvNdGRiOmJ2VrkRyJ9P3zduPqbBgTXwqy8h0bX4m+jmOaZBy1pxjhbuM8/XXJthicR8QI/WM7GocOd1r2Nn6bfkChJImLexFWafgiD3rLqmngsApvZtYz7Ch9hOt11fexOnMMjLtdPtJVjwUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094532; c=relaxed/simple;
	bh=Tjz1n/liWX/J7KdtrkYCzQ0rqZb/v1/aI34XVwCKU9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCh76Yw8ZYTW18PHNxkEA/ekqlxeXkfw5/fMRCmekEKgckDu/h9gu4oG4jai6F2G4KfnZpschfYpc86iI/EMmyZjnUyfrqBchM5s5210t5tn0nWKb+9WjXJnKff4Lrno3WxD8xXgKo64C+8E48zRxQkcCMbozONVyQsA+m/WnQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=E2lx91nj; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c5320536bfso121655085a.1
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 07:08:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769094530; cv=none;
        d=google.com; s=arc-20240605;
        b=QrP26K5nHf2UljelV6/EdsJCoZWrdFWkwkg9XweICQ3aJyAbaNrMMzSO+zZiBtr1wS
         F/ARPNSVCBnbB+L2DXd4KBrrHsD3ZX/gtjiZOAeBrEOT5SaZBNWz4nqWtKeBuLYOYyxG
         KnKhYbPHf0ehzDz4tLx5QftgNQkJqdnyjjhfDgORz+6rLqxhCqy8mHjhp5V7p9JrmSUX
         xi8A91+AiknsrnCng3+hEyx5T28u9xIU1q3wXPYKIg02QONuyVkEJdogx3m63R4OBYga
         L/XhDQsa1sExBYsl2yXvMg2WcVlMMM6tTsif1UUh1DaM6csxqKha6dqRvMVCdr2IFRJv
         EwxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M7fCfJMtEJsZ0dKz/99h9B45j09tit05GszkZNosCtg=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=feftEAL4zl1M8EQiZMY1NlP7ML+aC5+uA1EcLRQOAJMwLdLqrc5xnVIL1MBfrwtuEf
         U85xJmmGSOmcj2lUtSJtQ5+nr96aQQLhbUvYngMTDFTYHVTr9PxHCO5QIXEMJosJNgV3
         ehdk/85EBcjs951R3n2w2Dm8weYwT1J5kkkm5m+lzHu2cNj7iqIwjcj2EpsXUm/wV4LP
         JfqYwq4XVfoOcEN+9JpVAs+Lb0CIm7NbQVVWmHWN7rytzMoF9ihdGZnTlfCfOH3dEj4w
         P2kg8jR3IBf1gfMfv8qEThs/6rFrrhk5s8tu8ZJVzJtGsXHLLX45zYgJAa/+oSH7qMsL
         j3Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1769094530; x=1769699330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7fCfJMtEJsZ0dKz/99h9B45j09tit05GszkZNosCtg=;
        b=E2lx91njIMs8guO4rmWpPVwxC6aqhsJetBPjQmnfph60dz9ZhWnDCQuG6DIT4VIXyT
         7ZUZ1FX31fyZlbY2diDBMuZfz5xUYSxyXYqNsaB+87/hgyNES/GcM/3J/2RnEeCl8X8Y
         2hkf5x8Cz057yV0Yoobmqj2c/26GVETVyFt71k58aa8Rvhe1dJ4hncdKKQZHS8tQR+/v
         PaBTPSBo6pnn8BSpOaBwjO57/AhTshaNOkPSrToe+4F8R8taY5mvQGA3/7+C9vVBSmDh
         K0GCSqyFPGiUNpZjLn7qrniWyaWplx4lADAJah6SoBjB/6h99haeRRBmTC02msiMtpBh
         uBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094530; x=1769699330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M7fCfJMtEJsZ0dKz/99h9B45j09tit05GszkZNosCtg=;
        b=rj6a7AvYr6asyxxoeX/HBX3TUWbXEY0RsC54kRe2rZzjL38ld26G1xB3DsI35gbsBJ
         RQ29y6sRRCmK1d+Kh3NJMXBkoYO6xZKylApcUXSWmWZh6ANL5Zp3cwlGj1+9pm8089rO
         AB0r58ZnpUKHzGd6aEootHpIZ7rNmyIvypCmpdl7UOVRxsjU3kpOoBPAloH8XCl9j2aI
         SCIUe650eRZbf0813oJqjxxahCSFVRmg/tYGttIa43sZpxWSnhUtVs6VaeaNfeVn0Y0b
         KxbPUzyfoOxfp344SXh0eiPAFII3GOQwHr890c7tbfjFTcZc/xE578JVCHo3jlsAM5mk
         g3tQ==
X-Gm-Message-State: AOJu0Yy0Xc7paMCafWY3mg3pLVDUl0HmdhvM9FYiennjK1uapvtxeeT/
	I+qggULPBmCegdsfRzoUwpv8RMdaBd8ylXmqsmV/AazJisV489D+ivRvEVe6WedFfn3A2s6t+Fz
	51wOJu8qMbzQi11gxCyHfyB4WwSPYB1TYo4UKFypqZQ==
X-Gm-Gg: AZuq6aKYWejhQ5DLUUC4fT5kuOkBU0GG138p9ZlIi+YSzzanuyb++7oqMyV+rayLbiv
	0MzRrtZHuMP+JTBC1PcAEYPi6upketgEme/GNeaJj0JLm8eelxHXl0glsvTd7eOqC0ERolzfxzT
	mCLAtg9/x61t90M3DJGZ8hmMqW6BzB21h/FvRh5JRk5qOg3WWQexQw/DmVW7J5BgjhEWlOYbzV3
	acuC7bD7886A0+hOgYqzFlqPku6en1tiW4MGW3qUIxIKnTIv6HK3Mc90Vkiv03pMxeLQ+C2
X-Received: by 2002:a05:620a:4152:b0:8c6:a3ed:2f65 with SMTP id
 af79cd13be357-8c6ccdbf53dmr1159034685a.23.1769094529672; Thu, 22 Jan 2026
 07:08:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121181418.537774329@linuxfoundation.org>
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 22 Jan 2026 10:08:38 -0500
X-Gm-Features: AZwV_Qi2-KKtNqzQziNRTefvMrx5KYCaonZmcP-5tIIsASJajubPco-z2jiXGBA
Message-ID: <CAOBMUvj6Me7bfDGSGyaXMc+arHOgSEy9FazAy3_CB3n2t8DTrw@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/198] 6.18.7-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211252-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ciq.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ciq.com:email,ciq.com:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 9BA2668805
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 2:47=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.7 release.
> There are 198 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Jan 2026 18:13:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.7-rc1.gz
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

