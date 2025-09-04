Return-Path: <stable+bounces-177700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5717BB4347C
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 09:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC43B7BAE66
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266E226E70C;
	Thu,  4 Sep 2025 07:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmmPSgfD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51291F4168;
	Thu,  4 Sep 2025 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972038; cv=none; b=HVqCCqFXj3Syh2Q4lgBWdN8EcuFZQLz+4jrUItW5H4JqN6VSrM+8PQZgyX+te36ZwkLjLRgTWqc+aK//r2PSNRBwby7HbiyPimB8ef3TKOcvLtHCuYSnJnSBlQOaEkdPUgEcZJusP13qpPDN8poXnFg70yf2fZH3+JyC/RLXiD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972038; c=relaxed/simple;
	bh=H4J5zxUdJ49/J/mBi/4ikzFCJnA31Pn3op0PXa5oJoo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ufwRw0JbqNeWkxznMQnvpOgZ50wHSkOmnaeb3d5/fufwIyxECABKINxeBQrOGjPTkXdLUnWP7+jN1+gWkdVwtRHG90AIKMi5wzk3L0RIuxy8qgsisai5POI5ef4IdyJeDNhltdOBDnS5e3GBVj3ZiLymDbpx6ZwCHA26wJ94bz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmmPSgfD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717E8C4CEF1;
	Thu,  4 Sep 2025 07:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756972038;
	bh=H4J5zxUdJ49/J/mBi/4ikzFCJnA31Pn3op0PXa5oJoo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nmmPSgfDWSA9t/lbMWXGsbbam0dD0hvcW5azNxh3AR8ENbBgdfnaUyo5GfGHCr+0Q
	 WPVFhdd8z5BgpqBVky1qWdIKsNFRKij0CDRa8uHitt/9vzrD6xNXokr82Dd3GSOQOD
	 /vKVwo+8fm7Wu347QtS3YaqEPo0ByPHP09/1xdqRNsQgSRDiG8+L7ezWC1BIjx8bDA
	 x2dmVj0YH4y5ol8ffRL/cDUdX5iZr7UUPABN9nwQsdoKPUj0oExrO9HwDa8FwF33pA
	 wSwiNWWzqcTb/H4mhVIKwa1guFnm8dClnirGZI0qXa+e3FMHgLE45x1ErWvdSFnI0y
	 IBYEGSU0syP/Q==
From: Srinivas Kandagatla <srini@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Michael Walle <mwalle@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250819112103.1084387-1-mwalle@kernel.org>
References: <20250819112103.1084387-1-mwalle@kernel.org>
Subject: Re: [PATCH v2] nvmem: layouts: fix automatic module loading
Message-Id: <175697203719.10235.7817242458442326336.b4-ty@kernel.org>
Date: Thu, 04 Sep 2025 08:47:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 19 Aug 2025 13:21:03 +0200, Michael Walle wrote:
> To support loading of a layout module automatically the MODALIAS
> variable in the uevent is needed. Add it.
> 
> 

Applied, thanks!

[1/1] nvmem: layouts: fix automatic module loading
      commit: cc6f2b728cd06402127fb24df3c1c0e6f48c80c4

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


