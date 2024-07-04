Return-Path: <stable+bounces-57998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09322926EDA
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 07:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26101F234A5
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 05:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF03B19E7C7;
	Thu,  4 Jul 2024 05:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DLxrhXZ8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD0D144D2C
	for <stable@vger.kernel.org>; Thu,  4 Jul 2024 05:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720070926; cv=none; b=cTGOqph0hp7dUHqq1URf2o0jnUXRBtrKTelktJe2BNH0q/XW5DLgbIlfRoPjLCoqi/piadMiNWCJlixEZ3+0VlZBudlCsOtnM892p35kvtPQFpigG013tDcklLTdvx5tmHtoPy550nfrkUOzcGjGFvQ3hAAT6Mez8/kiSU8euMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720070926; c=relaxed/simple;
	bh=XCm2QkzZQOaAqjDnpM1D6kMyFi97tU9RY3w2K5CTyy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9Q+8qCOKmKq1vRJI3Ynoggwvvx+8zV2mWZAhFHmRqc2u/6YYfKtywe7/cLeWDmWvgG3HH6iVuUsWoGnTEWAAz+FktwNzBJM4XElnh6SrgvIRH8LEtZ9nmGvQEeR9KGbQedUwDshKqGg5kc/3qsjk49Rf4EZVTJ5Svsp8O4OyZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DLxrhXZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A728C3277B;
	Thu,  4 Jul 2024 05:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720070926;
	bh=XCm2QkzZQOaAqjDnpM1D6kMyFi97tU9RY3w2K5CTyy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DLxrhXZ8+q+cTXzxxD6qv5PM+N/yl+90aTbx/4DL6dn+u8IPXsNyiJRMK4X1i5oR9
	 Pbjw6xPFe6/15u31Dbhx/PBrlJ8tlyuVsQdXP5uoK1/zi1aGgCs057SSo156z5ciIm
	 MBO1XkQWaT7VfHyTyZtd2KaSn/CNEJqd7/94hg84=
Date: Thu, 4 Jul 2024 07:28:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: vigneshr@ti.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] serial: 8250_omap: Fix Errata i2310 with
 RX FIFO level check" failed to apply to 5.15-stable tree
Message-ID: <2024070429-majority-unlocked-29b3@gregkh>
References: <2024070338-skid-sauna-cd1d@gregkh>
 <7cdc5fa7-ab14-4e2c-bcdb-eee0f99000cb@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cdc5fa7-ab14-4e2c-bcdb-eee0f99000cb@ti.com>

On Thu, Jul 04, 2024 at 10:44:54AM +0530, Kumar, Udit wrote:
> Hello Greg
> 
> On 7/3/2024 7:41 PM, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x c128a1b0523b685c8856ddc0ac0e1caef1fdeee5
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070338-skid-sauna-cd1d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> > 
> > Possible dependencies:
> 
> 
> This patch has dependency on
> https://lore.kernel.org/all/20240703102925.298849298@linuxfoundation.org/
> Which is already queued for 5.15.

Oops, my fault, I hadn't applied all of the 5.15.y patches when I
attempted this one, now fixed.

greg k-h

