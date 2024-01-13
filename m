Return-Path: <stable+bounces-10624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DEB82CAC2
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B2B61C22237
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA9A7F1;
	Sat, 13 Jan 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BpPJqPqc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3057E9
	for <stable@vger.kernel.org>; Sat, 13 Jan 2024 09:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EE6C433C7;
	Sat, 13 Jan 2024 09:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705137650;
	bh=eoAh50uDOvc5tVHD3HgUpikRFOdMxA/7abY3+d3ufRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpPJqPqc08DSof7BVJnaFCEzCjaBfczgGroP+6CWpUseY6xKIEoOKFAnuOTo6GtRf
	 eBQqKv/4y43UVRdvuStld+dpbjAb0Q/+T40/QHAAd3HEqyngkuwv4m10AiR/kD3iss
	 mL0pZ6897GC/bV9o26s6YmhefjunfR9rM74jLxdU=
Date: Sat, 13 Jan 2024 10:19:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suraj Jitindar Singh <surajjs@amazon.com>
Cc: stable@vger.kernel.org, trawets@amazon.com, security@kernel.org,
	Peter Oskolkov <posk@google.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH stable 4.19.x 1/4] net: add a route cache full diagnostic
 message
Message-ID: <2024011350-hence-maternal-70b9@gregkh>
References: <2024011155-gruffly-chunk-e186@gregkh>
 <20240113005308.2422331-1-surajjs@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240113005308.2422331-1-surajjs@amazon.com>

On Fri, Jan 12, 2024 at 04:53:05PM -0800, Suraj Jitindar Singh wrote:
> From: Peter Oskolkov <posk@google.com>
> 
> commit 22c2ad616b74f3de2256b242572ab449d031d941 upstream.
> 
> In some testing scenarios, dst/route cache can fill up so quickly
> that even an explicit GC call occasionally fails to clean it up. This leads
> to sporadically failing calls to dst_alloc and "network unreachable" errors
> to the user, which is confusing.
> 
> This patch adds a diagnostic message to make the cause of the failure
> easier to determine.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
> Cc: <stable@vger.kernel.org> # 4.19.x
> ---
>  net/core/dst.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

All now queued up, thanks.

greg k-h

