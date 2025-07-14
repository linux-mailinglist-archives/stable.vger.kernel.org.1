Return-Path: <stable+bounces-161930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0935B04C68
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 01:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C98337A27C5
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 23:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0322749C2;
	Mon, 14 Jul 2025 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPLAFFyl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F84DF76;
	Mon, 14 Jul 2025 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752536107; cv=none; b=GouMfx3Qjsse5XAYq9SmM5DbUqnUlJ7x5RZsfFIPAK2uk3BuqDeEs8QLOwimbRACEcEYCjrr4v5Sa3dA+4z7/NOWPlYKzzknkCkl/41yV0vM9hAi9ZqUUmhh2PQtPVvYcL1NoOufg8ffQuL9QV4c2oBjXJxoOhrNk2WIdgr3OaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752536107; c=relaxed/simple;
	bh=tndqYKv5PsHCA6xhpRVxrUkq6dpnqkPjmvdWrg3TSTA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OrOvkwEQTxR9cqxXtthfPXFMRM7EarMmW98ohC05RN8LSKMrX+5fSFvC/RPC/0ax9kNTt3ylajclgqhwBa5TvWtpaqQcFCc44zdUwCIdptKq62HeYz/yf/OQQbaSM6zzHTLxo7mO79z3zT3a8WNgiA7luHD4AOe/ZxqkTDV2Hw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPLAFFyl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBED2C4CEED;
	Mon, 14 Jul 2025 23:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752536106;
	bh=tndqYKv5PsHCA6xhpRVxrUkq6dpnqkPjmvdWrg3TSTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dPLAFFylvSdb1xbE2nsGzNaQW3ptcx44wtwElfUX+VxxlH8E9VOmUp1y3sFRgaNd0
	 UjyPpl3VVLwZyuW6y98qKDcUc0KHtsHzwHTvRYXcbiF0Hq11wqNZ8rgros/EWqzeZC
	 u+jPJK7luDlke1/bRa6mzewl0diih719NdYVVaJdiJXTYuUOA2fSUGEcspd0c3YeLn
	 tT5JE1Ku45nyrUYQ3awurkhlDjhejbfljr0yD3bDhOmAGiK9aq7cAba5ktzEJFwKRv
	 7Y3SYnV4UXDSNh23YSnARDVWPpDjaLm3SObB8gw9kDRLyRzCq5LJp9vPnF+5JKi0qS
	 u1NPsZ5K4HbHQ==
Date: Mon, 14 Jul 2025 16:35:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: John Ernberg <john.ernberg@actia.se>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ming Lei
 <ming.lei@canonical.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH] net: usbnet: Avoid potential RCU stall on LINK_CHANGE
 event
Message-ID: <20250714163505.44876e62@kernel.org>
In-Reply-To: <20250710085028.1070922-1-john.ernberg@actia.se>
References: <20250710085028.1070922-1-john.ernberg@actia.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 08:50:40 +0000 John Ernberg wrote:
> Having a Gemalto Cinterion PLS83-W modem attached to USB and activating the
> cellular data link would sometimes yield the following RCU stall, leading
> to a system freeze:

Do you know which sub-driver it's using?
I'm worried that this is still racy.
Since usbnet_bh checks if carrier is ok and __handle_link_change()
checks the opposite something must be out of sync if both run.
Most likely something restored the carrier while we're still handling
the previous carrier loss.
-- 
pw-bot: cr

