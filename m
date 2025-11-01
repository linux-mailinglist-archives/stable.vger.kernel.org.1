Return-Path: <stable+bounces-192010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AF8C28605
	for <lists+stable@lfdr.de>; Sat, 01 Nov 2025 20:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC2E63492AA
	for <lists+stable@lfdr.de>; Sat,  1 Nov 2025 19:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21CA2F2915;
	Sat,  1 Nov 2025 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqdu+lEN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C79B1DF258;
	Sat,  1 Nov 2025 19:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024726; cv=none; b=QB6nY6h+WSBCw4kEbZu1IA5YUDdkRX8LIop8lBcwmXPyVIPTg1c6FPep5Ipt3rkhEyw3g7yrt6QokrYhNsNUhSqy6ioGZqzgXWwOlJHpraXhPm7Xdb6qfdI+B2ulSBX38yVvRX7Dyd6ZQJA5Xt/IW62GuRAhkBht59Ion8D72no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024726; c=relaxed/simple;
	bh=cnUQkYGXHjUcsZLZYm3sflJvG/VHZobPvnFjdGX4Llg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMdvR9h8KKN0DIkbjU88OWxO2zMVDCIWgCgwO+0ZJcLkfqHaOmCP1BpLZkZ1iLAovbfxIycBj6j55NRxRu6NYpunbx+mAMqXXySzNXQYCWtihGXLfyN77ari5QKje7NnJTPjSgA9lW5gYq9V2voGpJSL18xNaiqFz4P1DvNZh0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sqdu+lEN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB229C4CEF1;
	Sat,  1 Nov 2025 19:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762024726;
	bh=cnUQkYGXHjUcsZLZYm3sflJvG/VHZobPvnFjdGX4Llg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sqdu+lEN+gtoab5z29ZcPYfKo0KNPIOgZ2FrYYpW7g0+xvOpmzP1VyHSijJKtgMQ9
	 4vlhlUwyeaK8BcwOp2OmXDorSwQuAN2DMdIRyVSIXZ8iIL54zz/NTzxY4mdRJQ9b5t
	 i1ESd+JIrZ9eM1Xpah0VZxq6ZvDUMnJ8tMM0jbK9NxC5F01rL0fnq8kRBjl7fzXbgh
	 8BKnZRim5GLjZGk5DIDGWYtHkQXxBxPO0pQFe4M3Xcy+rHVoLxXjabV8POOpvTkKdS
	 /J4YgjOXPrBJa+jmPB5lIMBxTrI8NABQdbG8ctPoZQnSbB+qCby8gbDIDKZvxN10QK
	 hbYgmFxfRSYXw==
Date: Sat, 1 Nov 2025 15:18:44 -0400
From: Sasha Levin <sashal@kernel.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev
Subject: Re: [PATCH AUTOSEL 6.17-5.4] net: macb: avoid dealing with
 endianness in macb_set_hwaddr()
Message-ID: <aQZdFNHDwM6zVOgZ@laps>
References: <20251025160905.3857885-1-sashal@kernel.org>
 <20251025160905.3857885-63-sashal@kernel.org>
 <DDX8I8XRC06M.2BIY9ACNMI9ZT@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDX8I8XRC06M.2BIY9ACNMI9ZT@bootlin.com>

Hey Théo,

On Sat, Nov 01, 2025 at 10:01:27AM +0100, Théo Lebrun wrote:
>I know about the Fixes trailer and therefore include it whenever I know
>my patch is stable-worthy. Are there any trailers to mention that a
>given patch isn't stable material? If not, would you consider adding it?

We have one! It's in the docs, but basically you just need to add:

	Cc: <stable+noautosel@kernel.org> # reason goes here, and must be present

-- 
Thanks,
Sasha

