Return-Path: <stable+bounces-92784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE149C5956
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 14:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59CB0B2C5FA
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAE41CD214;
	Tue, 12 Nov 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p3DerUou"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950F61CD1FA;
	Tue, 12 Nov 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731413547; cv=none; b=L27vgJan6pg6TbpPX/drPQB++/HSKgUkfDdRtY3rKlUPpEoAMrpPJwCvwrcjeEfdAH6zIUzGQp1Or/tr2FOd6CCcJjgNEbb0fXlOUoqvEyERaxHyb9cuImivlPlKrtkN+M4D2jjmvrJkWWdoRun9LV5qjZ/I4KY7OQkdf8l5vWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731413547; c=relaxed/simple;
	bh=YvMp700/nphoxPDUKYPUHfJW22uH7YXfGxohEWP869o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLMXWGZ78W5rsbhOzR6ctGh25u0MHG++tNaBCEQcpswwGLvPOZ09CJqxgntq2rgTZJiP2Kr/lqc7LU8mXieuAsYKQWxtLiIeNuyIL3xk1y2haSvlXJQCoYwWHgjMZhKh9tFdMyXJyPEaAP59jdhUTeLv7EgNMlETQX5ncEZMWF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p3DerUou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E10C4CECD;
	Tue, 12 Nov 2024 12:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731413547;
	bh=YvMp700/nphoxPDUKYPUHfJW22uH7YXfGxohEWP869o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3DerUouQTmNdNzN+ANiVBScXr1u+eij6ydELtuAd7AmWcZiaeH6ICKkAzdowMpg9
	 Idt9ZgvkgXfZ45KmEs0j2C0s6lwdRoJtTKKlEWYydRnpTH99u+NM7lJci3+1aLiaUS
	 B7+KaExYs4Y+H1krgCpJfCyZfJx1CwrhoTIa++9c=
Date: Tue, 12 Nov 2024 13:12:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Agathe Porte <agathe.porte@canonical.com>
Cc: linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ufs: ufs_sb_private_info: remove unused
 s_{2,3}apb fields
Message-ID: <2024111251-buggy-scarily-38dd@gregkh>
References: <20241112120304.32452-1-agathe.porte@canonical.com>
 <20241112120304.32452-2-agathe.porte@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112120304.32452-2-agathe.porte@canonical.com>

On Tue, Nov 12, 2024 at 01:01:54PM +0100, Agathe Porte wrote:
> These two fields are populated during and stored as a "frequently used
> value" in ufs_fill_super, but are not used afterwards in the driver.
> 
> Moreover, one of the shifts triggers UBSAN: shift-out-of-bounds when
> apbshift is 12 because 12 * 3 = 36 and 1 << 36 does not fit in the 32
> bit integer used to store the value.
> 
> Cc: stable@vger.kernel.org
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2087853

As these values are not used, even if the shift goes off in the wild
it's not needed to backport this as it's not actually causing any
problems.  So I'd drop the cc: stable@ please.

thanks,

greg k-h

