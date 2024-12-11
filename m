Return-Path: <stable+bounces-100555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F049EC6CC
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96347188A7DF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23501D89E5;
	Wed, 11 Dec 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DjOVgp8N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613FC1D88DC
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904969; cv=none; b=jsWx4owwzmvEG7r7qq8X4sZiFCRC4mUM+qAtj0NAtPT/Kc+4+8U5NcOiMFwTZaEY2iOre/JA3Gbg5AmoidlK7kSfX7vreLz+7FaBtUCUM6P1U7wj98ZI+o/4LH3ShfLSUmsyQoETlRSylIp3BCgo+y4qRShA+8YAKQnOWbInOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904969; c=relaxed/simple;
	bh=fpx9tGRDfDzZSP3KVuv8D8lgarTge2pCJroUxAPhVGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQW2OyNENf8EEvrKS1AC23PRtS1XW3/900cWTcLc6qsbIeNR24MdEMvZdWrxth1VOa2zDnXOpTFOSKjrRGrt63VgxzpJ0i7HtkgIi9ItJvIyLo96cazM8GywGj7twSKUbLC0ZCCGGqjXxHezkwU4NOrzv3zYbNdtYlOvdT3yEBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DjOVgp8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A286EC4CED2;
	Wed, 11 Dec 2024 08:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904969;
	bh=fpx9tGRDfDzZSP3KVuv8D8lgarTge2pCJroUxAPhVGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjOVgp8NARcTCpTPvsFdRq/J4USwfpttxj+iOcKN5+HvtpNTmDvT3IyeGhOHIIiBk
	 5FPtfhqo0EYXWe1I1lt6RxIYBZ9KbMsd+s1PTtvlIhbjVBQ6N0/PGdJHIGeYM+A1+J
	 B60huFdLWEbef/Blh0F8u1XUb61lsDst/ocMhfAA=
Date: Wed, 11 Dec 2024 09:15:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: pc@manguebit.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] smb: client: fix potential UAF in
 cifs_dump_full_key()
Message-ID: <2024121128-padded-favorably-fa13@gregkh>
References: <20241206081436.110958-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206081436.110958-1-jianqi.ren.cn@windriver.com>

On Fri, Dec 06, 2024 at 04:14:36PM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Paulo Alcantara <pc@manguebit.com>
> 
> [ Upstream commit 58acd1f497162e7d282077f816faa519487be045 ]
> 
> Skip sessions that are being teared down (status == SES_EXITING) to
> avoid UAF.

Please cc: all relevant people on backports.

