Return-Path: <stable+bounces-45653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555B98CD14D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A1BA1F21DF9
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F224A1482FA;
	Thu, 23 May 2024 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pyEp80TW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91BBA2F;
	Thu, 23 May 2024 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464062; cv=none; b=uJrURL4VyzmNXCD+B4fEjiYY9IlxyOIr9bbFXgWecHo93pC8cDhZk8vaJRd0B5S9v6LLXxzlc8N614+ZIDBMb6YLlkyepXgIb1SKOWA5kqVz+AfntsmZdnG7L+OeYuXBbl2XxY97PqSP5LCJb1P7qafyNmFfLLY1MksswI4AuYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464062; c=relaxed/simple;
	bh=x/F9LRjG86L3igI7XUfcG8NAtYjBAyxlWrjUdapL0ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImVzH5xAqDhYoNRA1f9xyfRXSUCYnA+E8t7PERliOPXVu2e4J9NB72hHmjQLXj355lOEfPHKCwT3AY8MpJtENM7kb354Zdc98GMqM/iG2ot5sbbDUyepBZTzabmD7a9GFYFQSSCS59p81N4tHxOumSn4FRGNFTMAeDq8R22PphY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pyEp80TW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E556AC2BD10;
	Thu, 23 May 2024 11:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716464062;
	bh=x/F9LRjG86L3igI7XUfcG8NAtYjBAyxlWrjUdapL0ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyEp80TWjGEXXzsl7LKL/sF7j4OiR8gs1hAuVpOqVjVeuTO4/kp4xmDeSQApKv1bx
	 JYyfLyKfBA2rhv7AwyvxpxJvf2Vg1V4Hmf/qkLLVInDU2kKts6PZhqz8WHu9UN2gdW
	 lM6mqSGXN7vTkfGjL6Qbr7JP2p+1wzRrqRSL29qI=
Date: Thu, 23 May 2024 13:34:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
	edumazet@google.com, kuniyu@amazon.com, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH stable,5.15 0/2] Revert the patchset for fix
 CVE-2024-26865
Message-ID: <2024052355-doze-implicate-236d@gregkh>
References: <20240506030554.3168143-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506030554.3168143-1-shaozhengchao@huawei.com>

On Mon, May 06, 2024 at 11:05:52AM +0800, Zhengchao Shao wrote:
> There's no "pernet" variable in the struct hashinfo. The "pernet" variable
> is introduced from v6.1-rc1. Revert pre-patch and post-patch.

I do not understand, why are these reverts needed?

How does the code currently build if there is no variable here?

confused,

greg k-h

