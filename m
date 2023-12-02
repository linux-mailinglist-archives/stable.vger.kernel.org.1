Return-Path: <stable+bounces-3690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38ED1801A8B
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 05:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A1A2819EC
	for <lists+stable@lfdr.de>; Sat,  2 Dec 2023 04:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2A08F55;
	Sat,  2 Dec 2023 04:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0Tmj6hr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37928C0B;
	Sat,  2 Dec 2023 04:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A11C433C7;
	Sat,  2 Dec 2023 04:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701490474;
	bh=fPGmDPaKjV8LMrfSaKKD2/2w8V2jbH3SmiSiLi26M04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0Tmj6hrHp7t06Sqv+Y/4N2r4YHquEOmxHUYx+fUaHchKjih0iSlHONwecakzJUl2
	 IO66H2+Aji9o3rfqvoZhV3kElMddcjImiNFoYvuY9cfkLktIKP0DUepvGZm6f9Thkk
	 IGsCK+uOOAAg+EThqHv9tbE6RsHzlxh1cAnhVE9ZWIQ8d5FTrDblVpHZ1DrgPrRQxj
	 /Y7L+j61ZSeeVyHwWRf905+uqnagePbcRjjEFIg8UrIKc2CnU8Y7jbbBqZmY9ACZx9
	 BYoO65fc7x0qpPxttpF02xq24cZNlwRH5rTD+LTpN1tL8MvidzlrAWKgARgi1XfR8L
	 g7YsDM7q2yd2Q==
Date: Fri, 1 Dec 2023 20:14:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: <hkallweit1@gmail.com>
Cc: ChunHao Lin <hau@realtek.com>, <nic_swsd@realtek.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <grundler@chromium.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net v2] r8169: fix rtl8125b PAUSE frames blasting when
 suspended
Message-ID: <20231201201432.20d40150@kernel.org>
In-Reply-To: <20231129155350.5843-1-hau@realtek.com>
References: <20231129155350.5843-1-hau@realtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 23:53:50 +0800 ChunHao Lin wrote:
> When FIFO reaches near full state, device will issue pause frame.
> If pause slot is enabled(set to 1), in this time, device will issue
> pause frame only once. But if pause slot is disabled(set to 0), device
> will keep sending pause frames until FIFO reaches near empty state.

Heiner, looks good?
-- 
pw-bot: needs-ack

