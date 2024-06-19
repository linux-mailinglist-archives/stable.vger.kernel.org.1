Return-Path: <stable+bounces-53840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB9790EA4A
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9537B21936
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12C913CFA0;
	Wed, 19 Jun 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fIq3ojHg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7AFC1F
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798508; cv=none; b=VoaTrAgq/P6xiwSWW6RacKZJM77NvIANY2N9SakwTaGI1bC++0jn0IWue0Xb2cQId1U3dIM/7V9ny0JTAV02tJLgOCuQt45+QMB+Yt1+urM96Ha9GNA/KCvy1pYDdKUXy+0wNjCh5+2a65/8HLBLgZTWbflrGgIDtjf423GyY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798508; c=relaxed/simple;
	bh=3wGr2lgVZheHA9kXJ+cgRnBPt18vOBpuW6ZTHuLaQLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0TpW0EWFQqJMaCng4+O9C9cR8eVXg25Xo7AIe7JVUgPjnlyKscv2w2UK3tLPXrDi0L0YbMtqNuIJv/VsBkGpifI7rM72BHZ7PahfMJp7TznE6UxKx+uRaRXkLlvSA6P9CLA0i+TyiIKeBchA67W0GcFbBib5lMg6YH/qM3O+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fIq3ojHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5929C2BBFC;
	Wed, 19 Jun 2024 12:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718798508;
	bh=3wGr2lgVZheHA9kXJ+cgRnBPt18vOBpuW6ZTHuLaQLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIq3ojHgyqcPRk9ujx16JJ6xjOfc96dq7fhgtXDoQy4rPx/FQdR3VSm/Fk3zZitNf
	 Ej8qJ8/Z9k8bWRgk/VgPWtrZiY1kbgqeAnn5d43EW6V3fO3LkGi9SUKtw9tPPHY27l
	 JBEy53Df6V3lb5qg+pPQj4ytK92H4S6dU7eTDfr4=
Date: Wed, 19 Jun 2024 14:01:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronnie Sahlberg <rsahlberg@ciq.com>
Cc: stable@vger.kernel.org
Subject: Re: Candidates for stable v6.9..v6.10-rc3 Kernel Panic
Message-ID: <2024061929-panorama-roving-256b@gregkh>
References: <CAK4epfwEe5vuSYLvn2M2hdpy8WxRcnZ063LKCeqp1FqOU=30kQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK4epfwEe5vuSYLvn2M2hdpy8WxRcnZ063LKCeqp1FqOU=30kQ@mail.gmail.com>

On Fri, Jun 14, 2024 at 02:13:57PM -0400, Ronnie Sahlberg wrote:
> The following is a pruned list of commits from upstream v6.9..v6.10-rc3
> that looks like genuine kernel panics.
> 
> As far as I can tell these are not yet in linux-rolling-stable
> 
> If there are issues with the list or things I cna improve when pruning the list
> please let me know
> 
> a6736a0addd60fccc3a3
> 79f18a41dd056115d685
> 8eef5c3cea65f248c99c
> 12cda920212a49fa22d9
> b01e1c030770ff3b4fe3
> 744d197162c2070a6045
> 3f0c44c8c21cfa3bb6b7
> 0105eaabb27f31d9b8d3
> 6434e69814b159608a23
> d38e48563c1f70460503
> c8b3f38d2dae03979448
> 33afbfcc105a57215975
> 491aee894a08bc9b8bb5
> d0d1df8ba18abc57f28f
> ffbe335b8d471f79b259
> 93c1800b3799f1737598
> 3c34fb0bd4a4237592c5
> ffb9072bce200a4d0040
> 9dedabe95b49ec9b0d16
> 788e4c75f831d06fcfbb
> 642f89daa34567d02f31
> f55cd31287e5f77f226c
> 6ca445d8af0ed5950ebf
> ed281c6ab6eb8a914f06
> e8dc41afca161b988e6d
> c6a6c9694aadc4c3ab8d
> eebadafc3b14d9426fa9
> 29b4c7bb8565118e2c7e
> da0e01cc7079124cb1e8
> b66c079aabdff3954e93
> 514ca22a25265e9bef10
> 05090ae82f44570fefdd
> 3b89ec41747a6b6b8c7b
> 57787fa42f9fc12fe189
> 1af2dface5d286dd1f2f
> 81bf14519a8ca17af4f0
> 991b5e2aad870828669c
> 17b0dfa1f35bf58c17ae

Lots of false-positives in here as well :(

