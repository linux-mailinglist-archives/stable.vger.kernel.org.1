Return-Path: <stable+bounces-214476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL2cG0qrhGk14QMAu9opvQ
	(envelope-from <stable+bounces-214476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:38:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC9F41E1
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 15:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F133E302A7DC
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 14:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916DE3F23A4;
	Thu,  5 Feb 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="pi+KSI/E"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF633A7F4E
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770302016; cv=pass; b=Xr0S33S/baptuqq3EmsC2hM+Tq2mrdbN3Mb36sfS6W/XiLf99zHVVr6HASbl+oRbjxu1HIq0SnwzMM1+USDeir8O3sX1soSVykyIq9Qs7OK7B16xvIJaNVa2LiRgPLNVDBlv7GLsg7p+i13d7S3U3BawpIZ6nz0XQTN6CKLxNyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770302016; c=relaxed/simple;
	bh=4CksDTiJp5h3n6rmfV5Klh4tq+VvmLa08A0es/ESLFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9MocxA1jN+/2Jfcqqav6tgL6yKIMntXhGqedo8n0biFKFebC0th/sWtiBUkOj525bmC7JxQdrfghT/3piuPb9FNoNt1RjjKv+dBi59XDIdcE/V65EA5rf9t/0M+BymEezcGpQUSUodIN5ee1vnNPHksRjQxpYTfOQfSlQJUDeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=pi+KSI/E; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c532d8be8cso81679585a.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 06:33:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770302015; cv=none;
        d=google.com; s=arc-20240605;
        b=KQeW/wcS+ovO/Cjvm981ZqNFo7h7seS5AOjG4fC6Q0UUxUvJglSgYFIh2hiZ0S+nEZ
         pCULlh2Dm9vSlqMGqLbaE4ffIDk8JFpuzlY9KW+3jK4rnQHMvStNMVjxwgutSbn9d7cK
         64F3KFqnK0wtZab2a096I9G1SHTjKvj0a+PPW0ZjNb5CLdve4UlTFBCEqYS5SJChhAHg
         kO4uQQ7agaYCxmWDv0ZVg988+CEOzcHrr9Lx5Z3K+eLV9UTtvGv2z7WnoOQmRi0VDHbA
         DZn7Z4dtTVXa2Gye2ujBYYgGZ7AH6nma6jKXStbgN+00KpKmdzqi2PKSn9/hzY27Ft6s
         z9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W0lj6ybgFHfhqqBIa8eKQ8hru5DIEVLBuCsOgZF3M1s=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=BKfkbH8ApQ7IhYbBpOe/XfhN1X3jilUxIFTtzFNJuafoY8DJOrvB49yHkKw3FqUKqd
         VOB3ohJotYYSXh6xWhNCK02bqOnbvNT8jibvE82NlKm17tAkXfvHtaNOLsmX2cA6rMiY
         V+px69gldoiOsAJEmI98ltQPP7QiDK7CkTqLatxJKECoOYqYfFDdqbaNoJyFqdh+1FHQ
         eBvIDXYL6+OztCsErcebg1dXBrEEpy1WYGRHqaSP8zL4Z7jPOg/iuqkoPyT+ygd5NJtf
         RWrTkS/3+vrhP7ShNM+PhpoPiEywzD5nBiKEFuCCQM3CXyjYGPuFjoPbqrXA6vcF+TRe
         oFyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1770302015; x=1770906815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0lj6ybgFHfhqqBIa8eKQ8hru5DIEVLBuCsOgZF3M1s=;
        b=pi+KSI/EOSCzeVQjIcCZFmc/x1pUe8ZnjyQHsJ/Xgc7SdjBvQKuEY+tBD6d8gOMc+x
         MRnuz8cirNTxQkrzPzCGK6L6TKt6W2cwfch4DzBf9sQX7NzZHeN1WA43ZdHjpHdk0s74
         vNuXV7tzyuy0seIx0bNC5HI2CvTKGo8+kswloMOKW/e2ov+1lkgIxAoWWM+1rw4Ii9IV
         pFYPnwCLMsVWDQP38NOdQrBZqXItzsgJaTVUsPQ8SANdGyvdIEZjUFLHdPO6ZBA9Awx6
         kkISf85tVPwJmHVgSkSB9NIV3yNoRilTVLjyecSKO+9SFyHtbo1mDeI/AsAXm71ttRG5
         dvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770302015; x=1770906815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0lj6ybgFHfhqqBIa8eKQ8hru5DIEVLBuCsOgZF3M1s=;
        b=mYfm256cQJnxtfFinaaK/VgYndWKgRzytFZREz5DwlLeGQNZCBpavZB7p97tzCFXLW
         dioDQgppt+cVcH/WV3QLL96SMwO4CSXynIpLdEHbpPGX/tQ2z3s9OXkBODjgOg7ChJfa
         hlLa8m+T4xC+5YnsGkEtHBrHgryEwKHiWJ/zCLLz3UB8RMU2AMqIZsjVj8ITseNTZns1
         QHyy+vxXt7A5weXxS/hWXPHac4K085GTj8PBP7VuV713ALWBgN2GSIOryuS0WvFOwoMi
         rMKSiG9X/4u01WPb10aKa7NdfJYnd0KuNLJCHSMEqKupUb8q69n9CBf4B0BqUqGxN96p
         t1NQ==
X-Gm-Message-State: AOJu0YxcUWmCCHX8dNiJIGLDh0iQs+lFzSiCH9ElCs5G4DY4lfp4PCs5
	SLswVDR9v65leMox4J7Yw8ao2HK3nMHGuqMM85aYAafD0CLZLv1zYUKzT29U+LqoRzzqpfLA6dP
	JIm/NSDScnTruCM/uirKKm5oNM2dUwgWJuMvoYnomp5jlSEH8QreMON+QfA==
X-Gm-Gg: AZuq6aLqfDE7U7vlj4IvarMYm8s3Y3MZX54P0R+phP5hzGrrthihT/g9BrkctkfCAEM
	eMBQ9/PSSVIHB9M6Gt10+/G7iVbJbqDU/AxdeU78pRHfmi6JALsotOqvddBfaEvTEGe07DAwCI2
	5NnvPkKkbGDMwkOh0ak9/arJLJMsN4yxCgCXRQvE/AT0cTfbIveXAQ0u+5aSa0T6pmO3wa1joHv
	hsEZOkUJCOSeUwVQaXvQZbcLVpBS89uDCuMITHn307jTPrdvs042eCUu7Z2LdSNsoTPtO6w
X-Received: by 2002:a05:620a:4110:b0:8b2:ec1e:fe24 with SMTP id
 af79cd13be357-8ca2f9b6ed0mr842841185a.42.1770302014920; Thu, 05 Feb 2026
 06:33:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204143851.857060534@linuxfoundation.org>
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 5 Feb 2026 09:33:23 -0500
X-Gm-Features: AZwV_QjHw6unK5JJYkPoUZ6CepgrdEHtoGcfeD6qXg6V6OP6AqzI_lxU1VmDnGY
Message-ID: <CAOBMUvid=z5o+6wBWYKkOQRfHz3vqgZFRos=375DVUfZZOAHqw@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/122] 6.18.9-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214476-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,ciq.com:email,ciq.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C8EC9F41E1
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 11:00=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.9 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.9-rc1.gz
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

