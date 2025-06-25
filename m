Return-Path: <stable+bounces-158479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5B8AE754F
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 05:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4EB15A433D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 03:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD01DE3A7;
	Wed, 25 Jun 2025 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8FGv1Eq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444B630748F;
	Wed, 25 Jun 2025 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750822811; cv=none; b=gjdpIbVAEWXZSBE/Ne5D68PnO7vimQIGj/6bQA94AfZ2iihQAThUWa+/CfhT2fQl8IgsWOqHCy0vSMc/eF09aBopuz2gG092kTI9pXb3tjOG/yDyF6z9tcquRRMgFBG2UWISL2PcX0C2UFHI4Y8J3tWZlAgVORvWbfTRFXNrwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750822811; c=relaxed/simple;
	bh=HTN4j6beo8XoNfCpziYtC8mCBfKnTgXon8D+1hjrVCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzZgslFEh0Xjt756PT/2mwVT6MOqOlmcGQq+PJhDmv/LRaxpP/6XUfHtgqwdf1l6Tl/zh+s2rx2LQ8tq6MoD+8nfOhjIr0JdDQzRt0/SkW69H+RgJ9LVIgjrtZrU2e1W4JG3KyIPzeTXZjcg3JwY/7Utc8d4Kt9roNQacqcLtw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8FGv1Eq; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so3019035e9.1;
        Tue, 24 Jun 2025 20:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750822807; x=1751427607; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8Kzx4KoqtuSZ/XdxUjKebeViIMJctJX7JPgnZgO9sg=;
        b=a8FGv1Eqjn1JMEyXHPu9LsDzM//zb76adGcTXU4hfGqJNMC+zxoSVt/iHA//mchwV6
         O+1usdi7qIvWDpyfInTHizLeKyBolX5j+K1CruKa+twQFJbDgFDCybTkbMqqv0jorMYs
         dRVOWTtQfgraHCMYlgeXDFclGc2tZXrfoA0UdKSkWYK5Fg7grkK3STkjYHhQN9h7LLna
         JcLRc+gZkq4JprA1YTFPUuOi86DqjAFnAVmAr8eIvTHOCOXrUWx8edQF6O0ipyaRliX5
         Uk+IYC8dox4gXDT/PsE12AGI+B08kX1Qt4wOck/4ftmiXS9TnkzhQcQqaazlF+srrKvq
         v1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750822807; x=1751427607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8Kzx4KoqtuSZ/XdxUjKebeViIMJctJX7JPgnZgO9sg=;
        b=aZrLOIiBDaOixHjo7ydg4HN9q58pItCD1G2xQQNKSPu3krDKYtO+lAlF2CSDLuze6Z
         t8ORcUJzqIuA0uMrrELO3M2T1/Ck/rEf+fOvnlWwDa56TxxbFhkTWAn8FTRrEUUC8jl+
         7d3Dlu1Ki/X+dXF+MJDxfdpVZThFsHi9EoR49RTL735Ovwh/lMUY3W50DF9ON0n3pnAn
         yW/qhsDGzwnzyWtUNxCsMUWBPwERSBl3EmcdPxanTPnBkBilPvYt5ZnA12K4G5C1FB6b
         hy1O08b/Qgmvvi0isXwjkHZyucxFwT6Y1nFskGT/WJLf32yzPGUw499DzBCWnqFuxrIs
         18TA==
X-Forwarded-Encrypted: i=1; AJvYcCWbTBueCLE6AN/98/9+4MSTMcxIuz98HcbzNSDZa/BvUNUS7yj3FKNPiwWQZqEFQFJcLJ2WSjjw@vger.kernel.org, AJvYcCXuMVZyzJ+5+o4THJ2dTkWetVPxccCb+1LW00EO+C2GeVreJO67ksv7QuiqFpeUs1/yePp7CDgw8zM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2qUHoWd+tplKBpOHdxwmAi4nbppk/d7tl4JLFln1N62+oO73P
	THoxQ/bn5cNi4hgkhTNpOJYVoZN6QqL8evG8lC1cRHS9r/PE6gVMVnbm
