Return-Path: <stable+bounces-86816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A89A3BB8
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E3AB2353B
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 10:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C641201108;
	Fri, 18 Oct 2024 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hyvJZJvJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE352201109
	for <stable@vger.kernel.org>; Fri, 18 Oct 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729247861; cv=none; b=brvd4Mu20HZv/qq3181le++I5cUtR19w5SeG3U8FXfl99YJ2KGYC6IeZziBB0WYHiqI01jqE9a3JNdSgTijwjFHA84z8WHrC+Ryt1pK5+nySDhKCJdg6UjsFVA72WMcYQRs3poDQrSukBaMRptGIax24K5F4U23dl+e2e2WoUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729247861; c=relaxed/simple;
	bh=1XR6QO1JtUak5o/+dRM/QpRXK2oc9gByTt2TNt83pW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uoExIN6LnbCQkRzPFFhAiTO1CR7yCLne7tfRt28q5mzPsbygmC1YQpl0lephr1omHHw9qhGKPDrAoJHrQgny02clln4ClUbP3BGZrPXBxv8hNHNF6/+KF1T1SBcZ1xPU9WZ69gyXo/P2hm6jVHoeZVKEm5oHYwXuWcNeab0qX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hyvJZJvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E191C4CEC3;
	Fri, 18 Oct 2024 10:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729247860;
	bh=1XR6QO1JtUak5o/+dRM/QpRXK2oc9gByTt2TNt83pW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hyvJZJvJv2/O2/lH0APwy+DMCyO/6PU5u2kclW1pQgX75UDolNAvYTge7YvU9+RYH
	 gfGpdu+IL24vC/a2KC3OCKhzNuRP/xbND9QS4OtdfP/IG/L+lv392sZWTXNrftbZ4V
	 ZpVr+flvXSgMGck4fxKqXHWHwmDPELFY1fFYn/jU=
Date: Fri, 18 Oct 2024 12:37:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6 3/3] net: fec: refactor PPS channel configuration
Message-ID: <2024101822-calamari-litigate-8d87@gregkh>
References: <e437a6ba-292d-4a0e-8e81-074c84045b26@prolan.hu>
 <20241016080156.265251-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016080156.265251-3-csokas.bence@prolan.hu>

On Wed, Oct 16, 2024 at 10:01:57AM +0200, Csókás, Bence wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Preparation patch to allow for PPS channel configuration, no functional
> change intended.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)

Not a valid commit id in Linus's tree :(


