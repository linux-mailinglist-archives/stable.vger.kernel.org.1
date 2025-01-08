Return-Path: <stable+bounces-107951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C75A051CF
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70D3188A1A1
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 03:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A85919CC29;
	Wed,  8 Jan 2025 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aDzXEiRS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91632E40E
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 03:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736308702; cv=none; b=eD1WM6zVVHAEwjkwYshy5BW+34wJ2GbvfaG0fI2ZuKvLF0J1MKez+WVzXeWiLRXwTVIeqJ/F3pA6yl7VK9rnBcToJmlr/WB+e7fZAB3Q0KKtIMpqhPMVZmPbVlk9gs/sPHJWq1P0uDIySfkXrraje7bzXZS7OThxKaw4J2DBx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736308702; c=relaxed/simple;
	bh=zNGpVWpLu9Qvd2Wn/x54cG2h3cDfMLeqXE5y1RN712w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBsDgfR9nOivseZQwyvFjO1vIXfLB8ktgZq5XECLi+512g/vcMTIyucBMzoOlmEcfe6tGQ3iMcrmKmzW3TV78iCSV2KFDvoXiivYChDMiDAiLngGUpImWEWLw5gpo41g/9N2EPMSOP8K+lbMVU4fVEJImzcP3yIzWIoH9h/DX20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aDzXEiRS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166360285dso244225115ad.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 19:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736308700; x=1736913500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcBrl6keYH+0kZEwvvhNEQ1sIGNcdbWuJh+Y5ZXPHk8=;
        b=aDzXEiRSFrFcLvFNNjOThCO0cn+ZSdCN0JwON8ee9ycvvyEPANOycvO05AZ0AERD6u
         6Ln0H3ct82kIwJSdhnzPPtWhy9/T6mpng+uxlonb3fRQEx6deXDgfyNUlZsSCp7TxP+m
         c9WuqoynBSstnn7ank6NHYgtnAAOTEMO8geXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736308700; x=1736913500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcBrl6keYH+0kZEwvvhNEQ1sIGNcdbWuJh+Y5ZXPHk8=;
        b=AR6KUf2BymVgX8Kk63qYC/Y+aU7kIhCHnu7VDDbraAN5soLyNQB5u41h+BTm5+26oV
         zDhQppLiZ4R/IQrExd4frk2//+2OEvOmVsF/hEBdv0ZgZrVt6fpThmSlcyIOUWlwFYx4
         3m7SLqyzUmejIIguU5GmzPPtRg0ki2PkadOKVvX/yCh7iUkqWOjoiu0a++tnDcFRlvU7
         mCtdRd6IPf3Q5KiGNrRny3ihN9XjucVoZRTw4kZaUAMQn2RxKYemkNyC4xmAa6m8T/Du
         O4L504guV/vuwnzD7PwON2RM0KAQelgwqgQn9jdpEopWlDuY5LUlPSe0nrwAnkYyjkmz
         /43g==
X-Gm-Message-State: AOJu0YwApAfK4LBqdnmgnNdd2cgEmR86pKkBBIT6yjJ+tfa9OuH3XgN8
	38yQ5xlC2kvKu3YDvoi2zBCpnQ/l188hAVqAgNZ9SCbwix+T0ybMIpLRneCcgw==
X-Gm-Gg: ASbGncv9Ov4TZqQREuAeRutrF0WnVrTBrSgnlSV0dlh3OQuRdKiMbukinquqWi3Ax9k
	64RSCAwONX3GiiKVIeTV1D4VgF3uofS1xqoguZCxw6laaHMLapO0GEc0OxKcAa9kK/jY8BLfwOF
	u6xh0/sw3NakvNvgXF/VjjD8wE0gDEIy6NUEcLB4IgAN1GWcVPciE42S6oVe0sHyEaBV5FhvidH
	lx5L0eWZEUdbrnK2yjFSitew/r3gCtoRpwEtATyJmP5ddWEC5jyoaDONvoi
X-Google-Smtp-Source: AGHT+IFRI8VkNI5WzMBkrf+NdV1dwwPsWeNqtxBjhBmLN1x0Izyt9QoJfA3EZ0ajsULkV25Jflag2A==
X-Received: by 2002:a17:903:2b08:b0:216:70b6:8723 with SMTP id d9443c01a7336-21a83fb5af8mr24176405ad.44.1736308699936;
        Tue, 07 Jan 2025 19:58:19 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:57ef:1197:3074:36c2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962dc0sm319522885ad.32.2025.01.07.19.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:58:19 -0800 (PST)
Date: Wed, 8 Jan 2025 12:58:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Kairui Song <kasong@tencent.com>, Desheng Wu <deshengwu@tencent.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.6 086/116] zram: fix uninitialized ZRAM not releasing
 backing device
Message-ID: <tsalwprwgp2b4uarbrjzik6m4hg5kbezjthdqxp3foxuu2vyws@vtvw7sl5fp6w>
References: <20241223155359.534468176@linuxfoundation.org>
 <20241223155402.907380237@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223155402.907380237@linuxfoundation.org>

On (24/12/23 16:59), Greg Kroah-Hartman wrote:
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Kairui Song <kasong@tencent.com>
> 
> commit 74363ec674cb172d8856de25776c8f3103f05e2f upstream.
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
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Can we please drop this patch?

