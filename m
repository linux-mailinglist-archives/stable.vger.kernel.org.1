Return-Path: <stable+bounces-132740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2DFA89EE2
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 15:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2D165DB7
	for <lists+stable@lfdr.de>; Tue, 15 Apr 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C0E291160;
	Tue, 15 Apr 2025 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0l9gbBRf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EAB76026;
	Tue, 15 Apr 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722109; cv=none; b=lX8qj99Jq+3ptaogPLPZNP0nEJXeYU1KcfR6Oov6BU0K5FGtNrxLkLKBWYJDgvxWD4iOJlNHQzct8ssp9TZbEVQXVVqT0wNoVZwX5PRgZt2TSrxGms8txZA6cYyZ2kPcws9A8L2lQAijXx+i9UOr1fLlkakl0h0FsXw8k9WAkwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722109; c=relaxed/simple;
	bh=/ZyBKPl+icr/iZKTjKYPQMSt0pK3OLsfxPbLuRV69C0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBTSn3qXnihKPF7Lq4MBIisFJHCHZLQ5Et/GLol0iXk0LtRMjYfESzCGzIgf5dTvxQ3GZs5J0yCXTHQVhl1KFhJXm8QGlm2TroXPqD55bqH9NU6oDn5feMcYC/BQ8eB4P+f8SmDeQQ8MHpa3qYT5XkfFUqtrJHpA+ohDCnNXi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0l9gbBRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B09C4CEEB;
	Tue, 15 Apr 2025 13:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744722108;
	bh=/ZyBKPl+icr/iZKTjKYPQMSt0pK3OLsfxPbLuRV69C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0l9gbBRfHQmR20aOfLQek8OGsdLTxshocNS09YwsRMYoZohhkpxFLhX+DPE79qJHw
	 vkzFLmOi9P2nM/MEdhjyYpFBrwTrj3zn3h632fAWfFxoJuRmmAhvDEQljIoYEOYl7c
	 ZiISFCKL73Wc+8uuDkUS4k0jMvUo5Wy5dqyubuDU=
Date: Tue, 15 Apr 2025 15:01:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: "philipp.g.hortmann@gmail.com" <philipp.g.hortmann@gmail.com>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v7] staging: rtl8723bs: Add error handling for sd_read()
Message-ID: <2025041557-recollect-livable-a959@gregkh>
References: <20250408044152.3009-1-vulab@iscas.ac.cn>
 <2025040814-curtsy-overrule-1caf@gregkh>
 <67FE50E2.043FCA.23966@cstnet.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67FE50E2.043FCA.23966@cstnet.cn>

On Tue, Apr 15, 2025 at 08:28:18PM +0800, Wentao Liang wrote:
> >Again, I think this whole "hal wrapper" should be removed instead, and
> >not papered over like this.  If you dig deep enough, it all boils down
> >to a call to sdio_readb(), which is an 8 bit read, so the alignment
> >issues are not a problem, and if an error happens the proper error value>
> >is returned from that saying what happened.  Why not work on that like I
> >recommended?  That would allow for at least 3, if not more, layers of
> >indirection to be removed from this driver, making it more easy to
> >understand and maintain over time.
> 
> Thanks for the guidance and detailed suggestion. But remove the whole 
> "hal wrapper" layer is beyond my capability. Perhaps this refactoring 
> work would be better handled by someone with deeper knowledge of the 
> driver codebase. The changes would ripple through several layers, and 
> I'm not entirely confident about implementing them correctly. The 
> current patch might serve as a reasonable stopgap solution. 

Try it, it should be a "one step at a time" of unwinding the mess that
the codebase is in.  Shouldn't be that hard, and will give you lots of
good things to work on.

I don't want to take a "stopgap solution", sorry, I would rather take
the real solution, for obvious reasons.

thanks,

greg k-h

