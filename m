Return-Path: <stable+bounces-7871-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA61B81828D
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 08:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0841C23759
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF67D2F5;
	Tue, 19 Dec 2023 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vix4UM4K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4C1C8E0;
	Tue, 19 Dec 2023 07:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3181CC433C9;
	Tue, 19 Dec 2023 07:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702972075;
	bh=suh4AXSi8d5iYNnCmBhM0pnl6PZKlRCdwlXfa4237Zk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vix4UM4K5ntZfOl2tEX0iC8d6qKYgJJcqRldSLLe0Ie6tckWWMfFiutjRjHmr8AgT
	 dhpCN6hFBngCJoP/W1G29TlWr5ibereYSj3MJRQNppWoHtc6Ez+s85MF952UocDPif
	 y+na44gURY8ZsZWlZ1B8fO3ikOkAFZ9paDuh/hVU=
Date: Tue, 19 Dec 2023 08:47:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steve French <sfrench@samba.org>, Hyunchul Lee <hyc.lee@gmail.com>,
	linux-cifs@vger.kernel.org
Subject: Re: [PATCH 5.15 80/83] ksmbd: Mark as BROKEN in the 5.15.y kernel
Message-ID: <2023121933-bunkhouse-snack-8ae5@gregkh>
References: <20231218135049.738602288@linuxfoundation.org>
 <20231218135053.258325456@linuxfoundation.org>
 <CAKYAXd952=Y54gwM4KBDca52ZFcg+yjJeuiy+6o3jG+zYYUF1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd952=Y54gwM4KBDca52ZFcg+yjJeuiy+6o3jG+zYYUF1w@mail.gmail.com>

On Tue, Dec 19, 2023 at 12:54:25AM +0900, Namjae Jeon wrote:
> 2023-12-18 22:52 GMT+09:00, Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> > 5.15-stable review patch.  If anyone has any objections, please let me
> > know.
> Hi Greg,
> 
> It took some time as there were a lot of backport patches and testing,
> but I just sent the patchset to you and stable list. Could you please
> remove this patch in your queue ?

Now dropped, thanks.  I'll look at your backports after this round of
stable releases happen in a day or so, thanks.

greg k-h

