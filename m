Return-Path: <stable+bounces-35544-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520E4894B22
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 08:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CAE1C208C9
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 06:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A612A18627;
	Tue,  2 Apr 2024 06:06:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF2CA6F
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038016; cv=none; b=iXN97PJ3sfYaXmbwLZx/1mb3o5AVTRqIN5JKrs1Rm4hzOMz9aavAyvBgIfwUbT4rSHdykLDCss7kz5Wuia1ugtLccn3DQDGmo5NIIWF1T9MaUXYsspHORAyYdlFPIhfcdEJZs9b8UYaHWc83cmrx8Bod+8t0KAk9CRYcugb9iqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038016; c=relaxed/simple;
	bh=JBHXHj+hOTVqdrhCgwy4UVPS5ZJzcSVea2tXUaTYIoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PviNEywoHXGNBso4rZjKn33Lp7IciVC3sRYbxasLTRY4Xmtbq8peiEmEc5PnHhKV7LR6ObHgBSkbE0rvnnRp//zlTfy/OYoxaNYJKdF7QSKHwB8h8Jm1tFyDrKkGmIBO9nykFJ4JWhuNPP1+xBs5OCdO/xCDSDYnkZ9mqoWV9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 1489F140139; Tue,  2 Apr 2024 08:06:52 +0200 (CEST)
Date: Tue, 2 Apr 2024 08:06:52 +0200
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 6.1 251/272] usb: typec: ucsi: Check for notifications
 after init
Message-ID: <ZgugfCVW2j1Uwm4J@cae.in-ulm.de>
References: <20240401152530.237785232@linuxfoundation.org>
 <20240401152538.859016197@linuxfoundation.org>
 <ZgsWLUHW8nqUv7pi@cae.in-ulm.de>
 <2024040216-cahoots-gizzard-4ffb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024040216-cahoots-gizzard-4ffb@gregkh>


Hi Greg,

On Tue, Apr 02, 2024 at 07:40:43AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 01, 2024 at 10:16:45PM +0200, Christian A. Ehrhardt wrote:
> > 
> > Hi Greg,
> > 
> > On Mon, Apr 01, 2024 at 05:47:21PM +0200, Greg Kroah-Hartman wrote:
> > > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Christian A. Ehrhardt <lk@c--e.de>
> > > 
> > > commit 808a8b9e0b87bbc72bcc1f7ddfe5d04746e7ce56 upstream.
> > > 
> > > The completion notification for the final SET_NOTIFICATION_ENABLE
> > > command during initialization can include a connector change
> > > notification.  However, at the time this completion notification is
> > > processed, the ucsi struct is not ready to handle this notification.
> > > As a result the notification is ignored and the controller
> > > never sends an interrupt again.
> > > 
> > > Re-check CCI for a pending connector state change after
> > > initialization is complete. Adjust the corresponding debug
> > > message accordingly.
> > > 
> > > Fixes: 71a1fa0df2a3 ("usb: typec: ucsi: Store the notification mask")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
> > > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> > > Link: https://lore.kernel.org/r/20240320073927.1641788-3-lk@c--e.de
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/usb/typec/ucsi/ucsi.c |   10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > This change has an out of bounds memory access. Please drop it from
> > the stable trees until a fix is available.
> 
> Shouldn't we get a fix for Linus's tree too?  Have I missed that
> somewhere?  Or should this just be reverted now?

I posted the fix a few hours after sending this mail. It is here:
    https://lore.kernel.org/all/20240401210515.1902048-1-lk@c--e.de/

Either this should be fast tracked to Linus or the original change
reverted, yes.

Best regards
Christian


