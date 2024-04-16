Return-Path: <stable+bounces-39984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B18A6277
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 06:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF56D1F21800
	for <lists+stable@lfdr.de>; Tue, 16 Apr 2024 04:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B2B1EB48;
	Tue, 16 Apr 2024 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EPoxxBkD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BC312E4A
	for <stable@vger.kernel.org>; Tue, 16 Apr 2024 04:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713242254; cv=none; b=pGYQTToBDdaixQq4232KvhBhjbwsvxPsCWDn7H4EUTDnOI3Gty2Jq208aiJYv6RoGrejfs2yUtpbtIoL5IIRjPhLFWBWW+9daT3qYMf4KIDsXiRkjbDElsSl4SPYoixzrNd107ujolm7p4KObXTSQV7Nt60iANAmuzOHQKxo4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713242254; c=relaxed/simple;
	bh=C0O3RnJdDSKQClrWwdB9Rw5TFO52OxrKJMnBKekmWI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GuU/qvwEVmQd9drpaFlTjTmrHWZrJ01iJr6BMCpWkoiRA73zBVeXiCAVAps4ev/mRfR+uJK2kxQoXdWX30ZnGGBLSDdzgTxw7yb4Nfu84NuRVM9t8E41iW/8F0zZnOARlWqPKj71tznh3o+5z2IbhjsB1JC3cD6p9Ej2yf/+oLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EPoxxBkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D00C113CE;
	Tue, 16 Apr 2024 04:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713242253;
	bh=C0O3RnJdDSKQClrWwdB9Rw5TFO52OxrKJMnBKekmWI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPoxxBkDW9qYsb/J7blZySQfxR+XWalggQ/+05aFLjbF70m6rWOEu2VcAJfqN3GtZ
	 jLW+hnI7a9bXFLyqhELEeJ0C69eSEhCsFK0FiMyWCMUDCscgGP9UZA6vEaXsXVxP9w
	 65S3OnPohbOUiHdcb6P+anogXtaLjUKxrFIJL5Ug=
Date: Tue, 16 Apr 2024 06:37:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: dcrady@os.amperecomputing.com
Cc: stable@vger.kernel.org
Subject: Re: v5.15+ backport request
Message-ID: <2024041608-unnatural-bullpen-b38e@gregkh>
References: <20240416034626.163580-1-dcrady@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416034626.163580-1-dcrady@os.amperecomputing.com>

On Mon, Apr 15, 2024 at 08:46:26PM -0700, dcrady@os.amperecomputing.com wrote:
> Please backport the following v6.7 commit:
> 
> commit be097997a273 ("KVM: arm64: Always invalidate TLB for stage-2 permission faults")
> 
> to stable kernels v5.15 and newer to fix:

Any specific reason you didn't cc: the maintainers and developers of
that change with this request?

thanks,

greg k-h

