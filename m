Return-Path: <stable+bounces-43624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC0C8C4156
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:03:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914DD1F23D93
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5C14C5A3;
	Mon, 13 May 2024 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SlS1PJw+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6273502
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605426; cv=none; b=ciYnPoe8JYscVP0GttGuwuNcSYOq7R8woHQkqTsESpT1T9BtXXFsEB5v147a/NbrgjVmSSsIRqkkoCX1apGu4BrOnLWjEo15fE+1+l04pWbmng0CTxme1nscevvkkMaKMqzWNhe85SsnxLeQ756Mf6SK/jYyjLGmfAoMztrK0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605426; c=relaxed/simple;
	bh=BljPCLFN5bvQSGtOEKRZDyvD+r0AnTFB+a1xa84JdhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IhrgZaNbfLa41bGKzQF0xyshBHH6G74TzKwcc1NfK5zDtQ0lLcYxRokrB/rOJxLUwxPs2BjbAl1UHWsv1nNlfE2D+fvnIx8W5jBW8v72+cxjZLACkdMWF1ewkiDxZC6kQSOBWTSKerVAnkiiXMUI/To7CW7EBQh6A4uT0VrTPuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SlS1PJw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5A2C32781;
	Mon, 13 May 2024 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715605426;
	bh=BljPCLFN5bvQSGtOEKRZDyvD+r0AnTFB+a1xa84JdhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SlS1PJw+ZEbPsBi0GoKOWL+kz9PN/gI+cj/FfiN9KyQmoLbcJAB9lZunad6Vcq75w
	 G50vKjz7qVhYTEitwbAdiw/TGebtndGYogCJkhYFySvFfRzhdfJUf4cr341U3olWZK
	 1i3zDIkxlAID/aVIMFaxLW+7588IdX9cqqhZ7Ygc=
Date: Mon, 13 May 2024 15:03:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhulei <zhulei@kylinos.cn>
Cc: ap420073@gmail.com, davem@davemloft.net, jbenc@redhat.com,
	sashal@kernel.org, stable@vger.kernel.org
Subject: Re: 4.19 stable kernel crash caused by vxlan testing
Message-ID: <2024051321-fondling-duke-3dfe@gregkh>
References: <2024042356-launch-recapture-4bb1@gregkh>
 <20240507092049.1713953-1-zhulei@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507092049.1713953-1-zhulei@kylinos.cn>

On Tue, May 07, 2024 at 05:20:49PM +0800, zhulei wrote:
> By making the following changes and using our own 4.19 kernel
> verification, we can observe the output that passes the test
> in dmesg.
> 
> When using the 4.19 stable branch kernel for verification, the
> dmesg has no output, which looks more like the test program is not
> running. However, the code of vxlan.c is the same.
> 
> May i ask if the changes made to the maintainer are reasonable?

Why is this only a 4.19.y thing?  Why is this not also relevent for
Linus's current tree?

thanks,

greg k-h

