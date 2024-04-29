Return-Path: <stable+bounces-41627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E718B55F0
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA5B1F23371
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644D63A8FF;
	Mon, 29 Apr 2024 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A7lls3F1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243DABA2E
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388595; cv=none; b=Nnv8P0g5wlhM8AZF16GN1dEC0avL86aE/+WFuHsAF2urUqiMujDFgMuREz8P0DvDZm1GJ8EXNBnx7TxYdbaX35XWMOixmSSpj3SlyqDrxx8GaqSnq1rUKm8nijWL6C/5yBf6shKXs0cAPtL8L7ZJdu/bHmOY+oezoBtUnnKepuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388595; c=relaxed/simple;
	bh=uQnLUEM2UUpSk0wdFHfUmRw22eOx/gYtefL5oaEyUFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1Z9on0tGJ1gtpai0NKwjsVhWVKiTzWrNqwf5+ky8h2Ji33n1CqePG10skAlmHoxUebuiJsAoNWzGpITILnuYoXeYqgcPau8KUyWsENtneX9EyrcmPVi7r0iYwx20/bRLifz+6srHeweI4ajic3qyJqe9LLN2szuG2bFkzV8vlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A7lls3F1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6602BC113CD;
	Mon, 29 Apr 2024 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714388594;
	bh=uQnLUEM2UUpSk0wdFHfUmRw22eOx/gYtefL5oaEyUFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7lls3F19DlbNH4noPvVeQT7fso8/EYBAeDQcG//mKVtDEI0YSSoQwbH51Ra1a1yD
	 Zt6uqqJyIkc/bKVTGsDzfqZJadT7ZZDGOhDUrC/9U47ZrwDe5MQUoYNEvKegKi+Aki
	 ZSKPcXxgVMjDP/Ju1RtC0oPGtdTn2s3SNxEr8z4E=
Date: Mon, 29 Apr 2024 13:03:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Cc: saeedm@nvidia.com, lishifeng@sangfor.com.cn, stable@vger.kernel.org,
	moshe@nvidia.com
Subject: Re: [Patch 5.4.y] net/mlx5e: Fix a race in command alloc flow
Message-ID: <2024042902-swipe-glitter-c383@gregkh>
References: <20240426002703.709499-1-samasth.norway.ananda@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426002703.709499-1-samasth.norway.ananda@oracle.com>

On Thu, Apr 25, 2024 at 05:27:03PM -0700, Samasth Norway Ananda wrote:
> From: Shifeng Li <lishifeng@sangfor.com.cn>
> 
> [ Upstream commit 8f5100da56b3980276234e812ce98d8f075194cd ]

Both backports now queued up, thanks.

greg k-h

