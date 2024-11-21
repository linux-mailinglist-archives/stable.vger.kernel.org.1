Return-Path: <stable+bounces-94478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8B19D4536
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 02:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03008281348
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371D4374EA;
	Thu, 21 Nov 2024 01:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8IT7Fse"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CBD1BF58;
	Thu, 21 Nov 2024 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732151734; cv=none; b=Q58nPl2VMXEMEkPPyKSjRSf5d2Zyz0DvhmLoLeu1ACJ0Ajgfx4nldgKkbWxDrbyyK/2tGVhuDx1y3IJwru6VmeBGlS+zZEc8m9F5Om4ofHg+nyShS1BE7hFLvmCalP/x2HlLmwCgFRa3IZxwVYBPa0/8Tn3mby3gaonw+kpAVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732151734; c=relaxed/simple;
	bh=PSgtjaGOCr/DfqS6AkjrSTdXEqqEScdjYghHEjGWkiY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mTFFvDMcmaS1dVgml0YL5yBTEJPwilzVLV5A3fqb5rL5YCaheGugtLfIeDvprhpmkEo0oT+wnQUbn7VPPI6RsvBXAFsmIceww/0oXRUIms5Gvdu+1OEjQwvCzoAnwnv/UyiLhWne2mTn16bP8fDAB4S/ekkbAOPNzicCnWsW2TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8IT7Fse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE197C4CECD;
	Thu, 21 Nov 2024 01:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732151733;
	bh=PSgtjaGOCr/DfqS6AkjrSTdXEqqEScdjYghHEjGWkiY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=C8IT7Fse0pcSY+4Houfs00gbd8dCAMQ7KYG7CocpD0kNEbWVm2ADhIrYuAJ89iEja
	 R7lXAHWr7OKfoMu2FpV5XLKrZ5qwN9wk6QeCoyxU5s9rVXg6jcISU0IMIAqwtrFyk+
	 6MmLedsuvt5PKSrNvUpjheRPSllhFvUGRdj8GDxgw0MTj5NSiAFW58BlJk6nNoUeuD
	 iix1IvTpibYXdsgnF847utnzlmkCw5yzoekkfrO3E74dwVW858TghOOvFO7VooXtcG
	 fyyA+jvzy9deEaMBSLU4y0G/0yAgQXt3gM0IfOkRX46Y/LRl3kA5SuTjnlW6uItULm
	 BJhjELOxFlWhw==
Message-ID: <1364c01c-ecd7-4946-9646-a3e1b406006c@kernel.org>
Date: Thu, 21 Nov 2024 09:15:29 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, Daniel Rosenberg <drosen@google.com>,
 stable@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: remove unreachable lazytime
 mount option parsing"
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241112010820.2788822-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/12 9:08, Jaegeuk Kim via Linux-f2fs-devel wrote:
> This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
> 
> The above commit broke the lazytime mount, given
> 
> mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
> 
> CC: stable@vger.kernel.org # 6.11+
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

