Return-Path: <stable+bounces-195481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39446C782FA
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 10:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B15084EA9D7
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 09:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECA7339B53;
	Fri, 21 Nov 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hnTNaKOy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60323EAAB;
	Fri, 21 Nov 2025 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763717817; cv=none; b=a3rAlgisNe25yjTh/Xzz+ZQVKdF4JW77hO2+UOvLEoPv8lJxCAHMFHvrimx5ViUtyEbZS98aspKVArax4MiRZPzQVveiJnq9lRWZeakUJpS6mZjXyMDpFPa3zhnxcyBtaMA5Aeu4N0nT7lCpgJwvxoM8dZ07ankV5Vx5RCF45cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763717817; c=relaxed/simple;
	bh=XxKwOaJI9JKbXq3me/g2d7eNwLAnQ4XZyW1Eo06ZvS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6upqImd5wVDMeTriHPcnTbx/6AA2MF2U4TyMhCkD5o8llMuhSq7kpXYC3wBkXcU578cHSuU0JnVXYYEqWVw0+2VLTVTfPvZIUcuGwi1gccEYZwkmorEe9E5tJ0PO2xOyK1GX9i1P7OV4i/DLln3ub5xEpI9uJjSm/YmOswsEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hnTNaKOy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE560C113D0;
	Fri, 21 Nov 2025 09:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763717817;
	bh=XxKwOaJI9JKbXq3me/g2d7eNwLAnQ4XZyW1Eo06ZvS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnTNaKOyP2p25wbigXj4uq+V3T7gt2HwrGThbH0mc8uR3n7oCtOu3LzLBSM6zZYqh
	 5MbuM4TpEDnOvDUGWmZgtpl3EqnugTgnUBgfqsFkXc+WkGLb1i5c8mhi56JCwFFzQg
	 aKeeGWUU8KTB2rVWrUkK7EFkJrJeRg07uu+kn+i0=
Date: Fri, 21 Nov 2025 10:36:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jari Ruusu <jariruusu@protonmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Zizhi Wo <wozizhi@huaweicloud.com>
Subject: Re: [PATCH 6.12 000/565] 6.12.58-rc1 review
Message-ID: <2025112145-cobbler-reattach-8fb2@gregkh>
References: <zuLBWV-yhJXc0iM4l5T-O63M-kKmI2FlUSVgZl6B3WubvFEHRbBYQyhKsRcK4YyKk_iePF4STJihe7hx5H3KCU2KblG32oXwsxn9tzpTm5w=@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zuLBWV-yhJXc0iM4l5T-O63M-kKmI2FlUSVgZl6B3WubvFEHRbBYQyhKsRcK4YyKk_iePF4STJihe7hx5H3KCU2KblG32oXwsxn9tzpTm5w=@protonmail.com>

On Tue, Nov 11, 2025 at 06:38:21AM +0000, Jari Ruusu wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 6.12.58 release.
> > There are 565 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> [SNIP]
> > Zizhi Wo <wozizhi@huaweicloud.com>
> >     tty/vt: Add missing return value for VT_RESIZE in vt_ioctl()
>  
> Locking seems to be messed up in backport of above mentioned patch.
>  
> That patch is viewable here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?h=queue/6.12&id=884e9ac7361b2a3c3a7a90ffaf541ffc2ded6738
> 
> Upstream uses guard() locking:
> |    case VT_RESIZE:
> |    {
> |        ....
> |        guard(console_lock)();
> |        ^^^^^^^^^^^^^^^^^^^^^-------this generates auto-unlock code
> |        ....
> |        ret = __vc_resize(vc_cons[i].d, cc, ll, true);
> |        if (ret)
> |            return ret;
> |            ^^^^^^^^^^----------this releases console lock
> |        ....
> |        break;    
> |    }
>  
> Older stable branches use old-school locking:
> |    case VT_RESIZE:
> |    {
> |        ....
> |        console_lock();
> |        ....
> |        ret = __vc_resize(vc_cons[i].d, cc, ll, true);
> |        if (ret)
> |            return ret;
> |            ^^^^^^^^^^----------this does not release console lock
> |        ....
> |        console_unlock();
> |        break;
> |    }
>  
> Backporting upstream fixes that use guard() locking to older stable
> branches that use old-school locking need "extra sports".
>  
> Please consider dropping or fixing above mentioned patch.

Can you provide a fixed up patch?

thanks,

greg k-h

