Return-Path: <stable+bounces-100554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907C9EC6C8
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 09:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2727188A5DB
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A691D63D6;
	Wed, 11 Dec 2024 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nfg+iqF8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F51C1ADB
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733904958; cv=none; b=cfZykuqYs6Q2tIgEdiG/ixES48pbjFReHZ08LZGg+1x2Hmip+jWTSPBKFFYqCtG3Su+H2CPF91z19EjqrGSPtnP6FciNbeYI2l2szui+kYtzbhCIX+Cb5qiWfFfMjZyLKcwEW4/jTr48S4AnPIIV0fpjd8uglGB5cbBthuLDOU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733904958; c=relaxed/simple;
	bh=eiyPGg+HEjtQ7nC3Q6a1TNQ8wCFZCNLrvy8LsC78rrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZavQzCotDkn4kdfuszkprBejMfTG/RkEAKMwiRdwtYLHn7r0Y2qKGFhTHZ7XlGVrYj5pW3OikT3tyhPFzmvjZ5kfgHQubic2GwujcSzW6FLFV61fgjOSjQYuDcolX2xlPtJErsjbrFClOWV1zXLI4XHha9NJp3vPK3W01+r/6fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nfg+iqF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23997C4CED2;
	Wed, 11 Dec 2024 08:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733904958;
	bh=eiyPGg+HEjtQ7nC3Q6a1TNQ8wCFZCNLrvy8LsC78rrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nfg+iqF80+jA1aF/+hHjhOu+1bhDQ3KU2l08HLvrafG15NIBY38xJnaswZhT8vIWs
	 ZIbimEQnJeao5qc5SBVgM7yxI63HMu9OeS710cjLd1YOnayyrRBor63y4VTsTqLPVD
	 iaVXsQBbZeDZO1gldDKImdLu31/dO6LWUeNUMUPg=
Date: Wed, 11 Dec 2024 09:15:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jianqi.ren.cn@windriver.com
Cc: kory.maincent@bootlin.com, stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] dmaengine: dw-edma: eDMA: Add sync read before
 starting the DMA transfer in remote setup
Message-ID: <2024121117-liquefy-unveiling-dad1@gregkh>
References: <20241206032214.3089315-1-jianqi.ren.cn@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206032214.3089315-1-jianqi.ren.cn@windriver.com>

On Fri, Dec 06, 2024 at 11:22:14AM +0800, jianqi.ren.cn@windriver.com wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> [ Upstream commit bbcc1c83f343e580c3aa1f2a8593343bf7b55bba ]

Please cc: all relevant people on backports.

