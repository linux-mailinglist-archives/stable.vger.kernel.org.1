Return-Path: <stable+bounces-78311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3D98B2DE
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 05:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8AC283253
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 03:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB51B012A;
	Tue,  1 Oct 2024 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nnom2jxg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E3664CEC;
	Tue,  1 Oct 2024 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727754989; cv=none; b=kNgVXY4G5X2Z87/MjPsXm8SuAVtUYXJcfB3lndbZB37HyFKGtlgFB0DUfFICFcEb+ibV4jN45katFu9K2NAYNdpuUHCIerCbCbn05KbkJrlS3MAvMvxjfwAd/DMXyA3oLICHvpWkGQVoGa6l2x11LYdgOAmoLfJKFvFcTIMETl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727754989; c=relaxed/simple;
	bh=MqTIcPv2wreLQE3sRuPmqeOCVAS2j8QpUl+LEEm4tcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMmVhOXpSYlAv1GlgDuGw1S5zmORvsBlqILefphfQIio8uv56EKsPC6xlDlSJUChiAuLwJwXFtkLK50dA5Bt5pP4VpPf3od/1jOd/2n6yzKds2VKSq2XRMc7hUMGG/G/Ld+rTCeXaPCYCXOkDmlFm/zECYnRZEpUm1sSOSMHBDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=nnom2jxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3E8C4CEC6;
	Tue,  1 Oct 2024 03:56:28 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nnom2jxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727754986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MqTIcPv2wreLQE3sRuPmqeOCVAS2j8QpUl+LEEm4tcg=;
	b=nnom2jxgwZyMQO64kf/fUeixrrIqtf1zpWk8+UpfY+KVYBoHYBegNJMbP4g93QYN1AgmHu
	bcqFzEu8gsgKeLUt94zQpnwT7PddypsYoXqU705TKUgpTUaXbeDZ52YETEdjbRZu/K/rUl
	YPocpI+3sgXR7gLJFNElpAZ+Hx4jNz8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9ebe0dd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 03:56:26 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-286f1431bceso2858458fac.2;
        Mon, 30 Sep 2024 20:56:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YzUr1Us2XrIrbPXDTJpTRCh4s7R4Ew5jzV6nLhLmSDTFmLzsI4N
	fJ0NO9qu6aGjDa3UcH1ZoMRcUp/v81U4TOASFrqb+/eRyAAa/Q8qb1hw4Dd4X6b/Ykrile70CcX
	uKlwrvVUN1jGTBFM/HsQSE366wBo=
X-Google-Smtp-Source: AGHT+IEpl+PoBp2h0Cf/hgJ5MWvAzKcb2iWf37+Lu4KYZ8wOVq3M/2nQA9Hz0p9FrJGQ/deYDdwlvRrvRklusLuidpA=
X-Received: by 2002:a05:6871:294:b0:260:f883:95f9 with SMTP id
 586e51a60fabf-28710bd8edbmr10282815fac.42.1727754985561; Mon, 30 Sep 2024
 20:56:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930231438.2560642-1-sashal@kernel.org>
In-Reply-To: <20240930231438.2560642-1-sashal@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Tue, 1 Oct 2024 05:56:12 +0200
X-Gmail-Original-Message-ID: <CAHmME9pBufdO91FK8A_ywNhOcpxSjvZJA3_pBCbhPf+1qHZaMw@mail.gmail.com>
Message-ID: <CAHmME9pBufdO91FK8A_ywNhOcpxSjvZJA3_pBCbhPf+1qHZaMw@mail.gmail.com>
Subject: Re: Patch "selftests: vDSO: simplify getrandom thread local storage
 and structs" has been added to the 6.11-stable tree
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

This is not stable material and I didn't mark it as such. Do not backport.

