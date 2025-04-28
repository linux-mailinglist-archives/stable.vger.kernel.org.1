Return-Path: <stable+bounces-136898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1758FA9F356
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 16:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C15F3B16A5
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0A926E15B;
	Mon, 28 Apr 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Un5qawjW"
X-Original-To: stable@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F521527B4;
	Mon, 28 Apr 2025 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745850189; cv=none; b=Avi0XkBu0R5H6G02w28xPZ446G6xfPYZea8Hkvzt8HOoNRPKB9d6SIfAIKE8rSDIExTgqizw7zU4HE/7Tlk6+jQP05f/3KB1HCMEOBPPcEvirJ5vRp3qQK3RAP4ogu6j95o1rfTDtNYIgCbGSAJo7j5qQFK/25cItmVVn5B/8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745850189; c=relaxed/simple;
	bh=pkWJKi2o7+wr978ci73S7Jnm3yZMHVsqZR/8sngjnNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSrF6GZVIArmDQlfsDnijfYy7xutKzJOICtzMtkMWOSFHnY6rc3ddqM8on4FRnmiBpwGdrRZT8sfZFiIArVxf90QsvVT5TSr487CNxXZF6A+0XvwiGnL9fMUt97Y1cAU6e0DigkilyHaRIvNfs66QER/zAJ7oHT376vr/2tdZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Un5qawjW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KgWHsUCUBEFv7Ycjxi4yK47joNYceiEjUCO7mVk084w=; b=Un5qawjWiRpBR2oqejia2d9Kj/
	xECAGDlhKTvArROD6H9+JryYC0fxjNWD9oZitkfGUwAdn/SV5iv060Pep1TabLnggefqREufbzmH3
	JUZbiAHQ/cfufXb8dNwg2sgOb07ukMIm/J6qv1J0tIjtOaoOKldhb93bWuFUKUxqyeXQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9PNr-00AqV3-I3; Mon, 28 Apr 2025 16:22:59 +0200
Date: Mon, 28 Apr 2025 16:22:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] net: ch9200: avoid triggering NWay restart on
 non-zero PHY ID
Message-ID: <3a84b8a8-f295-472c-8c3f-0655ff53f5cc@lunn.ch>
References: <20250412183829.41342-1-qasdev00@gmail.com>
 <20250412183829.41342-6-qasdev00@gmail.com>
 <b49e6c21-8e0a-4e54-86eb-c18f1446c430@lunn.ch>
 <20250415205230.01f56679@kernel.org>
 <20250415205648.4aa937c9@kernel.org>
 <aAD-RDUdJaL_sIqQ@gmail.com>
 <b492cef9-7cdd-464e-80fe-8ce3276395a4@lunn.ch>
 <aAtgOLMnsmuukU42@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAtgOLMnsmuukU42@gmail.com>

On Fri, Apr 25, 2025 at 11:13:12AM +0100, Qasim Ijaz wrote:
> Hi Andrew, Jakub
> 
> Just pinging on my last message. Any thoughts on how to proceed with
> this patch series, I left my thoughts in the previous message.

I would suggest you do the minimum, low risk changes. Don't be driven
to fix all the syzbot warnings just to make syzbot quiet. What really
matters is you don't break the driver for users. syzbot is secondary.

	Andrew

