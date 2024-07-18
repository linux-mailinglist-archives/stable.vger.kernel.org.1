Return-Path: <stable+bounces-60579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E5A93526D
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 22:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7CC1C20EAF
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 20:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C61459F0;
	Thu, 18 Jul 2024 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTqI/faR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFB8143C54;
	Thu, 18 Jul 2024 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721334787; cv=none; b=VwxaoLVyQUdlDXFnjAXDXeXKkCdgDimreeEM6SPKKcZaEwBv/GDiHoSjoux7E15P11ayyShOU5TQXxSXsw5iOTpLzf6iyPHy8oCWKRwm+/7tGUCZbkYziHwh6cGWcpaYRptcPnEnDUjh5Q5COKQ/Da+OALcWkITD0Y1BsLK+wIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721334787; c=relaxed/simple;
	bh=gkOQjHVgkWksHQhhjsLjr2yUzFyuuGf3Wyh87ogw9bw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=DtNwXd4puOCfVSk6BlmD0HFGKrnAIEXAJ2Ic2o7JKuv1VZa/K3fbrGCetUW4q8W0WKAnZrTtyodWHnLn0eFqM9e5z43StJsZfdqkFddQwb0OLH3NV60CUx34gUhHJz3qcL1GoiBORfqSTMu4Uqyi9llXTvN3C5ofj3aN+I3ZKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTqI/faR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED425C116B1;
	Thu, 18 Jul 2024 20:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721334787;
	bh=gkOQjHVgkWksHQhhjsLjr2yUzFyuuGf3Wyh87ogw9bw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UTqI/faRxZD9GEOdsBCC3Hl1FCKMsh5HX1VdMQf3pX1z3O85/M13qLzpgRmIYbMtD
	 5z/gRo3JK2e2DOHFyjwPwCLzg7w/B0DqXA3LLpiEj6GIgGgqhJZj8iQtrbLz7b4ZJK
	 ogYUuc3A0qnzU5edX8FrZgSfWixpqQfeBhs9CqL/gZchKzFSz9o7/A7pONJpd0c6Cy
	 2ub3Bao8qECNtvtVZAsbnYgbq8aecBhEUdVddp2gZUxXeYHygHW9XfWWP6C4uPsbHa
	 /d0ykkU51RvpfK6+nmEe1IoyVfx9DowIw7+s2iA975fkSlTQqROTVb5y3dl0IWF3kl
	 njSTTyZaiKxyA==
Message-ID: <1551a3c354c3aef60f6cd27edd169273.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718115534.41513-1-bastien.curutchet@bootlin.com>
References: <20240718115534.41513-1-bastien.curutchet@bootlin.com>
Subject: Re: [PATCH v2] clk: davinci: da8xx-cfgchip: Initialize clk_init_data before use
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Herve Codina <herve.codina@bootlin.com>, Christopher Cordahi <christophercordahi@nanometrics.ca>, Bastien Curutchet <bastien.curutchet@bootlin.com>, stable@vger.kernel.org
To: Bastien Curutchet <bastien.curutchet@bootlin.com>, David Lechner <david@lechnology.com>, Michael Turquette <mturquette@baylibre.com>
Date: Thu, 18 Jul 2024 13:33:04 -0700
User-Agent: alot/0.10

Quoting Bastien Curutchet (2024-07-18 04:55:34)
> The flag attribute of the struct clk_init_data isn't initialized before
> the devm_clk_hw_register() call. This can lead to unexpected behavior
> during registration.
>=20
> Initialize the entire clk_init_data to zero at declaration.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 58e1e2d2cd89 ("clk: davinci: cfgchip: Add TI DA8XX USB PHY clocks")
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> ---

Applied to clk-next

