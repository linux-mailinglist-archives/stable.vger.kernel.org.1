Return-Path: <stable+bounces-45125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A36908C61A0
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 09:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 303FEB243FE
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3B94A99C;
	Wed, 15 May 2024 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ejVIxxNy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I5zsOdsg"
X-Original-To: stable@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8F84AEDD
	for <stable@vger.kernel.org>; Wed, 15 May 2024 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757751; cv=none; b=KEHA9oJx0gjqpvkkhFWjFewIZ/5ro2H8tCbL9KIzsizKjdPMRhYsP0NT0pgF8zDoRZEXC/3/kJYRJOnrMyvcOifyxMFmKaBjNg0XOOzo0kKlEFK/+e7VVcoyozmZ8sL1kBVMIbIQZ9HEPgkTX5HiIJvZthqnfQfn5x1mZxOp9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757751; c=relaxed/simple;
	bh=cxOQpXWzjRsOrjtDU+rkWKaGsUgkYQA/KXziwSRwGrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYmUGGDiSvtk62jX2w0zxtSyVoEVKf4bf03qkeo/8N5ZLwUJgpz6k37c1/NVnbkdQ3xp7K2vXQOMddzlZmLtrW516inVr7GMZXZ6+gPZO87Ft03lDlrtzjpHoTDMx5ypXNdPeAtnx2pwyc0RC9dF0ET9Gf2aGkLQesc5NoTMtz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ejVIxxNy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I5zsOdsg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 06F29138113A;
	Wed, 15 May 2024 03:22:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 15 May 2024 03:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715757748; x=1715844148; bh=46dIB/2TuB
	p/s5tzJr3TtxnH/4JWeEo36KDBYrnRoS4=; b=ejVIxxNyKkskDh4WWnXxqnGu7S
	YNP+R/QRS7AgiZuZcKdugVyfkUesN3cQfqu019M5B0eDnJif/1HmDeXfR8MkRn+h
	v3NjHSA14iVbJduGi0WsJbC9qCPXagmCS1EiNomDHBAiMzVnNDkwk0sqllTjtrpS
	usqNHKHTTLWV6HNmPjPvODtADEpebD0wigNX44ukZLtonVkMrvycVEA+Unb9lE/f
	7zr6QIAiOTjVwH28xiGSOMkBFpz7d/A2qcZ/RNCLysucdgC+hlWiYQz0d0uG6JJO
	VWISgdvPoi2W34HdTuq0qFfYpqKL1RvjWA4JlArDgofjVq8fpsRgj71lD3eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715757748; x=1715844148; bh=46dIB/2TuBp/s5tzJr3TtxnH/4JW
	eEo36KDBYrnRoS4=; b=I5zsOdsgwdpB5st8v6JgGQoeX5y9FSTp8igUoxTSIApA
	ThwJLl4PMNCmP5M9t0gEbAki0TipSvtY4bLsDNjmqc8oi+ySi6OsINrdJieoLo1l
	+7Ut0+Xhu97ZNaycIoecFGjPx1bbtxxiMJfBhj5KqtUewJTyPyX8bZmIuOXnWaNz
	Q95t1Pj3vtqcYDehWvTdjb8I2ou8+8Pcxnb0eG7J2EaSDJvjkw6G8NyfJqlKgIYv
	pFvjr3Vzg0KSXLhacT8DbZAp0LyHQxBls4XCXmrwuSC+efdPEKbTX/YY1mhuDIN4
	vtQhT+BTlk8IBaZXn4SZpSPeVW8P2wGzd7ls13wLxw==
X-ME-Sender: <xms:s2JEZjzfPYha4A62xxaOt5Exw_7GII_y5nC48qIYEfNQoOuLOTyzPw>
    <xme:s2JEZrQQLrRpfUGvB50lzt6HPdKco9h_BtoJz_xAO8ylLuF7Crq5mp3DcyiinB3zR
    IoEUVKU9MuQ1w>
X-ME-Received: <xmr:s2JEZtUs749Fb_3tk9AQyAsaXVA5QqRBzxPVB0xUr86IkK1eqfs6aobCrwURD6yC1nEBVrzCcVgWqO92U94Ox2uxfKybS6O-bxWsgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:s2JEZtjgXHqZeBC52ypiIQD8S2mf3KVVwAqYABvUEsQ8njs08sVAxw>
    <xmx:s2JEZlCQ8V6sw6KHGxC28eoh-8owaRNHZI24SMMNIgCfIYMA3M5Kcw>
    <xmx:s2JEZmLuKF8LSfa4DfiPmAbE_O-QI4HOV_qkYyHpunCNGaE-i3i_dg>
    <xmx:s2JEZkAdj3sJvyQO5TEat7CDjWhdtnPOMHH5aev9drXSaPGXawjFqQ>
    <xmx:s2JEZp7tPGWEovk8ZndP6I-137dEyuUcmwYhJLZKjlf2Fo8QRKHhsC0B>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 03:22:27 -0400 (EDT)
Date: Wed, 15 May 2024 09:22:24 +0200
From: Greg KH <greg@kroah.com>
To: David Sterba <dsterba@suse.com>
Cc: stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
	Julian Taylor <julian.taylor@1und1.de>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 6.6.x] btrfs: do not wait for short bulk allocation
Message-ID: <2024051514-outline-phrase-df66@gregkh>
References: <20240514171225.11774-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514171225.11774-1-dsterba@suse.com>

On Tue, May 14, 2024 at 07:12:24PM +0200, David Sterba wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> commit 1db7959aacd905e6487d0478ac01d89f86eb1e51 upstream.

Both now quued up, thanks,

greg k-h

