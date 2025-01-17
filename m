Return-Path: <stable+bounces-109354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAABFA14E6E
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 12:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36AD77A37BA
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 11:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4092B1FECA2;
	Fri, 17 Jan 2025 11:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XMGjjGEh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7711FE479
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737113043; cv=none; b=Ibb/i8EWp/QT3EmrnZkUz5TAbCpJSdleHwHbNDtfR6lQHI1SILnyvwqh9TkHZpeLHtuPxSpTpEd2NzMiiH9OMPCB9ngIiI+Ps9nqfVGW9txPtOcs2rzBZxQLPkOygHTTe6l34UZp47aUnXzHV9lU2ActAEQEMPDMjySVfId8VZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737113043; c=relaxed/simple;
	bh=Mpgdb55r7B3y3fAk7zqf8DxSHscTAMRNmMenqfRsAAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3JrDclwKo7+fp5CF6rgaBJMdQ4kDhczdbOEMOzSXyhALJXBtYdLOYlOb7LS4bCwC1xno/QZwjKKSq/MXntygOvqGY2BZsL8D/PeBlntobsGMBrY40TNqhtGDEoRBtSdWPdaSUbo5zoLGvLqqxhEeRorx3woQEXJe3cXITPJVX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XMGjjGEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9637C4CEDD;
	Fri, 17 Jan 2025 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737113042;
	bh=Mpgdb55r7B3y3fAk7zqf8DxSHscTAMRNmMenqfRsAAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMGjjGEhe6TVc7hCrLuH2S8UCYUP1KIufs0vi7nOHBxPzud70p5IS1PG/85Yh0pfz
	 8HrKPFBAh1Ou+qFBBjobpXMDS9IO2JQOSq1rwY2wp9bC7Amk0xI7gzq13WjZLQgoaq
	 LmbhaZFcrd/qpL1y7pYK/BGwTT0O+h2tOHCB71J8=
Date: Fri, 17 Jan 2025 12:23:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Terry Tritton <terry.tritton@linaro.org>
Cc: stable <stable@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Verkamp <dverkamp@chromium.org>
Subject: Re: [REGRESSION] Cuttlefish boot issue on lts branches
Message-ID: <2025011740-driller-rendering-e85d@gregkh>
References: <CABeuJB2PdWVaP_8EUe34CJwoVRLuU8tMi6kVkWok5EAxwpiEHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeuJB2PdWVaP_8EUe34CJwoVRLuU8tMi6kVkWok5EAxwpiEHw@mail.gmail.com>

On Fri, Jan 17, 2025 at 11:01:17AM +0000, Terry Tritton wrote:
> Hi all,
> We've seen a regression on several lts branches(at least 5.10,5.15,6.1) causing
> boot issues on cuttlefish/crossvm android emulation on arm64.
> 
> The offending patch is:
>     PCI: Use preserve_config in place of pci_flags
> 
> It looks like this patch was added to stable by AUTOSEL but without the other
> 3 patches in the series:
>     https://lore.kernel.org/all/20240508174138.3630283-1-vidyas@nvidia.com/
> 
> Applying the missing patches resolves the issue but they do not apply cleanly.
> 
> Can we revert this patch on the lts branches?

Sure, can you please send the revert with all of this information so we
get it correct and you get proper credit for finding/fixing it?

thanks,

greg k-h

