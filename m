Return-Path: <stable+bounces-80598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A6F98E338
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 20:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90BE1F223A3
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 18:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A477012C54D;
	Wed,  2 Oct 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llQ030eB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD2D1D0F50;
	Wed,  2 Oct 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895368; cv=none; b=jGUfb4wbOlNkaMJPDsYi4uRPFOMx6yzt0hZUsq07/adeF77wAUI1HtM1RvBgeBVIEbTV3Ux0zfUQutESmeR7y3A1ww/7FBrHcugM6uiNXdLVF9YGkgSb6F8OpSpbCMGIhqYzeWa3vVw0ir026dJ/73fKK1cWKFAkJ/HA4qS1nAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895368; c=relaxed/simple;
	bh=SE7J59Bg9Wo8/NwKT0LGz6X0j6hs9IoeehDLRiSg/aI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWBokJ9jzmAmS6jMsWIYDlD1AehchfFzp2JiY74fh6jZH9Rr3KJJO47RaW02tnSmuTdOhAouc1b5zNr5ugH4b+85sGEGrZxuO1ar9Y1jOB0ANULAqVK3zt1pEQ4SYv32FmFSdrURoepg61XZ1OgZ8Ni1dSJGDoxnb549FuLt4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llQ030eB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB97CC4CEC2;
	Wed,  2 Oct 2024 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727895367;
	bh=SE7J59Bg9Wo8/NwKT0LGz6X0j6hs9IoeehDLRiSg/aI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=llQ030eBQTvLkRqDT2s8eShacVyIT/130lxFSK+iPjQL/o8idNrFCXq1wagaDagcG
	 BHAzXaX9arr+CZPU8mw7pcHHCFJDcEfNQSNKlme8bolCfUIODXZ+w/yjHsaE3HSroQ
	 /OZ5Xh+eZU03Z4OgQmS5lk+6dG79SCv/dPICGALSkFdjsMbaXMEIVm/7JrFxHEqJPm
	 1B4DImZVaSX3QgLQebpyjIZDrdwefFKwRn30WfiJzwSdjyO+OiRA416U+tLOfHk3Sb
	 VgHZSkqevAukzdxWrSU71Kn3VjAysqmLmeyUdqgt2NYj1EoXAvXjlh17Kjx0aB0N0H
	 woBWGFCtImQWQ==
Date: Wed, 2 Oct 2024 11:56:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anastasia Kovaleva <a.kovaleva@yadro.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux@yadro.com"
 <linux@yadro.com>
Subject: Re: [PATCH v2 net] net: Fix an unsafe loop on the list
Message-ID: <20241002115607.1d689497@kernel.org>
In-Reply-To: <F4920F6D-1BE9-4268-8301-B69368DD2E1D@yadro.com>
References: <20241001115828.25362-1-a.kovaleva@yadro.com>
	<20241002060240.3aca47cc@kernel.org>
	<F4920F6D-1BE9-4268-8301-B69368DD2E1D@yadro.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 17:53:18 +0000 Anastasia Kovaleva wrote:
> If it is really necessary, it would take me a couple of days to make a test. 

The only tricky part, I think, is finding a family which can be easily
unloaded for the test. I don't see any good candidates, so fine.

