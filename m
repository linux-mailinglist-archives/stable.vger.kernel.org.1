Return-Path: <stable+bounces-152488-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DD0AD633C
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 00:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9961BC4EC9
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 22:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4AB2E0B5F;
	Wed, 11 Jun 2025 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ji1VIkVs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675F2DECB1
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682067; cv=none; b=nvOsHTQIT4IcfdvFsa0jdloHeYAY+1OUG1mOYiv7dO482LryKH4NK1DzSUfWF6x5hdtQ2wjUTZYIPKCSEh1kAiFd7+nKJYp7XcezJizYZ458diEnLuN+J7eJZoHVfTqkV1b+ncMMUOLf826ZbBb7j3mo+zKFlMjqdj5Nv5V1LCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682067; c=relaxed/simple;
	bh=i3uXg88GrmDL02Ipc0Qdy2wwCTXE7sOzhUrq+EghysA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM0gSJamw64cqo9ztPz2OR7PPYpGfPC9nrqE3nKuOpCI+rvG9pZn9wCKsAG4MulRl7rTnZw0LI9iILfQl4de/4QlI/1r8CaG/ziVolXE5+JUgzLhL4m11rFVRd8E9/7xugkEZKweXFiKb/ljonsggCnU/t0hNi30+NIUgXDEJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ji1VIkVs; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2f645eba5dso1141211a12.1
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 15:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749682064; x=1750286864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vtvuCkqBFYEZRyjG1H+yUqFCaACnLIwx9nH+82roXwU=;
        b=Ji1VIkVsSKn91hMtWjBeRs69fVlC/81M9b0VkJt2obusM2t5WlIhJwST8Fxp9qFiM1
         S51OhNCdia0Lep6POMXp5ozFYUqs6H4EBdax4VjslLbeX4mZzRVq2fcRW+JItQEbCaNN
         MEJ1uPLoiJHHXomsP9hUaa2Nq5ki3iwwmWuzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682064; x=1750286864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtvuCkqBFYEZRyjG1H+yUqFCaACnLIwx9nH+82roXwU=;
        b=BSklh6bl4OJ1RLmcjoxTyC8QaGrSsSTwXvBt/2Ey5pdHVu0ZvEdDi2etc6j4N4jZ5A
         d8r/WxAJwDyPjDKoWRBtEPx0mPFwWMisSIPrRtBW0lwqaC2QIoYINl1LYsviJSGw2RF2
         SG7t636bQiHfbwEMmcZSFI6gjIJe3G2FOZvuk0K7/wVNY4Q/e98BjAjbOPRdS7gF1Gyg
         9as7qRvpl8wO1TfSRvexNBkIs346NcYSlj6hyd4bGORAcdlqhNcxDhcavV7GC59WJMNQ
         e8T6LrY8HXjdPoSfEFS2f8uOHWHL60o5Btsub45J+A7WmKu0ZyG4M5gKxAZM+MYBSH0G
         QNdg==
X-Forwarded-Encrypted: i=1; AJvYcCXfhtmeWgTbEdGV8BeAP9/KXlZe3w5K0W9M4EXWBS+onusgboSM8Jes9MrF5GnV1/HNWj0Wibg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOlCxRDLkVmPuj1Pk9ux9wqjz9bwp+uTLa1tlTWP8SKkv3fmeA
	veX47QYGD+h6LoKXwVgYW1dnHt4C/MkfXVxXrCI4OjsyU9F58xl4bvimSabXjqRtY8pmU9hNFfi
	vx7A=
X-Gm-Gg: ASbGnctocLoAtRY7u8DM3A+RpLxxw07Zqh/Z0SaQtKqWpv5Z8QfUPyJhqOEP4c4TDtf
	R78wcojGQZCNEbHSMAbQ1ILeCFb8cD5mkxGXLr30qXGHM0yx+1I3URuLjxYuN44U7byps+kNsGZ
	YZv51pxlO4e2zNs09apXcQQEXyEfmCCaS0wQmAcahr8PEgrioOWMsTmGaQ1MxgwXkzgx6Z+fAyk
	CjVTCm5JC2qyHdfsQzr4KpmETp0irtwmKhE3y4D9CLNLQh2I53YoAhmEy1cgKEJaSR9ZrBTCjhb
	Oa4igPlwCDNpGOAmCS8VtakzL1urW7w4u0CKp4g8IMRyRVAle/hFUD7FebfaY+j2A3CEyshmjZd
	1HbSNcel1wzor2fiqUzJjgcI0
X-Google-Smtp-Source: AGHT+IFHrwkXqx2Z3BILANYYSOX7LZROue9EeXw+W5JfDdbWlJ4+YUXrdt9TxJMVZXgYYIXDGyUMfA==
X-Received: by 2002:a17:90a:d406:b0:2fa:1e56:5d82 with SMTP id 98e67ed59e1d1-313bfdcc12emr1461708a91.17.1749682064115;
        Wed, 11 Jun 2025 15:47:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e790:5956:5b47:d0a7])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-313c1bca4c7sm113244a91.3.2025.06.11.15.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 15:47:43 -0700 (PDT)
Date: Wed, 11 Jun 2025 15:47:42 -0700
From: Brian Norris <briannorris@chromium.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jeff Chen <jeff.chen_1@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH wireless v2] Revert "wifi: mwifiex: Fix HT40 bandwidth
 issue."
Message-ID: <aEoHjudwZKs4YMls@google.com>
References: <20250605130302.55555-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605130302.55555-1-francesco@dolcini.it>

On Thu, Jun 05, 2025 at 03:03:02PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This reverts commit 4fcfcbe457349267fe048524078e8970807c1a5b.
> 
> That commit introduces a regression, when HT40 mode is enabled,
> received packets are lost, this was experience with W8997 with both
> SDIO-UART and SDIO-SDIO variants. From an initial investigation the
> issue solves on its own after some time, but it's not clear what is
> the reason. Given that this was just a performance optimization, let's
> revert it till we have a better understanding of the issue and a proper
> fix.
> 
> Cc: Jeff Chen <jeff.chen_1@nxp.com>
> Cc: stable@vger.kernel.org
> Fixes: 4fcfcbe45734 ("wifi: mwifiex: Fix HT40 bandwidth issue.")
> Closes: https://lore.kernel.org/all/20250603203337.GA109929@francesco-nb/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Johannes seems to have applied this already, but FWIW:

Acked-by: Brian Norris <briannorris@chromium.org>

