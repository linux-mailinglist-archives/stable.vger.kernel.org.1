Return-Path: <stable+bounces-83282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839F999787F
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 00:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0861C215C0
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA661898ED;
	Wed,  9 Oct 2024 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKrWmWQ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54159145B2C;
	Wed,  9 Oct 2024 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728513094; cv=none; b=BZA9ncY2P708o36OaxjQAl4oSn7TzVshAxYmhBN4jdSChJbX63QbFVbW1k2rEQIxA+ajcuR/8XroTskk6b3UHWKsu8wBToakWtLSgMhKv7me3XT+k7haVYtJhLEa7IbBqpnQf21x4UIvvvgl132597ZAfELaRhlWddUHFdEeXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728513094; c=relaxed/simple;
	bh=/ctDSn+W94oOs7qo3do5T7WuCYl7K5I57xpME4eDnjc=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Ee2QXFM8oNeLCBn/iibm69JjKBRRn0tPUA8mLIEnYgkaVyeib4REeinUzM/M3PefvF1pjcRYuRWsTf7Dd2FNfw7Z2KlWHTrCRzMAH8AJz/mSYtOt8j1uTzZj/1hJIoIdEfScMXVXuSUYKMpj1oUGSmKju22SZ6k/uicCHAGV4eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKrWmWQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AB3C4CEC3;
	Wed,  9 Oct 2024 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728513093;
	bh=/ctDSn+W94oOs7qo3do5T7WuCYl7K5I57xpME4eDnjc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CKrWmWQ21hgGZLilMnIxEvMYqBfMaVmhIkAqx1Rss3KDpE2HnCck71TX73KeCjilg
	 Pfq5vb78mq7yd3HF/e4XOST0XQ0g2yIsd11L+rOTM3LiLUzQl66zFAm9lh95PI9BAK
	 5uAC1oOMG5UvJbY4tr1qXfm8vBCVXwGLp6cFskXN8bIcxu2O/cDNTLi1pNQIjFx2qn
	 j6bGlWOs2h2RhFGpUqLF8vKWDfUl6whAEhgyH01Tv4dFgiVEqn9BpQHHjOnPMm7w3j
	 9QiiZA+iam0pLg3Wa6XKSIynACXvAhc/pgMw3qhcsjMFNZV5sSy1d2Z3peeenI0H/3
	 HvIYFkC5aigpw==
Message-ID: <a0662187e806af01f4faf3f0875c5ed4.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241001-spmi-pmic-arb-scoped-v1-1-5872bab34ed6@gmail.com>
References: <20241001-spmi-pmic-arb-scoped-v1-1-5872bab34ed6@gmail.com>
Subject: Re: [PATCH] spmi: pmic-arb: fix return path in for_each_available_child_of_node()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
To: Abel Vesa <abel.vesa@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 09 Oct 2024 15:31:31 -0700
User-Agent: alot/0.10

Quoting Javier Carrasco (2024-10-01 05:55:52)
> This loop requires explicit calls to of_node_put() upon early exits
> (break, goto, return) to decrement the child refcounter and avoid memory
> leaks if the child is not required out of the loop.
>=20
> A more robust solution is using the scoped variant of the macro, which
> automatically calls of_node_put() when the child goes out of scope.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 979987371739 ("spmi: pmic-arb: Add multi bus support")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---

Applied to spmi-next

