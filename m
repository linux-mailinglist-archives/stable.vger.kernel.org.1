Return-Path: <stable+bounces-107947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D209EA051C4
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EA0188A36F
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 03:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C724719CC29;
	Wed,  8 Jan 2025 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aeLjOSGz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07A62E40E
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 03:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736308523; cv=none; b=CUk7qWRZYJw+/exE9oV4eTExJnzt/AbQyS0izVBMG9bHI+2qhK/RjAx94v1EMInjeUi2EFjKWroF+uMvB7HdWkGcFJsh9S/O6jZv20NNh52gWFG6uT0/EVwwCU2Raz1vwnzVvVToCoVYsJES/4Maa7AU3FBNKEf/nowOXdsmTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736308523; c=relaxed/simple;
	bh=WbigYg2yRO9VEDVswT9mVrFLFN5+TBloFGL4MITKvME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2M9kC2Lj0pxfXA/wK1aXj3yydXmGLMrqPU3R3mnoXi6eeqHCobKpNbfTtyBubNXIZvck/x/ZWrcAr/hZ6KPzr5BRGLBG9lGbs5R+hOnLC9Ek5TLO8745XPi23Kj+3MTUWtE8w1c+SUTClDRIOQGPWOnOtF58JGunyDdwH6WyZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aeLjOSGz; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216426b0865so235185025ad.0
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 19:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736308519; x=1736913319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7DwaRLPyXsOMv+w2WyaZoe6DE3g7vdBorhsTXgD8ngc=;
        b=aeLjOSGzmyG4BDStmpa2ZAGQeb8z9gzoDdaQ6PaNzSVMrpkbgkRgZiHUUmH15HxA7Z
         cT2sFKJ8AxcuDpBR/au6wOZg/mZUNDlLQ9YPBZZ82wY+XtXK/p4S/wyf0OkJo4epEclt
         hw+XXuIWnFmFR1TJ1HNboWIa/5Y86oMMbPqSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736308519; x=1736913319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DwaRLPyXsOMv+w2WyaZoe6DE3g7vdBorhsTXgD8ngc=;
        b=m3wX5jR6cZDLyZ1vADaOgGxfJ5H3UgG6sJIgE6DEwaSzvMOS/uo8HHXb8+5qXFXWA2
         Os3db2sG9nJIdvD3/08BJTJqjLwKW0kKi/kmbXopVKLdgItAhDMVVlOPWlS5s61eAFEi
         Wpvn0q2IpNCP254EsGsKIFuPembjPhO2dthGolE09hj3+ReQcnhyYmrgaBahKshuzkSr
         kKtIDTJCS4PcArMUh9UcbO9MAOyyIgR9btiirJt1QBfeFtWUpfUvVbNZACbj8AErsyIA
         /Dfei7MgcmcGdq0/qUUVTYUD4d9+ubL16bxHNSvnVl1jvyNzJMUkH474mgXCr4YA94+x
         cKlg==
X-Gm-Message-State: AOJu0YzdZbCPgIRNnZJwzz918Leg9YO5jTJ5N/lpchL0l1+J5J9GBnvt
	hSjSh6bYJHwbJSMMd9hYaHqlxvUsvsd2MDyghlL3z4bPR/uYRBC9U579M9dIig==
X-Gm-Gg: ASbGncvs3PScop5pqy45M9sCi6H5YBuIOwGvBZCU4MoD7JQW2g+ta1LD++/GeIU3U5M
	zaA3moKk/pWDKZ2ofn2WMjmaGPe5W/+MOD2rtc62mR1ALw/acoX3OQbo5ITURpT0PIW/Rd9Oh8z
	3FFHQGB5L3EDwukb2iy8SW3ltG6it1w3bIVJnhiwrSVTCJuZRLqWbZ/OoTM2Tv6aQFppdOV9iuA
	vIAy5zOS1BfvyZM47UdKYf6G9gsVbzm0jyhSn0kIsSXzXNFfbFpUO7TwaUi
X-Google-Smtp-Source: AGHT+IFOz4JPKSFmipqLW9ldyTAiNTpwDBn4CRJ5SVdFvgn7/SfE6w0SwP+fvIzQWn6ENlpxxn7nHQ==
X-Received: by 2002:a05:6a20:6a22:b0:1e0:cabf:4d99 with SMTP id adf61e73a8af0-1e88cfa6b76mr3129374637.14.1736308519246;
        Tue, 07 Jan 2025 19:55:19 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:57ef:1197:3074:36c2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dee97sm35248611b3a.126.2025.01.07.19.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:55:18 -0800 (PST)
Date: Wed, 8 Jan 2025 12:55:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Kairui Song <kasong@tencent.com>, Desheng Wu <deshengwu@tencent.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 116/168] zram: fix uninitialized ZRAM not releasing
 backing device
Message-ID: <in5x6saane6o2yjo3qxrcs3fpssgsfg3dutksidtsjie2g3zeb@5wait6y3lrz4>
References: <20250106151138.451846855@linuxfoundation.org>
 <20250106151142.833223628@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106151142.833223628@linuxfoundation.org>

On (25/01/06 16:17), Greg Kroah-Hartman wrote:
> 5.15-stable review patch.  If anyone has any objections, please let me know.
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

