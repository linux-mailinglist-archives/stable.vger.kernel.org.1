Return-Path: <stable+bounces-172930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39B1B35956
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE74B16DC95
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DE73074AD;
	Tue, 26 Aug 2025 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+aDotNs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2262FE065;
	Tue, 26 Aug 2025 09:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756201771; cv=none; b=VhM5SEu51YQxuoxmDw+ptpdvFJ4O1BJS46bOkACysW796B9x6TxCnG+5zEe3Mz3KwDe2zyQqBzZS4RA0hPFasaVrVun1hjyCdpbBlyYml8Lp19gct3jpm508IpYSHN0M7sjS3jp4A8vlZT0RPNp64ViEXhs1bf4y4nnri3pt7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756201771; c=relaxed/simple;
	bh=iaPzBqDKWZB4os6/7I6hJ1eE45Ek8EtyobRUhpF3kbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpKbG7+NfL3G6WnqX8IoGvzfatfvTLKjzR9sAfojOTQL2/m88dEpTNPDV4h2mbarackxPHncDoF63RpS0eo+KkkqIYukWPyN7B/uaPDwsPlkv9siAY5OVKw+V0QkZf3EhtkWukTHXyNHnXqpnBQkpxBHaIrNvFx8Mqb4Rsnxs5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+aDotNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81483C4CEF1;
	Tue, 26 Aug 2025 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756201770;
	bh=iaPzBqDKWZB4os6/7I6hJ1eE45Ek8EtyobRUhpF3kbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G+aDotNsQ5ukGAXkmP97Gtbn4fNwPDl6pjMK96C4Pg6keNwhs0A/TTmdc88UGkdlx
	 bnZjymxF9J5Kx0CSHawJtnl+fI/mn+k6EXBgcy/mzJ43MkLF7IBJ3TRnZPb3Lui38p
	 bIbYiagzl4wKiHy4PuoOFAvXJM3aDuAKzMe5AfV+MU1LljCtuCCfQAh5sUlXQf4JoF
	 EwV7Dnr4SBdCmRtJCmCuIFFd0v0nouijsdyzuwh9VwlQVOFmoPxS93Cixub40BaCmF
	 RrHI0SP4LLisEpzro0TeW9SthPOgRQEvah/7rgp4ez19QNOybF4HKPu+2vv+LpGZfz
	 aHz3XlaYBcEqQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uqqIp-0000000009w-2bZe;
	Tue, 26 Aug 2025 11:49:19 +0200
Date: Tue, 26 Aug 2025 11:49:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Telit Cinterion FN990A w/audio
 compositions
Message-ID: <aK2DH9NB7v6uYraH@hovoldconsulting.com>
References: <20250806120926.144800-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806120926.144800-1-fabio.porcedda@gmail.com>

On Wed, Aug 06, 2025 at 02:09:26PM +0200, Fabio Porcedda wrote:
> Add the following Telit Cinterion FN990A w/audio compositions:

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>

Now applied, thanks.

Johan

