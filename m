Return-Path: <stable+bounces-110204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E9A196A9
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 17:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7FF188D9C9
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6C2214A72;
	Wed, 22 Jan 2025 16:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6l1Rs/p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D1149E17;
	Wed, 22 Jan 2025 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563978; cv=none; b=NiuJUa3RuPFJpGMek8RyqwVppGRGNKTHV0i8Tcau7dghzKy9jWNnYZYVaAZjC1sJrXXXJi0Jo+pWCPyd1navIKqVsDs2gGzox5Rq0Y/8NZZXj+F0tQRPx2aSDqZs3Hwv+QiWX75nIFaZKROzXTW9VIaU6dlucwBWvc1ig/harQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563978; c=relaxed/simple;
	bh=rLCNKq0QvcqyKFhPixmoBnEghCd7lN8c9bmfihdQyC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDHiqE8wkSuE3f1YxgOlvJtKGCSowKgx0UkIcqQMfG0zSwgjBEdB+WzaiThXbt/pNYIm39TxPub5OXjlzB4ElX56ZqygdzbBvZir2UdTI4MOEiFb2V5Km25oQQuNIQELOnrEv4pchFhukXtVo/nGRDJ5xJczRHtm4UM3z9ll/Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6l1Rs/p; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2167141dfa1so22242415ad.1;
        Wed, 22 Jan 2025 08:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737563976; x=1738168776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rLCNKq0QvcqyKFhPixmoBnEghCd7lN8c9bmfihdQyC0=;
        b=B6l1Rs/pMyaXO6N5RxcG5iinnWbi5OikrgDVjQ3oUyI7dIGaEM/22QJiOGWLQhB3Se
         s0v2Pvi/8Gi2t8Qs/+MU0kuSmB2Y5hbZsusk1+xDNUyTjgMk4u2IiNlNP1Jr78nMMsUO
         3wabgNECNqzRte8OR36GqQf0NqRBnUNFjFV0C5MiPkG4+PRrZs/p/k2OMKLO2N04KvJ1
         9UKtRUky86YuzSfNjvjRzV/j0Jr2wVLjxGa2HH6FSS5o5IT3ij4j76CyowdF39UeujD3
         yAmUih67IB6uex+c0GzpS+TBtBmpwvF1u6qEK8sTgM0s8PJD0tAc2Hjl2k4afeQOjYEN
         QsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737563976; x=1738168776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rLCNKq0QvcqyKFhPixmoBnEghCd7lN8c9bmfihdQyC0=;
        b=AhKz6ypYpJIwDSNxkCCeSI+MDbxO62YZ8vZjUilu6VgZZy3CHryFw08aEidZ4P87vC
         xzCoROK1QdKXh4QSKLx9Oww9ySpfCj9QfHeUJVabuhyT3dh3PNuFpp+bxNwgCxxj0y8F
         +GKpub78ImfnAQ4BH6Es4X1TTGTd7ekZgtk53y+ZnDUfQ9vi48wv0b7ML/cNv9wqAIcc
         NVzqE3Stg+jbVoSfaEhbpfWNeH97Dzx2mm89DdDtbjMyJS8p4ye0Wa/rOa2Z/y+JORz9
         UjqTS11G0ZwdQLpORRBzxz/b8tIspIuF1IQGWk/3DJdOO7gbkyFMPsFyGkvHaYlR/VIh
         Q0rA==
X-Forwarded-Encrypted: i=1; AJvYcCULB6dech5lgo2BxbdeLW55Q9q6hPi8zWFjE7YZoFONBUTz5Ea/5vL0sjRUy8ms23eeD+yrJQBy@vger.kernel.org, AJvYcCXaVN6BGq6YUtuSdqJGI7Cjec7pE6dr1cOqTSaU4dLLC0Z8dNzPgyRxgbHfdTzEAYnF+dzZS8AV@vger.kernel.org, AJvYcCXueOCgpEEV940wbE9hrZhl3A8aYXeOzWpDM7mPmj5JwUJBxHBu2psS05O+dtAWyVUixGbEZbXlmRthfIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YykfY7aLWxOKzwAp4zHkNB2drmIsIv3Vk+CQeO5wrgcCQp5T5Sk
	iWDNcIGY5VnmrxNU5GVOhvtDk9PxuZihvN7w5+q0CnyvNHeInh8g
X-Gm-Gg: ASbGncssbzIxCcSeiTGTKDW1QZvKwTi25l9JqvcpZpD6/Yrzg5Q2K7Ok0QdgtvMeHzD
	9HH3xrb2Wg4aCyebFfS5z42to31oGBWG1DQZjBZ0IFAvabhy6E6+y8kZQnWNjk8ezXmilVjEgiI
	dkUhRHd4jspbzaKri/OFW8hXjWrFuFlyTVrTLtzlOvMqrFqUtv28ci/kbCF41Jnm8l6ASvytXU0
	6mF0XpZssR+ffmq7J1V6hBWq2bw0ldFAz7RIqUumkSwfK5T8fZ6+mjjqfYSyH+OJdnXlIiLSeeB
	yypFKksWlH8tKw==
X-Google-Smtp-Source: AGHT+IEWqZLFeawu/BLvp4QENLyalQedIGu5WNcgaP3vQ6agzb5JSRr1kEqaW59EjYzpOS7MIxrg2w==
X-Received: by 2002:a17:902:fc87:b0:216:271d:e06c with SMTP id d9443c01a7336-21c35c5302fmr294471205ad.4.1737563976210;
        Wed, 22 Jan 2025 08:39:36 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea0779sm97984035ad.14.2025.01.22.08.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 08:39:35 -0800 (PST)
Date: Wed, 22 Jan 2025 08:39:33 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <johnstul@us.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Cyrill Gorcunov <gorcunov@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] posix-clock: Explicitly handle compat ioctls
Message-ID: <Z5EfRcA5BCsPiMcy@hoboy.vegasvil.org>
References: <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>

On Tue, Jan 21, 2025 at 11:41:24PM +0100, Thomas Weißschuh wrote:
> Pointer arguments passed to ioctls need to pass through compat_ptr() to
> work correctly on s390; as explained in Documentation/driver-api/ioctl.rst.

PTP_ENABLE_PPS is either on of off, and the code tests whether the
passed argument is zero or not.

So does this compat code actually fix an issue for s390?

Thanks,
Richard

