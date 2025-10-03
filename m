Return-Path: <stable+bounces-183159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86785BB5F7A
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 08:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68513C86E4
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 06:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57A818D636;
	Fri,  3 Oct 2025 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HFWxwBmJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885A28C1F;
	Fri,  3 Oct 2025 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759471743; cv=none; b=C27guutMuhKYZZwtDvOrNDD/5SwIClaDDdBJLwFOKayf5ykfaBzWXiLQLsTuQhyyVCIrDqG551NSazglJG1+MhO2MFqw1AWaw7AvkHNQ9f/mVcRT3h0p3ZNStiBkM2H2kDEtMvgGBSMBzWMpU7l2A6k+9IytcbRK7+6Ya0PE6m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759471743; c=relaxed/simple;
	bh=MGnWNNkjxSVPfXqh8T4hdxl0VmxnWhU+xSmUT7pP/Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2oYApAin6zkFf0K4Q/F7e1WTfevkNhbXnkVvir+aF8wvtuHPJo1NrVq8koJNdIkyTzSvMakVjViY4FeaqeLMruvoUXbXQL/Sx8MNZYTQydRfNJsCEQpFl08YhgSxERSz7UqENkG4SB2WIq0D2bxlbaJAy7Ve6AX7cb7PiIoxZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HFWxwBmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F50C4CEF5;
	Fri,  3 Oct 2025 06:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759471742;
	bh=MGnWNNkjxSVPfXqh8T4hdxl0VmxnWhU+xSmUT7pP/Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HFWxwBmJvPIPqA9paMAYTqNFPlUh0r1eTJe5dmTjrWykJMcGdURzuZbKSPHztCxhh
	 EgvVN9Cqi3qsTfAD1O8Cj1FdB9IAcykN5CY/KQR3yqAqWh/MPdI0n0xQ6zkogylk9k
	 Ogfyn+KCX5HZjqRGbuylbgLXeiTrGn31pIPJWVYQ=
Date: Fri, 3 Oct 2025 08:08:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gergo Koteles <soyer@irl.hu>
Cc: Shenghao Ding <shenghao-ding@ti.com>, tiwai@suse.de, broonie@kernel.org,
	andriy.shevchenko@linux.intel.com, 13564923607@139.com,
	13916275206@139.com, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, baojun.xu@ti.com, Baojun.Xu@fpt.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] ALSA: hda/tas2781: Fix the order of TAS2781
 calibrated-data
Message-ID: <2025100350-botanical-operation-9dec@gregkh>
References: <20250907222728.988-1-shenghao-ding@ti.com>
 <d11c8b06ec79871df74f893da41e81c2f1bcaee2.camel@irl.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d11c8b06ec79871df74f893da41e81c2f1bcaee2.camel@irl.hu>

On Thu, Oct 02, 2025 at 09:26:06PM +0200, Gergo Koteles wrote:
> Cc: <stable@vger.kernel.org>

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

