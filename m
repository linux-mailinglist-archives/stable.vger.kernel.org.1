Return-Path: <stable+bounces-136999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DEE7AA0389
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 08:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E9C3A6C7C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 06:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89837274FE3;
	Tue, 29 Apr 2025 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b35z8SIu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868B21A449
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 06:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908745; cv=none; b=eOjKzpuoXDv42LBAPRvygScyXMshT+43XmC5Ni0BPlFE7rQgxX8RUamOp5GDXT47DrX92QJKyccmmcaNaYEWe4dPTyC+UNmHhwAbJS9nO7uYl9Xykv2uqTQ08jir9LX9+8K5k9AVuURwgg0O/VAHps2nvqP1VvMXxY6wHRUHsNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908745; c=relaxed/simple;
	bh=Ee8kzLF/lOK4ZuvzA+A+EvNhYy3AF7W/HvmiljF0Y2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gS3FtY5rtQYFYyMZ2q2Hj3PYbgi68CDDf0tuIswMHidtAcscl+H985/jH4UFbVW9sF+9P0gTBJBUq8t9GL6BB26s7aVko2oRvZvsB/gRTkWdubp+3Kmd/3PKs6HwWtHTf3XGr6e51AL0WTmLmD9HVyPIAMo0tPM2VpckV9jJM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b35z8SIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D299C4CEED;
	Tue, 29 Apr 2025 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745908744;
	bh=Ee8kzLF/lOK4ZuvzA+A+EvNhYy3AF7W/HvmiljF0Y2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b35z8SIuv12e3+/hfzcSsDIVQxSEqs4JXEPbuLPZzBFQ+gWWq87N80UwVDfzjZfAu
	 nDbclXAzWzbvpQEti2/kXhkPSOtnfYUCHJHe+pI5/b7IddzpgnVknRJSX0qyJqFx+W
	 3ojTDhpWcTN+0q82tylg3F+ExQ0mu2GKkUwooCxY=
Date: Tue, 29 Apr 2025 08:39:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Cc: stable@vger.kernel.org
Subject: Re: Patch "x86/Kconfig: Make CONFIG_PCI_CNB20LE_QUIRK depend on
 X86_32" has been added to the 6.14-stable tree
Message-ID: <2025042952-cohesive-seismic-99a0@gregkh>
References: <20250429014148.400200-1-sashal@kernel.org>
 <76952D8A-500F-491B-9565-C8EB12BDA897@o2.pl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76952D8A-500F-491B-9565-C8EB12BDA897@o2.pl>

On Tue, Apr 29, 2025 at 07:38:25AM +0200, Mateusz Jończyk wrote:
> Dnia 29 kwietnia 2025 03:41:48 CEST, Sasha Levin <sashal@kernel.org> napisał/a:
> >This is a note to let you know that I've just added the patch titled
> >
> >    x86/Kconfig: Make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
> >
> >to the 6.14-stable tree which can be found at:
> >    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> >The filename of the patch is:
> >     x86-kconfig-make-config_pci_cnb20le_quirk-depend-on-.patch
> >and it can be found in the queue-6.14 subdirectory.
> >
> >If you, or anyone else, feels it should not be added to the stable tree,
> >please let <stable@vger.kernel.org> know about it.
> 
> Hello, 
> 
> I'd like to ask that this patch be dropped from the stable queues (for 6.14 and earlier kernels). It does not fix
> anything important, it is just for convenience - to
> hide this one option from amd64 kernel Kconfig.

Ok, now dropped from everywhere, thanks.

greg k-h

