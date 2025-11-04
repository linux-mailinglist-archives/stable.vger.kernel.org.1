Return-Path: <stable+bounces-192358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F84C30B46
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 12:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A1118831E3
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 11:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0457E2E6CA7;
	Tue,  4 Nov 2025 11:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkcbnEER"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B557B2C0F7E;
	Tue,  4 Nov 2025 11:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255284; cv=none; b=pK/2EqNrdyUX8AjXu84CCwWhTPrTNf+ldAXCMMur0bV3rFSRCY83GNNVOY8V7KDKo0YoaWX7WhCg940VCxCP4+K42AVGHJPJolyCCuze/YsNXYqX/FtFaD+/o7mgEdqdB3tj3fnWpaugpzZY1kDzanOgiEKz3z934/a1Os8+o0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255284; c=relaxed/simple;
	bh=LiZJY/3wCT03/9ZLDXQDP1aBdRc5YScmWSbm14KOsPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8RS8gqma4Me5x6Ybn8VR6k1C05FLIXq2+B2G08EAPyfttFEJW+8klY11+l+yD5uCEA3adCIv/GVPbe0F564Uy7eh955X4smix0NN0xK8vtEVlrtQBzFJub4UK4UerXSv5/T3SuxfhuBISDSUfsnWahEWMHO2Rxe0D5t18SbznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkcbnEER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227C2C4CEF7;
	Tue,  4 Nov 2025 11:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762255284;
	bh=LiZJY/3wCT03/9ZLDXQDP1aBdRc5YScmWSbm14KOsPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KkcbnEER5owyw8/sqVExh1KJpmqHnUwWMApK/ti/BnI0pXk4aMwuM8DhLAax35FmO
	 rzGK+PmtqpC5ZHd8n1BQZ6KXsv48K0FBpiETLoB9QYcr7wVBFDJYXNMzroFXd8h+6f
	 VK4Q+I4KQhdRfr9OMouXlAgS6Og/gKCg6EyTc8yxE4dvNbzZh8lMS0ZIYiTGqOJtvo
	 LbN+GAw5ptKl9bbpzSqoOhfbgwbrcA+pK4sSgBpNpeYpkfmzlLzz23xIFVgbKMBQah
	 +632D6PJf0to/Qn+MztvmBizvmyI4jIJF9tjtqecJ0JR0AaEUCywX+ENJgdv7zgShs
	 SJ+Njqy00S4aw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vGF6M-000000007OP-1nwh;
	Tue, 04 Nov 2025 12:21:27 +0100
Date: Tue, 4 Nov 2025 12:21:26 +0100
From: Johan Hovold <johan@kernel.org>
To: =?utf-8?Q?Rapha=C3=ABl?= Gallais-Pou <rgallaispou@gmail.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH] drm: sti: fix device leaks at component probe
Message-ID: <aQnhtkIG9-A7yH-H@hovoldconsulting.com>
References: <20250922122012.27407-1-johan@kernel.org>
 <aQTtlvoe96Odq96A@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQTtlvoe96Odq96A@thinkstation>

On Fri, Oct 31, 2025 at 06:10:46PM +0100, Raphaël Gallais-Pou wrote:

> Le Mon, Sep 22, 2025 at 02:20:12PM +0200, Johan Hovold a écrit :
> > Make sure to drop the references taken to the vtg devices by
> > of_find_device_by_node() when looking up their driver data during
> > component probe.
> 
> Markus suggested “Prevent device leak in of_vtg_find()” as commit
> summary.

Markus has gotten himself banned from the mailing lists some years ago
and even if he is now back with a new mail address most of us still
ignore him.

I prefer the Subject as it stands since it captures when the leaks
happens, but I don't mind mentioning of_vtg_find() instead if you
insist.

> > Note that holding a reference to a platform device does not prevent its
> > driver data from going away so there is no point in keeping the
> > reference after the lookup helper returns.
> > 
> > Fixes: cc6b741c6f63 ("drm: sti: remove useless fields from vtg structure")
> > Cc: stable@vger.kernel.org	# 4.16
> > Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> >  drivers/gpu/drm/sti/sti_vtg.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
> > index ee81691b3203..ce6bc7e7b135 100644
> > --- a/drivers/gpu/drm/sti/sti_vtg.c
> > +++ b/drivers/gpu/drm/sti/sti_vtg.c
> > @@ -143,12 +143,17 @@ struct sti_vtg {
> >  struct sti_vtg *of_vtg_find(struct device_node *np)
> >  {
> >  	struct platform_device *pdev;
> > +	struct sti_vtg *vtg;
> >  
> >  	pdev = of_find_device_by_node(np);
> >  	if (!pdev)
> >  		return NULL;
> >  
> > -	return (struct sti_vtg *)platform_get_drvdata(pdev);
> > +	vtg = platform_get_drvdata(pdev);
> > +
> > +	put_device(&pdev->dev);
> 
> I would prefer of_node_put() instead, which does the same basically, but
> at least it is more obviously linked to of_find_device_by_node().

of_node_put() operates on OF nodes, but here it is the platform device
that is leaking.

> > +
> > +	return vtg;
> >  }

Johan

