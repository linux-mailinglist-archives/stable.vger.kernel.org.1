Return-Path: <stable+bounces-41812-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7C8B6C44
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 09:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62D3E1F23247
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 07:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D86D3FB87;
	Tue, 30 Apr 2024 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pwoHLqf5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C914AB7
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 07:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463689; cv=none; b=E3dCRDvOBfFcHyYqt37OD1Aj0zAeY/5XGhC1HpogCPRLCY16E4FBiKXAnnXhjMUT5kGEy2kCgwtW+SlbU2xMUh7V+sZavzAJO26+tVDkfW9ckpsBITvwC6x187Vsb/FZmsjFukzXTuD+H6KuaiWAu5Wl+U7mnL3fISDIIV5Kbpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463689; c=relaxed/simple;
	bh=Rr5gx5QtH+zNL5dt9IG0V61YEwuWc+tLoWK8gxxhxZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCttDHzU3cPc0gMmbvsBEpeibKj/pWb3AFsBZ+T+IWC1iDNOOwu0L/nJO3ElW3d6UeLRsZOPQGPq9hR08x7auye88BTY0FAdaLBLIUk0shp6/np2yHP6UnGcm7aLGkzTOg4lwtnT1jX+2cXpv/yhmh7RDXsYz56VboMltCEF+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pwoHLqf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558C0C2BBFC;
	Tue, 30 Apr 2024 07:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714463688;
	bh=Rr5gx5QtH+zNL5dt9IG0V61YEwuWc+tLoWK8gxxhxZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwoHLqf5lI99HnGHPG0PjC+CQ9SkHq4QZ/72kpn+8hKtEideGoPCmBT8ph7Mjt91U
	 3bGU+TTva8LkroO8w8rTdQpbm7sBMMJyo/HnO7vsrv2SLoiuEKWS45Kdkkat1K9PR3
	 o5OITLZ+ObAejjtVP1FHgIoTcvyZ4VcnlB/pb45U=
Date: Tue, 30 Apr 2024 09:54:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc: Baoquan He <bhe@redhat.com>, stable@vger.kernel.org,
	Chen Jiahao <chenjiahao16@huawei.com>
Subject: Re: [PATCH v2] Revert "riscv: kdump: fix crashkernel reserving
 problem on RISC-V"
Message-ID: <2024043037-enroll-polygon-e7eb@gregkh>
References: <20240430032403.19562-1-xingmingzheng@iscas.ac.cn>
 <ZjBoBYwdPMyPDGhG@MiWiFi-R3L-srv>
 <7f976727-3ad8-4071-9a91-4a32a01abd32@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f976727-3ad8-4071-9a91-4a32a01abd32@iscas.ac.cn>

On Tue, Apr 30, 2024 at 11:51:53AM +0800, Mingzheng Xing wrote:
> On 4/30/24 11:39, Baoquan He wrote:
> > On 04/30/24 at 11:24am, Mingzheng Xing wrote:
> >> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which was
> >> mistakenly added into v6.6.y and the commit corresponding to the 'Fixes:'
> >> tag is invalid. For more information, see link [1].
> >>
> >> This will result in the loss of Crashkernel data in /proc/iomem, and kdump
> >> failed:
> >>
> >> ```
> >> Memory for crashkernel is not reserved
> >> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
> >> Then try to loading kdump kernel
> >> ```
> >>
> >> After revert, kdump works fine. Tested on QEMU riscv.
> >>
> >> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv [1]
> >> Cc: Baoquan He <bhe@redhat.com>
> >> Cc: Chen Jiahao <chenjiahao16@huawei.com>
> >> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> > 
> > Ack. This is necessary for v6.6.y stable branch.
> > 
> > Acked-by: Baoquan He <bhe@redhat.com>
> > 
> 
> Thanks,
> 
> Hi, Greg. This is for the 6.6.y branch only.

Thanks, now queued up.

greg k-h

