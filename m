Return-Path: <stable+bounces-183189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E55BB6D0C
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332A04861D3
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157511C5496;
	Fri,  3 Oct 2025 13:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LKBHFc/J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667A1C860E
	for <stable@vger.kernel.org>; Fri,  3 Oct 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759496576; cv=none; b=I03j5ttLTM2yKZ6rsbDpwvw8Hhk6QgXfREi0LhZEnTIS0PBhlH8hCoT9CaKNOckakmr9wYMpwYCA1vpSFjq/WVsZUJls44gOE1NX5j49EiLV72kY6a9FgD4eQ+NgmjDcbmHZFxhFJUG/gflzbXh/gjyfcZ2bsU84+LhB9zDZL4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759496576; c=relaxed/simple;
	bh=bhy56jhfHPDN4BIKClhyIeFyatUDKehSjv+mZRNGr3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXkZIziN9Clmu9jjAC043OA7H1OWCwNxpbNZ+fqbD90EhQpgDaidKVQTPKEusR9SBgwky6Y68obaElwbRJO6JEkVmH9pD5/9Tq/L7EEPX5C5xvGxYisGCmDUwFcK5Ku3Dd3STtHt6p2C1GDE1GHsP/XOFuvAejA6s5lJHnOndxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LKBHFc/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4EFC4CEF5;
	Fri,  3 Oct 2025 13:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759496576;
	bh=bhy56jhfHPDN4BIKClhyIeFyatUDKehSjv+mZRNGr3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKBHFc/JYEPWOrm6UJDtiPQhh6RhRCyy9uKj3u+Z+K1A97DXLCvPVmKVlhMgmNeww
	 NVbUzqCEtUbnRsxjfAgYe/HwGuYKB+VAoEJLv1PBlToFA7xmEcNG+ISt0Xjp/RF1Qn
	 gftPNdOhVfk1ZtTXLo6+eLCSv3c4VHOfpKP10f+w=
Date: Fri, 3 Oct 2025 15:02:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: Please backport commit a40282dd3c48 ("gcc-plugins: Remove
 TODO_verify_il for GCC >= 16")
Message-ID: <2025100338-produce-disagree-69f2@gregkh>
References: <202510010810.7948CD9@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202510010810.7948CD9@keescook>

On Wed, Oct 01, 2025 at 08:10:58AM -0700, Kees Cook wrote:
> Hi,
> 
> Please backport:
> 
>   commit a40282dd3c48 ("gcc-plugins: Remove TODO_verify_il for GCC >= 16")
> 
> to all stable kernel versions. This prepares the GCC plugins for the
> coming GCC 16 release.

Now queued up for 6.1 and newer trees, it didn't apply to 5.15 and
older.

thanks,

greg k-h

