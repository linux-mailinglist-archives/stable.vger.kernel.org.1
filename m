Return-Path: <stable+bounces-71644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BABA896622E
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 15:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16064B21028
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 13:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14137170A1C;
	Fri, 30 Aug 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VvwMbVrC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5275165F05
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022875; cv=none; b=RQzpvdykc4roFmE+0dk6Pwu038KjC4q7Pg0PK14ovrptj1LDdpKbeim8ZHOLqNWEvpgrSEpPy4dGGbV3nxXuqahLkf8E8JPoKjg4/Y4fnWTV4fHPMtbe5qW+mumuvHh8tugfpGhAbqzjnT/IxdxoR5r1rLnPWr49Lhl82HBo0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022875; c=relaxed/simple;
	bh=kL+HjK6XkYplnJnW7XmyttxpXODnP5HVYUy8sTfq/sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhTfDPA3Zb8LZhbPOa1/PXORVLoDO7Qy7cE2aCrPNNgb1zdHT4lZk7uRmotob/MmdIlMzY4fmGeR9IF2WWFT8dSlsPuGd/RHocd+Naey2Wd3x6KuKxUWXQkPIJbL1fw2AndPk8m8FXyYs8z1DH0HwKd3h8VT0C3/hAJhpgMuqOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VvwMbVrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC08C4CEC2;
	Fri, 30 Aug 2024 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725022875;
	bh=kL+HjK6XkYplnJnW7XmyttxpXODnP5HVYUy8sTfq/sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvwMbVrCjyOI7ot5nug5lJ2PcJJ4rL15xGZvJFb39xB9meTCcV9a5p7Y/+Z9N4oh/
	 GXDMm+lr3BN2cZpyPh+UUFZkYPEGSCv9064hQdB/dXS3OGLDOgcnNtHDbucczR0r4q
	 Xh0uWu3ygT+2076lCcQjsXOTfn+wNIdtjNriBTWM=
Date: Fri, 30 Aug 2024 15:01:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: hsimeliere.opensource@witekio.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 4.19 0/2] Fix CVE-2021-33655
Message-ID: <2024083004-hazy-alright-b538@gregkh>
References: <20240829161419.17800-1-hsimeliere.opensource@witekio.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829161419.17800-1-hsimeliere.opensource@witekio.com>

On Thu, Aug 29, 2024 at 06:14:02PM +0200, hsimeliere.opensource@witekio.com wrote:
> 
> https://nvd.nist.gov/vuln/detail/CVE-2021-33655
> 

Now queued up, thanks.

greg k-h

