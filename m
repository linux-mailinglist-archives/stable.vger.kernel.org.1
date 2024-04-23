Return-Path: <stable+bounces-40757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E308AF797
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 613F4286D73
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 19:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CB4142620;
	Tue, 23 Apr 2024 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="3jdGkzWZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AFQK2stM"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119EF1422C4
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901814; cv=none; b=lXk87foQTHmZasAaNwEMB8+ZL2Fp5vPnybb4f5u7EWP7PsuuqcnICQ+tNeWjrmZLVDFDWeHmweZTIoNEZ4V5nbt67CsRSwvOAX5dOtiMVf+Fr00k5PUiZdXJ1eoLFJ26oTPlNUov2NXlqusSIFVhgyOeN9sPcVyKhz3EftuBXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901814; c=relaxed/simple;
	bh=KtqPrK98MW0rlIX3PWDffcDVJhZo0rp9cN1yLqCmfJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QAo1PTj+qMSsNjblNB1X9vDOfTuzMFVNq0zLrVVFzQRRkcqkgOUjbk6cGn1/HbnAzaJ9wTfWo17NAtbmVHfv8OufbMgseJFd3KQdAuNO+yigro/KlOsPsmQFfway0D1Z+AzHxEJBMiFgYw3BaBh7IBvK6OV+I4pXelwJa45mqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=3jdGkzWZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AFQK2stM; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id C68471800165;
	Tue, 23 Apr 2024 15:50:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 23 Apr 2024 15:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713901810; x=1713988210; bh=NY+7o2v6HU
	t3ca/XKJBg2kqYHvYrNuPCzfi1vTwKOzo=; b=3jdGkzWZ8UfrkkmJQZYVODkO7R
	ndB3u1viLJ+hvy6DE1IouBwLcoexwaB4uJwE9s5hg3mawQ01T8DFFl7wJhgKpStv
	s0HdS4YXHVJYmO6RGcgmrC/Efbv726OKK+9jbGLkf3AFtC47EifUXdeYD3EhcIll
	c2u2mSdNgu9PQCsAkAe2yuitPk8KKHlXXHUozDxnm/BoDI0RlGzZsLE8GyTL55Oo
	bG2xlkqeeyG9Z/iLkVgqN4dfwxvXlDNqa8ofVSIDRFp3mN7+kYlbuKPiCmwPakWL
	ChCbD6S12eyxTa9udp6cFswgiLpQzdoh6WpIdgI7a/l5rWA39IL9nbSZrI3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713901810; x=1713988210; bh=NY+7o2v6HUt3ca/XKJBg2kqYHvYr
	NuPCzfi1vTwKOzo=; b=AFQK2stMsc+x+o2GNNj0jlOymGHZHtHdr4Xvcbh1gdEO
	RlMnT5suT4kJddCOqKwBoyNQLChUhTooFN4QrjR3O0sB5UWxyPI7bAZyNVTLG1fL
	7+FXrk85mpTgTzBq09iA+V2hDjUbbqrYzazCZdsNK7CYAUhXMVNpEiEdAuf87WuF
	xP406nYXosqy65uSrYdoGNOE9ojOuSElz1DJdGmy6sae77Nvy+tAFM9kLeL64nUK
	IJPolQ0gtviMfEjjkG7m3PizlOAfO57R3++sTwv0/XZaKXUP7OSNA9frtbWuGIYs
	MAE71IzWPKTveJS/3+PNMXuG9VeigSJZ93NfxcW3ng==
X-ME-Sender: <xms:8hAoZltPcMCdejQYfAz7ogFLFcBjntbOXiH_QPIIJ9AsnYvTHFRunQ>
    <xme:8hAoZuen9zDo7lpotDVaIucovZYJj_5D1ltaRfw9fq69oAPWl8MdyOSXe2QUpmUvp
    ccUiWf7tnn0aw>
X-ME-Received: <xmr:8hAoZoxfoGxtEnXXX5hqQJCZyjIVYd4y4YOPyqVcavw_-PJlL3Nb_pDep_yn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeluddgudegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:8hAoZsPiExgYK--1SP6fUsU-o4bUzzYEnoFlv-p715AriYRhsZeeAg>
    <xmx:8hAoZl-DOoD7-NJh4GmOsrxgGI0CgmUa-596KnZtK8xYQ2TMtg7zLA>
    <xmx:8hAoZsXlaykFM4mpy2ngWedynvkederWATr2cbWE2KTyWI7smPu39g>
    <xmx:8hAoZmdkma2RmxYTDT_KdmdlQlePdiEiWH_Iu6GBWiRig62WOaaIDg>
    <xmx:8hAoZhZ59naRco4HVrZRaXlE7_icStc9KHlXsl4QQTkTMFTl8-Dp-PzN>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 15:50:09 -0400 (EDT)
Date: Tue, 23 Apr 2024 12:50:00 -0700
From: Greg KH <greg@kroah.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Reset thunderbolt topologies at bootup
Message-ID: <2024042347-humongous-unifier-5375@gregkh>
References: <a06d9047-114f-4e63-b3b4-efcd83ca6d1e@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a06d9047-114f-4e63-b3b4-efcd83ca6d1e@amd.com>

On Tue, Apr 23, 2024 at 01:54:27PM -0500, Mario Limonciello wrote:
> Hi,
> 
> We've got a collection of bug reports about how if a Thunderbolt device is
> connected at bootup it doesn't behave the same as if it were hotplugged by
> the user after bootup.  Issues range from non-functional devices or display
> devices working at lower performance.
> 
> All of the issues stem from a pre-OS firmware initializing the USB4
> controller and the OS re-using those tunnels.  This has been fixed in
> 6.9-rc1 by resetting the controller to a fresh state and discarding whatever
> firmware has done.  I'd like to bring it back to 6.6.y LTS and 6.8.y stable.
> 
> 01da6b99d49f6 thunderbolt: Introduce tb_port_reset()
> b35c1d7b11da8 thunderbolt: Introduce tb_path_deactivate_hop()
> ec8162b3f0683 thunderbolt: Make tb_switch_reset() support Thunderbolt 2, 3
> and USB4 routers
> 9a54c5f3dbde thunderbolt: Reset topology created by the boot firmware

The last one seems wrong, it's really
59a54c5f3dbde00b8ad30aef27fe35b1fe07bf5c, right?

thanks,

greg k-h

