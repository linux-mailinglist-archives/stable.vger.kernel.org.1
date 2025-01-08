Return-Path: <stable+bounces-107948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6068EA051C8
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8732D3A429F
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 03:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830062E40E;
	Wed,  8 Jan 2025 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DtHaxlk5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8B19F422
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736308556; cv=none; b=gz7I5M3rGv5oXpSLPSwYgVE6tMsWVDTEOniJCgQj6P03rzeT3JyfPhz3I3e5Gra1Kx+83MM3tREroxp/B82olnGgHG+0WZZWAxMsaFBNj3q+uZmQiGXhpO0tiBA4jvKkxHzFtINhP9eiEhMZnbHR8gRmOPKbUOJB4ZrUuHyEhRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736308556; c=relaxed/simple;
	bh=fJwTItY3WpyPUBts3I2F/xVrqfS1kWCnR52HMF5jmww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DG7YtxnpCJ/VLJxv9E+el7lpca6uHsOUMV+mSpbVuLz4nXnh+f7lheScLdmDR7psgg64fIHsxJSG7pD58kDVaVlk6KT/6SiX0TeIGKeLu6kb3iw6SHzM/96aB2LEgXwnDws9WY7JLCAxb4w6D5MAxt4xPTGKYmJKH9PV5lD0ylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DtHaxlk5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so18388417a91.3
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 19:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736308554; x=1736913354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JW7pnso5ES5YRv5DQa6Smxjc/jdlHEm/DPvIpOfBQE=;
        b=DtHaxlk5MwNmTFQKHCJFrhv4KtbQ+6xPeG2olkF1ad4Jpno8xM2/sV6ZwOVAt7STf/
         2gVkIvhxhpaL07rMDxZmQ3UqGImtk8xzng/NYFfpO5uOjIg9nlayfiaiv0NrdzWM6GBR
         ZGLpCnxs5TM5cCNm3zazLVhouVh7itMdVMq2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736308554; x=1736913354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JW7pnso5ES5YRv5DQa6Smxjc/jdlHEm/DPvIpOfBQE=;
        b=h/A/aRrP9UqEqWrZuSmRcVysa2IWqr7KFaNTb2EQIg5Un9+R4vSKQmkBxk/+aBxcAI
         MtqyQSaPBjdR432zBwFX3RZST1yp/Pq0snHzNT9o1a+8zDmq+lV2lw2Zs80cXRArbqtN
         Lxw5tVqEKLJQ0+S4ymnVqTU3rmK7Qv972kNGLAcu+BTq1+7ty1AEpGl//wY0p/Zso94/
         wAv/vLnPMYiKbCp0CD72VL/7KBolZVidzdsUTIlx7n/xmFtUzrW30Gbnfcm6PGUVgPta
         yDFFezBynX5i8dhum8HSa8UrQLC6pj5IYU/UuOVpqogNn+BxwjkHrB76jijUBgz7WW8G
         3i1g==
X-Gm-Message-State: AOJu0YzTeBUE179WLX/cB0THgH0huFQpiPtP+T/vlLvFqXtMoAwP07t1
	H3txTDDr9PVoKMItdURPH580HrJmMl2y/7lDDSV90FxNjV7iLVzsAvGS08Gvfg==
X-Gm-Gg: ASbGncu0G78Tp1VPyFP7Jbw5VsiVtKNjYLdcHpOFx552ZymvVVmUgCoChb8EL9KAgFi
	/G8CpRjEek4bQTXLJqdTDfY8FM+PP6zQRLs8w+oXUTCURQPAR86nmX2TPIITge0n41G8Opgfb3D
	FJAP6oUpH1bbcwj1eEAlhNFJB0UfQ462dkTk1JSrdwI8eWDgwetlpEUq1s/IIEox/3KRluzdhS+
	nFOMeOUfO2c8oM8kxtyA2zDgmUEicPYLXWviOs+4LgNRiLzfdQGUVrkJVdg
X-Google-Smtp-Source: AGHT+IGjt0PFakgymYUjJ6WbxlzWJ44dvPtTxDS6yMEemLX4k7Ge3UEc89MnlOVg7obSIp5svSSZHw==
X-Received: by 2002:a17:90b:534c:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-2f548da3a1fmr2395745a91.0.1736308554228;
        Tue, 07 Jan 2025 19:55:54 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:57ef:1197:3074:36c2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a34d87esm385723a91.40.2025.01.07.19.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:55:53 -0800 (PST)
Date: Wed, 8 Jan 2025 12:55:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Kairui Song <kasong@tencent.com>, Desheng Wu <deshengwu@tencent.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 098/138] zram: fix uninitialized ZRAM not releasing
 backing device
Message-ID: <ntg2w33w7lwfpx6ichogmvaxnr3h33p53zy2gfnqdxbmpp6qyp@2cu2hxibuudo>
References: <20250106151133.209718681@linuxfoundation.org>
 <20250106151136.941319893@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106151136.941319893@linuxfoundation.org>

On (25/01/06 16:17), Greg Kroah-Hartman wrote:
> 5.10-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Kairui Song <kasong@tencent.com>
> 
> [ Upstream commit 74363ec674cb172d8856de25776c8f3103f05e2f ]
> 
> Setting backing device is done before ZRAM initialization.  If we set the
> backing device, then remove the ZRAM module without initializing the
> device, the backing device reference will be leaked and the device will be
> hold forever.
> 
> Fix this by always reset the ZRAM fully on rmmod or reset store.
> 
> Link: https://lkml.kernel.org/r/20241209165717.94215-3-ryncsn@gmail.com
> Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reported-by: Desheng Wu <deshengwu@tencent.com>
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Can we please drop this patch?

