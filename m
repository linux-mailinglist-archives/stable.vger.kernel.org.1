Return-Path: <stable+bounces-155160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C41AE1F1A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69960188B235
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577FD2D8791;
	Fri, 20 Jun 2025 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vaHvBMDE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056D82D5427
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434109; cv=none; b=D6RBaOW6wyjHEwTf/HB/Er3PIBRz73v8p0WOAj+krCCejWD3SFl+NrkuCsxLnIGB6rQ8aZ0XYitGukHErrg1w6WC40pjCvWOJhWIBm9If+Hc2W7XWS7y5LfsE6yw6PQh7FohiyrW9zsobrJVP32En7y/ISSyKXejYdq+6WF+hJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434109; c=relaxed/simple;
	bh=ZErKt9CrGjJ7o/P2DO49567cDCdPgDsw03ihINUsxXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrwLZVb2Y8QLSrB96W4Jbuu7oUKXlipMUm26fAK0Mng5YAWxFT5xZ5anmq7CRPpshyn+Gd+K5k6otHcBYQx0n18lYHWDqglzrBa44dWHccDpT7L/MPYkEqJd7/JtFI0WLH74/+RNMwvZPTRCaSGMK1C7GtfChZbbuwAgMSa5R7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vaHvBMDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF19C4CEEF;
	Fri, 20 Jun 2025 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750434108;
	bh=ZErKt9CrGjJ7o/P2DO49567cDCdPgDsw03ihINUsxXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vaHvBMDEk1vl8xjqC3cdg2Fl2hwo3a3ggK8ndZedMilFUcmtdObe34A6UW50th/iE
	 sENQ/0QT8K58shFH98/8uRTOrSBUGoYzLBE3Sd1GkNlgHc//RgJXrA2Rm/UgCXZ6Vs
	 5RVfEpM6X2nx4FxdRx/u7DCkslOJqJUWfm08b9as=
Date: Fri, 20 Jun 2025 17:41:45 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Sebastian Priebe <sebastian.priebe@konplan.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: BLOCK_LEGACY_AUTOLOAD not default y in Linux 5.15.179+
Message-ID: <2025062007-fall-brim-a7ba@gregkh>
References: <ZR0P278MB097497EF6CFD85E72819447E9F70A@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR0P278MB097497EF6CFD85E72819447E9F70A@ZR0P278MB0974.CHEP278.PROD.OUTLOOK.COM>

On Mon, Jun 16, 2025 at 07:28:25AM +0000, Sebastian Priebe wrote:
> Hello,
> 
> we're facing a regression after updating to 5.15.179+.
> I've found that fbdee71bb5d8d054e1bdb5af4c540f2cb86fe296 (block: deprecate autoloading based on dev_t) was merged that disabled autoloading of modules.
> 
> This broke mounting loopback devices on our side.
> 
> Why wasn't 451f0b6f4c44d7b649ae609157b114b71f6d7875 (block: default BLOCK_LEGACY_AUTOLOAD to y) merged, too?
> 
> This commit was merged for 6.1.y, 6.6.y and 6.12y, but not for 5.15.y.
> 
> Please consider merging this for 5.15.y soon.

I'll queue this up now, but note, unless you are starting with a new
fresh .config file, the default value change will probably not be
noticed by 'make oldconfig' so you would probably have still hit this
issue.

thanks,

greg k-h

