Return-Path: <stable+bounces-87566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457819A6A94
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7457B1C25124
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4C1F8921;
	Mon, 21 Oct 2024 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="cpZlIILT"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1F91F8917;
	Mon, 21 Oct 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729517982; cv=none; b=ZuPFFkpNVNhn5wHLcRBFVCP0FV5xETcGj3eKXcnNoR6HruYrBnfIN9Rm2z3t3egh2OU+GSY+YI1ChPO3QerK0fMts4AF7p4NYhraC3Qp7rUF+bayf/8YmdTkUxo3egDFQ20hFU+DOryAVyj/r1j+He4a6DZVPe8EJOT4BK0hLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729517982; c=relaxed/simple;
	bh=lOn/qtlpo5i1bDkC+lQsBswhDJXwxoDx5wi3y9Hgfv0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODmADxvdtWdp1cPp62M8Nkm/HHmqT71x/qW9IQRXuN9ja4aQDWZsN6AiEydihQ0FgrlckYvs1idtsS6sleMOq+eX/LZq/INViFuoiz2z0+0eVEcVnLK2YDYiOAHc6KSuhZojGr1fcG5ysQnDZnrTlaa6AxjL3onqdhCByYsk3NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=cpZlIILT; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Mon, 21 Oct 2024 15:32:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1729517551;
	bh=lOn/qtlpo5i1bDkC+lQsBswhDJXwxoDx5wi3y9Hgfv0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 references:reply-to:Sender:Subject:Subject:To:To;
	b=cpZlIILTI7rNsmSk7TqI/SVX88x2NcRD+Yz7H1z00pDpwloLTMsbwwTNnxxz/cW2G
	 vgWi/wEqHWlWXcZHpoWht7X2j7355id1U1w+ePAYntWU0vtKz+npaqbf2HTVC52Dgg
	 khqNWm9BrTMLy6OHSz/bWSjiwCMFoJ4kruR12+7DEO35YfMSSA9zakaI3hq6IYTc7v
	 T6AYHNyPZqPG7V41j4Ad60/uDeiQ9IuaCNTZSPGKdLJOwEtNl2lXceqzRotOq5xbqx
	 PN2V4WsKy9xHXYtbGnaDe8tRn63Ggh9ZZTxnrxskmrelnl48R9TMncNZez1kGFHZ7f
	 c+wTs7PRSfWWA==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.11 000/135] 6.11.5-rc1 review
Message-ID: <20241021133230.GA11490@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241021102259.324175287@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021102259.324175287@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.11.5 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Oct 2024 10:22:25 +0000.
> Anything received after that time might be too late.

Hi Greg

6.11.5-rc1 compiles, boots and runs here on x86_64
(AMD Ryzen 5 PRO 4650G, Slackware64-15.0)

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

