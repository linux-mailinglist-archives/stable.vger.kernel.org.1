Return-Path: <stable+bounces-40275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D58AAD03
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 12:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4431C20FB6
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 10:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0E37F487;
	Fri, 19 Apr 2024 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="erKftVLP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EDC7EF1E
	for <stable@vger.kernel.org>; Fri, 19 Apr 2024 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713523481; cv=none; b=PByrARzChQXowP/m1dCnRfTjU8cNSUW4pU6XmK0gXxMr8Gv79A1Nb/PtL5W5gn0kDm4FnDGnUFHtdi5yTRQ3eGXBIcDEv4NCPErV++M893Urg+kJEWfbCO6NTP/xJDqDbammHjmKBTR01o5bEp30+2xD2qQ7d/F012vQw7giJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713523481; c=relaxed/simple;
	bh=4ihvklPWnzK7Oodjh1zTBTNR47ULLNr9beR+rb3Bbrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmXL6g9bsbSG+76O++TVOuzZM1Ko/8M0WUYa6JFBXOjDLFclsV5gliGk24+xrvlzAkHmp8sEtgpjCdl67eVqL4tlKdP/YAeUiuuCubCY30C8/G3XjWqt36PvlfdpbHpUw6h6VTtzto8yCUkyGL+O5yzTglV3ogTDYu2/gjyzQKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=erKftVLP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000C7C072AA;
	Fri, 19 Apr 2024 10:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713523481;
	bh=4ihvklPWnzK7Oodjh1zTBTNR47ULLNr9beR+rb3Bbrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=erKftVLPT1VueRpDBqn2CaHODa5GpOQZX0lj4+IrIalAb3uWqSkoTlehrKPalsBF2
	 RNZQBAxtAS4sS0fCuJ/cm/IwYpMWqHZv8PtPQICHD3WdJzR78l++OznVOF6cPGVyb/
	 BIO4rR4AtLojPm0/kG/EWE4S41AEV+BzyBRuVBl0=
Date: Fri, 19 Apr 2024 12:44:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] Revert "riscv: kdump: fix crashkernel reserving problem
 on RISC-V"
Message-ID: <2024041927-remedial-choking-c548@gregkh>
References: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416085647.14376-1-xingmingzheng@iscas.ac.cn>

On Tue, Apr 16, 2024 at 04:56:47PM +0800, Mingzheng Xing wrote:
> This reverts commit 1d6cd2146c2b58bc91266db1d5d6a5f9632e14c0 which has been
> merged into the mainline commit 39365395046f ("riscv: kdump: use generic
> interface to simplify crashkernel reservation"), but the latter's series of
> patches are not included in the 6.6 branch.
> 
> This will result in the loss of Crash kernel data in /proc/iomem, and kdump
> loading the kernel will also cause an error:
> 
> ```
> Memory for crashkernel is not reserved
> Please reserve memory by passing"crashkernel=Y@X" parameter to kernel
> Then try to loading kdump kernel
> ```
> 
> After revert this patch, verify that it works properly on QEMU riscv.
> 
> Link: https://lore.kernel.org/linux-riscv/ZSiQRDGLZk7lpakE@MiWiFi-R3L-srv
> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> ---

I do not understand, what branch is this for?  Why have you not cc:ed
any of the original developers here?  Why does Linus's tree not have the
same problem?  And the first sentence above does not make much sense as
a 6.6 change is merged into 6.7?

confused,

greg k-h

