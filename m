Return-Path: <stable+bounces-188268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D950BF3F2D
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 00:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A418C5BCC
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 22:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12A22EFD98;
	Mon, 20 Oct 2025 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b="CFcf9CSX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25732F3606
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 22:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760999909; cv=none; b=UzPsNSDgS42H4+R6sIqc+4emn/Ho/Jv/ik8ZmpKcP64jk6uXYaPEJMNx8mJTfU5/YoP15r/XMPF4i5aVSCLsrsSXasb7YTjWDHBYuRUIOQrD+vt+PZ3h2E0knrA/pg6hv6sB0I6DfSrsqeQ0tj+oXhl6BmMHFp5JFEdxVxVWzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760999909; c=relaxed/simple;
	bh=orOSuq6/TaO8b3SlIRmCg3DN5wKL87zSxAtzqpgiNKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMIuvfbbrGLa3Ywr/qrBRoMkA03IPqHFCFZuNlUI/3sfTppbd2FFvpFTUFcvatHppMKIq3WU1yx521jM8mWhJ39tBsA2Ih1fyXjzUb9cDmm+qD5DBBJQiehj1GNPmb6AMjseJI5nNvnKvLxZItQNBBT+vUQiHwKhhj2zpPz+Uas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=kerneltoast.com; dkim=pass (2048-bit key) header.d=kerneltoast.com header.i=@kerneltoast.com header.b=CFcf9CSX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kerneltoast.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so4482509b3a.1
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 15:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kerneltoast.com; s=google; t=1760999907; x=1761604707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWRTJlVR14k1p+t4VRxVrxCe+1iPDNnQxl1YGhAuvaM=;
        b=CFcf9CSXl2jYFaAF6xSkEiIDwt95eijEUXTOipjjSQe6DZ6yd7VbsHu33f4RQQg0fZ
         aka/0ri6163qPlwHhxSiqQ9RKLBu0OGVDm447MrwpbpbNcxHH+Ue73dj2uWYdsnkq8X6
         N5kL38eH0vAIdm7VvMKhKRVHhQ3v71hsRxQUHmk4BCdsX3DZ/Yvj//cWs7xqGeyIAjIj
         7+/b2IbbtcGtcCQHGv4i90EWDLc0yahwlWwEker72MWxvYMskj7sn6Mw7Q+obZsr5mIK
         m2Ix9SOTYc4aGBlOFdvEh5n4k7PAxkuns4JUiceLhzHWMhge3/Jbyw/YtXkCeZlEy93C
         1k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999907; x=1761604707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWRTJlVR14k1p+t4VRxVrxCe+1iPDNnQxl1YGhAuvaM=;
        b=kZE1WehqN18yQrdguRVqJIs/V9Op2Bi9cfc9bZVvnT9Va+4SmDUUrEcA/8qA/7QQ8f
         U7ta4RC6DkCFrpMebiHsqW8lsvhI/WztJSPBSgCVQGl4kmWJfvWsb3blq+KIO70vb1eY
         iPBR2NYeU9XzvEI4V7Tm+7xsf5lODEi3KT3MY4Ux1wmQ34WMxlFhXEavWVb/5qnMqNZF
         8CANpnDXbKrl48XUaQs6/Yo1mFPsxSPZx3aHbO1ctCQwfZaoXVnPoPM7e3bC2+OU7VYY
         tn6QHdEV8HhJaxQKkQQN2fF+n5ewEaYl9snOoPTK0LhP7FyS4B1RDRjfmo1F0NThF5IW
         NgOw==
X-Forwarded-Encrypted: i=1; AJvYcCUUcrp2KM5gdWNB/vDR583kKAu6mE5GW6iXFIN/XrMcDgJzliqIswkG7tZ86DJdIaj/jkXiw4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG5Uo/7gdPaI7aiVdIpE1ENsgO7mwN/oDlvEyG8Bp7IpIapEIY
	vXGdCIw3PMcuY5SBx8IVTBkUCTNpkG2usokPGyiCP6LeNOvAdXElxrzniyGRSrgy06OL
X-Gm-Gg: ASbGncuPiFtrplq//qYh9G+/dQpu7tvFm60Yo2Go5atpL0LQOgBBggN0MuMtRX/+OEF
	inydtCtp10mkVplm6U/yDpYEyNyNFxSzIumKjS65COVB9s7YeseqeRUQ1pyw+FZFIUbkAk1gJbc
	16UOIUoCGRmcypcRg3ComATghf4r1Z+o3sjIFzOmbAMB+wC5K9EwRrAVz07eULQjmJlklh3nDld
	qzsmIdzGJB++/CUr1Yc+4OPKsKqELWl+BbJBfC/Y7pGYgGJs/Xf7DH/L7fZ0YgYw/7pQTlG//Pe
	z9MJtC/h9r8nzIyysraCleoFY/I5jvjbxrvQN7QlNh1VAcEY9Sc+Akvlvq9LiP9JwCuwtmpV1rX
	h06EHX1kWqbOs9vrYz9oOJx87/quu2ALUzj76+egHMVyGnHRDa9kGK5kB4aHq4tzKgYiFID6Q3W
	9Qk6NfZb9duRpb
X-Google-Smtp-Source: AGHT+IE0LQAIsZCu6j5Qdn8HCSh5MlQ2d0egKfnqGzGTZXmf5cDOmsKO8hmb5ZyKOB5MJuaSc4fszg==
X-Received: by 2002:a05:6a20:42a3:b0:32a:91c6:e085 with SMTP id adf61e73a8af0-334a8504812mr17300178637.11.1760999906692;
        Mon, 20 Oct 2025 15:38:26 -0700 (PDT)
Received: from sultan-box ([79.127.217.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b349b2sm8861349a12.23.2025.10.20.15.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:38:26 -0700 (PDT)
Date: Mon, 20 Oct 2025 15:38:23 -0700
From: Sultan Alsawaf <sultan@kerneltoast.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd: Add missing return for VPE idle handler
Message-ID: <aPa539qN_yjj8_a5@sultan-box>
References: <20251020223434.5977-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020223434.5977-1-mario.limonciello@amd.com>

On Mon, Oct 20, 2025 at 05:34:34PM -0500, Mario Limonciello wrote:
> Adjusting the idle handler for DPM0 handling forgot a return statement
> which causes the system to not be able to enter s0i3.
> 
> Add the missing return statement.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Sultan Alsawaf <sultan@kerneltoast.com>
> Closes: https://lore.kernel.org/amd-gfx/aPawCXBY9eM8oZvG@sultan-box/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Sultan Alsawaf <sultan@kerneltoast.com>

