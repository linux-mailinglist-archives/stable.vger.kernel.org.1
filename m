Return-Path: <stable+bounces-159104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47758AEEC16
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 03:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CACB1BC1641
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 01:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8461386B4;
	Tue,  1 Jul 2025 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIgrU53c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1322301;
	Tue,  1 Jul 2025 01:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751333488; cv=none; b=foXXQrZCpDExc+XM8s1aFlnj4k/dyf4W5StDJSULBQitOmAu4FVfQy/YzhO1CODj/HM9Sc2s8XcGF8hU67e+73WBK1F/9l+XP7oZjsCj4pEtVmAu/fzmvnnxF9llZGq1NANyg69e9QSugh8OLmOt4vcQOEaI2rPHyJNyLNHxbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751333488; c=relaxed/simple;
	bh=e7bKistve7YivYNZJKLgWgbkpZ/EM+fxOApOd2EJ2hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8izK3oThYv4kgHmpBxCUBlA1i02x2TKoqRCgcgXKiw9mMAIZ+pYhfGSvyPbTUbZi09adGZmsDzOtWbZ11BUuwsihn7GNHCPhLxTT11WRGcSZx0sSjEO9oKoHWsHyF1dEdZ6fDG/6/wy1pJxrweokCMtoO/UyET+rl5+ORt6xZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIgrU53c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8EDC4CEE3;
	Tue,  1 Jul 2025 01:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751333488;
	bh=e7bKistve7YivYNZJKLgWgbkpZ/EM+fxOApOd2EJ2hs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rIgrU53cbbjPQIRetD7V7EB1bzCO0cgD02IxMFjBxmBFJOswyXp61LlnEXkNluk8b
	 XwFVUEKpYNpQl7hPRX7vK0Pfr8hdNwXxDCtW6260cpNPgJjXA/1CLTjPKpzD6B+2lo
	 4o+9LOIBsCr2oz2h8kxTPeh8UqKmt0JhQI5XqsMQaYA8bG1F9eph12rxg4CKfdGLFU
	 rOv/YqgNAngtXM7DBO3AI0zzjfOXJHLCb15+IO9q5nAvBN27Wchk+N0vV0oD6XG/Td
	 bhi38ooB+xO0NjON64MCbq2DxIAKdjWWUUwRn/CYfRF8rr95NrXHlJ3LOgON0LA61f
	 9z9bgfIQTtbGA==
Date: Mon, 30 Jun 2025 18:31:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH] net: libwx: fix the incorrect display of the queue
 number
Message-ID: <20250630183127.0eea7b0b@kernel.org>
In-Reply-To: <7F26D304FEA08514+20250627080938.84883-1-jiawenwu@trustnetic.com>
References: <7F26D304FEA08514+20250627080938.84883-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 16:09:38 +0800 Jiawen Wu wrote:
> When setting "ethtool -L eth0 combined 1", the number of RX/TX queue is
> changed to be 1. RSS is disabled at this moment, and the indices of FDIR
> have not be changed in wx_set_rss_queues(). So the combined count still
> shows the previous value. This issue was introduced when supporting
> FDIR. Fix it for those devices that support FDIR.

Why are you hacking up the get_channels rather than making _F_FDIR be
sane in all situations? I mean why not:

--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1709,6 +1709,7 @@ static void wx_set_rss_queues(struct wx *wx)
         * distribution of flows across cores, even when an FDIR flow
         * isn't matched.
         */
+       wx->ring_feature[RING_F_FDIR].indices = 1;
        if (f->indices > 1) {
                f = &wx->ring_feature[RING_F_FDIR];
 
?
-- 
pw-bot: cr

