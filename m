Return-Path: <stable+bounces-75833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D968297531A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 15:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E681C231AD
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F831190047;
	Wed, 11 Sep 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnAPTgOc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DD5188A05;
	Wed, 11 Sep 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059623; cv=none; b=QrnoWkjnHeoVO/e01zwMJIIzX5wtmDhD5pIuh0wg5MTk3lhzMBIVs3T7D0pMvx4qIvWjSDq+4WGpB5uhlWBCjN6BUC3DR0chGuzARnA5CL8I7IA+/MFVcY17z/QQYpO9fi4xEKN/YDA1/vY4m0Eip28t3Nv9xcMjdwGJDeV2VTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059623; c=relaxed/simple;
	bh=pCriNAcMe1ziFoxte4zs2syVGRTisc3DyD/L0FBPWYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/zKvinVmhl/3Z+g9RACSyQAwOhmIpogjcbIbUme5twd4lr+JYkqdPl2/5rHrWFGURgn+k+R5drBo3kBaMGHPqZARcUTMPzP0YBCm+8YsbgbgpqCbyebD8FytH+W+04VEB2ajj6YqegPlLjgAI8DIRYlrtw23p7u/JMEoet/G7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnAPTgOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A04C4CEC7;
	Wed, 11 Sep 2024 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726059622;
	bh=pCriNAcMe1ziFoxte4zs2syVGRTisc3DyD/L0FBPWYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KnAPTgOcQ3KH6ICs0qIbOK2Z0GNRBtViQFgET/RaQacuuLVqHGltUsPTdv9KVN+CT
	 wQDhvz6p6uviEF9/1yWvNCWceoqwHWx5pIYkGaLGRK+YC5RqoBlVdXkLnAhOBJkv/Q
	 KaoIOLtMaYSGjeIlfue2lIZ43FO4FHTu56Cp8opA=
Date: Wed, 11 Sep 2024 15:00:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Richard Narron <richard@aaazen.com>
Cc: Linux stable <stable@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux kernel <linux-kernel@vger.kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH 5.15 000/214] 5.15.167-rc1 review
Message-ID: <2024091103-revivable-dictator-a9da@gregkh>
References: <4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a5321bd-b1f-1832-f0c-cea8694dc5aa@aaazen.com>

On Tue, Sep 10, 2024 at 03:54:18PM -0700, Richard Narron wrote:
> Slackware 15.0 64-bit compiles and runs fine.
> Slackware 15.0 32-bit fails to build and gives the "out of memory" error:
> 
> cc1: out of memory allocating 180705472 bytes after a total of 284454912
> bytes
> ...
> make[4]: *** [scripts/Makefile.build:289:
> drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.ho
> st.o] Error 1
> 
> Patching it with help from Lorenzo Stoakes allows the build to
> run:
> https://lore.kernel.org/lkml/5882b96e-1287-4390-8174-3316d39038ef@lucifer.local/
> 
> And then 32-bit runs fine too.

Great, please help to get that commit merged into Linus's tree and then
I can backport it here.

thanks,

greg k-h

