Return-Path: <stable+bounces-98961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573F49E6A1E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 10:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B32B18847A0
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 09:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C7E1D8DE8;
	Fri,  6 Dec 2024 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qb3d2lI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56233D6B
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477423; cv=none; b=l/v0CNXSSpHP9dmviEvjsbJJ2Iuf1ouHmGjbE7irOvmiFbn+1hIFxPdTnjHIndOWlwku7WvZbTl6QpXVVHWpYRosaTUFfM/qK6F1Jxz3pvTrvyy28HAH8lA0qqzBmU27swTXr3tU5P76xY9QUI1tWkuT9+ip7Cr+pueYYKjtWMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477423; c=relaxed/simple;
	bh=JRzX6i3NgxROz5Bzj9gWZFvZV4r8dKrqu49WvJ7IRkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu6dTiJoSxICo/o3I7h15EHlhZnzaqlWbvr01MCM7aJFSDMUnhtq1l0CvT4jhCGdzNRsC5TJQLYXzcITXicJqNQvs/u+3JCF3zVnfTfK/IC+7cFdJoeYMtuC4P/bgeBn/utcmJoAOHtndSJO+3SQU08DmQogUt2ev/2jbk/ePto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qb3d2lI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FFCC4CED1;
	Fri,  6 Dec 2024 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733477423;
	bh=JRzX6i3NgxROz5Bzj9gWZFvZV4r8dKrqu49WvJ7IRkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qb3d2lI/d/zNVDljFJ6UgFKqGT3eirlbtnn71rnUvfV871DUsPMiUHvWo7kMzF8i2
	 QUH+Mtc/KFxPs/Qk+gVp8s4JNv2rAnZjgQK5718aAUtBrZ9HFN7GEX2eLyEpxJ0KI/
	 6hUO9vF0uzR36Sbs4lyEUt3zTHwTUVI9XYnsO8zE=
Date: Fri, 6 Dec 2024 10:30:20 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?B?Q3Pza+FzLA==?= Bence <csokas.bence@prolan.hu>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 6.11 v4 0/3] Fix PPS channel routing
Message-ID: <2024120611-earphone-wriggle-fa05@gregkh>
References: <20241203141600.3600561-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241203141600.3600561-1-csokas.bence@prolan.hu>

On Tue, Dec 03, 2024 at 03:15:57PM +0100, Csókás, Bence wrote:
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
> Changes in v4:
> * Remove blank line in S-o-b area
> 
> Francesco Dolcini (3):
>   dt-bindings: net: fec: add pps channel property
>   net: fec: refactor PPS channel configuration
>   net: fec: make PPS channel configurable
> 
>  Documentation/devicetree/bindings/net/fsl,fec.yaml |  7 +++++++
>  drivers/net/ethernet/freescale/fec_ptp.c           | 11 ++++++-----
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Sorry, but 6.11.y is now end-of-life.

