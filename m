Return-Path: <stable+bounces-115113-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD80A33B85
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 10:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5893A5F60
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 09:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1044420DD5C;
	Thu, 13 Feb 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QHhuORDr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A4202C31;
	Thu, 13 Feb 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440039; cv=none; b=aF5nw/0BUClrAfkqq6++DNKFhMCV/y+zfGqYgseSQDHvzSvCHzYEhrQD5N5GdxVeHJ35r+hWnNcz8kpQA7HlEbZF0FyIY7rpDBOCM0OjYx0XqwaSSGcgh1lmMTvJNPGWNjtc9Dqy27vWxN9tpV1U9QfQ0KdIJnEH2SDA6CxKt48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440039; c=relaxed/simple;
	bh=ZxDr6AwnXUdrFTM7NUHu4gVEND5MJ7HwI8ht+KxlXR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRkIN5pgVGFmwpAJy1v74RLLE24mmfP2PsC/MT9mjWY0gTMuk7++e1kQD5j+SeebezNAvuYhxPte+kfVgixZcsJQELR0EFU8VaP+mk5TKtAJAwiDcbuTndP5JYYU5d1W90vFLX0QgexRg8MZcbHaLKJ69RdMcMROfmgEZW+Qz7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QHhuORDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C063DC4CED1;
	Thu, 13 Feb 2025 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739440037;
	bh=ZxDr6AwnXUdrFTM7NUHu4gVEND5MJ7HwI8ht+KxlXR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QHhuORDrzKwj5nBcVvdvE5Y948j1UgMJfjFp8pw/e97yQK/EVb8EgOuHGtLW+/Sm0
	 VSpcvBWnl1O9uwpg/75Ztx0bcfcaNXjfr5rPM2mOG/Y5QLBX9ASpAVfNssreu592VR
	 x0B1SbLlHxlMZ5cFeevkHgHIgNXX4NPCsOnCxarE=
Date: Thu, 13 Feb 2025 10:47:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Badhri Jagan Sridharan <badhri@google.com>
Cc: Jos Wang <joswang1221@gmail.com>, Amit Sunil Dhamne <amitsd@google.com>,
	heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: typec: tcpm: PSSourceOffTimer timeout in
 PR_Swap enters ERROR_RECOVERY
Message-ID: <2025021323-surviving-straddle-1f68@gregkh>
References: <20250209071752.69530-1-joswang1221@gmail.com>
 <5d504702-270f-4227-afd6-a41814c905e3@google.com>
 <CAPTae5+Z3UcDcdFcn=Ref5aQSUEEyz-yVbRqoPJ1LogP4MzJdg@mail.gmail.com>
 <CAMtoTm0bchocN6XrQBRdYuye7=4CoFbU-6wMpRAXR4OU77XkwQ@mail.gmail.com>
 <CAPTae5J5WCD6JmEE2tsgfJDzW9FRusiTXreTdY79MBs4AL6ZHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTae5J5WCD6JmEE2tsgfJDzW9FRusiTXreTdY79MBs4AL6ZHg@mail.gmail.com>

On Wed, Feb 12, 2025 at 11:16:35PM -0800, Badhri Jagan Sridharan wrote:
> On Tue, Feb 11, 2025 at 5:50 AM Jos Wang <joswang1221@gmail.com> wrote:
> >
> > On Tue, Feb 11, 2025 at 7:51 AM Badhri Jagan Sridharan
> > <badhri@google.com> wrote:
> > >
> > > On Mon, Feb 10, 2025 at 3:02 PM Amit Sunil Dhamne <amitsd@google.com> wrote:
> > > >
> > > >
> > > > On 2/8/25 11:17 PM, joswang wrote:
> > > > > From: Jos Wang <joswang@lenovo.com>
> > > nit: From https://elixir.bootlin.com/linux/v6.13.1/source/Documentation/process/submitting-patches.rst#L619
> > >
> > >   - A ``from`` line specifying the patch author, followed by an empty
> > >     line (only needed if the person sending the patch is not the author).
> > >
> > > Given that you are the author, wondering why do you have an explicit "From:" ?
> > >
> > Hello, thank you for your help in reviewing the code.
> > My company email address is joswang@lenovo.com, and my personal gmail
> > email address is joswang1221@gmail.com, which is used to send patches.
> > Do you suggest deleting the "From:" line?
> > I am considering deleting the "From:" line, whether the author and
> > Signed-off-by in the patch need to be changed to
> > "joswang1221@gmail.com".
> 
> Yes, changing signed-off to joswang1221@gmail.com will remove the need
> for "From:".
> Go ahead with it if it makes sense on your side.

No, what was done here originally is correct, please do not ask people
to not actually follow the correct procedure.

Jos, thank you, there is nothing wrong with the way you sent this.

thanks,

greg k-h

