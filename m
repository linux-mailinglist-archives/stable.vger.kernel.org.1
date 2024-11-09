Return-Path: <stable+bounces-91981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E096B9C2AE8
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 07:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269E6281CD2
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 06:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E61113FD86;
	Sat,  9 Nov 2024 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GLoe4MAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326838DF9;
	Sat,  9 Nov 2024 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731135574; cv=none; b=m2iBjNGU/O0Px0MKO1P6iu8dueGSumSiqNiXNb3Gze9DZ7/2MWTGtzVOmKLB4wCItnEvSmZLDSzA7NBiLf1phKoWiNUIqmQsu4kVtZq44cIJXeewll/BbooWuSV6jzuH/zpu8WCJTakuSNflRJvr02v/A96T+5/FkSbN/hVAaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731135574; c=relaxed/simple;
	bh=+UkhUQ6mDDW3zbQ7VzXhosBO5S5lCqMQHb8ZTPWyO38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIpEHmuWD5jtq4hJy7Ccq0M88apiCWxZS3AiXH5yzERRTN0degR2J7N1ulQb4+QLKfevvYkdXlhUUrva+Ce7TT9RfioJw11+u9Q3pRuZ2BFfbnsOjfV0IQxKbjD/ZaE9ZuZS06iQ7YE32MtPLmc+9th1nxWITOuzKmFbSk4rewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GLoe4MAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB41C4CEC6;
	Sat,  9 Nov 2024 06:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731135573;
	bh=+UkhUQ6mDDW3zbQ7VzXhosBO5S5lCqMQHb8ZTPWyO38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLoe4MAIBGhGQfnGUsveUnFJ/6dVaeyGYEuOF6agadwzcjGb0zBgxkIT6+ZUeTT1/
	 imjohGvYvqNtFXK5J14O8lsGQf2mEwIFvGXpAMGKFtCJ4pIFnwOXdIE9crflOptSNj
	 TxRwRNNjJhW547ktyyJBWmRzHvseKSfBFoD1ynNQ=
Date: Sat, 9 Nov 2024 07:59:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rex Nie <rex.nie@jaguarmicro.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	angus.chen@jaguarmicro.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] USB: core: remove dead code in do_proc_bulk()
Message-ID: <2024110947-umpire-unwell-ac00@gregkh>
References: <20241109021140.2174-1-rex.nie@jaguarmicro.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241109021140.2174-1-rex.nie@jaguarmicro.com>

On Sat, Nov 09, 2024 at 10:11:41AM +0800, Rex Nie wrote:
> Since len1 is unsigned int, len1 < 0 always false. Remove it keep code
> simple.
> 
> Cc: stable@vger.kernel.org
> Fixes: ae8709b296d8 ("USB: core: Make do_proc_control() and do_proc_bulk() killable")
> Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
> ---
> changes in v2:
> - Add "Cc: stable@vger.kernel.org" (kernel test robot)

Why is this relevant for the stable kernels?  What bug is being fixed
that users would hit that this is needed to resolve?

thanks,

greg k-h

