Return-Path: <stable+bounces-96218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA839E16D1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E6C1611B1
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B497D1DE8A3;
	Tue,  3 Dec 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHmAqz4W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6BB1DE4E3
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217047; cv=none; b=sAP3B5jdf139zhC6JW3QfMrgbydv2ShvaS56Md7TBsKaZ/Bk2D9BAiMd19zmZGGbmddCfNlSngowyvX0eUCU1H7jCM5XvM00WuiltQMnir4UEAND5mHl/x+0R9e128PjCJUTY5PQwwFiA9q5wUH36ZfROYIv/kmDqjog8WF7u0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217047; c=relaxed/simple;
	bh=944GVJnklr31nX/wAsGBzQxv5+A9H9gecnpYSX4Xg1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDLzi4cxyccYEotcejsD/GD91C8oTKM+vbWQ2CUN0xkOmQtWtBZbrPA0p8FEZ0zDQ0Gk5T1W8slVSxfCAF8wI08ukYyLanonmbzQHInNWHBmuqJhsmPqifU1fxylKnYrWLxyNxNgXQVjL/kbN6F/hbkGvshNrcoQfkLALl5BTpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NHmAqz4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471D3C4CECF;
	Tue,  3 Dec 2024 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733217047;
	bh=944GVJnklr31nX/wAsGBzQxv5+A9H9gecnpYSX4Xg1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NHmAqz4W3kT4W+0VZvqypZMYYJBdsKchJLKu+7Z7Z9gKxiPIRJKN2XPEfhTFSZrwL
	 edLMnBUMj1EvKYMfTyLHzwh0ShnwyqfsrHte2YyNubN9J6j5XFvntmpHmJxA9a5EMD
	 KIBtWPAjkK5+xxWAaArdWiJ6W0eRqopVEDob7aTY=
Date: Tue, 3 Dec 2024 10:10:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Sasha Levin <sashal@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.11 v3 1/3] dt-bindings: net: fec: add pps channel
 property
Message-ID: <2024120332-affix-scoff-94d1@gregkh>
References: <20241202155713.3564460-1-csokas.bence@prolan.hu>
 <20241202155713.3564460-2-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202155713.3564460-2-csokas.bence@prolan.hu>

On Mon, Dec 02, 2024 at 04:57:11PM +0100, Csókás, Bence wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add fsl,pps-channel property to select where to connect the PPS signal.
> This depends on the internal SoC routing and on the board, for example
> on the i.MX8 SoC it can be connected to an external pin (using channel 1)
> or to internal eDMA as DMA request (channel 0).
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> (cherry picked from commit 1aa772be0444a2bd06957f6d31865e80e6ae4244)
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>

No blank lines here, please fix up.

thanks,

greg k-h

