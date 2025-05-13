Return-Path: <stable+bounces-144130-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F4AB4DCC
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 10:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E8219E7519
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCA91F866A;
	Tue, 13 May 2025 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtkuE2W5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485CF1F584E;
	Tue, 13 May 2025 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124035; cv=none; b=O/lcc1cd7L4ce4oLf9oyh1O39eZa0XDQnvCVOQB6QWr7kvPr5IijSzJsCsd85YgRjQOaIZEdZusFxkzx/a2DGAPxSVhSE7VL+TFLokYlskelRpLC5oCTlqjdngzPcIQHXi3vuf2GCRv6GbaC8ygJxj7jCsT8hjsSIDff8/VHt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124035; c=relaxed/simple;
	bh=Fsnar5Saf9YVtCR9YVLgKpt0ezeA3V+SxIoKJKk2c+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y79vBzOCneA8D3UUSIJONIn+PbRVYt5cCjam4m746wmMzXz8/GTqqSBnPG0Y2kt6NmGGlKaFleDNhyQFIE9NC9k/PlvsnxUNrRUBMSR5+DUaURrRAbatMqdJTOjBuAO7UC64/uK/JyoDgt/DOIbvdDpXcNrv0bYg0XtMgcwMdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtkuE2W5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884EFC4CEED;
	Tue, 13 May 2025 08:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747124035;
	bh=Fsnar5Saf9YVtCR9YVLgKpt0ezeA3V+SxIoKJKk2c+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtkuE2W5F+P54vm0rBJHZVhtrgeVVz1p1tLjaR6ErA1Xjh11YCw98KE8vcg3F2SaS
	 yYSCExW/9I2+QzI9QmVb69TU/dR/7syevr+v4oWnenJIllIcZfCFi57NUc273lxXR1
	 615+JGMQOW/nuKKp8GMBCmTHkVjuWgyZK+v3fmBk=
Date: Tue, 13 May 2025 10:12:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Sasha Levin <sashal@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org,
	loongarch@lists.linux.dev, Haiyong Sun <sunhaiyong@loongson.cn>
Subject: Re: [PATCH for 6.1/6.6] LoongArch: Explicitly specify code model in
 Makefile
Message-ID: <2025051359-impurity-landmine-2f6a@gregkh>
References: <20250513080645.252607-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513080645.252607-1-chenhuacai@loongson.cn>

On Tue, May 13, 2025 at 04:06:45PM +0800, Huacai Chen wrote:
> LoongArch's toolchain may change the default code model from normal to
> medium. This is unnecessary for kernel, and generates some relocations
> which cannot be handled by the module loader. So explicitly specify the
> code model to normal in Makefile (for Rust 'normal' is 'small').
> 
> Cc: stable@vger.kernel.org
> Tested-by: Haiyong Sun <sunhaiyong@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> We may use new toolchain to build 6.1/6.6 LTS, backport it to avoid
> problems.

What is the upstream git id for this commit?

