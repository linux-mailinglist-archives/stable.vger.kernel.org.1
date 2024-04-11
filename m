Return-Path: <stable+bounces-38066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C292C8A0A81
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 09:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9742831A4
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF0613E413;
	Thu, 11 Apr 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBmRtBrb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF6D524A
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 07:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712821784; cv=none; b=CyFIfmhTDr7ATGVV3/1eNhQpDapameeBBpIivFplKzuGfsKthMU76/QHiYkXi/zR5s30Kx36DBjamySJcXE0mCU2i18EZjjXDEQ+N07TtGUv2iGmwuNhaEGlX6N5wy+a6Tvpw0j2BF7FimltpCmNBAJobfxcDObJVJr31OwLCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712821784; c=relaxed/simple;
	bh=q7VXHts8tfT2R1a9r+72tku88CneQPbzK+v2G4Abs/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=offZucysY3zuWAFnDnfuMr2/u8RukCBOVYww+6n3lnWM+akmqZhdTvufODJHHUkryvI2eSfu6DAswPg4HREUmXAA/+RBA+jyYEOcHXMlIhMhdC5iPK0gGeCIIQvOzZZC038ux7DCjww2OqvUz74hRXhOidDtNN4ap0Feg/fqR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBmRtBrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F94C433C7;
	Thu, 11 Apr 2024 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712821783;
	bh=q7VXHts8tfT2R1a9r+72tku88CneQPbzK+v2G4Abs/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XBmRtBrbLtlxQ6wL8CeIvumNKxsWWDM5eOg6QHx31lx4SL4nzg9lIThPyaN0m+b1C
	 7z/ag3yDiN7rPkdbrGgR4ZtpVfMeuwyahAH3jtJ+nR23pC5F+O9bquokuola8zeyxT
	 j+xZS5NI9GLxPryCYc5BtC9D8gnUFg9g6Z5HuMBQ=
Date: Thu, 11 Apr 2024 09:49:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Dr. Neal Krawetz" <dr.krawetz@hackerfactor.com>
Subject: Re: Backported patch for linux-5.4
Message-ID: <2024041133-upgrade-copper-45f2@gregkh>
References: <3363d9f7-cdc1-4e5e-a476-45e03f5e9b10@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3363d9f7-cdc1-4e5e-a476-45e03f5e9b10@suse.com>

On Wed, Apr 10, 2024 at 12:00:59PM +0200, Jürgen Groß wrote:
> Hi,
> 
> there has been a report of a failure in a 5.4 based kernel, which has
> been fixed in kernel 5.10 with commit abee7c494d8c41bb388839bccc47e06247f0d7de.
> 
> Please apply the attached backported patch to the stable 5.4 kernel.

Now queued up, thanks.

greg k-h

