Return-Path: <stable+bounces-92772-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A609C5669
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7301F20933
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6942170D4;
	Tue, 12 Nov 2024 11:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+Od7uMv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBDB20F5AF;
	Tue, 12 Nov 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409866; cv=none; b=TVesnhNksXoBTIRXmzLwWOTRRZGHjkKTk1i8DtiWWEnmlGo3ekxP1TKxi8l51DX9BRMd7cA6T5NS2gshN3CW7dgYjsdYR93DKzc8zX0kmVQ1DW+z1bGK2ffb5HT6JZORXrOE91i91DeRh5ULeEq7ewXE+sZ/Yo/boObvwfkkcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409866; c=relaxed/simple;
	bh=XTmez6esYZix4zEIExzvryIvtWhzuaD1aYHB9dK8R4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkQ6CoOue0ehSN8/Td0FbFel7MO2LBv5NGQ6dvf9v5+GFbDojzBFm4mRV7ANDsTV8FY9U2pqfAc19Ozy3nfQ+hXs/4QXKDdZfSMqZnKCBLF4Y+v825kW85HoBshfwHHAbd0S1+sTiBcb/EP7tGWBE/zbNgiNrZ8fGUmPQl28jbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+Od7uMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F9FC4CECD;
	Tue, 12 Nov 2024 11:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731409865;
	bh=XTmez6esYZix4zEIExzvryIvtWhzuaD1aYHB9dK8R4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N+Od7uMv6TKw1xFecazXPs9sajbjNsQuhAWkWs6sb4NfumsiHXKSiYzyIkKFpNupE
	 Ge1IquGZd3xjAcdsvCMg33y3FZISBLnm1XUNNKr1gypDUMZGgSQ0AE5S8hZwRYnae0
	 Rexgk37itCLPKo7IZ4gB2hiWXmNDrfoIQYSWTrIE=
Date: Tue, 12 Nov 2024 12:11:02 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rex Nie <rex.nie@jaguarmicro.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Angus Chen <angus.chen@jaguarmicro.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI0=?= =?utf-8?Q?=3A?= [PATCH v2] USB:
 core: remove dead code in do_proc_bulk()
Message-ID: <2024111249-stifle-mundane-dbfc@gregkh>
References: <20241109021140.2174-1-rex.nie@jaguarmicro.com>
 <2024110947-umpire-unwell-ac00@gregkh>
 <KL1PR0601MB5773F9F97A6AFC7E5D987323E65E2@KL1PR0601MB5773.apcprd06.prod.outlook.com>
 <2024110911-professor-obnoxious-f411@gregkh>
 <KL1PR0601MB5773FD459FC71707E5FB0B7FE6582@KL1PR0601MB5773.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <KL1PR0601MB5773FD459FC71707E5FB0B7FE6582@KL1PR0601MB5773.apcprd06.prod.outlook.com>

On Mon, Nov 11, 2024 at 08:01:59AM +0000, Rex Nie wrote:
> 
> 
> > -----邮件原件-----
> > 发件人: Greg KH <gregkh@linuxfoundation.org>
> > 发送时间: 2024年11月9日 19:47
> > 收件人: Rex Nie <rex.nie@jaguarmicro.com>
> > 抄送: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Angus Chen
> > <angus.chen@jaguarmicro.com>; stable@vger.kernel.org
> > 主题: Re: 答复: [PATCH v2] USB: core: remove dead code in do_proc_bulk()
> > 
> > External Mail: This email originated from OUTSIDE of the organization!
> > Do not click links, open attachments or provide ANY information unless you
> > recognize the sender and know the content is safe.
> > 
> > 
> > On Sat, Nov 09, 2024 at 11:38:43AM +0000, Rex Nie wrote:
> > >
> > >
> > > > -----邮件原件-----
> > > > 发件人: Greg KH <gregkh@linuxfoundation.org>
> > > > 发送时间: 2024年11月9日 14:59
> > > > 收件人: Rex Nie <rex.nie@jaguarmicro.com>
> > > > 抄送: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org; Angus
> > > > Chen <angus.chen@jaguarmicro.com>; stable@vger.kernel.org
> > > > 主题: Re: [PATCH v2] USB: core: remove dead code in do_proc_bulk()
> > > >
> > > > External Mail: This email originated from OUTSIDE of the organization!
> > > > Do not click links, open attachments or provide ANY information
> > > > unless you recognize the sender and know the content is safe.
> > > >
> > > >
> > > > On Sat, Nov 09, 2024 at 10:11:41AM +0800, Rex Nie wrote:
> > > > > Since len1 is unsigned int, len1 < 0 always false. Remove it keep
> > > > > code simple.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: ae8709b296d8 ("USB: core: Make do_proc_control() and
> > > > > do_proc_bulk() killable")
> > > > > Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
> > > > > ---
> > > > > changes in v2:
> > > > > - Add "Cc: stable@vger.kernel.org" (kernel test robot)
> > > >
> > > > Why is this relevant for the stable kernels?  What bug is being
> > > > fixed that users would hit that this is needed to resolve?
> > > HI Greg k-h, I got a email from lkp@intel.com let me add Cc tag yesterday,
> > so I apply v2 patch.
> > 
> > That was because you cc: stable and yet did not tag it as such.  That's not
> > passing a judgement call on if it should have been done at all, which is what I
> > am asking here.
> > 
> Thanks for detailed explanation.
> > > Although this shouldn't bother users, the expression len1 < 0 in the
> > > if condition doesn't make sense, and removing it makes the code more
> > > simple and efficient. The original email from kernel robot test shows as
> > follows. I think it no need a cc tag either.
> > 
> > Does this follow the patches as per the documentation for what should be
> > accepted for stable kernels?
> >
> I check Documentation/process/stable-kernel-rules.rst again, it don't follow rules for stable kernels.
> I think this patch can be picked up by mainline kernel tree.

Great, please resend this with that properly removed.

thanks,

greg k-h

