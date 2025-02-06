Return-Path: <stable+bounces-114102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C28A2AB3F
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 15:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FCFF7A477D
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 14:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C7F21CFF7;
	Thu,  6 Feb 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xoVIwM3Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6921C9E1;
	Thu,  6 Feb 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738852056; cv=none; b=JNgETraguv5sNrnN+M3PoJ5pASWJbzxF+oSRTTzrZILXCpfZdVZ0y8ni6tscNpzM3DIbS7L7EbgqJZR7ALJDIKgOVJi2Fmia/8zFG0FfPmMD3E7aI1COC9OEOGcDYmgUovglGUUB1wmVrYKx6Z0b99ffcrwdqH2VvTY1XG6pCF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738852056; c=relaxed/simple;
	bh=7A7DVGgIt1VxVEInxFfe5J3EMYqK7KEeySMt5M0JSYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNLjJ86VFrilUzeJqXT5jnZsA4NVNu+cZ0arUSaSc9nnY6NE7c4khE6V8KUhwSeHSwDVSxphdeI9tuuVwtwdGb7JtyFm1RexeE1cH1wVb6m78zq4VNLa42657jdqEblzLXaRz5nI2HpFvCDQhQVwdIiFZuQFAF19su/ujp3jz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xoVIwM3Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CC0C4CEDD;
	Thu,  6 Feb 2025 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738852056;
	bh=7A7DVGgIt1VxVEInxFfe5J3EMYqK7KEeySMt5M0JSYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xoVIwM3YRbkid6rD8u0a7X0cpFueQOPV/Gx/1Nj+qUOrmH1J63TjyD9LtPnf+PbWG
	 /byqh1o3R/G5mSXXUj4nQcVsgJPNBs/WEUV4f0WaIuUhY7VrNUG8gxXQ0dN4RRLmig
	 IR9Bj1qiQOtDCYT/brs+AW1uNTO3UO4qMUWyvaLQ=
Date: Thu, 6 Feb 2025 04:54:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: sashal@kernel.org, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Patch "hostfs: convert hostfs to use the new mount API" has been
 added to the 6.6-stable tree
Message-ID: <2025020654-worst-numbness-ca31@gregkh>
References: <20250203162734.2179532-1-sashal@kernel.org>
 <e71dbfcd-317e-43b0-8e67-2a7ea3510281@huawei.com>
 <2025020534-family-upgrade-20fb@gregkh>
 <52c4c9a3-73a8-40df-ab37-e15b2f4f8496@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52c4c9a3-73a8-40df-ab37-e15b2f4f8496@huawei.com>

On Thu, Feb 06, 2025 at 09:09:17AM +0800, Hongbo Li wrote:
> Well, by the way, is the patch added because there are use cases for the new
> mount API in hostfs?

I am sorry, I don't understand the question.

greg k-h

