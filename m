Return-Path: <stable+bounces-26883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5F8872A39
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 23:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193761C2172E
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 22:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8701B59F;
	Tue,  5 Mar 2024 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F91gqYFc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D414290
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677979; cv=none; b=hCjqxWQAn8dF/QJU0/3VV6iTXjel6e3BLbGLt67K/L2mmUQ04/3ouRhaVoUpxIpzj2MTZTzKEKEBLyGO4dgd+axspSX0O72IUoDTpuVb3Kuw1JbRST3SfBwmi74mDq1J3hwSGrNw021R9yzDictTTpnid5bYhPgNGzPYF5ucsa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677979; c=relaxed/simple;
	bh=CR3apIHKxfx8CehRoKh2i7lKMiU0SaLTbaUmyqdA+lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlSI5jHeASxVYmi35K36ju/OE8yHs5Vi9qq3Fmr+ax4HmGvwzj77WIjKhVvYVPbnCSA+g6MlCelOtdOqxxXuE3hKFsuBDdKRGoJDc0mTYL3DR9CCGVASeQiJKEFAzTQq1/UkiY6ujw3gJa61QFk28jUtaGReoS605/3SnJ0XfKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F91gqYFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58AEC433C7;
	Tue,  5 Mar 2024 22:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709677979;
	bh=CR3apIHKxfx8CehRoKh2i7lKMiU0SaLTbaUmyqdA+lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F91gqYFcbB+NZ1oJATQj2sH0ePOqbqdIR6LjQCUeSfBTk1flslPt6RRMp8EIaJxtn
	 maBCtP8bemrhE7JPXbv4PSpGvkABMYJrhlften9LQsLLzpXMpVpGve3qWrIrF6/Z7/
	 8hDwTeFTz4ae5Gg5qeBclkkqt8oJAFHlnbsqU0Rw=
Date: Tue, 5 Mar 2024 22:32:56 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>, stable@vger.kernel.org, linux-mm@kvack.org,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Naoya Horiguchi <naoya.horiguchi@linux.dev>
Subject: Re: [PATCH STABLE v6.1.y] mm/migrate: set swap entry values of THP
 tail pages properly.
Message-ID: <2024030527-footrest-cathedral-5e15@gregkh>
References: <20240305161313.90954-1-zi.yan@sent.com>
 <2024030506-quotable-kerosene-6820@gregkh>
 <0910e8f0-5490-4d08-ac64-da4077a1e703@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0910e8f0-5490-4d08-ac64-da4077a1e703@redhat.com>

On Tue, Mar 05, 2024 at 11:09:17PM +0100, David Hildenbrand wrote:
> On 05.03.24 23:04, Greg KH wrote:
> > On Tue, Mar 05, 2024 at 11:13:13AM -0500, Zi Yan wrote:
> > > From: Zi Yan <ziy@nvidia.com>
> > > 
> > > The tail pages in a THP can have swap entry information stored in their
> > > private field. When migrating to a new page, all tail pages of the new
> > > page need to update ->private to avoid future data corruption.
> > > 
> > > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > > ---
> > >   mm/migrate.c | 6 +++++-
> > >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > What is the git commit id of this change in Linus's tree?
> 
> Unfortunately, we had to do stable-only versions, because the backport
> of the "accidental" fix that removes the per-subpage "private" information
> would be non-trivial, especially for pre-folio-converison times.
> 
> The accidental fix is
> 
> 07e09c483cbef2a252f75d95670755a0607288f5

None of that is obvious at all here, we need loads of documentation in
the changelog text that says all of that please.

thanks,

greg k-h

