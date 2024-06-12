Return-Path: <stable+bounces-50283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344CE9055CD
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE13C285927
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F88A17F374;
	Wed, 12 Jun 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lz4Qg7Tu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F517F371
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204016; cv=none; b=h2zIH34pOPm3E091tyrmLWc9r8TwG0TfnPwSZFLyjrhEINtS4ZnRVgGwMSYL/LBn40iFatI4tToT2syV4jqLkIAy/svWQUZS9BeWkiL5EEPymFYPyAzIiNDVW0Kqew3Hmqw0vG5VbKdKC3dSyMJYCOWc5defI1pDWMLYNb0v748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204016; c=relaxed/simple;
	bh=5VJUNgWbOSQsaCaxyJqTuzpwHkcz8iaXCzUuTSrJcu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUKqaW+J33FzbdjMxKs2kXFk0qYqt08lLdZC1zNZs5aY/gQ+DKPZcI9Fg3KIZ5H3X+IRalX9JLdfgF7rpkYgMQIXG/SoaaaCuT3fKa6bjq404GLqtwiO4JXVxtNXBNsIE+CzP/b8kgMiwIVWDeibTDgiFjVgnBj+X6FubGB8zic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lz4Qg7Tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F5BC116B1;
	Wed, 12 Jun 2024 14:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718204016;
	bh=5VJUNgWbOSQsaCaxyJqTuzpwHkcz8iaXCzUuTSrJcu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lz4Qg7TuaDN0AZ5bQ/i4FLLyPhY+z298k7dC5EbtgjZlxAJo+mdTnTaogd7GWQwcb
	 dC391JoYpiYHQua87w8AvmN6JEeeyVql67zZnLTs0sQyHgKh1b+YKFXlK/0ZUAWPWn
	 VQBMPSAUw8/Wb5yECysB9pTkhRwjc2oSL4z+Jxb8=
Date: Wed, 12 Jun 2024 16:53:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Voegtle <tv@lio96.de>
Cc: stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>
Subject: Re: 6.6.y: cifs broken since 6.6.23 writing big files with vers=1.0
 and 2.0
Message-ID: <2024061215-swiftly-circus-f110@gregkh>
References: <e519a2f6-eb49-e7e6-ab2e-beabc6cad090@lio96.de>
 <2024061242-supervise-uncaring-b8ed@gregkh>
 <52814687-9c71-a6fb-3099-13ed634af592@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52814687-9c71-a6fb-3099-13ed634af592@lio96.de>

On Wed, Jun 12, 2024 at 04:44:27PM +0200, Thomas Voegtle wrote:
> On Wed, 12 Jun 2024, Greg KH wrote:
> 
> > On Tue, Jun 11, 2024 at 09:20:33AM +0200, Thomas Voegtle wrote:
> > > 
> > > Hello,
> > > 
> > > a machine booted with Linux 6.6.23 up to 6.6.32:
> > > 
> > > writing /dev/zero with dd on a mounted cifs share with vers=1.0 or
> > > vers=2.0 slows down drastically in my setup after writing approx. 46GB of
> > > data.
> > > 
> > > The whole machine gets unresponsive as it was under very high IO load. It
> > > pings but opening a new ssh session needs too much time. I can stop the dd
> > > (ctrl-c) and after a few minutes the machine is fine again.
> > > 
> > > cifs with vers=3.1.1 seems to be fine with 6.6.32.
> > > Linux 6.10-rc3 is fine with vers=1.0 and vers=2.0.
> > > 
> > > Bisected down to:
> > > 
> > > cifs-fix-writeback-data-corruption.patch
> > > which is:
> > > Upstream commit f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c
> > > and
> > > linux-stable commit e45deec35bf7f1f4f992a707b2d04a8c162f2240
> > > 
> > > Reverting this patch on 6.6.32 fixes the problem for me.
> > 
> > Odd, that commit is kind of needed :(
> > 
> > Is there some later commit that resolves the issue here that we should
> > pick up for the stable trees?
> > 
> 
> Hope this helps:
> 
> Linux 6.9.4 is broken in the same way and so is 6.9.0.

How about Linus's tree?

thnanks,

greg k-h

