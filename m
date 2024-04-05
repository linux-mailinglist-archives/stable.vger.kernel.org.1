Return-Path: <stable+bounces-36018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA2289954C
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE1C1C218F1
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7205B22616;
	Fri,  5 Apr 2024 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h7XVbyij"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F60225AE
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298494; cv=none; b=DMQrVAQxoz9jEh5tFS7HVdfkNnumZLVK2dtghdMRYCQanHWt9/YcDiSopgigMAUBfIf9RvTmWj6zAURUhF1UlzyuvCa4sOC9qgoKPOvNdRDoSfbj4GXFKbd7iFYNz7Yaw90zJpYnsfBbYytOzJGcJL5sIIFgoQ1UpNdCXQoL+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298494; c=relaxed/simple;
	bh=/gPrhrTCkIqyKNtMViJEgX1HFWMRQd20oOpGwza0oSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8gV8ILbrBeylGSQE22GzGivFy8PaQbfE9TYGCP9hnI9AzVRcWuT3MKCSQPBbLNMUOOTBp2vI1e2fp2kuuXEemkoLpn3OzKyPeUkkctfLtvEH2kAlU7hFPR638VZ8J878K4WY5SdmoVg1k0BdHoZ1IQni6UxGp4T9nGkvUXfgAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h7XVbyij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C61C433C7;
	Fri,  5 Apr 2024 06:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298494;
	bh=/gPrhrTCkIqyKNtMViJEgX1HFWMRQd20oOpGwza0oSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h7XVbyijd/QtrhA97KvEhFGLOwZL66VnJDFAriPPhyUIizzxrtDW1dFlNC3BNmx81
	 Xg9VCDEq35jjlB8/C0tG1gjavrCy+RB6GPEwul2183jYWTYYo4oGgNpItd9rGrDEd+
	 pWannAwKu01Cj2WhDUi+VJORMW0YYJoCDZCOpD04=
Date: Fri, 5 Apr 2024 08:28:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de, davem@davemloft.net, kuba@kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com
Subject: Re: [PATCH v4.19-v5.10] netfilter: nf_tables: disallow timeout for
 anonymous sets
Message-ID: <2024040504-saloon-cattail-948d@gregkh>
References: <1712160493-52479-1-git-send-email-keerthanak@vmware.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712160493-52479-1-git-send-email-keerthanak@vmware.com>

On Wed, Apr 03, 2024 at 09:38:13PM +0530, Keerthana K wrote:
> From: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> commit e26d3009efda338f19016df4175f354a9bd0a4ab upstream.
> 
> Never used from userspace, disallow these parameters.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> [Keerthana: code surrounding the patch is different
> because nft_set_desc is not present in v4.19-v5.10]
> Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
> ---
>  net/netfilter/nf_tables_api.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Now queued up, thanks.

greg k-h

