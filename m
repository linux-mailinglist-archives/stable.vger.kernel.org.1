Return-Path: <stable+bounces-155179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E098AE22C6
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 21:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4ED64A5B29
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 19:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C56223DC6;
	Fri, 20 Jun 2025 19:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkPCnNC6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4FB2222D8;
	Fri, 20 Jun 2025 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750447246; cv=none; b=KyjBfmdMFg61m0TJhXi7O+0aavj8SyimYA7fOjW7wkQsDy+zXKSPp8neyyGGUu0KSDpcSioq5a71EOY2s+/Nxk8VXTnPwgPZwNyz6pipbIaZDCApyxe9ru+C9eJ8sJKU4umvA5Pm+ewJRB9xSP2pBmne6HG6ElefHaW1pRBbCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750447246; c=relaxed/simple;
	bh=ilXnAqYMDwX2xluyBBX5nFo0usHqV7SIWUSbptLAfII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FCrJNL3Qd3VHtVSCa/ETlXJl1pk7jvIi4gIq38/G2eCFc6QCkcsrcnWMH6OWi4coKGK/N+uXvkAgdJWOhgcZ+/JkklNibs8zjgSEch1wLiAIOZ1Rq4W0PHZgUvZrpPmvEv6Ik0jngVAaFN6EqQr8BkP6JrC7N7pPmMk2tcznQAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkPCnNC6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45310223677so17720325e9.0;
        Fri, 20 Jun 2025 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750447243; x=1751052043; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4UADvpkf2IiBFZKK6AAi88bvFyLNL2fvrTWtjFa2BEw=;
        b=FkPCnNC6odppzbUrn2KgITRqgzkam2txuPQzfWoRl9/cJASwZUURguUg380ZbjpNvi
         me0eV4B9Ri1gOzacd0pgbVmasOA0V64lCJ761+eMZIv2iqDiCble4KsJktsg31Ba4w1g
         eXj5R9RQy+Y/kDl18HMCAxSl0qi+2AvnBvocbKIhUPwishhKqfUt++hu4XB5Fvmc5oGW
         WxGdh1bCh3xkygtekA8u/uJYMU+LQnqmGyYAdKBCedP/5CMWq5INKWShSV9pw2TBpAwO
         FxYjF5m3rfLndwORxEGsgO3mpM89HZkPw0k2pJ9+59weGapMj5gwepgp0/xSjguUT8Z6
         1XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750447243; x=1751052043;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4UADvpkf2IiBFZKK6AAi88bvFyLNL2fvrTWtjFa2BEw=;
        b=rFVa4tGRvmAMvqYm/H3uzO5J+kkIr+Xz6DU4guD2o3uFc26Fab28/fmyGf+eQODe7y
         AJyr1GAq73FGBaA5mRGh5vkyhmVApZAnIsWq68Yx7BVPpOsw+0ICz5rl9p2jqqf3t7Zs
         GPMTXa8rAMegTZI37Z39YOKIpxhXEH8C4GvAnbPGU2Xps3/wONMbfqedanGCmROniSfg
         o+r7gICSQN4NHFKlma2gIWAlcb/0l2rsO1Ea8fb0uDNrU36AX2BmYwYW0UZLcsNSkMdT
         8BHbFgGFO63QTCeo4ZLBZX2rLtGAjBrvUcU8niOyG44UZrpLJJhee8m2j/DgP9ZfSj3Q
         0weg==
X-Forwarded-Encrypted: i=1; AJvYcCWZddpk8+esOMc1HRxju44hpknhLox+1XqL+wVV6e8sf4HoDUYvmbSzAabVtboHG8apBYxOweY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+CN4DSy6jGqA0p9J36X2CT92qYs3y0jIPmotAMEw+cKP60Qn
	3i9MwVPXUjCpJE5pvU4untRdcsQTEF71cbKSHvljj09bO7ym7ETRbAyU
X-Gm-Gg: ASbGncsU/qyTvePQ0LeOGAFbUkNMjiFuYVaqo/tAh7BUWAeDsx6iSBzSN3yk8HebkYc
	tGH1ZoZptLew9sD0dPV3gbm3FK/yuq4/6ilvLAfIcgF5MwAeSCTZTdQxtRXMmUHPKruSSzNFrnP
	wf5rMzgIuJ7i/B/7/V5uTtfzVzQhob93SAM51eECEKfIL14Hxpi8q7pnPZeNYgMBuMtyfEDuwir
	9ZxP+BiHu4wijWTn/zF2mGzzWbdlgYScF8RmcOxOsLEVLIhqAK26atACUnbkKeJbo2wS7To6rDl
	sB77kv3ovoPzWPZ8K4CNYyQD7vysgDoEto+kautV4i3EPXpVypfm7bAyFXajGLqQdQZYBgi4Ssp
	fXJDGGzhIdwRNkXFj6wU=
X-Google-Smtp-Source: AGHT+IG8aOoZC8S1rb/ev7lP9inHcJLu9ktL7RT5BqPIoEbcvhdGm52Wha1xhaCLBRuUuM1GSAo0nQ==
X-Received: by 2002:a05:600c:3b2a:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-453659b68afmr35278195e9.6.1750447242856;
        Fri, 20 Jun 2025 12:20:42 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e98b4bbsm66613005e9.15.2025.06.20.12.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 12:20:42 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8766BBE2DE0; Fri, 20 Jun 2025 21:20:41 +0200 (CEST)
Date: Fri, 20 Jun 2025 21:20:41 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: regressions@lists.linux.dev, Jeremy Lincicome <w0jrl1@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, 1107979@bugs.debian.org,
	stable@vger.kernel.org
Subject: [regression v6.12.30..v6.12.32] mmc1: mmc_select_hs400 failed, error
 -110 / boot regression on Lenovo IdeaPad 1 15ADA7
Message-ID: <aFW0ia8Jj4PQtFkS@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

In Debian we got a regression report booting on a Lenovo IdeaPad 1
15ADA7 dropping finally into the initramfs shell after updating from
6.12.30 to 6.12.32 with messages before dropping into the intiramfs
shell:

mmc1: mmc_select_hs400 failed, error -110
mmc1: error -110 whilst initialising MMC card

The original report is at https://bugs.debian.org/1107979 and the
reporter tested as well kernel up to 6.15.3 which still fails to boot.

Another similar report landed with after the same version update as
https://bugs.debian.org/1107979 .

I only see three commits touching drivers/mmc between
6.12.30..6.12.32:

28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
67bb2175095e ("mmc: host: Wait for Vdd to settle on card power off")

I have found a potential similar issue reported in ArchLinux at
https://bbs.archlinux.org/viewtopic.php?id=306024

I have asked if we can get more information out of the boot, but maybe
this regression report already rings  bell for you?

#regzbot introduced v6.12.30..v6.12.32
#regzbot link: https://bugs.debian.org/1107979
#regzbot link: https://bbs.archlinux.org/viewtopic.php?id=306024

Regards,
Salvatore

