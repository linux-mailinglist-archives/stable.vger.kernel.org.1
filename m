Return-Path: <stable+bounces-91985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A469C2C3F
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 12:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF9C282B69
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 11:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0544C1547C0;
	Sat,  9 Nov 2024 11:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zqOCxaCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E5433BB;
	Sat,  9 Nov 2024 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731152831; cv=none; b=NWrD18aalf7LIkHzBhLe3JXB34AeyhxyB7eHRuENot1LXY5S6i9eoKdwQmc7Emh6I0EBkZAFnL1lb9oWJyYOW+9Ra07fZr4MG1EtgEt1+LYfA/1hKUnlJGNnB0S7G1zr5ZuQWfsZztJoa80MyXEcxdGewj+HqcP/7oIjFfP/Aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731152831; c=relaxed/simple;
	bh=PkNaX/onq2nxjMaz+CMLZrEXUmFc3MMTQGZC1r6OsDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDCFhUPcGvJHjDQO0YoftlnNuoJnxPYNDlvEE1C02XfBf/5XxrMUKz9Z0KMhTN3USNQIk8GZpR/SuiMSsjYVBi8UqprdXWo/jtrPhLyBd7UVqYUA2ErQbbvVX9+DdaJ1pYmZhzCwCaPXVPiCC5q8fTwSgHSaNenWLMEhRA6shs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zqOCxaCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB2AC4CECE;
	Sat,  9 Nov 2024 11:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731152831;
	bh=PkNaX/onq2nxjMaz+CMLZrEXUmFc3MMTQGZC1r6OsDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zqOCxaCVXQwLD5bFkXtatvnMn81wuo0PqdiTb2lHDQxlKTdScatXdtA6SeVana6Rp
	 6fG+jHy1d7eY96y2mQBL9k7UJ4cJcAP8+cO2X79neiUY91ulFJcegqdbKc1HgI2qDK
	 O/OPtTfMhFQ2BN8+CviJUsviIvQShjQUDMk6ATsk=
Date: Sat, 9 Nov 2024 12:47:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rex Nie <rex.nie@jaguarmicro.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Angus Chen <angus.chen@jaguarmicro.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH v2] USB: core:
 remove dead code in do_proc_bulk()
Message-ID: <2024110911-professor-obnoxious-f411@gregkh>
References: <20241109021140.2174-1-rex.nie@jaguarmicro.com>
 <2024110947-umpire-unwell-ac00@gregkh>
 <KL1PR0601MB5773F9F97A6AFC7E5D987323E65E2@KL1PR0601MB5773.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR0601MB5773F9F97A6AFC7E5D987323E65E2@KL1PR0601MB5773.apcprd06.prod.outlook.com>

On Sat, Nov 09, 2024 at 11:38:43AM +0000, Rex Nie wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Greg KH <gregkh@linuxfoundation.org>
> > 发送时间: 2024年11月9日 14:59
> > 收件人: Rex Nie <rex.nie@jaguarmicro.com>
> > 抄送: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Angus Chen
> > <angus.chen@jaguarmicro.com>; stable@vger.kernel.org
> > 主题: Re: [PATCH v2] USB: core: remove dead code in do_proc_bulk()
> > 
> > External Mail: This email originated from OUTSIDE of the organization!
> > Do not click links, open attachments or provide ANY information unless you
> > recognize the sender and know the content is safe.
> > 
> > 
> > On Sat, Nov 09, 2024 at 10:11:41AM +0800, Rex Nie wrote:
> > > Since len1 is unsigned int, len1 < 0 always false. Remove it keep code
> > > simple.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: ae8709b296d8 ("USB: core: Make do_proc_control() and
> > > do_proc_bulk() killable")
> > > Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
> > > ---
> > > changes in v2:
> > > - Add "Cc: stable@vger.kernel.org" (kernel test robot)
> > 
> > Why is this relevant for the stable kernels?  What bug is being fixed that
> > users would hit that this is needed to resolve?
> HI Greg k-h, I got a email from lkp@intel.com let me add Cc tag yesterday, so I apply v2 patch.

That was because you cc: stable and yet did not tag it as such.  That's
not passing a judgement call on if it should have been done at all,
which is what I am asking here.

> Although this shouldn't bother users, the expression len1 < 0 in the if condition doesn't make sense,
> and removing it makes the code more simple and efficient. The original email from kernel robot test
> shows as follows. I think it no need a cc tag either.

Does this follow the patches as per the documentation for what should be
accepted for stable kernels?

thanks,

greg k-h

