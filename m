Return-Path: <stable+bounces-47903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8288FA92E
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 06:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 088EBB2711A
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 04:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE47613D2AA;
	Tue,  4 Jun 2024 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b9LSPfnC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3458ABC;
	Tue,  4 Jun 2024 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717475027; cv=none; b=EkwT7Iu1Aa9OMzOC7bj98739FRpLfZqM32WOnUXJTNIWIVbtxio58ibtCsKlPFEeQxnBsevqh4eNud9swGcW6fvl4d4OLkVV4ORjLhnx6ZDcaLGhg+WztJGlqwukkwsngSj4trqbZIehKj4zXkTBKFI33ijAgG4DgQz103A0sII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717475027; c=relaxed/simple;
	bh=iLd7cgx6ibP4YKhoLDBW15p2SVG5OuLq+YKnI07DV78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAfYoV9ImxjWntYGP5pqzlmxDwRyqUiJjMN1lFx4/APB5zUuUZ9wtmU1y0RsIaIQWOELsOs+ZA1qLC+M6oZRhpkYrh5HpanxdBLOUJdX/5mDo6CuJ/JELihX9ZthfFFunmCaMUF0NTNWlimX7nEssG7hbQya7Jj9alNkU0lBvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b9LSPfnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F7DC2BBFC;
	Tue,  4 Jun 2024 04:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717475027;
	bh=iLd7cgx6ibP4YKhoLDBW15p2SVG5OuLq+YKnI07DV78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b9LSPfnCMdsSYt7uoLThiDEV81/e/D02UG8zzLIDlesFcCyq0kiwd3cyKoue9VUoP
	 BEoXtBixtULz5017/tOoRocc+/2HJeohPgg0lcGDYqsm9CG0AGzhLQfnCmSPfT9tCR
	 n4/Wv95gxkim5YHAoi5L9SUyqKIJX6W6lnzrjhAo=
Date: Tue, 4 Jun 2024 06:23:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: miquel.raynal@bootlin.com, dwmw2@infradead.org,
	computersforpeace@gmail.com, marek.vasut@gmail.com, vigneshr@ti.com,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
	leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH] Documentation: mtd: spinand: macronix: Add support for
 serial NAND flash
Message-ID: <2024060430-expire-geography-64dc@gregkh>
References: <20240603073953.16399-1-linchengming884@gmail.com>
 <2024060337-relatable-ozone-510e@gregkh>
 <CAAyq3SYg3Qr08DguhPbC8Bb89_KS_AAG-Z8SNG_A7H_v4YNrDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAyq3SYg3Qr08DguhPbC8Bb89_KS_AAG-Z8SNG_A7H_v4YNrDA@mail.gmail.com>

On Tue, Jun 04, 2024 at 09:44:01AM +0800, Cheng Ming Lin wrote:
> Hello,
> 
> Greg KH <gregkh@linuxfoundation.org> 於 2024年6月3日 週一 下午3:58寫道：
> >
> > On Mon, Jun 03, 2024 at 03:39:53PM +0800, Cheng Ming Lin wrote:
> > > From: Cheng Ming Lin <chengminglin@mxic.com.tw>
> > >
> > > MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC have been merge into
> > > Linux kernel mainline.
> >
> > Trailing whitespace :(
> 
> Sorry, we will fix it in the next version.
> 
> >
> > > Commit ID: "c374839f9b4475173e536d1eaddff45cb481dbdf".
> >
> > See the kernel documentation for how to properly reference commits in
> > changelog messages.
> 
> Sure, this will also be fixed in the next version.
> 
> >
> > > For SPI-NAND flash support on Linux kernel LTS v5.4.y,
> > > add SPI-NAND flash MX35UF{1,2,4}GE4AD and MX35UF{1,2}GE4AC in id tables.
> > >
> > > Those five flashes have been validate on Xilinx zynq-picozed board and
> > > Linux kernel LTS v5.4.y.
> >
> > What does 5.4.y have to do with the latest mainline tree?  Is this
> > tested on our latest tree?
> 
> We have requirements specific to the 5.4.y, and these five flashes
> have been adapted for the latest mainline tree.
> Additionally, they have been patched on LTS 5.14.y, and we have
> tested them on LTS 5.4.y.
> Given these circumstances, we are hopeful for approval to backport
> these five flash IDs on 5.4.y.

If this is a backport, please just follow the documentation for the
stable kernel for how to properly get a patch backported.

thanks,

greg k-h

