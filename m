Return-Path: <stable+bounces-58213-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CDE92A2F4
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 14:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8829A1F22038
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD28811FF;
	Mon,  8 Jul 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fex7LepN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F3D80C0B;
	Mon,  8 Jul 2024 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442342; cv=none; b=KtjbCgXYW0egNWNdjPIrKdqnhLVsVPF+KkNIjfZ7YTsHX27gxfxi5Fm/rDlCjXSEQZEI4tcAXfw7dKCwPP5DNmrIJdZwuMa9P4+86+qO91Y0CwzmBoFxZsHvG3Du1HCmsE7glyh4ax6c+u5HHBs7LN3+9Mie68A1oyK6OrTSDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442342; c=relaxed/simple;
	bh=JGV7bUSfLoCZvYabme84m5Sh5sEEsZ/zeuYuKsyy67M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S74q4u3qE/2njR1zTSeJYEj+UpSojWjW8Lyy6IBE0OB+GylWAegyviQOU+qDX+niC5/Gk6hgwlcT+4GKJjW8qfiJ8GzLYxhTkbFEv4ZN04R5g/NWGuAZiZIDmDEcGNNVvrVhieA/MK/Jaq2t3szPBwvj98H3/A6N+fEmASrOg3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fex7LepN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6FAC4AF0C;
	Mon,  8 Jul 2024 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720442342;
	bh=JGV7bUSfLoCZvYabme84m5Sh5sEEsZ/zeuYuKsyy67M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fex7LepNRH9ZPkhUp2l+zeXLrPJ7/cQ50hqrsvhcAAyiz8NwJHN3N1TQfCthTyuXs
	 T2or67YPLC0n9Lp3n0Tps/jI/gmr2QiaOc1q+uRbpvGUjLEJ0H6z+Rl3fezKMLYJT9
	 54qInBg9rvCXqHs7l2/CbUNmUhtcqp7Z/xZr6zs4=
Date: Mon, 8 Jul 2024 14:38:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: stable@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Subject: Re: [PATCH 4.19] Bluetooth: Fix incorrect pointer arithmatic in
 ext_adv_report_evt
Message-ID: <2024070849-goldsmith-policy-36c9@gregkh>
References: <20240705100106.25403-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705100106.25403-1-guanwentao@uniontech.com>

On Fri, Jul 05, 2024 at 06:01:06PM +0800, Wentao Guan wrote:
> From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
> 
> Please apply the upstream commit:
> commit cd9151b618da ("Bluetooth: Fix incorrect pointer arithmatic in ext_adv_report_evt")
>  
> Solved kernel BT Err  "Bluetooth: Unknown advertising packet type: 0x100"

Now queued up, thanks!

greg k-h

