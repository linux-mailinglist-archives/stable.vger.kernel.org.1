Return-Path: <stable+bounces-47855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE338D7CE7
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 09:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB05AB21D7A
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1835450281;
	Mon,  3 Jun 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0UGoFNTK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B954F8A0;
	Mon,  3 Jun 2024 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401495; cv=none; b=YAoxs11Onq0uwwzXGsbQfF5XMcw7g11hk5EusApXQyaB1vFNsH7+q9ZrsbrV4MMoovdSYV8DV7HtbGc2PabbpQzeyjCpOpCl0CX7B4hv2RE8TAwOzY9xYwCj2rqTWJgKR6pnZsypqK3GWtn35TiIGBmFU9Bh4XH8vXC85RVoSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401495; c=relaxed/simple;
	bh=eh6tut1IJgmad37uAxGyzCMHVLe7YQvVq1+Fct/0RUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7hJ97iO35wl7mMm1Kvtx+B/sma0LrBBFesrEYKwBRs02LrS4kXSevyJEfGnarci5HLDdezyJzRnx8O0MeuVfMg8Xnie/SydhX8YVAsm3v5Bh7yCZA1NOfwatqI8sOxNAdfSS/nMKW8Fdjvwl+1RVjTinylUgD2ninfucUNv/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0UGoFNTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E759C2BD10;
	Mon,  3 Jun 2024 07:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717401495;
	bh=eh6tut1IJgmad37uAxGyzCMHVLe7YQvVq1+Fct/0RUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0UGoFNTKfM8WWJ5xuVy5f5mH0kJxC4HXV+osILnRIzYpkbTi/deYLZ0bcl3QFf21k
	 GerH5YbdCMiI2JEMhAChUUYlveImSterN1d251iemDBrucckIRCfXypCI0aNwVXVip
	 G7UobbL64908L55b247TxUvSJ3c+iKkn4RutQqmk=
Date: Mon, 3 Jun 2024 09:58:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: miquel.raynal@bootlin.com, dwmw2@infradead.org,
	computersforpeace@gmail.com, marek.vasut@gmail.com, vigneshr@ti.com,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH] Documentation: mtd: spinand: macronix: Add support for
 serial NAND flash
Message-ID: <2024060337-relatable-ozone-510e@gregkh>
References: <20240603073953.16399-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603073953.16399-1-linchengming884@gmail.com>

On Mon, Jun 03, 2024 at 03:39:53PM +0800, Cheng Ming Lin wrote:
> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> 
> MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC have been merge into 
> Linux kernel mainline. 

Trailing whitespace :(

> Commit ID: "c374839f9b4475173e536d1eaddff45cb481dbdf".

See the kernel documentation for how to properly reference commits in
changelog messages.

> For SPI-NAND flash support on Linux kernel LTS v5.4.y,
> add SPI-NAND flash MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC in id tables.
> 
> Those five flashes have been validate on Xilinx zynq-picozed board and
> Linux kernel LTS v5.4.y.

What does 5.4.y have to do with the latest mainline tree?  Is this
tested on our latest tree?

thanks,

greg k-h

