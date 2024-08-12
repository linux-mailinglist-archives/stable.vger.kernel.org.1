Return-Path: <stable+bounces-66467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C9E94EBD7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FC881C21282
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27FA175D2B;
	Mon, 12 Aug 2024 11:32:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6621A3C0B
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462322; cv=none; b=mia/t6VLndEBNLSQ+MLm3w0uy7dGChXViYKPHsxVpR//zROD6pcUQRXJFQI2y6loQIVqgKo6XkSexxFAzK2YwNfjmbY6QjJIRlOfDMnBo9xLAn45AtZ/av3ecv3QxoH3ZKyY6wGY6wzWDRMdSWOZvacpQT1mRd5ia6WnRnzAA1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462322; c=relaxed/simple;
	bh=uoJlGyT6RS5g4tugFxAAZ0/cr0rN7uyO1W/SSFWPNPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNNOFhA3rpgNjzzuJvAlyp+O85SDpQNRIEIqqvpCaRmMDSpUvvxc30DDuz3saWvGIowK9gf/KxyPC5z/S00W+07rfSe1HwrDRZw82VHiuKZd3DVGhMASp/O3NxQIh5xEPzRUFee0Nca+j40T1lMbCHjx+8IZfgA4YE7/Zo70zxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ADA8FEC;
	Mon, 12 Aug 2024 04:32:25 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6027D3F6A8;
	Mon, 12 Aug 2024 04:31:58 -0700 (PDT)
Date: Mon, 12 Aug 2024 12:31:53 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, anshuman.khandual@arm.com,
	catalin.marinas@arm.com, james.morse@arm.com, will@kernel.org
Subject: Re: [PATCH 6.10.y 0/8] arm64: errata: Speculative SSBS workaround
Message-ID: <ZrnyqZxR_0mjNFdZ@J2N7QTR9R3>
References: <20240809095120.3475335-1-mark.rutland@arm.com>
 <ZrnxgS9RTDP4FDtK@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrnxgS9RTDP4FDtK@sashalap>

On Mon, Aug 12, 2024 at 07:26:57AM -0400, Sasha Levin wrote:
> On Fri, Aug 09, 2024 at 10:51:12AM +0100, Mark Rutland wrote:
> > Hi,
> > 
> > This series is a v6.10-only backport (based on v6.10.3) of the upstream
> > workaround for SSBS errata on Arm Ltd CPUs, as affected parts are likely to be
> > used with stable kernels. This does not apply to earlier stable trees, which
> > will receive a separate backport.
> 
> I've queued up the backports for the various versions, thanks!

Thanks; much appreciated!

Mark.

