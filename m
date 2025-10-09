Return-Path: <stable+bounces-183701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB66DBC935F
	for <lists+stable@lfdr.de>; Thu, 09 Oct 2025 15:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AB63A64EB
	for <lists+stable@lfdr.de>; Thu,  9 Oct 2025 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29B12E6CD4;
	Thu,  9 Oct 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CKb0BOuK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC762E6CB3
	for <stable@vger.kernel.org>; Thu,  9 Oct 2025 13:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760015368; cv=none; b=WBEQiqIKx/MS5o1PX+Bn0FVZqBEJjnLX2EeeX5+5SJ+QP+e8LHCwySDo1tovap7getbDXPO6f4Rxy5gI/4k5ZqJIVB7Ou5jLdmyQrI9wP/7bCovc+EoVbqXNatrqrzt0Cu4rKJvelHbqQdeEECDEoa54hh9V8fG/fTWEA/a5sBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760015368; c=relaxed/simple;
	bh=6cjja84iF75EUM3RnTgEMD3R7teVR8cP5vSoors5xcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWzdWI9ES3knk9DwLB2RnxQ7bOfsVoMxFBE3CjuoJmIKW9/ljauAdhCfRryhPTQlZCUfydxUL5YOUZsNdEOnq70v8rCBvhhspf35DcoPRCnZcQ6ppj0VwDy8RpShCpN9PEPjdL5rsN7eloQBbyTiyVI8JT+uYkAh6zISNxAsN3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CKb0BOuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887AEC4CEE7;
	Thu,  9 Oct 2025 13:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760015367;
	bh=6cjja84iF75EUM3RnTgEMD3R7teVR8cP5vSoors5xcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CKb0BOuKUhhmCxj7wVPPu+F0XhEQiP+sOxzF1zvuo/QbqTPeU9c0o0sf4j451d5s/
	 FKhJTqqTbTWfid4MInO/+C5l6rvKuchfRtWXA/XsLioSG8b+x1ejuc6Xtue+/8FpnR
	 C4ZoSVsSvFHRGDhRtwaUK3anTLw50QVaIPhXekKo=
Date: Thu, 9 Oct 2025 15:09:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	jianqi.ren.cn@windriver.com
Subject: Re: [PATCH 6.1.y] spi: microchip-core: ensure TX and RX FIFOs are
 empty at start of a transfer
Message-ID: <2025100934-tweet-rotten-d617@gregkh>
References: <20250512015227.3326695-1-jianqi.ren.cn@windriver.com>
 <20250512163207-282f1e7f1aec7163@stable.kernel.org>
 <CABMQnV+mjLbn62AXSp4QPG1rBY+4vTq-yFKJM+rT=YKwVwxVsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABMQnV+mjLbn62AXSp4QPG1rBY+4vTq-yFKJM+rT=YKwVwxVsw@mail.gmail.com>

On Thu, Oct 09, 2025 at 09:35:21PM +0900, Nobuhiro Iwamatsu wrote:
> HIiall,
> 
> Why isn't this patch being applied?

Perhaps because I had to drop ALL windriver submissions due to them not
working at all.  This was in that batch.  See the mailing list archives
for details.

If you think this needs to be applied, please test it yourself and
submit it with your signed-off-by please.

thanks,

greg k-h

