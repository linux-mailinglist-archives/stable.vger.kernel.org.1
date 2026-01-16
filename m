Return-Path: <stable+bounces-209980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D12D2A10F
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 03:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94DAE302D92F
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 02:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DC42222C5;
	Fri, 16 Jan 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZnG4dTd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EEA20C00C;
	Fri, 16 Jan 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530018; cv=none; b=YUtVBjC3jHrWppl5PVkDGv3DzaY2E/EhRRN5EniqjjpZum5unXwKP2sjGIh3W4uLvy7xo9O+MJ1OQ+p01ZG9pV6R2DdmB6oVLWUpwaMvZEeus+pg1vRTME0/FBN8tD/uScd+sDZBWIxMdD8oTdu88ABDXQB3ZQvp056lIqcXlMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530018; c=relaxed/simple;
	bh=EG1hY4Bj4RYTqTep9iIgJg/7syTPIFuY/17rX6gtjqM=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=dZL9osZ8Z+YMhGrQoPbySQnaZaTJFH3J8UH362yUG/bswD/dYFnwxgXI05/mETNu6yr4dtDP5UtpuaWZNysT3VQUhLpaIjJdGnoaIhSpeB8gyQ9AVvKL2XBEO3lcDwLWFBcY+hkM5w/B/g4qSuFTmfSgrZupnAA4++xWZheiWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZnG4dTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51492C116D0;
	Fri, 16 Jan 2026 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768530018;
	bh=EG1hY4Bj4RYTqTep9iIgJg/7syTPIFuY/17rX6gtjqM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=WZnG4dTdOLUw4oTH5wlBwJrxGQDkv9wbhTG6chJsVQKfPL/fBhcLP+HcWvxqnMSGL
	 Bz0r+4bHtQQhUMzGIk/TAqiwHICLrOJv8hlZaJ7Gzagi2OU1y4xaG1OOfCmhAyFJ8h
	 nd55Oy+VnZJL+MRibGdirDMLIbk4k7rX1BvBYm8IpjoZ6YxMUt/d+GBEAtfGupHtGg
	 20YUghOK5FzG3mDbo0poYawJuerdqqlQvLnAMnViPVb7HNrffmpvavYRELx1HY7G6L
	 pYTMwW9fPJr0rQciKD0aXBBgmscJl3vgtONIRP+hiYFkefHZ/ot5QwWgJBgV+5Pez6
	 np9RqeS9kiL0Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251231-spmi-apple-t8103-base-compat-v1-1-98da572086f9@jannau.net>
References: <20251231-spmi-apple-t8103-base-compat-v1-1-98da572086f9@jannau.net>
Subject: Re: [PATCH] spmi: apple: Add "apple,t8103-spmi" compatible
From: Stephen Boyd <sboyd@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Janne Grunau <j@jannau.net>
To: Janne Grunau <j@jannau.net>, Jean-Francois Bortolotti <jeff@borto.fr>, Neal Gompa <neal@gompa.dev>, Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Date: Thu, 15 Jan 2026 20:20:16 -0600
Message-ID: <176853001644.16445.12638081232487224512@lazor>
User-Agent: alot/0.11

Quoting Janne Grunau (2025-12-31 04:41:32)
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,spmi" anymore [1]. Use
> "apple,t8103-spmi" as base compatible as it is the SoC the driver and
> bindings were written for.
>=20
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@k=
ernel.org/
>=20
> Fixes: 77ca75e80c71 ("spmi: add a spmi driver for Apple SoC")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Applied to spmi-next

