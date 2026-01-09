Return-Path: <stable+bounces-207864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6B3D0A86A
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 15:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A9303024D79
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC77535CB9A;
	Fri,  9 Jan 2026 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="Zut1qHYK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4635B137
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966950; cv=none; b=o05fhBcYynj55pXEc++P95aw2qcx5D++Xuw3xsRMH9lOLvsZZX/i1TMLwiYQz5xOWnFfIfKzKjcOZJGIjLu8G0Sj9BfB1d3AlTUwF2e0BSuNbIQiffuvK552Mo8WffRU9k9auJPKvXIKR3KtZuXDHPozdATboC/kYavsIREtIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966950; c=relaxed/simple;
	bh=2Yo3C5ERmMfDM4ZSWlEcKdZbPH4vlI6N2Ud2n/PFc6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWGoYADo4EQg7dXd6VEAKDkdgikVeLADvKQiNJ/H+PznqlZLnGGwNk9J0njtduDcSXPdkCH+iheCr7ZiCHy3UGpC4LRd2TGznEDwV8E2eONGQaNBmopaj/Y+mbRWGL+34qEXihmbFVIMB5fcvPOa9F9RbT6HK1EF6XecLgxLQtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=Zut1qHYK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso6690655a12.3
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 05:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1767966947; x=1768571747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpFrTZ0+VBSyjied1Kan5BDiMM1vNNW7nvgXJ0c0ilc=;
        b=Zut1qHYKlVj9WT4INnP7vo6YM5mxis5NeuZKgaczZiWtfoFt3JuxnM4zjH+0kSSW1C
         VcqL69vk6VdFolRrwRfTD1Eb+0JBzWDSJQroDmKBTO+IkAvkXm1bJqfY+BizAQ3Vxtji
         S0M6Ll4SSK1QxPdojtb0xuEtkI7XX7pagPJE4hXmu+32m5oc3QHQU39HKVUQXBhNdSV1
         +WscoCd+iglh9FKEpNczuD3luNSBoclSh/d/rk5Z6GaRX3WloNRzlpr1bsgPBICNLmez
         luBcNB732clm1oqedQaSA2DV2vqMF2PiepGV1h1FXynm0PFvVeHBQ3HY+Mfy4JV38aN7
         7/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767966947; x=1768571747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PpFrTZ0+VBSyjied1Kan5BDiMM1vNNW7nvgXJ0c0ilc=;
        b=Cueykov6ov+Rmyw0T4W9hR6j4AapGrVxnW0M9a2LlDoRkIsgs7DZqB2TfPMmzUZeoI
         5c1fA0cUQLxgz7tLvfEzh2X6ILEKWscaZE241LvdRDi29w2YUZKxV0f46CZAZTHXH+Zw
         lhb51JEO9qsmp8Uii+ULhzntL2qcWJk9BeT4PsC1wKXGtF8KviHLx3Jpy+MG9YcEOmZI
         S2lOEDAvPK79+E3gmpaCYxVHMxpx+wS73hl/yNFZZIYpgq8vUJZJu9bnUq0u3Tt2yxX/
         1NJhzDHUMJev6GGqCxw0LHAWFSABud4QOelpRG/T2JcmBDZOWr/OyS24xITaWuzNUi7s
         hyug==
X-Gm-Message-State: AOJu0Yw01DbLkcrV0kBi2UcAneRzNv6mURqjCa1o7rOmmSeSn9jI4HZz
	4BE8KgzQmV0acxs7/4jndvZiw3v+CifdSr6/etzzci19aI1fwafHM/mV6AymYRPlQDIWmjTNbCu
	L4ByovaKT0mYrBt2nVzu7eOrMsltmtfEMfxZq7wJje1u/4yQ9Po9qdbjlL/Y71pfEp7finNNOkO
	ctUe2tN7TpqAUXQSeNIg0DH2klL94=
X-Gm-Gg: AY/fxX5NLjIew6LbzPYqm1hjkKhROYMLrxW8OvJpzmFJUHSyv6bOQqZpMRtQ05X3tWB
	4fQpgu+FfQDUeZh2xgLjEDJNJ//YGEMAhWp/vWJMEY5stF6jErUDu62IirshRDGk6DYOKQxvUI9
	dypJ1gxWWExKcYhazPRq3Abhio22UW43C2QYYTb0MSP5Yu4mj8E80m1FBOe4ZE/FuzDqCaRPMdR
	oEHxpSTEN5SIqgBJt2PCcY91IzE0YUk1igP6YfgOLydBeRB17M5uLhbViG9kRVpF1E0eq2dgVCy
	+8IPqvdWGpWAbU3AHrtnWA6GnKJM
X-Google-Smtp-Source: AGHT+IHAv4n9Z5meAss2Wg84D8PKp50SiiL5mtVKvS2pIvI3+Rn21z7q+hkwG9BUVjX7iLyv4GEHwejLyq1Sh98UR78=
X-Received: by 2002:a05:6402:34d5:b0:64d:57a8:1ff3 with SMTP id
 4fb4d7f45d1cf-65097dcdcfdmr9011967a12.4.1767966946654; Fri, 09 Jan 2026
 05:55:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109111950.344681501@linuxfoundation.org>
In-Reply-To: <20260109111950.344681501@linuxfoundation.org>
From: Slade Watkins <sr@sladewatkins.com>
Date: Fri, 9 Jan 2026 08:55:35 -0500
X-Gm-Features: AQt7F2obc11Ixda_pyW8d42vhGcxIIDXRy4rNoe8mp-6Sgs8-JHlVw4m3X8UdQY
Message-ID: <CAMC4fzJQ1kVczNs7XhZSVRRY0iX82UQD1VrbmX6bFOmAvsFxsQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 0/5] 6.18.5-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-SW-RGPM-AntispamServ: glowwhale.rogueportmedia.com
X-SW-RGPM-AntispamVer: Reporting (SpamAssassin 4.0.1-sladew)

On Fri, Jan 9, 2026 at 6:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.5 release.
> There are 5 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 11 Jan 2026 11:19:41 +0000.
> Anything received after that time might be too late.

6.18.5-rc1 built and run on my x86_64 test system (AMD Ryzen 9 9900X,
System76 thelio-mira-r4-n3). No errors or regressions.

Tested-by: Slade Watkins <sr@sladewatkins.com>

Thanks,
Slade

