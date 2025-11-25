Return-Path: <stable+bounces-196911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4920C85578
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 15:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58C963B29F5
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 14:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17E532471D;
	Tue, 25 Nov 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="FKeZqF7r"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86B33246FE;
	Tue, 25 Nov 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080052; cv=none; b=FdLZOhBjCWZTdaelAKrU1/yxPxqPfXJlOsvz2Sx5qIFlGlJKgXKtB0BVlEQlYC92A7Fk8pk5qeYNhV9sHBMxnxkgPG2GWZNhI9EYcprsjs0s+AbrMw9lGTH8u4vM62K97oqnqw8WEr0FBTBHZiJWPyjxWbiJxfNf8sU9ymtQbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080052; c=relaxed/simple;
	bh=uthHQj8bf5IFlXYHPz1G3ZrRTq9pOt4o24DtLhOWP0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkJ7bs+c5yIH52ZEF0fKYUZAMdtcQE46Rpp16c+M4qdJg1HHRIdCPPx+rIjY3WfxI30/ndlYHndPCC3xHwt7QmIikjMxnkJGPDOr6hvuYbHwDbe8DAHM0kyAgevp4p8SqauWN7tz3U63qpgjBcwtli9DvqvHK/232OImrpgQomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=FKeZqF7r; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9A37E5C40D;
	Tue, 25 Nov 2025 15:14:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1764080049;
	bh=uthHQj8bf5IFlXYHPz1G3ZrRTq9pOt4o24DtLhOWP0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKeZqF7rdLVg6lvXNV7R60/qFhIKrzUpU4dzolk28psVyLcVawfhHvFRYQ2RubQuU
	 IesPQNs1A6o6Vn7Q5eZ4VO5jpArdzCke6SCQE+xfDLXtQZJJ1ekrHgDy4bXrJueK9s
	 bW1xsRb21O3WHwj1xW9u8rbhpiCqfELRW2ck5mY3a2sAlTqhDmxhT/+1ICzsFLcdeA
	 QJwmZm1TDDzop8jzkMvtOVhCLSHBIlZtdisqlf1H0rmoiT5qXa3GWFIR1FJEjS/X/K
	 MhqgmrW5R/387LA0IeoLs/3yIBV4+ojrAHELJ5d2UUgg1UD16nlVmW8gkLn42aj46I
	 u8GxdcIdDA4ZA==
Date: Tue, 25 Nov 2025 15:14:08 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: suravee.suthikulpanit@amd.com, Ankit.Soni@amd.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iommu/amd: Relay __modify_irte_ga() error in
 modify_irte_ga()
Message-ID: <nlhi47ro3xj3z47bhfw2m5ee3nbhsv3lh4athvhwry3wfebsqu@fg5h2d37jiu5>
References: <20251121052139.550-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121052139.550-1-guojinhui.liam@bytedance.com>

On Fri, Nov 21, 2025 at 01:21:39PM +0800, Jinhui Guo wrote:
> Changelog in v1 -> v2 (suggested by Ankit Soni)
>  - Trim subject line to the recommanded length

Applied v1, and as checkpatch did not complain, I guess the subject line was
fine, so not replacing it.

