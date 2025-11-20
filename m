Return-Path: <stable+bounces-195274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF11C741BA
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 14:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B80FF34390D
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9884533A6E0;
	Thu, 20 Nov 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1M0jMHS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524EB32BF4B;
	Thu, 20 Nov 2025 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644386; cv=none; b=MCEQZUWZ5Kx0u1nHSxzrQm28OZ/i6UPW2afmhxGHhf6JxLhy7zNH92VZBfukpno7M2bZYaFAzEdyemT8sC5p1L925zkEV1CW2hWoak8XjWE+G5S29PetmiB3Gm5Th3OMUWrdJ/Wt4X+cwqAiiVAaqFYrQniKdZSufyPelxE1cko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644386; c=relaxed/simple;
	bh=YtzGImFpZtdQZnyydJUvggXY/xCUjG1yCpjp7Ujji8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXeQ4gZSlFm+aX1f+0tAGg1IhuNs1XKQ7gX8e5lUOZM4YraEwjEIspZJyzz1wDmZtwD9XU4vGzFdJxXlBxK/3oLzoc7Oo0jIYrZyqinvoqiPv+e1CCOD28Zocq1JEnvXrsb3haX2ve6gvc2vejZJmaBF2cm0IT6yg1fUtgUzzqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1M0jMHS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1D1C4CEF1;
	Thu, 20 Nov 2025 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763644385;
	bh=YtzGImFpZtdQZnyydJUvggXY/xCUjG1yCpjp7Ujji8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S1M0jMHS8P1lM05E5KYSPHHAR/pI1SOgoOO/L/IbrsAT7qR044XjTAi95llogH5OC
	 8iI6jpkKSU63cHiqk5HX0WiVuVM3QTbeR4/GvF17F79k4P3hm3bnMqzaC8g1G132pf
	 bJdNVqx7sdRUdaMJNtWSwOBEiE5CMrXMFcdqf7QzAknfvJEfFwD0nl0VM6/gn5e1nO
	 sYgFW3dJ1VUQH+1z8ldoPN6EVBCBnidbh5UKiRqYUI4ZpAV6ThBAdTFpTHgWz2k/sp
	 Rdpv1VKbVVe0ned7Tbrj8F9gRkVQFUxC8SlgWOM6nzB4g6TjKf+JambS8y9jMs6TT4
	 bfE7OfkdZrxmQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vM4TC-000000003lh-0hDv;
	Thu, 20 Nov 2025 14:13:06 +0100
Date: Thu, 20 Nov 2025 14:13:06 +0100
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
Message-ID: <aR8T4jbp9hr04cre@hovoldconsulting.com>
References: <20250922122012.27407-1-johan@kernel.org>
 <aQTtlvoe96Odq96A@thinkstation>
 <aQnhtkIG9-A7yH-H@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQnhtkIG9-A7yH-H@hovoldconsulting.com>

On Tue, Nov 04, 2025 at 12:21:27PM +0100, Johan Hovold wrote:
> On Fri, Oct 31, 2025 at 06:10:46PM +0100, Raphaël Gallais-Pou wrote:
> 
> > Le Mon, Sep 22, 2025 at 02:20:12PM +0200, Johan Hovold a écrit :
> > > Make sure to drop the references taken to the vtg devices by
> > > of_find_device_by_node() when looking up their driver data during
> > > component probe.
> > 
> > Markus suggested “Prevent device leak in of_vtg_find()” as commit
> > summary.
> 
> Markus has gotten himself banned from the mailing lists some years ago
> and even if he is now back with a new mail address most of us still
> ignore him.
> 
> I prefer the Subject as it stands since it captures when the leaks
> happens, but I don't mind mentioning of_vtg_find() instead if you
> insist.

Can this one be picked up for 6.19 or do you want me to respin?

> > > Note that holding a reference to a platform device does not prevent its
> > > driver data from going away so there is no point in keeping the
> > > reference after the lookup helper returns.
> > > 
> > > Fixes: cc6b741c6f63 ("drm: sti: remove useless fields from vtg structure")
> > > Cc: stable@vger.kernel.org	# 4.16
> > > Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>

Johan

