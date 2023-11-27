Return-Path: <stable+bounces-2797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7547FA938
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57D4A2817AC
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB66735883;
	Mon, 27 Nov 2023 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CdY+teJ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7831A6E
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 18:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32C3C433C7;
	Mon, 27 Nov 2023 18:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701110864;
	bh=rN+QbSiOLR8JR//8UJq++nkUtJmn8X+tfPS4Dyzkm50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdY+teJ5H1rBE1zWQiMv1E38Rqfqgt4K3kpPk+EuybeLay5USoGwSY28ZeKg6MlMx
	 XQ56cgG1uiOiicbjSSfh5I+rApkA3xyUp5E59YzU7hIzrJgH+LYyfTqsi5XpaAmJEL
	 pUVUbsQEZvnBmHNbNpvjUr02hY2GTqQykxuXNe+A=
Date: Mon, 27 Nov 2023 18:47:41 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] vmci: prevent speculation leaks by sanitizing event in
 event_deliver()
Message-ID: <2023112728-footless-overkill-3732@gregkh>
References: <20231127183745.94955-1-hagarhem@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127183745.94955-1-hagarhem@amazon.com>

On Mon, Nov 27, 2023 at 06:37:45PM +0000, Hagar Gamal Halim Hemdan wrote:
> Coverity spotted that event_msg is controlled by user-space,
> event_msg->event_data.event is passed to event_deliver() and used
> as an index without sanitization.
> 
> This change ensures that the event index is sanitized to mitigate any
> possibility of speculative information leaks.
> 
> Fixes: 1d990201f9bb ("VMCI: event handling implementation")
> 
> Signed-off-by: Hagar Gamal Halim Hemdan <hagarhem@amazon.com>
> ---
>  drivers/misc/vmw_vmci/vmci_event.c | 6 +++++-
:  1 file changed, 5 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

