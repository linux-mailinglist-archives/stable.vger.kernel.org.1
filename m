Return-Path: <stable+bounces-11863-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B1830B71
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 17:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637901C21438
	for <lists+stable@lfdr.de>; Wed, 17 Jan 2024 16:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60BC20335;
	Wed, 17 Jan 2024 16:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aS2JcNDK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FD91E522
	for <stable@vger.kernel.org>; Wed, 17 Jan 2024 16:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510168; cv=none; b=OR4M0aKkZOIBPyt1Lesitm6XtbJF7IXsSytS6b0f8sNgedq36+uIwuqz6YsjkmMGUZyuJ75hC3zpK5i44orhL8ohdnivxR7UcwWWo//gxfgiSduiGIMIkFhtCWJKTGXCoOdB+gW+2cen82/avIQt6k9G+40u3/j/HNguYgsxKmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510168; c=relaxed/simple;
	bh=rlQk4Q1vBQHGF1RF3b9bdYEx5kbIrmsCY0p7pUWkFbM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=nV1ObNgsVoAiNXYRYWtD9Ar2sWc/mfiVdpi7RLrblbCwXuF1u/OfQ6o284x6rWbWGoFxJfn8vr+ufOYJv8gx/hoDfDtaIFRhHfEQ+7x7sQdR/hvD05IeQ4QuTIpVPCe7UCUfLpnOEEPmg9bdjslvkKDKFw7KOD7u2bVnombS4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aS2JcNDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3959C433C7;
	Wed, 17 Jan 2024 16:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705510167;
	bh=rlQk4Q1vBQHGF1RF3b9bdYEx5kbIrmsCY0p7pUWkFbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aS2JcNDK1+BoGIvfxj2E7q7kuGbm9/IxV2+oPslAw8eV7iqgeSnzsPDqBoX1GGP3p
	 7b+3eQ2GOlqn/lpyFE3s+eGnneCQ00dCfENcXB88yuxAC4m3aoJTro8zAfJhXFEhW5
	 Md5prxIPqNWGafqU9Mlp5AvLL4ukmoVYiNsXw60Y=
Date: Wed, 17 Jan 2024 17:49:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	"Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: Re: drm/amd/display: Pass pwrseq inst for backlight and ABM
Message-ID: <2024011750-outhouse-overbid-9139@gregkh>
References: <CADnq5_PCqgDS=2Gh3QScfhutgY4wf4hoS15fW5Ox-nziXWGnBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_PCqgDS=2Gh3QScfhutgY4wf4hoS15fW5Ox-nziXWGnBg@mail.gmail.com>

On Wed, Jan 17, 2024 at 11:16:27AM -0500, Alex Deucher wrote:
> Hi Greg, Sasha,
> 
> Please cherry pick upstream commit b17ef04bf3a4 ("drm/amd/display:
> Pass pwrseq inst for backlight and ABM") to stable kernel 6.6.x and
> newer.

It does not apply to 6.6.y, how did you test this?  I've applied it to
6.7.y now.

For 6.6.y, we need a backported, and tested, version of the commit to do
anything here.

thanks,

greg k-h