X-Gm-Gg: ASbGncuLyqq4lVaGnEofPV7voziKJG6UZeZ1gAPt0OtXeUKmpxo0dxS6mBLAsLP5h6T
	CRV/AnujbANVG8N6goWkhI9yGiWsUYBkiWcWHzpf3Ef0HKnteMwaTMq3geCOn87ZGxpI8W5U+r4
	8rfnFWPf/QI3DJx3keT7Ck31C21R5U1XIQYLHdslsERZBfRMfDRRDO9iGye//GPxTOBHVSqKOyd
	ZF6QhfF8cf+D7oJ8C88nNyV5wJ4ChFDRfCBTwCF1AsRF9cf+MzuGPY7lIY0K0WJTScNeO8OD2O6
	DSo2tVCVBsOfMy3eDw1W6brW3i+fcACrlBX4yIV8fbUl6wBoB9K5jgD5d5/1yWcDW9es//7s+vm
	tkh43A30g8JEtmzG4FuE=
X-Google-Smtp-Source: AGHT+IHa/xBtBOaEIq7LdYmOvKqiiJCY3VJZLSTUGHohTxGoXmGPfluK0CzBv8XNLk4u7cyPComKcg==
X-Received: by 2002:a05:600c:871b:b0:450:d79d:3b16 with SMTP id 5b1f17b1804b1-45381bc0fe6mr10739405e9.14.1750822807508;
        Tue, 24 Jun 2025 20:40:07 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823ad186sm6910025e9.21.2025.06.24.20.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 20:40:06 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 28EC5BE2DE0; Wed, 25 Jun 2025 05:40:06 +0200 (CEST)
Date: Wed, 25 Jun 2025 05:40:06 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, regressions@lists.linux.dev,
	Jeremy Lincicome <w0jrl1@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	1108065@bugs.debian.org, stable@vger.kernel.org, net147@gmail.com
Subject: Re: [regression v6.12.30..v6.12.32] mmc1: mmc_select_hs400 failed,
 error -110 / boot regression on Lenovo IdeaPad 1 15ADA7
Message-ID: <aFtvlqPxO6eZkhfF@eldamar.lan>
References: <aFW0ia8Jj4PQtFkS@eldamar.lan>
 <aFXCv50hth-mafOR@eldamar.lan>
 <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>
 <65400f7d-0bfc-4b0c-8edc-c00d3527c12b@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65400f7d-0bfc-4b0c-8edc-c00d3527c12b@intel.com>

Hi,

On Tue, Jun 24, 2025 at 11:26:41AM +0300, Adrian Hunter wrote:
> On 23/06/2025 12:13, Shawn Lin wrote:
> > + Jonathan Liu
> > 
> > 在 2025/06/21 星期六 4:21, Salvatore Bonaccorso 写道:
> >> On Fri, Jun 20, 2025 at 09:20:41PM +0200, Salvatore Bonaccorso wrote:
> >>> Hi
> >>>
> >>> In Debian we got a regression report booting on a Lenovo IdeaPad 1
> >>> 15ADA7 dropping finally into the initramfs shell after updating from
> >>> 6.12.30 to 6.12.32 with messages before dropping into the intiramfs
> >>> shell:
> >>>
> >>> mmc1: mmc_select_hs400 failed, error -110
> >>> mmc1: error -110 whilst initialising MMC card
> >>>
> >>> The original report is at https://bugs.debian.org/1107979 and the
> >>> reporter tested as well kernel up to 6.15.3 which still fails to boot.
> >>>
> >>> Another similar report landed with after the same version update as
> >>> https://bugs.debian.org/1107979 .
> >>>
> >>> I only see three commits touching drivers/mmc between
> >>> 6.12.30..6.12.32:
> >>>
> >>> 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
> >>> 38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
> >>> 67bb2175095e ("mmc: host: Wait for Vdd to settle on card power off")
> >>>
> >>> I have found a potential similar issue reported in ArchLinux at
> >>> https://bbs.archlinux.org/viewtopic.php?id=306024
> >>>
> >>> I have asked if we can get more information out of the boot, but maybe
> >>> this regression report already rings  bell for you?
> > 
> > Jonathan reported a similar failure regarding to hs400 on RK3399
> > platform.
> > https://lkml.org/lkml/2025/6/19/145
> > 
> > Maybe you could try to revert :
> > 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
> 
> Given the number of other reports, probably best to revert
> anyway.

FTR, Jeremy Lincicome confirmed that reverting the commit fixes the
issue for him as reported in Debian bug #1108065.

Regards,
Salvatore

