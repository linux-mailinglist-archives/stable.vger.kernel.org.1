Return-Path: <stable+bounces-83769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8440299C710
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 12:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDCA285FFD
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 10:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6715B13B;
	Mon, 14 Oct 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGYhTL8q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F893156676
	for <stable@vger.kernel.org>; Mon, 14 Oct 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901389; cv=none; b=et2mLrktTd91b9hIU9bQePmdDuk22zubm2znp+qqHS2+c0WvQdli4aip7uWRTKyM3BMXLeZiMUxGFkEY5dOnZexHFt1Y0F9QmA36Zq4vA9J5LPvMm6fwxTHaHX4i6u0W8ySW4HWgwCUXIOsdslE4MrtgTqa65G2xT3NIAyMbLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901389; c=relaxed/simple;
	bh=9l8FErKAyGNJ/Ju6TyWHciFnQpsfsS5BT05KEY4GmwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYzr1l849vLd+cN7KWzBEgv/d9HeYcHDbty2tWd3xov3lKtGXjtKuUKkNCvf94b1KmNOZSQwZ7TgQPE8sCVB0OiVoi0ldf5AbvgxUgV+iduotDui2nAm+GMyflOTVNVCREvNZkgPSogr8tfKe2F9xrbJrenjRTB2PbwNQNqCr5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGYhTL8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A693FC4CEC3;
	Mon, 14 Oct 2024 10:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728901389;
	bh=9l8FErKAyGNJ/Ju6TyWHciFnQpsfsS5BT05KEY4GmwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGYhTL8quB9sR7x2U0ogCikL454wr869iIl5VKYisWzjA196fzTkr/gwz7ovaf1ZJ
	 LpLqUbSRGbU/a8dGu7m3W1KwyBBdRSgJuXLZk+QyUOaJT/RRqv6/bkE26X7nM/6KeK
	 efIFowO5sMXAN7TaR9zTYD3663Xp0ff+9+BsgGcE=
Date: Mon, 14 Oct 2024 12:23:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: kuba@kernel.org, stable@vger.kernel.org, horms@kernel.org,
	Frank.li@nxp.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, richardcochran@gmail.com
Subject: Re: [PATCH v3 net-next 1/2] net: fec: Move `fec_ptp_read()` to the
 top of the file
Message-ID: <2024101459-blah-catacomb-73ca@gregkh>
References: <20240812094713.2883476-1-csokas.bence@prolan.hu>
 <172360263324.1842448.13885436119657830097.git-patchwork-notify@kernel.org>
 <196c236b-75d7-4609-958b-fdf458e69a07@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <196c236b-75d7-4609-958b-fdf458e69a07@prolan.hu>

On Mon, Oct 14, 2024 at 12:08:48PM +0200, Csókás Bence wrote:
> Hi,
> I just noticed this series' `Fixes:` tag was dropped when it was committed.
> However, we believe it should be considered for backporting to stable, so
> let this be a heads-up to the stable team.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

