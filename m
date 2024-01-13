Return-Path: <stable+bounces-10622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C6482CABA
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1FDF2850AF
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F687E9;
	Sat, 13 Jan 2024 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NusiQOYj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D757E6
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 09:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F508C433C7;
	Sat, 13 Jan 2024 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705137209;
	bh=ukTXz6IafL3za5bBIAGxB2WOcR7/A8VN9GsuW13+A+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NusiQOYjNQg2nclgb+OTCM/oe5n5ngv7wPe3mGVu9sjtKP15xcEOpvQZLT93xmaoF
	 SAblcR/f5P8XL60yjykuFjOFFWNgQQ8LLUr84lLm85c+xNNLNhvDa0w71dwQT54Hm2
	 vifJTvfMRyR/5hlLOSHbulpwMaI3R1ko0eiBI34s=
Date: Sat, 13 Jan 2024 10:13:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, joel.a.gibson@intel.com,
	emil.s.tantilov@intel.com, gaurav.s.emmanuel@intel.com,
	sridhar.samudrala@intel.com, lihong.yang@intel.com
Subject: Re: [PATCH 5.10 0/2] PCI: Disable ATS for specific Intel IPU E2000
 devices
Message-ID: <2024011305-backfire-plating-0724@gregkh>
References: <20240112141545.395067-1-bartosz.pawlowski@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112141545.395067-1-bartosz.pawlowski@intel.com>

On Fri, Jan 12, 2024 at 02:15:43PM +0000, Bartosz Pawlowski wrote:
> This patch series addresses the problem with A an B steppings of
> Intel IPU E2000 which expects incorrect endianness in data field of ATS
> invalidation request TLP by disabling ATS capability for vulnerable
> devices.
> 
> Bartosz Pawlowski (2):
>   PCI: Extract ATS disabling to a helper function
>   PCI: Disable ATS for specific Intel IPU E2000 devices
> 
>  drivers/pci/quirks.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

All now queued up, thanks.

greg k-h

