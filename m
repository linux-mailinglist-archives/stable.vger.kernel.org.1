Return-Path: <stable+bounces-93649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFD89CFF61
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 15:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68EF21F21DEE
	for <lists+stable@lfdr.de>; Sat, 16 Nov 2024 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BA7182BC;
	Sat, 16 Nov 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EgmNKDNg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2945617597
	for <stable@vger.kernel.org>; Sat, 16 Nov 2024 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768704; cv=none; b=KfaLwV1MmQhqs6GCjGB19fHHneDc3QDAojvJBUKqHQ8QNBJ0UN/xGr2VbNpAWJabfKPFe8dvX3fZXULMFJK43QQmszC5iBIQ+8vKa2iSwRTR2fvEUVra0W60idLv7ItIK7qQfpa6n/elZGgoRYb7ATOvErjcE27uCwb8XPKJzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768704; c=relaxed/simple;
	bh=IK1sF2MLVR1kps5RVm+P22WWfxnqOtsqNq1AeN8amtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6Vilo2UPjhu/KrlYcp/NHI5DXnxepc3Jrl/9IBlbwCs8mIUbhWF3MRQ1A3ItvYNvM2ynghdP3qCpQqcXBOKFACUz3P7puihq6dq1r5MfpcxalNIb2NX+NkYB/L5yC5tbBNl7JMN8S7FZMI9TyTGyuPRSvcnLXdvyXxbeL4g/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EgmNKDNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBBBC4CEC3;
	Sat, 16 Nov 2024 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731768703;
	bh=IK1sF2MLVR1kps5RVm+P22WWfxnqOtsqNq1AeN8amtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgmNKDNgH1J0Uz0OJRq4N74sOEZd9GMmOS33/ELk7+njcXKS+7MQiwE6LBn3nLbrd
	 myUtns6hLpvXrzEt8NnLi9ymPyWgJZEtvRuYiZaEZDrRSXgUQCMCHunTIKvleaLMLR
	 4+LkL9tVOGj+o8nq2xh9CJILqTLjmbwK7SQnilpA=
Date: Sat, 16 Nov 2024 15:51:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] Revert "drm/amd/pm: correct the workload setting"
Message-ID: <2024111653-storm-haste-2272@gregkh>
References: <20241116130427.1688714-1-alexander.deucher@amd.com>
 <2024111614-conjoined-purity-5dcb@gregkh>
 <CADnq5_PkG8JywBPj5mivspUPJUC6chEGuNEH5a1_A-FCd_8wog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PkG8JywBPj5mivspUPJUC6chEGuNEH5a1_A-FCd_8wog@mail.gmail.com>

On Sat, Nov 16, 2024 at 08:48:58AM -0500, Alex Deucher wrote:
> On Sat, Nov 16, 2024 at 8:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Nov 16, 2024 at 08:04:27AM -0500, Alex Deucher wrote:
> > > This reverts commit 4a18810d0b6fb2b853b75d21117040a783f2ab66.
> > >
> > > This causes a regression in the workload selection.
> > > A more extensive fix is being worked on for mainline.
> > > For stable, revert.
> >
> > Why is this not reverted in Linus's tree too?  Why is this only for a
> > stable tree?  Why can't we take what will be in 6.12?
> 
> I'm about to send out the patch for 6.12 as well, but I want to make
> sure it gets into 6.11 before it's EOL.

If 6.11 is EOL, there's no need to worry about it :)

I'd much prefer to take the real patch please.

thanks,

greg k-h

