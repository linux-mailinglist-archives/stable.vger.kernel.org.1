Return-Path: <stable+bounces-212782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uACwHoJue2mMEgIAu9opvQ
	(envelope-from <stable+bounces-212782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:28:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CEB0F04
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58AD230238CF
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002D82DB786;
	Thu, 29 Jan 2026 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="UkR99Lej"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CF288D6
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696813; cv=pass; b=lRnvjck2c6a84Ojtf1Xnw8u7lDEUJN4cgKoP19UJ1DTtMmZjE/brPQRQi4yw4cdvlSZedb4HFz9LgDYFhrGw98LOVfcgHbkWVhKjreRR82ffwJprpkpm3m5UK4GDHXW2HLpI1+LZvuvmRYDOAy60074bENgETeADbM+BrpblDbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696813; c=relaxed/simple;
	bh=h8NXGHQhpL4nP/D5D4etUetHdBLtsw2/0Xd7XJknJ0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWY74mX404TPnnL8XQt3hjZN2BCQswdzMoR2whEFPqYtToOZ+qTXqwhaspvPsHx1+R67f2CABs9aIa9WSwRmAWaRyqYqDIpKKbJWYhGgVPd1PPzDhhENNeReRgRQz0hbHDg3AeYIvGaqf51LLLQLcGftf9wdKTgKT7utWW4MDGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=UkR99Lej; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88888d80590so16664726d6.3
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 06:26:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769696810; cv=none;
        d=google.com; s=arc-20240605;
        b=ACJQvnJO2i5zx9/aQoL3N4/U51pg0gCThhNFtWte/M1a/rV7YDj5jOIFEUtmTiLCtk
         s3GRHY8PFN0GuNNDSHBW7XT+j7syLWUrvqq+fWePRRpu9tvskIz2tLedzM5z2ByHOTs9
         /mdSUgcctSqQUaoiKbmRY9jfijNP0gMa/snu1MQtD8E92/sWvXET91LdQ9Mdpi6Aj/qn
         YuTK7Av2mIUWSbn3/n+rElBshveyJQm2de15EZW7/UIbYg+weizLwj7dffTosX8AoYp1
         aydZYVXbCrdrGRsJ+Vw7yXsp407XjlrsLj/waHCxgnCdx3LWijJrv545WIXSs73ibRGt
         YhDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7QsXA3epa89cEhQE5Er/kgphFw30FwHiK9Ct4PFPOTg=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=LwwfWA3xgDcq/KxiLTnAmtJJWsQQTP3hf3F1y8qkDQ1uvkIrhOxnVQ35712pEEkQzr
         r+JDdpkgYEyiEGNIeM9EJhxfgzVk3rctuUVEDbHzK/xqRA4P+3xAXM/0Xy7RgOzzdi4N
         OZKsNlocKUFx4sk2E5G9H+HNzMW5WMlBMskFgQdYn8yDBAEFPjJGXGuAbpJX0wcKWx2q
         heX68yHYZrtT+PZtTz5TE6bm2iiobNy+ZJn0UtGLvKBjbpuvGq8pP7DPHmM9fx2D3dyN
         27LFkDTelYLPa503IaiKHV6Bu4HWTli9Vi2VbUV/a3wXkhCHhEkEjyMj7+uWs0cqp+Rb
         ZWGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1769696810; x=1770301610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QsXA3epa89cEhQE5Er/kgphFw30FwHiK9Ct4PFPOTg=;
        b=UkR99Lejk1W/zkRNGx/KYDg2x6RYprBmuBst9bEbu+4EOGNMe+I4UqvUSY22Wsuwry
         Mp7VqUecSbtBBjRtHcG7vekysFPgnsxq2OXJARGS/d4/L1mz0dcpdIb335K+gM+FkmyA
         +flH15uk74MgB1WHDMMZ9a7j6NsWnXpS7SlCrJfMmU77GwTQpbDQRDbn5S6FbcH+dS45
         j2Znfb2X4KOS90VPo/qo7yoqE7Kcr1Ok/QLhl/hrCHPSLZu8kPTpxJdz2mHvBSsuITb4
         HHF6zeXMf9fKRpY18WCck8c6OhrGdovM87kuIfSWssH5zSAeMdtdYF6V7y7Q0z+mZa9I
         37Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769696810; x=1770301610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7QsXA3epa89cEhQE5Er/kgphFw30FwHiK9Ct4PFPOTg=;
        b=ntbJh6BzFyktmAaES+yI7J0OjrkTZKmAuIMw6X3QFjF0MqBdbvRDZdkFlb4tWVUuw8
         kRyeFGw8vaBSk5tDYFTnIXVQ77i1vQIjyqCjSguyn639+Cshav8UHGSrlX+roO/2QE6E
         ZvNcBl+559o/jSsrDdclXzpeSW5nDNag05pap6+I08Ok44yGBBjJyim+2iE+vnemIb9M
         BXs/qeMeq5tJgNU5JyKsXL8LxhQRz51rkvzFXVQq+/Uk7kLtyp8JCm0PMgXcjnN8heYw
         0yzONdDR8Hhse7wnGrHYwAgVNaP9BFm4pIYoDk2me8fOWZsgfd0UWd2CrEfXPzzD+/ap
         LtSQ==
X-Gm-Message-State: AOJu0Yxh9IDsU9yPuZYi2yYc03+h+Q0zOtfDbrFom1AUoHgUhbKywyja
	yg+zDcB/qR9ewcPsbUvcOr6wRM51wTrMsA78G78NDrkpf7nHX3zk6tzW7RhmugyO572q1D0DTfK
	nH8yRkmwH9oUZROnExICMS5vCm0wsTX0mbjUfWfDOPg==
X-Gm-Gg: AZuq6aLCvNdRUuINjVDDLNUPhvesN4f0tlDxyQp1AEQ+Vqs1HXylHwRskS9z/2yj8GQ
	KcbKkM9O7QtfbAsNPWNYlQJHuurmWHth7oLM4cABV+gx/RO3Wy6mz1eRoEv/YVDTY4I+/rdKJD3
	egWyL/30W6Un+kTNmyyHfjoVdI4OU3TJ/LfAKJht8e2icxRN0kEo5Sv+eu29uNuyce03iRNVq8T
	MqGXwH0CrkvO0D6eUncyl8LetamqHaHt/mQR+Xxk/gWqyJG1Wu/DU5InVSB91EMQ2YqUyS6
X-Received: by 2002:a05:6214:1c89:b0:894:6daa:a01d with SMTP id
 6a1803df08f44-894cc956d6bmr123278816d6.52.1769696809879; Thu, 29 Jan 2026
 06:26:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128145334.006287341@linuxfoundation.org>
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 29 Jan 2026 09:26:37 -0500
X-Gm-Features: AZwV_QicnjuhWmheBkPGbz9M9v7gkiDmraAzzCDriRsPUx8lbiigcYOy6KKUVsA
Message-ID: <CAOBMUvieFR=3798gSLriKGj+VTCZNo+ot-ESQH6kmbT29_y=yg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/169] 6.12.68-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212782-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ciq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: D92CEB0F04
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:57=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.68 release.
> There are 169 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Jan 2026 14:53:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.68-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

