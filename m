Return-Path: <stable+bounces-222730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPH7LUcVpmnlJgAAu9opvQ
	(envelope-from <stable+bounces-222730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:55:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE81E1E5FA8
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D18FE3377D00
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC7839099B;
	Mon,  2 Mar 2026 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="I676adsX"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1373909B4
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488324; cv=pass; b=nX0EgirCiDCoVk5lrBQkIErq1XOZooQxuMZLMc8Ez4ltlLBTCRIpk7BUZVlvXYRg+ZZS7cLKH3Y9tG2R/yFr5E/J3lC/zFfiMrdS13nySAwJWUUud7V7Uy5qekFJZsN+Wn40lAWLbZs4xLRvDNANSPCoeBGB44odaPJmokjRfhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488324; c=relaxed/simple;
	bh=/aYkXHoceuLTDq+XODuF84znWG3nLcw1zyBW9okAvv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=np81JehbjJWRmWCcEBqD7WyFkNoqS5qBqEwFquAJBNnVa+P7vzKwgBLu2wZVjD8HYd0AlYNa1l2BqFPQMLy9y6KI/2/o2Ow2sp4CpmmaigX+MO1o90EDzqxhH3ZIVCV3bBgtj3XFFGL7ojYHum4XYqWzukNEkFLTRSYgKmY6Bc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=I676adsX; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-505e2e4c35fso50139101cf.3
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 13:52:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772488321; cv=none;
        d=google.com; s=arc-20240605;
        b=UmfyB+RZa8NrNoI9rkD9m6iF1E5lhtBI4jgi+k0iRgMijbY7qcE7iqML9c9KXkZX4Q
         6j7zoew1w2O3rD+rP57d6T9oJmFhu4saffMAS5uUMXYTfUOF2KbJHWbAq7keRo3Aabwp
         inndisbW8584MtI2A7kGvRI0dgRBnseipVZgwpwm7cVLlflvY8TaB3i57C5KiPv8evvN
         F+sxGKZ9MlJP4+Gz7Z3EwPluSojRIURLT1z1b3deTEjgsTf9iA2/0kJv62hoVwuh7dP1
         6cbHYgtDKYvR91Y8r8dJF1jo4bnqqICR229BwnCdMD8zGLUCooKdpRt6yO/hg4Ma5Cjq
         y8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U83OTh/J04tIfV9u9cnR7j7lp/7sDg2CrZNqgyJVfj0=;
        fh=f4Ly09fpiM6X6lo3HVKAVM6Vnpo1E0p4wXdJpEabH5Y=;
        b=DVICAWd8uDUlQYqLqTvqhA3JoZ9nd/r8iDXgprn1WeRd1lbYpKdnKE5NR40r4DTeyN
         pprc9Ys5T5Cc6EVaHEw7xB/kg4XAlnIEDNRp+fTn9+kkYZmkp2UXVxmKE0VaL97Kd3MN
         2pS7OO/eA1EVensebi3Q+bR5C0zsCdWk2zUJBt/xuWcKrich6k1/uHDmuE0bzA84bosH
         9+mMlQBb/HTF5vPKdbg/YpYAjdIIxRH0iummM7IYqJUSEUWA6oItg+s5dA7tFTCQiFvg
         PdZUT9+Egkb+FTW2/uUJnxoiqjL+5E4K5pNCbz+Vd5n34ppZgp1HTBtRZ+FircDg0sdX
         Ol3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1772488321; x=1773093121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U83OTh/J04tIfV9u9cnR7j7lp/7sDg2CrZNqgyJVfj0=;
        b=I676adsXfh6a9toZXaYYs/WE6MIAQ59rHZIusy+hch2V7g6oCc9E6rBX1dCXvU9PNA
         exe6GznMXvpeHdW2q+p1rQHdDXGKMGG5m1hT/wtNRtlDHZXjQROExfwHA9G2EjsC1iKG
         UwMr8AgRRw84lUQEXFx9fGZlvFAfheI7HLRLlkG7LxkUB2F2xHJse3zk5uz/hvUCKjEn
         dFwcGGYcMK/3oygUUVH8+lqLcIMAKBHz8AHdsmDPvT8KKAofY/2meYqABOcyP/oxNvI9
         Mo1ZY8GKPMYE/mSP6IeIPU6OAUWjhT4y0ypf5YW+z5/NL66tGiFoTJflik7sBE8rDfbo
         ajOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772488321; x=1773093121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U83OTh/J04tIfV9u9cnR7j7lp/7sDg2CrZNqgyJVfj0=;
        b=Mp4J9hKj5eISFL0KGbh6oaZ6YW10j7JGDuQki85Jwhjk0Nymv+cDYsfG3ffx+L1lKW
         6T/0Zo7Cr4pmImGAJooXLHFm+uayZIBEYSQVqJAivju05osjzEMAXkupr1tCcQXEGiMe
         dve/rQhH/Kup43b8wOayGj7JYc8yQuAdc0p/q06qgXGLrtHAZxURVALji8B4iheH4rOz
         dqUApJ+FHAjOKEugQS/IqT2ul1EKFIO7GaG7zlv+lEl/sx7wrjwnvQh/bbgmz474cpvN
         TEI9weHxscz9tY7w251rmvJx7V/uSaNXIQQQC/5e5tp2554sm+LxjQc/asUVtvhUbUCg
         rkUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWY2kKXp30NgdMYkgQVbXLdDE1dVMt3uk/sAO3p7mvFhhHH/NQQQzXEOHCFt+2miS/+/2X+F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxERvK8OjgM3XaOJA1zmEZ1tfkrttmLao9xaUh7I2wWpUfOKc5J
	Eq3WpcPtK9jELvv2GJhsjxcoO/Pt9JjDqa/J9B+Xm1VEbdpWd5mfJpedmME1tEMnTWPgkfFKBzt
	GQ7jdgm2wH7RcYSTan27iJEvPYlQBcVT7IRzhUW5lwQ==
X-Gm-Gg: ATEYQzzTs0FyFXZanLlsgYHH4JrYVB6cQp35FVRT9BmHV6+pn9gxEYHxgei7nn/+rad
	YoxM5tPcx1tlPWBYvMpD40RrN1S4RrFS3yrmFpNxYXTkP9RkRJG+Idad6Aq8dT+kIkqZSDWSiGh
	YN4UslyDFC4chFiSbr1un5WdXySiaNecBR6vS+nT+VTCVfgqFUNX04V4X7buiWyTyAxd/3+yIWF
	5g+yim7Al1I1NrD0aJmRN206jRnHH31RoH4IZHW/9eIMysO8txD6XZ4DsrsSvTHfjOUCy/jLNJt
	fxVy4c2c
X-Received: by 2002:ac8:5ace:0:b0:507:3d3:6cd4 with SMTP id
 d75a77b69052e-50752875a35mr178404361cf.9.1772488321026; Mon, 02 Mar 2026
 13:52:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302160853.2519610-1-sashal@kernel.org>
In-Reply-To: <20260302160853.2519610-1-sashal@kernel.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Mon, 2 Mar 2026 16:51:49 -0500
X-Gm-Features: AaiRm53PQsuGgYFDRMTR6ykQJnakx9veYaASPh2vMJjn7YulyJx3HyltF6zDv8c
Message-ID: <CAOBMUvhHsynrdfoc0opNRvEUm2Ddd9jObqs+1DsticSf9EgU2Q@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/757] 6.18.16-rc2 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, patches@lists.linux.dev, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DE81E1E5FA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ciq.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222730-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ciq.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ciq.com:dkim,ciq.com:email]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 11:24=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
>
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 757 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Mar  4 04:08:47 PM UTC 2026.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git/patch/?id=3Dlinux-6.18.y&id2=3Dv6.18.15
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha
>

Builds successfully.  Boots and works on qemu and Dell XPS 15 9520 w/
Intel Core i7-12600H

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

