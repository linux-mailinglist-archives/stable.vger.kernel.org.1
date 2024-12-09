Return-Path: <stable+bounces-100164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142C9E93BB
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 13:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD98283BF8
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B97D221DB6;
	Mon,  9 Dec 2024 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jeXPe+Ok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABB822C6F7;
	Mon,  9 Dec 2024 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747016; cv=none; b=auhgody3NLtrDzyDvHyu6fe2QWIfHE9eErxjZpvO77EBb/Wv0zwQ01vRcGeEbCSb120DHk8bKagmyARalEY3tStVX5KBNHa9/aCDG9PQAs795FHhkAc2QGqrgcFL041PjIt9kGM/HQpmeTp19CXvXsfYR0eAk1bgOUo45h0IO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747016; c=relaxed/simple;
	bh=KVkjfWYylqMPK7Oa6OyaK9/zznA/avVPXE/BE+dfzKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtZ+LdbMuEcyVmiwUY+Y8yGOzw54ncpfoM0KiVuz9xvYaegc1HDtvhlj2Qs5iKVMlGLVLiBvepx65gjDFZZxr17qcjIRIzk79rkWppxSoWTS5u6Dl0uEZ2VYnDfEPk7mCpyFoVfpFsl+oOp4g7dJLfgGlrEQHTYJMxj7WrD/ViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jeXPe+Ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A238C4CED1;
	Mon,  9 Dec 2024 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733747015;
	bh=KVkjfWYylqMPK7Oa6OyaK9/zznA/avVPXE/BE+dfzKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jeXPe+OkHXQBiEYRXm89kz7qkuDJxNhiVo7UGbrnjlWh4nh+SJIyJOCD4k4dg2tHd
	 WW5jmGTDfEij74UUOuPQWdy3k90IZORDMYw4EBpTUQ6MqlijvULNlfOr3RT1sd5b9J
	 GizKWiFOktufK/3kh0oNHyokK9uSLRa8kNba8FGQ=
Date: Mon, 9 Dec 2024 13:23:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH for stable 5.4 v2] usb: dwc3: gadget: fix writing NYET
 threshold
Message-ID: <2024120910-triage-consent-c442@gregkh>
References: <20241209-dwc3-nyet-fix-5-4-v2-1-66a67836ae70@linaro.org>
 <2024120926-uncolored-lip-b571@gregkh>
 <127a17f0d7cf74f2fb69e996817dd783e768e0eb.camel@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <127a17f0d7cf74f2fb69e996817dd783e768e0eb.camel@linaro.org>

On Mon, Dec 09, 2024 at 12:12:05PM +0000, André Draszik wrote:
> On Mon, 2024-12-09 at 13:05 +0100, Greg Kroah-Hartman wrote:
> > On Mon, Dec 09, 2024 at 11:50:57AM +0000, André Draszik wrote:
> > > Before writing a new value to the register, the old value needs to be
> > > masked out for the new value to be programmed as intended, because at
> > > least in some cases the reset value of that field is 0xf (max value).
> > > 
> > > At the moment, the dwc3 core initialises the threshold to the maximum
> > > value (0xf), with the option to override it via a DT. No upstream DTs
> > > seem to override it, therefore this commit doesn't change behaviour for
> > > any upstream platform. Nevertheless, the code should be fixed to have
> > > the desired outcome.
> > > 
> > > Do so.
> > > 
> > > Fixes: 80caf7d21adc ("usb: dwc3: add lpm erratum support")
> > > Cc: stable@vger.kernel.org # 5.4 (needs adjustment for 5.10+)
> > > Signed-off-by: André Draszik <andre.draszik@linaro.org>
> > > ---
> > > * has been marked as v2, to be in line with the 5.10+ patch
> > > * for stable-5.10+, the if() test is slightly different, so a separate
> > >   patch has been sent for it for the patch to apply.
> > 
> > What is the git id of this in Linus's tree?
> 
> I guess I misunderstood the docs... It's not merged into Linus' tree
> yet - the proposed patch is here:
> 
> https://lore.kernel.org/all/20241209-dwc3-nyet-fix-v2-1-02755683345b@linaro.org/

Ah.  Yeah, wait until it hits Linus's tree before telling us about this,
otherwise we'll just get confused :)

thanks,

greg k-h

