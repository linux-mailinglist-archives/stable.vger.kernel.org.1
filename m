Return-Path: <stable+bounces-33131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D930891612
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 10:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2FD1C2387D
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F6E54BE0;
	Fri, 29 Mar 2024 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWYjNfSi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748625778
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704715; cv=none; b=hXIeHqH6dkhexC19smfeYhkRppR6AoFJI4S6mXSBNNn3H3+kqn/CeVnLOUKri/fBohuUAjmQ6s3EDPNf8FMW2r24hjDft+feuyC8RlumXFr8sUkCKfhJdkQ0B3VfpyZCG5KWHA0mRhYFaoaecNA/3DrEsn7LUBH55vSXteogQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704715; c=relaxed/simple;
	bh=J3YWr/AaV/WNOm0loZYiRP2vnfTBUSJgmpsEJTytguA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StIkHFnQJmIMpK9HhPmycXiLyOvpAw3C7SS1TVTMkf1TJpYAApKsgqjcJ37Hm3PahFics6VnxfnGZixNazqBTVq4TKzZMPM7b+gykLS/g0B+wVRwP+nuAfkd8Kz+g/SZGtNWadviv2fVkf6jqGCoc8YrR+Nng5msQG3Y8rFYzsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWYjNfSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACC7C433F1;
	Fri, 29 Mar 2024 09:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711704715;
	bh=J3YWr/AaV/WNOm0loZYiRP2vnfTBUSJgmpsEJTytguA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWYjNfSi1jrDiLg9JqxN9mPFscsQAKcAtrRCAU42P2zFIyRN+diA4pO2kvgXUm5N/
	 oV4U2ed7nhQXenYQcAkzrC5mjCQLb1sYdr66nCiDkpk6dPvcuUgQAMLxpHnvGI1OoH
	 hC5sqqivAoQoes43i1nZdf4ed/RUl54z3S/nBAhQ=
Date: Fri, 29 Mar 2024 10:31:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: stable@vger.kernel.org, Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>
Subject: Re: Pull ASoC amd fixes into stable
Message-ID: <2024032909-cognitive-twerp-a19c@gregkh>
References: <1b8a991b-ad82-44e6-a76d-a2f81880d549@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b8a991b-ad82-44e6-a76d-a2f81880d549@gmail.com>

On Wed, Mar 27, 2024 at 07:35:33PM +0100, Luca Stefani wrote:
> Hey stable folks,
> 
> Can the following patches found in mainline
> 
> [PATCH] ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2"
> (861b341)
> 
> [PATCH] ASoC: amd: yc: Revert "add new YC platform variant (0x63) support"
> (37bee18)
> 
> be backported to linux-6.8.y?

The first needs to go back to 6.1 as well.  All now queued up, thanks.

greg k-h

