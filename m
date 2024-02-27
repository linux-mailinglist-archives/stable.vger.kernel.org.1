Return-Path: <stable+bounces-23845-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBF5868B45
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 09:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0AC1C21D49
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498F4130E27;
	Tue, 27 Feb 2024 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pou8i58M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05313130AF8
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023934; cv=none; b=If1ZPvlTkWxGqi+tEHoc4FHrMbOwloKyeGWd97zfQztryCrUrtzgiaZRXu65ZMIKP/ee9Pgc0u0r/eHYdyRkeZHDvPQB86BVmHxrj6hwZyZcNpI1O8ZN3xUUQEbw47kTNV2wNSxCgOn/SSKWihg1NI5avgd5LL3YisR5hIum4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023934; c=relaxed/simple;
	bh=P/zwOOotQ6YR93fm0kSQdKSEqh6cRlBcvrRGWaXcZ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qz4YWEOCgLQCQ8P3JlYlMBpZ0nxQadJSkgDlU0lW1C4QNTeseLC/eQZBnKr0fBMTRARjWzOPRwYdW0/g+6eLugVVOxMni6OodwEDc9sEMJRWrXw82+Qkjm1tx3GQJza2BBj7XTLHHrr0AO/oryXkTFduoX33xahJoRhH7AMmZYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pou8i58M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E09BC433C7;
	Tue, 27 Feb 2024 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709023933;
	bh=P/zwOOotQ6YR93fm0kSQdKSEqh6cRlBcvrRGWaXcZ5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pou8i58M+1Pw5lWxythU5IS7tbdLTLyoSKz8oG42AFP1QYeOV6YQkmtArpunzrAkp
	 qKrc+axaoi9YyleWCOAd11sc4jMxZhoWG5q0Z07f6slRroDla0keQODc3lTiJIXNTV
	 Y0jvmfvpFsQWbYB1L6j9Wz5BDLx/iDX4OgfB4Y+8=
Date: Tue, 27 Feb 2024 09:52:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yue Hu <zbestahu@gmail.com>
Cc: stable@vger.kernel.org, hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com,
	Yue Hu <huyue2@coolpad.com>
Subject: Re: [PATCH 6.1.y 1/2] erofs: simplify compression configuration
 parser
Message-ID: <2024022703-skied-tassel-cfc6@gregkh>
References: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5216b503054dbbb9fccf8faa280647c728e82726.1709000322.git.huyue2@coolpad.com>

On Tue, Feb 27, 2024 at 10:22:38AM +0800, Yue Hu wrote:
> From: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> [ Upstream commit efb4fb02cef3ab410b603c8f0e1c67f61d55f542 ]
> 
> Move erofs_load_compr_cfgs() into decompressor.c as well as introduce
> a callback instead of a hard-coded switch for each algorithm for
> simplicity.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Link: https://lore.kernel.org/r/20231022130957.11398-1-xiang@kernel.org
> Stable-dep-of: 118a8cf504d7 ("erofs: fix inconsistent per-file compression format")
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---

Both queued up, thanks.

greg k-h

