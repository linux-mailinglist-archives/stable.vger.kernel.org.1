Return-Path: <stable+bounces-152617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C822AD8A78
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 13:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFCF189D8C5
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 11:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99F72D5C78;
	Fri, 13 Jun 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tl7P6l97"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EBB2D2392;
	Fri, 13 Jun 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749814244; cv=none; b=k97t2w4c4nm6D7m8gKL1LRoQoIoWHBvDKgyzlh5L79HrlMrrLKavI9LqY2AI0p9L5RzcfLpdRVcW6vM/L6uQlkDLnj77vLZijz3b16A8it/NZglKVsYJ2QSAvGOFphy3HEx4fY8n8Qye/+i9y0RH9DsWf3NRaO7QUFGIdW7/JxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749814244; c=relaxed/simple;
	bh=fKaEXM82Lo7S4nejpjTamokjZxkFmTO2OuYbJtxRBXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNRwtA/ikW9cfMQap41RCB1VK2HN68ki5Zw0sdxZXSeHaiJG4nu5l1BVm2NGQfYc03KBGQrTiR8r86SEWTXGHPDrP/dMCDDQN1YD1qREghBQAOegeBUzyYgaJxorO7jYsVFOkoGCguppeuVLKEGjoIRuxKu3S4hiDPW43UxemVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tl7P6l97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84C0C4CEE3;
	Fri, 13 Jun 2025 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749814244;
	bh=fKaEXM82Lo7S4nejpjTamokjZxkFmTO2OuYbJtxRBXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tl7P6l970i9E7ubkajOLSgJfWngtT+204zANfmMffPbqNuPJahyLPUkKeb6PHBwvr
	 y7xdpf4F9hzARr596upXoxCuwHRZSyrWQsOnd+6/p99yz+TNWe3rSON/wk8ipPYf3m
	 MushoSVMLa65rSM3TDwF/4zWlPzyRTbPnuqG0rHqM+TdbfcCK0A/5mRhsUVF8ayChW
	 f+jH3Y4obZKMEQF/5rI8S7vcwFRrNsWMEMfLz39VYizwXLrGoZoBVwx0V2LCQxyCHS
	 HSIqJzuUhD7RypW84DRgsR1IhsEGIrApfvBy74NdK1RyvjXImJGp3ktcFZft6fZuAN
	 gBqd9pEHrddLw==
Message-ID: <1295512f-2856-4e1c-9a07-742433de5d50@kernel.org>
Date: Fri, 13 Jun 2025 20:30:41 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ata: ahci: Disallow LPM for ASUSPRO-D840SA motherboard
To: Niklas Cassel <cassel@kernel.org>
Cc: kernel-dev@rsta79.anonaddy.me, Hans de Goede <hansg@kernel.org>,
 Andy Yang <andyybtc79@gmail.com>, Mikko Juhani Korhonen
 <mjkorhon@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-ide@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>,
 stable@vger.kernel.org
References: <20250612141750.2108342-2-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250612141750.2108342-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 23:17, Niklas Cassel wrote:
> A user has bisected a regression which causes graphical corruptions on his
> screen to commit 7627a0edef54 ("ata: ahci: Drop low power policy board
> type").
> 
> Simply reverting commit 7627a0edef54 ("ata: ahci: Drop low power policy
> board type") makes the graphical corruptions on his screen to go away.
> (Note: there are no visible messages in dmesg that indicates a problem
> with AHCI.)
> 
> The user also reports that the problem occurs regardless if there is an
> HDD or an SSD connected via AHCI, so the problem is not device related.
> 
> The devices also work fine on other motherboards, so it seems specific to
> the ASUSPRO-D840SA motherboard.
> 
> While enabling low power modes for AHCI is not supposed to affect
> completely unrelated hardware, like a graphics card, it does however
> allow the system to enter deeper PC-states, which could expose ACPI issues
> that were previously not visible (because the system never entered these
> lower power states before).
> 
> There are previous examples where enabling LPM exposed serious BIOS/ACPI
> bugs, see e.g. commit 240630e61870 ("ahci: Disable LPM on Lenovo 50 series
> laptops with a too old BIOS").
> 
> Since there hasn't been any BIOS update in years for the ASUSPRO-D840SA
> motherboard, disable LPM for this board, in order to avoid entering lower
> PC-states, which triggers graphical corruptions.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Andy Yang <andyybtc79@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220111
> Fixes: 7627a0edef54 ("ata: ahci: Drop low power policy board type")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

