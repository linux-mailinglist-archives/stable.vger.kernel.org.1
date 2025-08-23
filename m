Return-Path: <stable+bounces-172576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FFFB32853
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 13:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB1317E13F
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8124C68D;
	Sat, 23 Aug 2025 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BX00ax6+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DEA1DF97F
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 11:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755948161; cv=none; b=B+09HXUavpx+fXLfHtjYtsbCYn9rXOMd9JfDYLL02CnSxO2LldCqStOXE1Al28w5+xzNxH72j7ce/DZRrA+jo4u/+JiZBKD9LMmff6sukHgIwiEPoCsq74JNuIwkHT9vXYY85+Rl+RUKaUizbkfV5VeAdS/XSewqj2PqnYiNdn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755948161; c=relaxed/simple;
	bh=JYhNV2hEH5FJ/Vnhd5PfHVoJSuPT1J9awWcd6bp6BpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gw0tqyIv5ckpwcbMQojH0wChGEw1mewDrqlksoVwKGGnCk9efBb/3qVclmc+JUiGJnr70YpPkATUnSXSnj3Jz1vnlIZAlrfNvF+j+tH78Gyao8Rsq8dhL/hhP4zxE8gtpURbW7KY57k9u+/qXzbWdZqxlgMg9h6/s8ScmrmgcFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BX00ax6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1851C4CEE7;
	Sat, 23 Aug 2025 11:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755948161;
	bh=JYhNV2hEH5FJ/Vnhd5PfHVoJSuPT1J9awWcd6bp6BpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BX00ax6+7tkB+Da03F/+v0TExHOyEbrLwcgYUDhPm5Qlk6261+s0SjvpiFvZ15008
	 6EbHuPKhJTjLajV2fZTJJ+p+ypV8g9FULbo+Im6Gd4aamq9fi8n7rccVXozo+NfMd+
	 qtf7Td6S59hFdtZH8NGkEXzNpYirFD/VzhmwMQS4=
Date: Sat, 23 Aug 2025 13:22:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Igor Pylypiv <ipylypiv@google.com>
Cc: stable@vger.kernel.org
Subject: Re: Backport "scsi: core: Fix command pass through retry regression"
 to linux-6.12.y
Message-ID: <2025082324-sympathy-sporting-fe38@gregkh>
References: <aKkJsOJMKzOT-kqu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKkJsOJMKzOT-kqu@google.com>

On Fri, Aug 22, 2025 at 05:22:08PM -0700, Igor Pylypiv wrote:
> Please backport commit 8604f633f5937 ("scsi: core: Fix command
> pass through retry regression") to linux-6.12.y. The patch fixes
> a performance regression for many SCSI devices. Without the fix,
> SCSI layer needlessly retries pass through commands that completed
> successfully.

Now queued up, thanks.

greg k-h

