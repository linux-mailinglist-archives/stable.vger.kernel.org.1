Return-Path: <stable+bounces-39969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A4E8A5F11
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 02:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11E4282F90
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 00:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDBEA34;
	Tue, 16 Apr 2024 00:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="EAb0U5at";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="QBnT5S1B"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F84C42055
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 00:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225742; cv=none; b=Qot3mSDdz3MlC7N6YspBXpffEjJf13UrNTFcG2OnpiGO4zE7etlq03LRCJy28dKUVGw9/c4Z/Ln1fJV1LM5h0JTysQh/vtA46fex49zhj9aHXArPilfL9+WvgAnfm9jQMhbqFvcVXY1fT5zLg02TPCbJMY7IC3CzmonL/G46lQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225742; c=relaxed/simple;
	bh=XtnDUmWlLZeyFLQKEMz8f8iOD/ATpGxddGc899c5tu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/s8C0gua6/ea8jFMWFWtG65QOcDTsK+XojIkTDkg09knv5zmvOiP4Z34d7O5Bb7V7kkvShRhjIFeQ4zzIlvuLynWnF8dL6OaJwfg0AuhNQv1vkBqKIUKJ0gV+nS9IpKuSVAv4wdTKDy9T4ke8nXOoyqtqx0ndRP21pyaZXDWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=EAb0U5at; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=QBnT5S1B; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1713225734;
	bh=XtnDUmWlLZeyFLQKEMz8f8iOD/ATpGxddGc899c5tu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EAb0U5atUkGS/Mym2F2EyaL76HMOhBdTCLNM/ECN7JCAJZQ0cjFKfKI5zOFw/shKn
	 SIYOIpX8ojPD30DCzGl6HJHOGZOboM+7RegpRjbRORMkKV3rERoTD9JwKFA6IsrbCt
	 g4uCcgeZxOPnKqHZEFtEs8/rMKWU4DR/4pjzwN8s+5+cZxAK4O3NkYgFuf0ZgkUC4C
	 +gNi3xUFQWj/QVf28MB2hYxAcpyNzSLrrTySYcOLVQrxe8IAvlvrXW4WWEFxHEywnX
	 Ci1Nt5bGmi10XhYPMR5fEZd+cjcmy/QvenqLd6al0/VY+HHlbzRnHs9D4MM2MO+jcp
	 tUxAOA6JPzs9g==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id 712528AC
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 09:02:14 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=QBnT5S1B;
	dkim-atps=neutral
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 017C292B
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 09:02:14 +0900 (JST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ed596d8713so1711166b3a.1
        for <stable@vger.kernel.org>; Mon, 15 Apr 2024 17:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1713225733; x=1713830533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sD2kNrdb+f2UYdmWC5FsJv/hSCAYG/ofTx0/ZxLk+gg=;
        b=QBnT5S1B3RRW6US2cxGvWpK+YvD81W7+dU/7Nbv1INCJpr1snzm0r7xehxoJNqfuxa
         elWK9DBEkRNl9uxrWuPWok/bR2D+fbZTjPzkDShxyyHUc8djcgzhUP7FePdIFkn0oFPL
         m6rf1LloA6KaUMm+AKTghks16/PwhajDPXu6v+0K2TCo2ECSR3d9c2PwtC1Bidi7912A
         MIYzDt9yxfkwgKw4X9orgRuYvkOMyt+VRFLImAR5dem+rIyiZCZAJjhONgB6h29Zq1md
         AxBtjwt+l9ButsWlugg1CIvbI2Y8tXqMJfl8I4ZhX18ZORRmvF3nW1ihHvGg9iwujZS8
         5Syg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713225733; x=1713830533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sD2kNrdb+f2UYdmWC5FsJv/hSCAYG/ofTx0/ZxLk+gg=;
        b=Fe0VEVzOmKqjMngLetLdU3wPSfpFxOoRx5H2bP5ipWeYOftulWtf6N/fntqkDTacdG
         BlkmgMgmQbLmmOzGe0pyMRip49yIIvdcuPnFJtbW+ZW98wstAE94z/Z5sDkr7m6i6l2c
         TFWyRbXHQ5G+chXGDWfwi1uUzqlOAcnaCbWuhEEpwzEt1OD24yLUzO40uF1s5NlImbSB
         WvFcYo6lgsx4dSKdgDz3wku31bMYZcpHjYMBAZI9OJ0naMb/T+A0X7Fg9N1Oen9OQVwJ
         SX0yfHFfKfd8BNjDhO13JvqApQiRVmL3Haha6zDuT/lczSrAUuE4y8oC6HKXt2Nf5NGu
         u+Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVEomdimVh1X0OjREGC3RoNx6XmQL4GI8Q87Ho5AFieY1qKA7GZp4C0usgDnPXSSLYy/go7F3aYDUQTLIWwbhc0v/93o/iE
X-Gm-Message-State: AOJu0Yx4wN/s6YYRaeMVt7ZEGe9kBfXEDM+tPjqmgixWaXkRcKi7rFpE
	d/2TjZkbjUIETG7g4w1yZbVrmhbRf0W+7Vi76bN/4zUt9k6NlBSXqhFlt4OzpDi/imTfQVNY/zI
	a60FYY9kptGaHHlXrupyjBn6s80te8U3sh69ZWQKyiombp8sQoKUByxUDm7y02Os=
X-Received: by 2002:a05:6a20:918e:b0:1a7:73bc:1a66 with SMTP id v14-20020a056a20918e00b001a773bc1a66mr11218105pzd.17.1713225732955;
        Mon, 15 Apr 2024 17:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx5fio1gv2nMzbq6rjDVEsTE8SNJcWLizpd49RpWDHcOeiqBOGwZd0cMyX2mWWdhX4VM++kA==
X-Received: by 2002:a05:6a20:918e:b0:1a7:73bc:1a66 with SMTP id v14-20020a056a20918e00b001a773bc1a66mr11218071pzd.17.1713225732485;
        Mon, 15 Apr 2024 17:02:12 -0700 (PDT)
Received: from pc-0182.atmarktech (178.101.200.35.bc.googleusercontent.com. [35.200.101.178])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7750584pfm.25.2024.04.15.17.02.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2024 17:02:12 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1rwWH4-00Dzdd-20;
	Tue, 16 Apr 2024 09:02:10 +0900
Date: Tue, 16 Apr 2024 09:02:00 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: gregkh@linuxfoundation.org
Cc: mizo@atmark-techno.com, stable@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: Patch "mailbox: imx: fix suspend failue" has been added to the
 5.10-stable tree
Message-ID: <Zh2_-LHx8oH9fdOS@atmark-techno.com>
References: <20240412052133.1805029-1-mizo@atmark-techno.com>
 <2024041520-wasp-suave-8d3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024041520-wasp-suave-8d3e@gregkh>

Hi Greg,

gregkh@linuxfoundation.org wrote on Mon, Apr 15, 2024 at 01:18:20PM +0200:
>     mailbox: imx: fix suspend failue
> 
> to the 5.10-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mailbox-imx-fix-suspend-failue.patch
> and it can be found in the queue-5.10 subdirectory.

This only fixes typos in the commit message, but Mizobuchi sent a v2 here:
https://lore.kernel.org/all/20240412055648.1807780-1-mizo@atmark-techno.com/T/#u

(unfortunately you weren't in cc of the patch mail either, sorry... He
can resend if that helps with the process)

Peng Fan also gave his reviewed-by in the v2 thread, it's always
appreciable to get an ack from someone closer to the authors.


Since the code itself is identical, I'll leave the decision to update or
not up to you; I just can't unsee the "failue" in the summary :)

Thanks!
-- 
Dominique



