Return-Path: <stable+bounces-52636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F9690C3EF
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 08:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004BC28167D
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 06:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0E86A8CF;
	Tue, 18 Jun 2024 06:48:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AD769D3C
	for <stable@vger.kernel.org>; Tue, 18 Jun 2024 06:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693285; cv=none; b=uiK/eaE+RmkFC92mem8pYzTg3h5+XOtfyMXdullAYdvmrOori6sEQ2UCE1lEMs2sF7xvOjuDA347XDLCAsvP+v5VxwlEsih2dmSGZJ5BHCGV9pWHxc3Eh0buZZ26yyqYfD1dAunTKOD5jJTqNwzf9Ttsoi+RfBs1bVhg5d+MP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693285; c=relaxed/simple;
	bh=YBjG30SWUstGSZZ2uclvSwNCr4GxYcJBQjwg5OiSxdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaNJiRjKGYlOuAejhyd3PcEYDMvRRF79n71/hUiUhLhAkMoQhxgkaIIi2v/BtFxkyiPrP6k46EQe1lMDPcZVMl2EymRyBIwPdmwcbiHdbGPLmU2Q6Zyw9vJvnd9sTfbsFBj6Dlo9YhJzgJuiT9lE2barSnBmeKvJpwBoBwekaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DBF2267373; Tue, 18 Jun 2024 08:47:59 +0200 (CEST)
Date: Tue, 18 Jun 2024 08:47:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: stable@vger.kernel.org, will@kernel.org, mhklinux@outlook.com,
	petr.tesarik1@huawei-partners.com, nicolinc@nvidia.com, hch@lst.de
Subject: Re: [PATCH 0/3] swiotlb: Backport to linux-stable 6.6
Message-ID: <20240618064759.GA28989@lst.de>
References: <20240617142315.2656683-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617142315.2656683-1-festevam@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Don't expect a qualified review of stable backports to me as I don't
have the 6.6 base in my mind, but the patches do look sane to me.

