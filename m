Return-Path: <stable+bounces-100117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F89E9E8F86
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C2C162175
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA9216600;
	Mon,  9 Dec 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="afw8lIaw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364312165E7
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738405; cv=none; b=Aj4zbQ0XWTWtjhudppeGrEATYPb8UTuOWzQMpvDR5rVroJKLB69GSq7yHsPOOBDuA6tDOroE1FDifitjaIqvJronhJXGLc/lwrk1BN6Y2H91r7sFcHk5cbkMB2t1LFWIHdLAwE7VxYl14gnc+3/P3wYcPjIeNuIuafxGXdZ48F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738405; c=relaxed/simple;
	bh=M/Rmf9yovS4Cwy5mmXvTqvxxxgPNsor+mco8342dCnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7qxjglFX9Rb7jxzMAVuzUxp7eLwUEni0e4OJz3nay+XuRa7GxNskSuSREX21xkTMreqyBcYVcXWfNoA7SKRY0U3sgj8vZNgho1nTICZGsSkJWKt2C2rDrB3DYWPQgfW24bCSr6aqryDx3/2mTR0RA9I8Sk+SAT1+zEDHNcwmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=afw8lIaw; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46753c8c21cso495931cf.0
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 02:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733738403; x=1734343203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7/vYCqssXEXU9HGHVHfHhbepLuJMNTyPrcgJSSPXOU=;
        b=afw8lIawnrX+HvvAqtdOV7hkYTR5q7AS9mQUWs6Mg9eTDjaeQqXEWeuL6onbOU8xak
         Sx/rm+2NJPtuIvpPpBkcq0NUnGBv8Y8RSOrGX6FNboCTY/Ltu5hVg/0bUddmAyqVwvbF
         51mMB6MqhaNHZ6DfHYnggdrtI7JEB1zBy0974=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738403; x=1734343203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7/vYCqssXEXU9HGHVHfHhbepLuJMNTyPrcgJSSPXOU=;
        b=uWWte0y5uLboqYt8MeEhbPOmg+e5/Q6FRwEB1+NlL1KvOK/d+8506Ay8HsiRYkSCum
         FFJ6XNuf9sYcYKR2nFBO9eH38iI5DvErwTwwqoBEAeVn+9iUUYpXqxeWz+KKHZGzP4Kx
         fRoTgGej3KbTZnWSqLy9YLgT/bL0gl9q9oz2OMtWdU6F/kBsyLOqTd6GJuOn3xJQkFXB
         J8Ux8XN6qRdxf2MKWcbyKSAEiis94smtCdH6wLM2ItocHP/65s2v0Wid26lmTZBqwnYs
         64BR5B7xx4V6/jMPy2qkbX4iCzrzEUcNGsSRc/mmBoQPKYxDmy5ZVkpYXP63Ue+WWAIU
         ALIg==
X-Forwarded-Encrypted: i=1; AJvYcCWjUWnIC3nYM/wpMHtiIcnR5GxEPFhwGs+ZHnTTlPqgFkwu74E6ovVlshZus2jTcNLsT7+b9n4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1UZA5ZEIpmLN5MqXFcxfR7+tCtHKrULOLloRFIPvvUMC8WdaU
	0rJEO8r8QBWBVPqb2jvynEeTj5BFLCes9glcdpuY+BjQ1wB8ZCVXIehput7okQ==
X-Gm-Gg: ASbGnct1BMmFkD8H8JvaewhDMdO/eWcgkRLChzZY6w99moRN1SfGkWqyozTMUrNq37G
	z44Hz4xD5jDmgssSvDx6Paaru6tpRCCZflvAm5djy72SScP1/G4YR3JYiX3+8T3K+ygskwhqT7a
	Apk8a9Af8J9ZPLlEiYa7vwDV1EyTz4nYJjCsgMOoqISF2FLVTKNCVocAL6XmvH4s6q6uQpTp/Zb
	Ec7sDanjBQhnM9AJKudIvCnuwXVrxO67TNMDotymrDI7e9WCJ0z7CYaqH8yZHD1udvyhzeIPnqd
	su2z8jmc9/c47XmhhA==
X-Google-Smtp-Source: AGHT+IFVyJKRGYTrxVse1thtlN7wpt9Iy9+JK0qpbiPhRnK1U7pcfm7uApcLZ86HAH5R/q2Xpcu5gw==
X-Received: by 2002:a05:6214:21cb:b0:6d8:cd76:a44d with SMTP id 6a1803df08f44-6d8e6fbce73mr77901806d6.0.1733738402797;
        Mon, 09 Dec 2024 02:00:02 -0800 (PST)
Received: from kk-ph5.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da6b687fsm47287716d6.70.2024.12.09.02.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:00:02 -0800 (PST)
From: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
To: sashal@kernel.org
Cc: keerthana.kalyanasundaram@broadcom.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v5.10-v6.1] drm/amd/display: Check BIOS images before it is used
Date: Mon,  9 Dec 2024 10:00:00 +0000
Message-Id: <20241209100000.4049772-1-keerthana.kalyanasundaram@broadcom.com>
X-Mailer: git-send-email 2.39.4
In-Reply-To: <20241206104607-197c3a79c93b8054@stable.kernel.org>
References: <20241206104607-197c3a79c93b8054@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sasha,
I could not understand the error message from bot. Is something wrong with the patch?
Please let me know if it needs any change?
- Thanks
Keerthana
> 
> 
> Status in newer kernel trees:
> 6.12.y | Present (exact SHA1)
> 6.6.y | Present (different SHA1: e50bec62acae)
> 6.1.y | Not found
> 
> Note: The patch differs from the upstream commit:
> ---
> 1:  8b0ddf19cca2a ! 1:  3a1c77af30b1b drm/amd/display: Check BIOS images before it is used
>     @@ Metadata
>       ## Commit message ##
>          drm/amd/display: Check BIOS images before it is used
>      
>     +    [ Upstream commit 8b0ddf19cca2a352b2a7e01d99d3ba949a99c84c ]
>     +
>          BIOS images may fail to load and null checks are added before they are
>          used.

