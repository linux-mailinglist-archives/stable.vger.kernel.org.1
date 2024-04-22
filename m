Return-Path: <stable+bounces-40411-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B358AD8EE
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 01:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A881C210B0
	for <lists+stable@lfdr.de>; Mon, 22 Apr 2024 23:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713751D539;
	Mon, 22 Apr 2024 23:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mfToZisA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC910A20
	for <stable@vger.kernel.org>; Mon, 22 Apr 2024 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713827617; cv=none; b=CEoHkKLB5mRlueNsSy+6ghgke5L5N0mcLWfawHkcAWOZBr4d3mulrcqGWkKzTwkl5e28oge7sNpsmhkbwv/OkKJ7zyyo4G6sfydlcoOZrfK5ytd4Fduk+T0ZwQY9WB+MxBJaU2ElAPl2oIdmw1CzouGKp7wOXmVkWf02vqAvqqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713827617; c=relaxed/simple;
	bh=Crocx8LgcnShW8KT26YZbLBIycX/v3D0gVrht+Uw3NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwl1MeduEi1LY3nK39lIAJk7J0710Ki+C3giURpB2iMVrSAxHv5L9wCWv5dK9aISnpAUUjjZyCT33V87uNS4SlP6mLEFlGZckcRtELqu4PimmuFCxuzMFrbzJKUEp3OMAJHG8y4Zy9Z2LynCfnGCpb8Zmr9y5wwKQTwpUpqWOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mfToZisA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95012C113CC;
	Mon, 22 Apr 2024 23:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713827616;
	bh=Crocx8LgcnShW8KT26YZbLBIycX/v3D0gVrht+Uw3NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mfToZisARbmJVquWcUJfFqSU7ui52B+HA6mEm8ByL8TPoOo6NFNor7b40q4eJXvFh
	 Dap/qBgDxMkkD2vJC2MOUbNgcXMpFVIC1eAGltpaZ2beeaXAEpfYn1hf9kfQ6YPzz9
	 aEkUB468Eh+SxfpCHrgxhs/bJy5W0GFyWHdPebOI=
Date: Tue, 23 Apr 2024 01:13:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: imran.f.khan@oracle.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v4.14, v4.19, v5.4, v5.10, v5.15] igb: free up irq
 resources in device shutdown path.
Message-ID: <2024042347-establish-maggot-6543@gregkh>
References: <20240312150713.3231723-1-imran.f.khan@oracle.com>
 <2024032918-shortlist-product-cce8@gregkh>
 <28752189-6c59-4977-abda-2ea90577573f@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28752189-6c59-4977-abda-2ea90577573f@oracle.com>

On Tue, Apr 23, 2024 at 08:32:09AM +1000, imran.f.khan@oracle.com wrote:
> Could you kindly confirm if a backport that fixes an issue but breaks kernel ABI
> is allowed in stable tree ?

There is no such thing as a stable in-kernel api, so I don't understand
what you are asking here, sorry.

The only api that we ever care about is the user/kernel api, that can
not break.

thanks,

greg k-h

