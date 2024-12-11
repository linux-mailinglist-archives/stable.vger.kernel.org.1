Return-Path: <stable+bounces-100560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A99EC6DC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6DA2188A9E9
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1E41D8A0B;
	Wed, 11 Dec 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dySG4DXW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5F01D86CE
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905006; cv=none; b=YpgoTkhURdfUEG4UG5r9MmivDAJa9T2jTR9Uz1J/fx5KC1KCygKIKOZlFeADvCbkBhoR6JIVkaSVlGDMFKGwcUVU0H1sgcKYJazD/+fCvr09FQ2NNkI/CFN7JLe1wXhciGeOydkjSPjJfwI15DrLCl7b/jgHdbdenCDnx7uU1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905006; c=relaxed/simple;
	bh=kCoXEKYvMszg7DeGaT71Wabjf8fk6Cjv3Tn2beHzquI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uinuEFZ4rE2mIYxUunRrO1oSNdkmT7b1tuFiCrKDdjipHyHLkWl2DJ5UnIJJL2VURYtDjlqx2nvd5jAR1fJ8Zl1B8t/EiEqkNyNe+VC+/7UMBJfRuHzCm0ieh6ZhuOd3QqiMcCFB69Rb+R/CGJ8NgLDEY+AD3lI34+dlKQ59/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dySG4DXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CB6C4CED2;
	Wed, 11 Dec 2024 08:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733905006;
	bh=kCoXEKYvMszg7DeGaT71Wabjf8fk6Cjv3Tn2beHzquI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dySG4DXWlHQx4B8+OTcAttq/VaUBxtYV/7mcQ4vCuw/5JHpmL4ZPJRi8IYuZVqTAF
	 AkZRb8zLjam+Sb6sq4GahtPbERC1w71b8+hldf2T7hPqJdsIdGEQupfDRDSnKsGxHU
	 n14viyjqjK75KbsB/yBP8HNN0+d9QKFZ0CK3KBls=
Date: Wed, 11 Dec 2024 09:16:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: almaz.alexandrovich@paragon-software.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] fs/ntfs3: Fixed overflow check in mi_enum_attr()
Message-ID: <2024121106-spoiler-blunderer-d542@gregkh>
References: <20241204032913.1456610-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204032913.1456610-1-jianqi.ren.cn@windriver.com>

On Wed, Dec 04, 2024 at 11:29:13AM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> 
> [ Upstream commit 652cfeb43d6b9aba5c7c4902bed7a7340df131fb ]

Please cc: all relevant people on backports.

