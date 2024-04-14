Return-Path: <stable+bounces-39387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 471058A42AD
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 15:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D544B20E20
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 13:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BCC44C89;
	Sun, 14 Apr 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KE5FiLTo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1422331A94
	for <stable@vger.kernel.org>; Sun, 14 Apr 2024 13:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713102115; cv=none; b=LjPlEFTB0KDRUvMSDE8ePZzj5024Vj7qH4mtPGDUc04dmUVha5x/pBNYqZlqnnQjmwq2mn2C9ceOvuS/zDX2mHd3JqhAsBvWRc1M/IxNoYp61cl5DQnhsn4tecq6tET7nne7xs7MJcSO7OmG/t9rZsO4IrBhS7ZKNHGr+zA347E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713102115; c=relaxed/simple;
	bh=WnGgc1dRKpajCIeBqEdFWlvsnn1iBiK9F4JOl1c4bLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7cW69JfLX0mIwUYgDcRBuvTRzPoOaTGq7jN/SheVvRvAnSv80i5OAkT9IdhXgheOtxnmMCgbdA5zFs7Ji7PPuyL34buPJaq7efJQ8fwPpIvhdNBvG3GSVGdg/vVpUR+iElmesW2HSasAcWxsFMyj7CbPE6yJg/58Po8syFzFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KE5FiLTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88254C072AA;
	Sun, 14 Apr 2024 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713102114;
	bh=WnGgc1dRKpajCIeBqEdFWlvsnn1iBiK9F4JOl1c4bLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KE5FiLTo+5Y46KzjEHu2k7K8GvhD9/9blcirloFrzSTqqlbrlzYPxjEbW5HvMxfDA
	 H7GjzV4X5WGCIxqtJkwiubsSeR2qsjOz1QubI6gDuYRH/YFCxxSwAGFY5jP9rlan4m
	 ij4M1bGOXEM8BvnCUIm+XuXSoYGDJbsLtXE0jLCc=
Date: Sun, 14 Apr 2024 15:41:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mihai Moldovan <ionic@ionic.de>
Cc: stable@vger.kernel.org
Subject: Re: 6.8.3+ panic at boot with CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y
Message-ID: <2024041443-portfolio-puzzling-3fbf@gregkh>
References: <8fd3cf24-59da-4b91-a0b4-858d2b0916b5@ionic.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fd3cf24-59da-4b91-a0b4-858d2b0916b5@ionic.de>

On Fri, Apr 12, 2024 at 07:33:38PM +0200, Mihai Moldovan wrote:
> Hi
> 
> 
> Since you backported 41044b41ad2c8c8165a42ec6e9a4096826dcf153 to 6.8.3 and
> higher, the kernel crashes hard on boot if BTRFS's sanity checks have been
> enabled (CONFIG_BTRFS_FS_RUN_SANITY_TESTS=y).
> 
> Please backport b2136cc288fce2f24a92f3d656531b2d50ebec5a to the
> stable/mainline series fix this issue.

Now queued up,t hanks.

greg k-h

