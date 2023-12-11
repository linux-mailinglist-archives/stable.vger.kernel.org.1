Return-Path: <stable+bounces-5348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9004980CAD9
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3026AB20E9C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402EC3E467;
	Mon, 11 Dec 2023 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J6D2zZ4m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0377A3D97E
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 13:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780C7C433C8;
	Mon, 11 Dec 2023 13:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702301012;
	bh=sEaPyIiF/BDNHqPMg6sc0uPH+wDkOZ4nCiFT263O+C4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6D2zZ4m6kKtS2oRwnbxiWYGus2at+4uV0orj5KU/LO5hL59gF83enesmA2502U7L
	 J3LNcQQnQ+V+bNccTq0ysCdL71bA6ii9dTLhEISwQ9vEV83DTMNJ1AwW+8fMiHqtpa
	 o9vUFb6lRsCdNPTkd1UNNUZr8+Bcx+owyj9rLegw=
Date: Mon, 11 Dec 2023 14:23:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: asml.silence@gmail.com, jannh@google.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/af_unix: disable sending
 io_uring over sockets" failed to apply to 5.4-stable tree
Message-ID: <2023121115-neglector-geography-671c@gregkh>
References: <2023120913-cornea-query-b9bf@gregkh>
 <21079c31-f48a-4616-a976-c4421113f5fd@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21079c31-f48a-4616-a976-c4421113f5fd@kernel.dk>

On Sat, Dec 09, 2023 at 09:52:01AM -0700, Jens Axboe wrote:
> On 12/9/23 5:03 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.4-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 705318a99a138c29a512a72c3e0043b3cd7f55f4
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120913-cornea-query-b9bf@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..
> 
> Here's one for 5.4-stable.

All now queued up, thanks.

greg k-h

