Return-Path: <stable+bounces-105620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE8C9FAE51
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 13:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B57164789
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 12:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142DD1A0721;
	Mon, 23 Dec 2024 12:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sXHIhEhE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752C19DFB4
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734957505; cv=none; b=EibMH7lM8Gh+aMwHpAAqP+Fz4k+VQzWiMGPB1Uavlz2juNpYVPlEHucQTrjmNx8mErnQCISfqBzRX3HGcIPuDTQCNQ5Zd+2IbwrGTZhSNL5V+yBXyuWnooFRnzx7a150GQYz4Dw2ZRSHPDcGgNm6AVHgy4iUvktAD4IB2bZJgB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734957505; c=relaxed/simple;
	bh=TlpeCYk/LMgSrVgpXgElsgZZ7BdKH4W2zCU1BX/TdSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rxz3dZoK6VJTCuFU92DD7TFL+GlnQISg8Obnefu5EXAPkNxWmygmURMtb/M/faGJTbE9TnOFrLMge0oEykspDQASenB/1Q4Rlj/E+1yr4CharNZqrMPwTHl/g8PupWkeLvZPLfeLNaiw8dng7Cqh7b/1dn5R0rvBTozobbAODk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sXHIhEhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A64FC4CED3;
	Mon, 23 Dec 2024 12:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734957505;
	bh=TlpeCYk/LMgSrVgpXgElsgZZ7BdKH4W2zCU1BX/TdSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sXHIhEhES3LyVGrMva/j2LeHIFrX5ApzM27vg4nhGhbCLQpdVKfmagd17A3VCMqaY
	 ih4IcNHoIoHs0jDLa87MNu0SahFupExNWj6GNQLpN/5y0NBGduergpCO3bKh6H1OF4
	 KjMxgPbealD4TSLIso/pSBLtwPeOd1yVu99s+H2I=
Date: Mon, 23 Dec 2024 13:38:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 6.6 0/3] Fix PPS channel routing
Message-ID: <2024122313-unsworn-think-a029@gregkh>
References: <20241217175042.284122-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217175042.284122-1-csokas.bence@prolan.hu>

On Tue, Dec 17, 2024 at 06:50:39PM +0100, Csókás, Bence wrote:
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
> Now that these patches are applied to 6.12.y,
> it is time to include it in the upcoming 6.6.67.
> This series is picked onto 6.6.66.

All now queued up, thanks.

greg k-h

