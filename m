Return-Path: <stable+bounces-202718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCA1CC47C3
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E370D300CB99
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A61320A1F;
	Tue, 16 Dec 2025 16:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="BhJHwkLH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210A5254849
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765903935; cv=none; b=elsekq5zQ5BmyhzUw+owRugYB84ZUyNSV/T1+uiQKGpxchIDw7QdLwJ6cf6oXJUgFIx+8p7L3dOP6FSsZGb1lau5JQmBt1xsw9CvAOCT5HCOjP/TXiYFwS3TVMmm6N9hmSyONae7Ddnh64po9COOrdbAfSFabsVCKwoKpH7IXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765903935; c=relaxed/simple;
	bh=FwjdDS1Sox44VxEqtfgWxa7v8a0DK1bpiJ12VqO95CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh7uqIcdSugSUW8tvDTsXp5ZH+97AqAooiKWdXyYSIDtzDBcWA4Nn2YwAf3QEBTtN4yzuLdDg0sbcUIMmsxBv8XMIsZZSzHJC31IvxTZRvTb+kCkLW5ZNTL8M0DhEja03aIbM3h+q51OeBI4088iJJyVhjpNGZ3/sUtYbm/+ef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=BhJHwkLH; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f2676bb21so53230955ad.0
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 08:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1765903931; x=1766508731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=044jJ5OZga77MHiu5HO2sauTgRDM/5MaBSigPsMPKDw=;
        b=BhJHwkLHOhlFS6Dx98J1u43Lzd/re3cOlPZjziy0FzyR4uvnUt1YKI6NtmGLXcQMoQ
         d4eljM4iYMVBHlk8BsoOtO3uDTIyQQ7aByRctEDVvPULdYHSQ7EODXrTIRnbeMIIiM3P
         qpRqyyBkqUmwCyq7bxpPuNBBivMKPV5Zv199klsKNGFpyREFxt/7h3rJcYXI6BycHrTq
         IskzEDNXPKSE6Bunxxf2hguGU+yXaGUD8A52b0DJXYApAvy6u0ok9HrB4iDIQ0Fy7nVm
         +KGhaTcnabxQnjblYc7TRLeI4PYcfJT7hT4fQhyp074sFxbSvDahkP6UfxBX8AaeHjZy
         XuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765903931; x=1766508731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=044jJ5OZga77MHiu5HO2sauTgRDM/5MaBSigPsMPKDw=;
        b=nUBO5mYMz1RdPRIlTdxfjs9zyx79mLG6MZiJJAbA+6hfRduQYtEhtV+SudEIAxy4Rz
         8mZiq2QPTgM+3ammr3nmhwiaqr2iQCwEFRDxVPdEYOlSkHcOP6yxPSId+7jbN7xK8JJp
         5Ek5BLFxHx/0tvs6gJuG7wvgHTTiZnby76nnrNOYtca1mCWhzGAvq4fkfkg71fBl7o86
         X7C/TPV1px0KvW7FZP/5DJ8kApuGHBui7MhWFBU/2QAdkw0VJIq8nxWJ8eMgo24+lC8l
         aLlvaKDlg2T/gbqtC23eusedNV5ZKq3eRIw3LdugOpZx5MHRVVDv5HaWbkoPJVna2mqZ
         lM+Q==
X-Gm-Message-State: AOJu0YwSj48Aa4rjFb7irHBu7pUqBBlWvG7q7Ivi4d+eztYgg2+bp5eI
	LNFyGnofEnmrXyEoMAgakQl9IYq1e7hR4+dExXwYZXGjc509o+7GdZM1+T8e+0YEVA==
X-Gm-Gg: AY/fxX6q0+IVYnXoNjRt4LKtMNLrn7Sugwr12zDBxkzkxqmyniSS+c0kQQKM6+4DQg+
	LuaZZl8T7vvQDbOxTsyy1Orp9m0r5APpYq+xTQtY5JhsL0T/NIUklnkeOm4e14yKvhfCfbd46JP
	EVPGDs0Z4GIfvi1AM+Hocwm9+8Dsh4xDJxHc6NsziJWGTW8/v6bs5PlgYLFEM/8PgDa5vFd+Zhb
	9krlFSeggJnbOZmXAG62ktrScHCzDdU+54gd+PYhRfn5D4Gl+lh/pfAQ7+nYchyAGLCsRTHHrdF
	DHZgogwW1AtcqAEPQrZGwlIQ0Cf6qPF82ohHva32Np4Dix+/2y7I+Pvv5A7jPp2kNUBhRefSlr8
	+ME7nQBul20bmPGnHlbag9M3PIKf9wkRULZ5Kv+Y6GtXner43dBp0zIChBlISfHw7M9HYzEYojg
	ze8n3FGPiym0FbAcIAm1trOHaqk4StwEqN
X-Google-Smtp-Source: AGHT+IEpWCbeLGHpAd3C/0Y1ZbY5B1k0NJpI5pCZS9qiA4FHSv0ZUXZnpihKTE1T/asTYZyHKQFkMQ==
X-Received: by 2002:a05:701a:ca88:b0:119:e569:f620 with SMTP id a92af1059eb24-11f34bfac4cmr12209335c88.25.1765903930546;
        Tue, 16 Dec 2025 08:52:10 -0800 (PST)
Received: from gmail.com (ip72-200-102-19.tc.ph.cox.net. [72.200.102.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f392500cdsm37342761c88.7.2025.12.16.08.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 08:52:10 -0800 (PST)
Date: Tue, 16 Dec 2025 09:52:08 -0700
From: Will Rosenberg <whrosenb@asu.edu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Oliver Rosenberg <olrose55@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.18 447/614] kernfs: fix memory leak of kernfs_iattrs in
 __kernfs_new_node
Message-ID: <aUGOOLGP84wGy6cM@gmail.com>
References: <20251216111401.280873349@linuxfoundation.org>
 <20251216111417.567991274@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216111417.567991274@linuxfoundation.org>

On Tue, Dec 16, 2025 at 12:13:34PM +0100, Greg Kroah-Hartman wrote:
> 6.18-stable review patch.  If anyone has any objections, please let me know.

Please see https://lkml.org/lkml/2025/12/16/1248.

