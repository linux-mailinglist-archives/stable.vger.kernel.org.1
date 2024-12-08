Return-Path: <stable+bounces-100076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786229E8602
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 16:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6D718831B8
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 15:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507684A3E;
	Sun,  8 Dec 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s6oKQEx9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB7814B955;
	Sun,  8 Dec 2024 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733672904; cv=none; b=Zexey4PLvTBFd+6UCJ70bxR88C7srgUmQ2KNX+JPnbhHQ4PX599Kq0s+7CIFy2svBizM+ETyCwRbWe7+BP01z91RPzJYgxsXKk8n/gZyDfHoTs23Gv2tN/kvJcdiaXDyuLWoOohKZTF9w2imkZIRtc0fQ4i+BqQTbBb5q8mYyFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733672904; c=relaxed/simple;
	bh=VU+tLRADlMGKJ+QJbATntTYgudKNv7zVfLHH2/esa2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhY5SOIaJ2CXAJHJtUFWZ2dNGVW0DXgymwxZR5tw8Rhr9IEFaVuhnhxZr2ojN6q/FDQqgj7SgjsSPSu6BGNnDiPgMF2m1IKG2LWzZcjnOk+DlpqGq+z4H8qqrdrCogfhjAnWbz2D7C2AF7DkVqAMYRMIpL4Q4h2+becNvxtJt+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s6oKQEx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A8CC4CED2;
	Sun,  8 Dec 2024 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733672903;
	bh=VU+tLRADlMGKJ+QJbATntTYgudKNv7zVfLHH2/esa2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s6oKQEx9II08dTybmVOTxH8ShTZokhPrCvU+QMzefqe0Qsls7HyUnHsHkGxedQuTf
	 Yiyl2olA8oicDZBRBqCbCznvTltLC+rzfTQuJUUtunV/afjqlteUswjszlrtVd50gM
	 7RLIY+7O45SpFDpoc9YLVkbmo0cQzDVB+ObI1eSs=
Date: Sun, 8 Dec 2024 16:48:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Selvarasu Ganesan <selvarasu.g@samsung.com>
Cc: Faraz Ata <faraz.ata@samsung.com>, quic_jjohnson@quicinc.com,
	kees@kernel.org, abdul.rahim@myyahoo.com,
	m.grzeschik@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, jh0801.jung@samsung.com,
	dh10.jung@samsung.com, naushad@samsung.com, akash.m5@samsung.com,
	rc93.raju@samsung.com, taehyun.cho@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_midi: Fixing wMaxPacketSize exceeded
 issue during MIDI bind retries
Message-ID: <2024120809-frostlike-dingy-1113@gregkh>
References: <CGME20241208151349epcas5p1a94ca45020318f54885072d4987160b3@epcas5p1.samsung.com>
 <20241208151314.1625-1-faraz.ata@samsung.com>
 <5d4e59f0-76a7-43bf-8a96-9aa4f9e2a9ac@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d4e59f0-76a7-43bf-8a96-9aa4f9e2a9ac@samsung.com>

On Sun, Dec 08, 2024 at 08:58:32PM +0530, Selvarasu Ganesan wrote:
> Hello Maintainers,
> 
> Please ignore this commit as this duplicate copy of 
> https://lore.kernel.org/linux-usb/20241208152322.1653-1-selvarasu.g@samsung.com/ 

So which is correct?

confused,

greg k-h

