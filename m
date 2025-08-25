Return-Path: <stable+bounces-172786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49274B3375F
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C027188EDD4
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 07:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7774D288524;
	Mon, 25 Aug 2025 07:04:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD182877D7;
	Mon, 25 Aug 2025 07:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105447; cv=none; b=C+/AhP3mqa70KzyuvBadW9Woxa8l/SaJ5TO5P2tAXitYMCQaQTg2nlzzsr0RnH3ZPsj4994A5XvP7Qtj0tVZgc2wgZdPN605LwT0AlvNAWdQZWgk3VeCmV03LtnyO0itsZFTJxf0Q463TkeCNxRTxyD/7TvMmuveVKtRToBY1Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105447; c=relaxed/simple;
	bh=TWm9MYJoFAfqQdU+/dstSShjOic0usdbGXdhwJjhy8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN5hncT8ZDlMKVAEGMm1wnKa9jWmgHB833NsPkbE+Pg4IH/l9Vp9a40pw+pHv6j5WC27bj3bkexiIyrNQIGnfRkoDOSDhAXs7XwL1/c3h/Lbjo7RzZ1hv7gc+WzulvSlfWo1Hkf/hrhhbYJDvwxJGaeueD/Xe/MgbTh5Msshbto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
Date: Mon, 25 Aug 2025 07:03:52 +0000
From: Brett A C Sheffield <bacs@librecast.net>
To: Oscar Maes <oscmaes92@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org,
	netdev@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: net: add test for destination in
 broadcast packets
Message-ID: <aKwK2AVP7wXBSeA2@auntie>
References: <20250825060229-oscmaes92@gmail.com>
 <20250825060918.4799-1-oscmaes92@gmail.com>
 <20250825060918.4799-2-oscmaes92@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825060918.4799-2-oscmaes92@gmail.com>

On 2025-08-25 08:09, Oscar Maes wrote:
> Add test to check the broadcast ethernet destination field is set
> correctly.
> 
> This test sends a broadcast ping, captures it using tcpdump and
> ensures that all bits of the 6 octet ethernet destination address
> are correctly set by examining the output capture file.
> 
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>

Thanks Oscar.

Signed-off-by: Brett A C Sheffield <bacs@librecast.net>

Also, please add back the
  Cc: stable@vger.kernel.org
line for the fix as this affects the stable kernels that went out last week.

Cheers,


Brett

