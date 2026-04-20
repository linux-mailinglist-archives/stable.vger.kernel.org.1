Return-Path: <stable+bounces-240007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFOrHKOh5mkrzAEAu9opvQ
	(envelope-from <stable+bounces-240007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 23:58:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DACCC434664
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 23:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB9C5301BED7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0BC3CA48C;
	Mon, 20 Apr 2026 21:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mL6G8dBO"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637F43C4565
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776722334; cv=pass; b=sRFQt7MoiGGeUEFYwl8+uFKu/FcBr1U8EXkO/Q6rsOravSvCbOsWJCD5jho+VwbbXmDx/JAaQ7fUWIwIgOy5wfrGtMWJocN3fP/Noq8KlDtNDktND/IEnySMSO/GUMr6ib7guCD7HyyVInteWdjLPctot+6VIP6Wjt9h2wZdBi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776722334; c=relaxed/simple;
	bh=HCKD6toY3HbJTkl6w1jbl0IXrfFRt2dT7KDwdYn/4B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/t+NUA1J/fT6kCbJ+rX1uWmH+fJ9BVGbZ1umbrwpUDB80Akgql+pvH+7fVPivMwamXIVtSK+P31X3Zk6+BakjMd9xZN3Z4oZYG1zshLBWxFxUKaUO+NAfLJT7fqSWuR08a7XYA0Rx/nSqDtAdudJuHFhXt5xBtTXdf6WpU4CFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mL6G8dBO; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2e622a9da9cso994258eec.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 14:58:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776722332; cv=none;
        d=google.com; s=arc-20240605;
        b=cF0cx85rGlxzgclUTvaKnI/TWoq0n+sNX7J5eIIhWc79jcCwSMHovujk0U1Xn92Xv9
         SFICzr9S7CwlwSHI8vKxIL8M8jKdGzUCKFn1GaF/90nByC4Fvcvo6n8SR7YtEp/Hy6h2
         NamGL3IZ/aYSWFD6pPnUPH28GfKqemE+H33IEvDn/OQ4cVBWBDduYcbLcXSJTR4m9yBp
         WjAHIpu91c/nQJT+4ldLTAT8i6TKKvvUrLc3ZF1p75ZJVZV7FbTc/TO1BjEgjZyVSpGK
         FRoFBZ1IFhqq0RuW9L0uCHAR4UZfn57OB64AKL7jaNlD/CAvRWt41xlNjogqYCjOpart
         t2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MtrzV8J7pr7E8w58W+xsLbTKab+0Y/0KKvbePLdun0Q=;
        fh=Gn+sffF8yoCmi/pJzirjG78rdP3tokCWM35lW59Irl4=;
        b=Mwx6gMLSK3NmCZDA80eNQ+1KntU8eK2Nlwf9ISOaCQFk78fap+3lXfwLCaCBJB7X9D
         3Nnj/XyH2lAS0+XTNem5hLtyDTxEe+nEHgFgc4HfAksjfs/XBRZHHtBFXHNRXX0I3iab
         gPm0Pwxw/52JoL7Gk+s7nF3AYjrGzo70SKOLDp3ezUv1JwB2tJrDARfWpIPz5L5igrjU
         1uq2PREDxIi0+qhKLc2QzXMAd/D4+EFDE0lQ4gjVuMRBlcKyxWkr6PzYEmHPnMyK1mMn
         u9aTkK89peebnxwlv4Qu3oKhK/9yY+3QORy2bC9TUYtkYNsSyFhLy9MNhl0hfo/OCRP6
         emxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776722332; x=1777327132; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtrzV8J7pr7E8w58W+xsLbTKab+0Y/0KKvbePLdun0Q=;
        b=mL6G8dBOXkoeYRoLUxAW8ecI5AObBGlN23KqhZy1+A4W7pCARTdkfRvp8pGOcxBQwg
         uxn+w2SDbt8tq54464sVMe0Ow2uf38mmExuzPLx0ue3+QmbljlgGmrAUAsblt6Dcxs8B
         DbMdHCly4Eipypsa12JExOdQzgkGqn8aWkeWQyoVFoPrIXS23OaTSKiTxKcxO1DGK86u
         id91iy5BAn4yqwcYDyWa73w4XnLZX87v+wiCn/ZxQfK2iFQHuX48Kf8l3NLo8xhOeAgJ
         ptWZLNGZgFwps3lTKQJs0Tn55AQ416fcHBgoFOL97ip+i46TjNX7HmoLmV8K0+H735nZ
         BQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776722332; x=1777327132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MtrzV8J7pr7E8w58W+xsLbTKab+0Y/0KKvbePLdun0Q=;
        b=JHwbtZqwMdqgGyR751cBV8VJ+sBouJxL1+PxODs58QZH+2IOyx1Ij+XVIHAzCfWL0z
         gZZrwt0/yHqrpuWZTO0n63Uhq9iZ/Nksoy/KJwy4IjwQcVs3dwdoTMdyctswLujXY8e/
         zNuDg12Pf5D268nbz1qk+4akJQ6w7500Fd0sO/ARTrDk3TGpro4O7pk0c7P+4lvSwfs+
         NJoEeb3gaq0XhubQ5Hb1zEr02hvMP9D1nmzBOh1/kp2u+OTTZH1MHEXEDtKPOP0bnP4N
         wMQxmYEuI1izrjWjp58r9m0C0/MOZPjyNndDcfJSF3hAOBpM4pm0GAmxGHXQswZ4iuaF
         666A==
X-Forwarded-Encrypted: i=1; AFNElJ960dKNjy179ze5izWp5RGThTZxS+wTIdPpHiUT+6QQfkai8DMlkZB+iE/7rOpeMH7GUTW4Sf0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm9r343SWBajL/U8anhUPJG/0as2kgopxIvmCeUFYbsxCbck4y
	r9Cfkiq7hdErCXOu0TBZ3PvocH+vOQk7y7Tni2Glbl15qcIAe5MZ4pcmToGfmE5LtF/gxk/isd0
	jx6KPztLBUd1gKlQz3U5BKCUubWV3b0c=
X-Gm-Gg: AeBDies5sNa1DbLigQevHMt3utmFFgLJ4Si130hveAoWe665z5HjKDoXtztW8AGtMQd
	CTOPXAzQTupIjBpZULDq8YrZR/ZUb9hKaS+DsOsc5qTA99SgScBZcu43qOYaXFTqs9pnJSbF9Wt
	n+SXy7eibyvTpS37hf/8ONoQ7awFIAF0xtE55fnrrQR4E68NDZVp4yDEyCRTa1USdxFw0nHeH0P
	urgKB9USu5GHkA9wcl1iE7mtgoul5vaDueFpdcDS9/DU7rgzybJ9CqIHRGg+jHWnNS8AHFdlYSv
	gyQgct3dB55VjQaQjmoSyQJT63T5LQAOCPiivB1Mw0ALd2NsJ9k76EuBZz+JurpKfjGCip/3nxI
	XrmcHLWEnuwO31zzJ3bH9wn/T2gluO++Pmts6xQ4QgTu/e7DW2SP+BZm4O0pybGJZjV90LaEJe+
	rrks3WBWgnt4f8uFjnRXtc4g3r/jh9sXnjdaaiWM02OptWQWQacQ==
X-Received: by 2002:a05:7301:5784:b0:2de:c5ca:c1f3 with SMTP id
 5a478bee46e88-2e465293dfdmr8343947eec.4.1776722332471; Mon, 20 Apr 2026
 14:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420153910.810034134@linuxfoundation.org> <7cc779f6-3cad-42fe-a8a3-fcfcea581015@gmail.com>
In-Reply-To: <7cc779f6-3cad-42fe-a8a3-fcfcea581015@gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Mon, 20 Apr 2026 23:58:38 +0200
X-Gm-Features: AQROBzCVj2mxscr7ZQ_HMMDBZUZrxE7mZBoBwGuLKZS-PAHhT5mJdIWFcmdvqjY
Message-ID: <CADo9pHgE3E1Nqwc9O7usTRnUOhRCg2f+CRRbaEL9Hr4xk3x5KQ@mail.gmail.com>
Subject: Re: [PATCH 7.0 00/76] 7.0.1-rc1 review
To: Florian Fainelli <f.fainelli@gmail.com>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-240007-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,archlinux.org:url,archboot.com:url]
X-Rspamd-Queue-Id: DACCC434664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

and a Dell Latitude 7390 with Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den m=C3=A5n 20 apr. 2026 kl 20:17 skrev Florian Fainelli <f.fainelli@gmail=
.com>:
>
> On 4/20/26 08:41, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 7.0.1 release.
> > There are 76 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 22 Apr 2026 15:38:50 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.1-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on
> BMIPS_GENERIC:
>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> --
> Florian
>

