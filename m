Return-Path: <stable+bounces-40732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FBA8AF424
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 18:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E7828EBF6
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D4F1C2A1;
	Tue, 23 Apr 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YC59IWUU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA470160
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889877; cv=none; b=ozCGkd/Dcuoz1ICzYxLYFD4NcYa6e1g0euIkoqy2Bu2QBYbxl/Mjiw6wjJCJCwibYhu/Cd32b34je6gCxglfRFV6jFv96LNK5O/eKHNIOHq5TIeyOkJvKvnTmy8hqz6/MmAE6E7wGu8zpKIJHB+wITxEXv3kmGo4otWCT6YL4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889877; c=relaxed/simple;
	bh=RPvu4ZM7dRN9DjxWJkxCrW25RxBMmJK5lFWU0VJVo7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GebH6ULHf+wvw7lQGesX1PnNTVB8ff79lF+l2xMlDF+0WhPqcDlGN4NepGCAQWFjpvsrkA9V5z3GwO6c2it4rCV/uHG4D/QIMah2krMDDjXovT/Ej+U3YS5vyr1JZyU+tYGJvYnDRmPlbLMEhQkDz+zblDJOb5qGcVoqW6jW1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YC59IWUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469F0C116B1;
	Tue, 23 Apr 2024 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713889877;
	bh=RPvu4ZM7dRN9DjxWJkxCrW25RxBMmJK5lFWU0VJVo7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YC59IWUUr+gmhXzuIgeGRmbHacPTpOzLUXiTFGRKd5NYnce8sIjfygZFZD1bcC7yt
	 FueFEVMhuGqxo8uhvQohIG6iJJiHiFU5BtVKeAVtblfRDcEXS1j543pHojmt1pkmdH
	 KD8Wt0diNxnKVtt65DDbDPj8QL06E1DBxQW4zvOo=
Date: Tue, 23 Apr 2024 09:31:07 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: arinc.unal@arinc9.com
Cc: stable@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 0/4] Please apply these MT7530 DSA subdriver patches to
 6.1
Message-ID: <2024042355-delivery-helpful-dbab@gregkh>
References: <20240420-for-stable-6-1-backports-v1-0-0c50ca4324ea@arinc9.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240420-for-stable-6-1-backports-v1-0-0c50ca4324ea@arinc9.com>

On Sat, Apr 20, 2024 at 06:59:49PM +0300, Arınç ÜNAL via B4 Relay wrote:
> Hello.
> 
> These are the remaining bugfix patches for the MT7530 DSA subdriver.
> They didn't apply as is to the 6.1 stable tree so I have submitted the
> adjusted versions in this thread. Please apply them in the order
> they were submitted.

Now queued up also for 5.15

thanks,

greg k-h

