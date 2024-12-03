Return-Path: <stable+bounces-96217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C1F9E16CD
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 10:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED95A163958
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACCB1DEFD3;
	Tue,  3 Dec 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dTqi+A0X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3D1DED53
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217022; cv=none; b=Ba4Tt/AZhGPBoZ5gmDsw0BrL8kpJe4bhxHPIpoRYsMyq+eH1PDxoJD4Mo8DDKAMBL9Wgt9ZU3h9Pv3XcwWYePmS5g4wDnydAsg3fWlX+Jz3nf3Q3oV1uMwUaQN/Mh6DHtvj7+VVm6zqom2TGmhUMrYZy8rzSxw3REcpChSzM06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217022; c=relaxed/simple;
	bh=xxK1q1vt6bmyB/pmCEaYZ4PcqujkgH6ymb74oYX9ec0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g215Lzjw+Td0Y5ahqyXVUu57Ox8lheRkMJOc4RkRR5fM+9hn7iGo32qYYVoi8dI31cwAIQx+3IRdhPfmhUmdEnejWUYV66ucVMryMhBXt3gdEkYUPE98UTCfA2GyyOaGMzXxcetvm5Oug7TeuNrTdceZwM5OSrc5ZbeH8iS349Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dTqi+A0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04B9C4CECF;
	Tue,  3 Dec 2024 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733217022;
	bh=xxK1q1vt6bmyB/pmCEaYZ4PcqujkgH6ymb74oYX9ec0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTqi+A0X0hsKMG7IkY2Js0TqSpRGCtE8B6ts6mILqS9v9PtNDRrXPfz/ShATk5aUV
	 15aU8Ul0aiWJA6fpLuR9TQ3/dexnQZNBCltjgIcfr7Zdo4pdoTuZEQGFqN20PVUy4s
	 YXRVUvRHHBd3t+Qi5ckIHbRhYYDENAY5aLTFTnJ0=
Date: Tue, 3 Dec 2024 10:10:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 6.12 v3 0/3] Fix PPS channel routing
Message-ID: <2024120332-synergy-quadrant-574b@gregkh>
References: <20241202155800.3564611-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241202155800.3564611-1-csokas.bence@prolan.hu>

On Mon, Dec 02, 2024 at 04:57:57PM +0100, Csókás, Bence wrote:
> On certain i.MX8 series parts [1], the PPS channel 0
> is routed internally to eDMA, and the external PPS
> pin is available on channel 1. In addition, on
> certain boards, the PPS may be wired on the PCB to
> an EVENTOUTn pin other than 0. On these systems
> it is necessary that the PPS channel be able
> to be configured from the Device Tree.
> 
> [1] https://lore.kernel.org/all/ZrPYOWA3FESx197L@lizhi-Precision-Tower-5810/
> 
> Changes in v2:
> * add upstream hash (pick -x)
> Changes in v3:
> * Add S-o-b despite Sasha's complaining bot

Are you sure?  I don't see them here.  Please fix up.

And Sasha's bot is correct for this, it's just a warning that we need to
verify the patch a lot more stricter than if the original author were
sending this to us.

thanks,

greg k-h


