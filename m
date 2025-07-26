Return-Path: <stable+bounces-164800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 385FFB127E7
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 02:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD1AA3FE1
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 00:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155A20EB;
	Sat, 26 Jul 2025 00:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNnNPd/s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA6214AA9;
	Sat, 26 Jul 2025 00:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753488888; cv=none; b=Cl/BV28C05QmuXNAp7n5KYjeoL8rmDuCVLJ5fmAigWhX3uM9DfYzaaeo66ZnkUoQ0zgKubgBzhYUhJmZQNWaqnvIQ5q23uoiGGqb6LW964OMErriDNeyE9o47pGPm8OkWgGfnosYi1yyQnv5bvga2Bm50nTt6bYMg1PnmAbrsEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753488888; c=relaxed/simple;
	bh=iiMBm0oZXR5aBPd+EQuKP+D8dY9mYXzNqyAp/lI5xqc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aA9PGamLPEsGZddPqtsdT00XowRRsTXT4DTVpR/tbgzwCwo260d3CmHfxP2gz8GGZZQe80zYGIUeaV9iq1oevLTceTxhyZYE01wJOhph5lohMXGybxCiD+BSTOK2LfpiVc11CfR+cKZGBXk6CSpz/QIDIe/oddNFUCjXXfqTRao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNnNPd/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B6FC4CEE7;
	Sat, 26 Jul 2025 00:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753488887;
	bh=iiMBm0oZXR5aBPd+EQuKP+D8dY9mYXzNqyAp/lI5xqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eNnNPd/smVxDBRNmt5WJXp1S3tcmF3bqESezaKgUWjoDJaT62xH1JXdtuKMWhZvSK
	 1xbz+27qyPPSQDgrt52FCpxjN8vEXY6Cldb85MrXUxkzEThLO6AFcawY/JnJj4vWZ9
	 lh5u6H5jQBmCJyA87dfrkwKclJh/b7Qk5QGQZt/XXf5indIO6Htp+tGOMBT/P1jhMS
	 guijxX3FR8wPNKWJySD+Tx9FRzlFVFbd4t6FKyfDinxyunO5mhLfdQss33MyUH1+s/
	 DIia0CB9waOzk2z6vWhnThrYpUGHEUFvH1RwzZBUpLXpWgFWkG5emL4mLqlZo4V4Dc
	 AqX4oktx6N9Qw==
Date: Fri, 25 Jul 2025 17:14:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: chalianis1@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, edumazet@google.com,
 pabeni@redhat.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] phy: dp83869: fix interrupts issue when using with
 an optical fiber sfp. to correctly clear the interrupts both status
 registers must be read.
Message-ID: <20250725171446.73bb3f8c@kernel.org>
In-Reply-To: <20250726001034.28885-1-chalianis1@gmail.com>
References: <20250726001034.28885-1-chalianis1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

First of all, please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

> Subject: [PATCH net] phy: dp83869: fix interrupts issue when using with an optical fiber sfp. to correctly clear the interrupts both status registers must be read.

The first line of the commit message becomes the subject, it should
be a very short summary of the patch (100 chars max)

On Fri, 25 Jul 2025 20:10:34 -0400 chalianis1@gmail.com wrote:
> From: Anis Chali <chalianis1@gmail.com>
> 
> from datasheet of dp83869hm
> 7.3.6 Interrupt
> The DP83869HM can be configured to generate an interrupt when changes of internal status occur. The interrupt
> allows a MAC to act upon the status in the PHY without polling the PHY registers. The interrupt source can be
> selected through the interrupt registers, MICR (12h) and FIBER_INT_EN (C18h). The interrupt status can be
> read from ISR (13h) and FIBER_INT_STTS (C19h) registers. Some interrupts are enabled by default and can
> be disabled through register access. Both the interrupt status registers must be read in order to clear pending
> interrupts. Until the pending interrupts are cleared, new interrupts may not be routed to the interrupt pin.

This needs to be line wrapped at 70-ish characters.

> Fixes: 01db923e8377 ("net: phy: dp83869: Add TI dp83869 phy")
> 

no empty lines between tags, please

> Cc: stable@vger.kernel.org
> Signed-off-by: Anis Chali <chalianis1@gmail.com>
-- 
pw-bot: cr

