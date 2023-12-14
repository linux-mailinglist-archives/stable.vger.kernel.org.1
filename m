Return-Path: <stable+bounces-6736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80204812F8A
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 12:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B320B1C21984
	for <lists+stable@lfdr.de>; Thu, 14 Dec 2023 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9A441216;
	Thu, 14 Dec 2023 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HbSVlyDb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C457C3F8EA
	for <stable@vger.kernel.org>; Thu, 14 Dec 2023 11:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2611C433C7;
	Thu, 14 Dec 2023 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702555100;
	bh=XZh9Zr+khmeAEUj6/ZRixvfGqq85P5vPJD88a8XwOC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HbSVlyDbpei7Tnz/b0dalTT/T4Xca2vgPXh/LfbNd/TUda/Y/JqqxU9WO+j+0G8EP
	 58bkeZVAhCfrwAo6/y4NIk/mKA3xbicdsxmB4VP5ENYAQDDP+bTZn4paIZy/9BIHCA
	 HMVRvn/B3XSvMBaLEQi+AYytdMAM8zf8dIqwt/M4=
Date: Thu, 14 Dec 2023 12:58:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steven French <Steven.French@microsoft.com>,
	"paul.gortmaker@windriver.com" <paul.gortmaker@windriver.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH 0/1] RFC: linux-5.15.y ksmbd backport for
 CVE-2023-38431
Message-ID: <2023121439-landowner-glamour-f7ad@gregkh>
References: <20231212184745.2245187-1-paul.gortmaker@windriver.com>
 <2023121241-pope-fragility-edad@gregkh>
 <DM4PR21MB34417B034A9637445C598675E48EA@DM4PR21MB3441.namprd21.prod.outlook.com>
 <2023121350-spearmint-manned-b7b1@gregkh>
 <CAKYAXd9H+-zi5QnGQCD5T8nKkK733O6MPUnPn2_d10OW0Pp_Ww@mail.gmail.com>
 <2023121434-universal-lively-3efa@gregkh>
 <CAKYAXd_CU9qRt8Y2n5n-=tUKPPHBUpiu2sLOp7=bF4=MzPMz4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd_CU9qRt8Y2n5n-=tUKPPHBUpiu2sLOp7=bF4=MzPMz4w@mail.gmail.com>

On Thu, Dec 14, 2023 at 08:33:48PM +0900, Namjae Jeon wrote:
> 2023-12-14 17:05 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> > On Thu, Dec 14, 2023 at 08:31:44AM +0900, Namjae Jeon wrote:
> >> 2023-12-13 23:36 GMT+09:00, Greg KH <gregkh@linuxfoundation.org>:
> >> > On Tue, Dec 12, 2023 at 08:13:37PM +0000, Steven French wrote:
> >> >> Out of curiosity, has there been an alternative approach for some
> >> >> backports, where someone backports most fixes and features (and safe
> >> >> cleanup) but does not backport any of the changesets which have
> >> >> dependencies outside the module (e.g. VFS changes, netfs or mm changes
> >> >> etc.)  to reduce patch dependency risk (ie 70-80% backport instead of
> >> >> the typical 10-20% that are picked up by stable)?
> >> >>
> >> >> For example, we (on the client) ran into issues with 5.15 kernel (for
> >> >> the client) missing so many important fixes and features (and
> >> >> sometimes hard to distinguish when a new feature is also a 'fix') that
> >> >> I did a "full backport" for cifs.ko again a few months ago for 5.15
> >> >> (leaving out about 10% of the patches, those with dependencies or that
> >> >> would be risky).
> >> >
> >> > We did take a "big backport/sync" for io_uring in 5.15.y a while ago,
> >> > so
> >> > there is precident for this.
> >> >
> >> > But really, is anyone even using this feature in 5.15.y anyway?  I
> >> > don't
> >> > know of any major distro using 5.15.y any more, and Android systems
> >> > based on 5.15.y don't use this specific filesystem, so what is left?
> >> > Can we just mark it broken and be done with it?
> >> As I know, ksmbd is enable in 5.15 kernel of some distros(opensuse,
> >> ubuntu, etc) except redhat.
> >
> > But do any of them actually use the 5.15.y kernel tree and take updates
> > from there?  That's the key thing here.
> Yes, openWRT guy said that openWRT use ksmbd module of stable 5.15.y
> kernel for their NAS function.
> The most recent major release, 23.05.x, uses the 5.15 kernel, and the
> kernel version is updated in minor releases.
> https://github.com/openwrt/openwrt/commit/95ebd609ae7bdcdb48c74ad93d747f24c94d4a07
> 
> https://downloads.openwrt.org/releases/23.05.2/targets/x86/64/kmods/5.15.137-1-47964456485559d992fe6f536131fc64/
> 
> https://downloads.openwrt.org/releases/23.05.2/targets/x86/64/kmods/5.15.137-1-47964456485559d992fe6f536131fc64/kmod-fs-ksmbd_5.15.137-1_x86_64.ipk
> 
> https://github.com/openwrt/openwrt/blob/fcf08d9db6a50a3ca6f0b64d105d975ab896cc35/package/kernel/linux/modules/fs.mk#L349

Ok, thanks, that's good to know.  Also you might want to warn them that
it's missing loads of security fixes at this point in time and that they
might want to move to a newer kernel release :)

thanks,

greg k-h

