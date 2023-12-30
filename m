Return-Path: <stable+bounces-8737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E393382047D
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDC2282178
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 11:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7632920EA;
	Sat, 30 Dec 2023 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0IONXEww"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4042623A5
	for <stable@vger.kernel.org>; Sat, 30 Dec 2023 11:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865C9C433C7;
	Sat, 30 Dec 2023 11:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703934255;
	bh=qCr5eH5B2b2rCHKhppChVF07LCokeTHzHgQlz0HlNsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0IONXEwwWpNyLSAmfNB8HGAylvTUexP/7qBL9jN+GEhMIeF9Y8MekthQpAxpOFN4I
	 Oa8bXZRmqq8yjMa260hQlKJC/3r1R5Bw9Aay6PTlxDUm44m9y3ApaK+sbZNRgEIs7J
	 YaNhq4prkhMjNQWnWZq2SXcpMVezkf7i7YUJWA9w=
Date: Sat, 30 Dec 2023 11:04:12 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sashal@kernel.org, stable@vger.kernel.org, smfrench@gmail.com
Subject: Re: [PATCH v2 5.15.y 0/8] Additional ksmbd backport patches for
 linux-5.15.y
Message-ID: <2023123044-creamer-connected-32d8@gregkh>
References: <20231227102605.4766-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227102605.4766-1-linkinjeon@kernel.org>

On Wed, Dec 27, 2023 at 07:25:57PM +0900, Namjae Jeon wrote:
> These patches are backport patches to support directory(v2) lease and
> additional bug fixes for linux-5.15.y.
> note that 0001 patch add a dependency on cifs ARC4 omitted from
> backporting commit f9929ef6a2a5("ksmbd: add support for key exchange").
> 
> Namjae Jeon (8):
>   ksmbd: have a dependency on cifs ARC4
>   ksmbd: set epoch in create context v2 lease
>   ksmbd: set v2 lease capability
>   ksmbd: downgrade RWH lease caching state to RH for directory
>   ksmbd: send v2 lease break notification for directory
>   ksmbd: lazy v2 lease break on smb2_write()
>   ksmbd: avoid duplicate opinfo_put() call on error of
>     smb21_lease_break_ack()
>   ksmbd: fix wrong allocation size update in smb2_open()a

We can't just take these for 5.15.y, they also need to be in the newer
stable releases as well, right?  Please send patch series for them also
and then we can take these.

thanks,

greg k-h

