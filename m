Return-Path: <stable+bounces-11860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5009C830A62
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 17:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80EA287BF6
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 16:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439FF22308;
	Wed, 17 Jan 2024 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NspDVcYf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F8200C9;
	Wed, 17 Jan 2024 16:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705507679; cv=none; b=L5QFvrmgEHrN79T7RCtNeDK65QQJ5DISEXOGjVkczA3hnxehRv8eAp8j9Xd88TrMkD/ZrJF9NUkVGIfqBnlVtDZT+J3hhcJXSOSm+IYG3HhUE9U7/4xsHpvJDaNq8d+jN1bFwQxZc4Jj4hJm2T9Fu9KRo2tZc52uuBijM3VTXu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705507679; c=relaxed/simple;
	bh=oDP05LnhDIbTjB4jT0mJYX/ihYTAmAr4+2MpdCn0d4o=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=KnZcuWef1nzIrPrSuYp1fblXLBKmEGm+n5yOT/WoJEo7+Pmz4TsGnB31mkR5XCMwXrf2qBuIx2UnkxN29q3+jQZwh8gMsjphneV4h9UdYYVwyNRWby6gRWaQsSthjCSUuujZOk4201Oepn/+t8SQjRx5rtCom8i4VvJvd8RsN1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NspDVcYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0D8C433C7;
	Wed, 17 Jan 2024 16:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705507678;
	bh=oDP05LnhDIbTjB4jT0mJYX/ihYTAmAr4+2MpdCn0d4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NspDVcYfFeLLW41tD7zT6pMgeAy9qGfjrOopzSNgka7fWvetmwlNsii7eE8uyuzFm
	 3naWASkMCs2FA7S8oH13CiQr9ldMdg329166/TcUiapboo65aCq9p/14z9f192yIlG
	 FEeHvVxQTgfNy3DzP54qE0YHiPhwSjhwNpi6hEiM=
Date: Wed, 17 Jan 2024 17:07:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: kernel test robot <lkp@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, stable@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCHv2 stable 6.1 1/2] btf, scripts: Exclude Rust CUs with
 pahole
Message-ID: <2024011746-aloha-ripcord-8dd7@gregkh>
References: <20240117133520.733288-2-jolsa@kernel.org>
 <ZafYCmLzkWeqI6sF@fc6e15c3a4e0>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafYCmLzkWeqI6sF@fc6e15c3a4e0>

On Wed, Jan 17, 2024 at 09:37:14PM +0800, kernel test robot wrote:
> Hi,
> 
> Thanks for your patch.
> 
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
> 
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> 
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [PATCHv2 stable 6.1 1/2] btf, scripts: Exclude Rust CUs with pahole
> Link: https://lore.kernel.org/stable/20240117133520.733288-2-jolsa%40kernel.org

False positive :(

