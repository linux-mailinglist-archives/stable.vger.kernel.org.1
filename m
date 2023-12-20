Return-Path: <stable+bounces-7982-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F269781A167
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 15:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9234F1F22F11
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 14:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312C23C07B;
	Wed, 20 Dec 2023 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g0nKqWSY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15E43D960
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 14:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 240EAC433C9;
	Wed, 20 Dec 2023 14:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703083674;
	bh=+WwgLQB3v/ngwwCDgMSp5Awgf/vC3Z7RAAx+tWmS2VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g0nKqWSYlFDn89QCRpWPwgPGIvdwVDtU8944P5y7LM/mE8afdRCk+FC4HCOqocX0/
	 kQPK/iBimUF5JXNa4F/Eh8xVuIkpXspsl47yvZahVSkfMaeT5zl8vyBrZUsjj13wmT
	 +K6jBmSI0XfBQhjySSYRP7TGPfu+liaxHR3Md42s=
Date: Wed, 20 Dec 2023 15:47:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Francis Laniel <flaniel@linux.microsoft.com>
Cc: stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH 5.15.y v2 1/2] kallsyms: Make kallsyms_on_each_symbol
 generally available
Message-ID: <2023122042-jacket-gnat-f1f0@gregkh>
References: <20231205185749.130183-1-flaniel@linux.microsoft.com>
 <20231205185749.130183-2-flaniel@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205185749.130183-2-flaniel@linux.microsoft.com>

On Tue, Dec 05, 2023 at 07:57:48PM +0100, Francis Laniel wrote:
> From: Jiri Olsa <jolsa@kernel.org>
> 
> Commit d721def7392a7348ffb9f3583b264239cbd3702c upstream.

This is already in the 5.15.143 release.

thanks,

greg k-h

