Return-Path: <stable+bounces-232749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGtGJVDuzGknYAYAu9opvQ
	(envelope-from <stable+bounces-232749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:07:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFE2378364
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92C57300D921
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 10:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8177928690;
	Wed,  1 Apr 2026 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkvFSCsD"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201429992B
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038028; cv=pass; b=gwGdDC1guiOg05tHeapiO8jqOq7cTbfJwBVxPhad9TluTuO98g67fMXBkgpV+f5g6Xagp8JMGKbD3wpd2tWL8iDHv8wovk37tqhR7pQ3mki3mOAoA69z6xESmTxfeu8TEhZR2u9KmsPr4gQy0FRiwfPHdMGzAz6UblA1S7sfsi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038028; c=relaxed/simple;
	bh=GuAGy0BwVa+KlDpElYaX1b2UqkrYg6svMWho463ATIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKxF8nRdiYY/1QfDMirU12r623vjToavY3yVvnCsjtiUrwsN6Dz6DNZ6MzS+L02zFAMljp6IBQ515vTCqretWRJFB9T1cfYbVmjxeD7DgQK074tJoAacu3rAHKVOY74aEBlFUbRzsXihJ+NghOWNA4Lu257xab/xLz3AGTOv6L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkvFSCsD; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c87871133dso1656861eec.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 03:07:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775038023; cv=none;
        d=google.com; s=arc-20240605;
        b=KCggNq4xgwGCyHz6toCzJA0o28Rhi9OxLXTbeu7DWdU0Ukeychcmo1ijKxgc0zNxFF
         YKHRggqQ7QP8fz3zNDbR/EwYaV8VNa1Y9slXK49DGCot9V3nausKYiDVTlyMJvj3jtpo
         hCAJwE2WNpVNqgw3fHzYyhrTS9Mwoqio9bGRE9f+wnXEPLEllVijXxBoW0Qg2pWly9N/
         PKtkkATupbnnDo7sAHc5MLniHvB+AivUrAIhyIgrhwa5eifkKBxNYiH9Z6mK5N/36znA
         hXugaVn15J4SicdMuKjrOX+9uc2fkIpi+SS7/NYnQUviXnhdV9gzaf5uIJ0LP29bbUU5
         nEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sgo3rYYgI3Q6g7deAMcHP7eT6JeZriCPTcT7GLi0w/Y=;
        fh=W6XF49moCwMQbnR0u0vRPkh9jiSeL4OHxKjTH/pKcI0=;
        b=MQQJeDdmjk53Qh8RQneQk+Vg5USgnAOoy6K/FX6hZ6MqoqWfYxd6IdFJbnw/LKLFU2
         TPQJsRj4JBF9+m0G89I39d3n5nHQcdCjv2/cP/cLn0ZWEQZRAUcS5R5JKIWbhoJu8iHw
         TmmEZEZ2Ntoc5EHGTM17SGzT34IAgodiV7IIQ2j7kmMZIV2AYk3Z3l2qROILxuBrArr8
         FTvvMR3lhC8Gnoi7X6lM52MEIUiM69azFGVpuQPUdoFVsaJjKYm472DMjCveDSed9wZU
         OmhyH3mF3kdZ+CYFsB1s/EmaSHllX6dZrMMw9DgB34jb0wMLLNCDKEs++F0fMpbnTOZy
         6O+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775038023; x=1775642823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sgo3rYYgI3Q6g7deAMcHP7eT6JeZriCPTcT7GLi0w/Y=;
        b=FkvFSCsDVLG/4KiDX2JcOIlm97nJtxRD2LPmociOXz/PqHkPr60xdyeKN0kC6hTRwN
         rYoeCkJcazRdF6bmalQKhKvznzhkSc/Ek2+ZiXTg8ciR4LT9pSCh4H+RV7kRRyzuWrHa
         zdWWCNAKz8en+VWn+LlsJ2CbjrYucA4Q0bqaO0AyfPdriWpiGYMZVVGOK5KqhoV0pQbS
         gxexKhayRsP717qgGUBmaePIRs+E2hbGZqs4/WzqQ+WLO0QAghyU5wv0wJpxlQRdRkFC
         4qbxmuUF8c6/Ni9w/jFG2LoZ6edjlsoNiboqdfqlReODxaYcplTNVUkUI65/ZuDvXdsX
         U78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775038023; x=1775642823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgo3rYYgI3Q6g7deAMcHP7eT6JeZriCPTcT7GLi0w/Y=;
        b=CgIj5buCsIqZJwNHPTVKjPLsxb1tmjPbGG0MKp09GntQWwdx2x0XgqD8d+w3Hrh40d
         U7e+E2YEZoT2lZCETviof7mzFFsSMmHeK0cIoq5147DvNCzCNy0ae+E6yvp9ua/IPXLa
         nzIpU5RYK9nphUyvjsn5B8uDGLXlRHRieKXqAV2IRXYHCz9g5Qf2B0FUIFWXz9ogGZmT
         rltwk69rNWQshasKBRoZTRnrOHFCuN3cP9NOrHRdDYG/FBgZ+X4GLUmD9nJFsB8iFhMu
         Q9kMgUOTrz1vGuZLIC/vSfIQQhQ4ZTJfxpurK82f0dhpVeGjasRjIgFh3jZSDG4ALHUz
         MPJg==
X-Forwarded-Encrypted: i=1; AJvYcCUIP8y7m7zPu8FVKVR+1jGMImDr3OHnjPOItVZ34SSt6kLUGT6Yk6GINKuF01kok6fApOWLWhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTgeWu9B3Rtfzu9an7JPa6mwXVWpk40ZIXMNoSPpE4aAiN6/KZ
	soxkJdlTgk6jGg4imj8fkT2HshbJjL79grLra7e2cxTgkpP/+KONQOwyX/3K23Yx7wxkYmbACWC
	ugIUdv/DRy53PRIjdqkpg/1T1H1m/K74=
X-Gm-Gg: ATEYQzzRbN4+/n4vBzfPu8az6poL5z/QBGyStEBJd1iVyYyE4DWMnenZZf6oVlzOcAy
	g4MTi3Fnxdct+YoUfX2WtvjEeF99C8QPL+xGCKHvXY9S0nha6FFppi5mPRLY3co0zH7OoDUI2pO
	tR7PPTLnh8rdFTLd3jo5RQLMv+0O77vPNDrWCGoj7+evm4S24IQEYLDB+eHNCVaTJz7R4GQtJCF
	Mjd01Wm66F77BI+jy9xLrTYrp86SkE5AATiRt0XsEr/FwJjml1xA9J0+OQRUMdXCn3neDb2GO9Y
	O3xrHevD6wdhMAgT5dg9a0ZoR31G8j7DfoX3CEdd2AiyABLPBsGNYrX6KTA/2vJVQNw4quIQSGe
	Y4zhEuPrRPQp/EDwoIpvjMg5laYO9coheFklQckogxlXxcIe9nrObIWAXs/Qii3N0Y0ZKmt4uqc
	RNMgRW/MEsLdetKxU/cTI=
X-Received: by 2002:a05:7301:4591:b0:2c8:8e74:4eca with SMTP id
 5a478bee46e88-2c9320c06d4mr1454568eec.19.1775038022452; Wed, 01 Apr 2026
 03:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331161758.909578033@linuxfoundation.org> <aa4dcd03-8c65-47c0-9c0d-9fc3d3b69a1b@drhqmail202.nvidia.com>
In-Reply-To: <aa4dcd03-8c65-47c0-9c0d-9fc3d3b69a1b@drhqmail202.nvidia.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 1 Apr 2026 12:06:49 +0200
X-Gm-Features: AQROBzBovxZAlwV3ssxnPNvdOJXfETlbAjvvU5Zlw19y2SgZgm7CgvUGd1JeuNU
Message-ID: <CADo9pHhKnfU2s8oPvM+odjxk5FK4YifBgLxPAjAekOQU9j4Avg@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
To: Jon Hunter <jonathanh@nvidia.com>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de, 
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com, linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232749-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[droidbittin@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,archlinux.org:url]
X-Rspamd-Queue-Id: CFFE2378364
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den ons 1 apr. 2026 kl 11:25 skrev Jon Hunter <jonathanh@nvidia.com>:
>
> On Tue, 31 Mar 2026 18:17:13 +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.19.11 release.
> > There are 342 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.11-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> All tests passing for Tegra ...
>
> Test results for stable-v6.19:
>     11 builds:  11 pass, 0 fail
>     28 boots:   28 pass, 0 fail
>     133 tests:  133 pass, 0 fail
>
> Linux version:  6.19.11-rc1-g411f8a553ae8
> Boards tested:  tegra124-jetson-tk1, tegra186-p2771-0000,
>                 tegra186-p3509-0000+p3636-0001, tegra194-p2972-0000,
>                 tegra194-p3509-0000+p3668-0000, tegra20-ventana,
>                 tegra210-p2371-2180, tegra210-p3450-0000,
>                 tegra234-p3737-0000+p3701-0000,
>                 tegra234-p3768-0000+p3767-0005, tegra30-cardhu-a04
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>
> Jon
>

