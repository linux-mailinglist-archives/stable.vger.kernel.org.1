Return-Path: <stable+bounces-225317-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH/iHUsctGlLhQAAu9opvQ
	(envelope-from <stable+bounces-225317-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:16:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC2A284BD5
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1150E31B08FE
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0FF3947BE;
	Fri, 13 Mar 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="jtJLUhub"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1B396599
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411086; cv=pass; b=BHLdfyAPl8K2zrWXPz75d3F9wxVkKoXji7LvKNUVtcR0Ns+kNo0LIauZnTHrhWhP0bMnxXJBxQMZOcGegknvWDKwcoz4IoqlGbpT/JZtzYvHAVVed4JLshTM/e5XuMWBICjFg+55wggreHxo166DvRxAJmhWPxdBe2FaW07/w5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411086; c=relaxed/simple;
	bh=tN8aEbL+UMUREEvHUigQI8zy0u5JmgzO+oNlqeBYNaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utS5lQxiUWkH2vhARYeBHxHIFqmsLm46VN2kjxRELNDUHFDZSDiyQFeeSOBSzHCWOIO9J491xKZlcvGknZaPRDuWRhhI3jCXOGNAC6HcEPOqGtqBsLh01S1nQN/DlS8NwvxXvXYmUnGCQhVRrI4Zp8gAWwvkrVIfbF6wc2q1+wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=jtJLUhub; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1279eced0b9so2917672c88.0
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 07:11:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773411084; cv=none;
        d=google.com; s=arc-20240605;
        b=JRomP5emocs0x6Fys/bosUGLBc4S8z0vtThnAwQdQLad15DDGux7/m+k2VkYJdrCQt
         mH7TTYtQ8XLx/m+OW5ZA2AG2+1w4FncinHrF6+I+zLLH+5iwdPqQNtbyOwAkaL0GvUmW
         Oe19nN66EkWokY5KxXzgaVHGNS2BSjeqlh8M/p67MRXPLTcahnmSrIO8vfD1yM7AmhR8
         wRN9ZTYdbYCZk1CA5nz4lTc057DbCp7sduvdMl73yLDYpEY4xOYOFrlFqYKe1o95phlr
         4wBO1gng/lGW0FgzXvKk/76P0Fq6lBRsxzpkdPdVADwdeZruMBrxwa3eXPwriTSGacfH
         JCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y7631mooJHh1Ik/whGkGMVn1GYzZTs9RVCbxYIh21Nw=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=b8owM0dHBlUWUB+53yut7raGnSjg7Fzvd4ylmoLSo1CgeaXot1j/HQ/PR3+bpOgcg+
         75lQISOTpH1rsauD7gJLZ5S82CQ17BLtWe7fYljezj1GeSxx0YCdreZZJyPOlkKEWazX
         cHplvUs+cbNitAAFGNiTVHRHX/KwFaTh/vpPumpBDPDt+q4tbm4zLf3Fn3dGMvHhNwYp
         mu3yyZ1x8wLstjFITw+yNvcnJo45fjBJenakBdM1eAvaAehH9oegZsi9qOAWZCJD3Ea8
         9bEhMD1uASA97Mp+PHtRx6wZQD0UKuduoSHAsguc5bLkgGYPgJrIGjYTwWPC40hxRVlM
         80mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1773411084; x=1774015884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7631mooJHh1Ik/whGkGMVn1GYzZTs9RVCbxYIh21Nw=;
        b=jtJLUhubqeOgO/dgH8BFEs3tE34wPU7DlnMBVnVSZ3u3I0zegbGuZw+ZPHT0T8gCGl
         4KyBO0/PMcUE7ZMbUIdpuLMyAV1hon5BPY8nv4U7CL6IL8OPzFsTsa0GfCNavvwg7292
         Tz9un7xkQ/ozucMZu3mBQ8gSWoz6qf3KmpDpukIiWLf92yX4XAR7QvQmyRdsl+WahPjS
         V51MoQ4Sh8XG3IshJH06ry6gH9xaoZotpiwL1sdlTduMfobxaRDruFmwsICnvk4/FvLw
         1B2o+FwdXmiA6Y3YpfdJYzDIJFT+XbMoME21urczTtcoIUZGbdtt01jo1bBPcqD1zrMb
         32Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411084; x=1774015884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y7631mooJHh1Ik/whGkGMVn1GYzZTs9RVCbxYIh21Nw=;
        b=lxOg/Fha9wCg2Dk0hSArGOc/sMilR58sMYR/+JLxLjs73XzH9aW61qryIEkMnpi8+d
         2rebFvEDyetMQ+4teCwd3hTtMgsLNYCbACKkjSATcmRvqbCxx2VGvuxoIsnJTy4vtfQu
         44IPvEzG/o+QnEUnK5Byq7EmflWhOgxc65YU1W6I4fDjMc50zetz65g9auDvgVKvroeB
         w4jyHrlw+SfEW0uhD1yteshw1RMR19rst23P7oHxWWvWziwWySQnpPC1Mb2ssyucf+ub
         lTkCG4zAAcI2lNuCq3gncAN+bLT5TPY8E50/SJgClcqGsI6EHfatMCEQ/XUzuJKIOY7F
         I7hA==
X-Gm-Message-State: AOJu0Yx8uSG5fZ73LE6izSiIr+TGyFna3Mc3pTD9HEWY/fIZfyNYPP4Q
	NQ3JENGFKbvIl9wiuEDB0+Kghs+jjw7cpRSUJpbO+zURmReoeOLlUb6YgCNQtnRo5PJBYWrlwlz
	lJdlDfmaFIoT9v52NiEWly8qv9xF7OSONlPp4sb+bng==
X-Gm-Gg: ATEYQzy/EQcMLwNB4wTUbRwyFYEwrqfyeK0Z63J4Z77PCsAvWyDifGYwWBlukCzXlVW
	18v8sfIQsNnuIfxGpr9ZTAtnCMHdW+6EUc3sKfdAxKpA7FZ5XL1XVIxV0Up6tIu5UrOJA9FGEd7
	SxkjvE+RciixLDtRydEOCQpvrp1rHiiiIAecK3iZz3zay69IaSroIeUKMzmbQHfpHuSQJQ5n9F9
	YCou3jh03vItz8RfPBsga1f4aK1Q3h9FJwbND7fvNwOwl+xhVarHnZPhitBLZB4F4NdVMDQ29vc
	wXoyI56E
X-Received: by 2002:a05:7022:fa3:b0:127:3b1e:7e0e with SMTP id
 a92af1059eb24-128f3dd362emr1472980c88.20.1773411083882; Fri, 13 Mar 2026
 07:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312200321.671986598@linuxfoundation.org>
In-Reply-To: <20260312200321.671986598@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 13 Mar 2026 23:11:07 +0900
X-Gm-Features: AaiRm52A4WufwfZhX19dCMjL0VALRJ77y2dPNt6g8sh1ImlYHg03JDPx6Mznoyw
Message-ID: <CAKL4bV66vAW5hVOg0UPiSNLYse_Nt_kon61QXsF8U5KrTL3gXQ@mail.gmail.com>
Subject: Re: [PATCH 6.19 00/13] 6.19.8-rc1 review
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
	TAGGED_FROM(0.00)[bounces-225317-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,thinkpadx1gen10j0764:email]
X-Rspamd-Queue-Id: CBC2A284BD5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

On Fri, Mar 13, 2026 at 5:06=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.8 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 13 Mar 2026 20:03:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.19.8-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.8-rc1rv-gc1996363ec4b
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Fri Mar 13 22:20:12 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

