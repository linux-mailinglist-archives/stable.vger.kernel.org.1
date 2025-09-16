Return-Path: <stable+bounces-179721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0499EB597CD
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 15:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148A6460C87
	for <lists+stable@lfdr.de>; Tue, 16 Sep 2025 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482E430649B;
	Tue, 16 Sep 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrF7Hiaf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B12294A10;
	Tue, 16 Sep 2025 13:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029834; cv=none; b=L3HuwNhApYIRLy0BAQRXufd8+kNvcBqBM8VloyEDy9HzlxwZGRON4GkQ5dbc9q7RUOy7U374ZpwYKSvvpZSQ/nQsOoYOhFFuXzHNGeTQCrrUenB3CuL6Q2lHlh6mJS6nxaVU5flPsj9dC218w7yZ+1/Iq7jYPitH2T0A0vgbpCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029834; c=relaxed/simple;
	bh=3gSL3aPwRNy/2x1SBVshXAd3ucKVXAx41bshgbZzZ2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZzCB9GaPDUG+l+1Os7CL4bz8ukQq9USk8iLyVU7IuI4bk3i7LeoJADLYXhzMuVKaLv8zBFg/LXtjMuDNZ1elQ2aK7LWDOd3jALBTidqJXabRxZxS1jYhOdN1EfwklvVotOtM/L46nAtFJogonJcg0PrV1KXwlYUWfSgYJwLEo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrF7Hiaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFEAC4CEEB;
	Tue, 16 Sep 2025 13:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758029833;
	bh=3gSL3aPwRNy/2x1SBVshXAd3ucKVXAx41bshgbZzZ2U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZrF7HiafrfTUVoBcP1d5N1rDlAKZPlajcSBMYbMk/GFpOMI6ce2f+j5IG8KPevymx
	 3jNL1JwxT16sGUR9mshL65b/wqR8gFrlh+IBTHvPOKZOoUNdTsCgjHGi47+yBcbRLN
	 PQd7seRQdf9TsvlhrxvQKjLQdprwRakw23piOiTh72bJAvcBJiUDDKvngsltMPAkgQ
	 7OZyKQnksFNYVDI458fLhBOgvKwXrU+p2r4aUgt78MgHuDD44ahpqSenmDIjCLyDnl
	 NmFdEL5307JHsMglXNMlQr29OpzWnDvrc/BwC8SpMLq+eEP0EFABXlrhHphC1tk8bf
	 w1jrGXXLFWJQw==
From: Lee Jones <lee@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Lee Jones <lee@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250910175914.12956-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20250910175914.12956-1-cosmin-gabriel.tanislav.xa@renesas.com>
Subject: Re: (subset) [PATCH] mfd: rz-mtu3: fix MTU5 NFCR register offset
Message-Id: <175802983246.3793381.4904672352136105040.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 14:37:12 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c81fc

On Wed, 10 Sep 2025 20:59:06 +0300, Cosmin Tanislav wrote:
> The NFCR register for MTU5 is at 0x1a95 offset according to Datasheet
> Page 725, Table 16.4. The address of all registers is offset by 0x1200,
> making the proper address of MTU5 NFCR register be 0x895.
> 
> 

Applied, thanks!

[1/1] mfd: rz-mtu3: fix MTU5 NFCR register offset
      commit: 12981d7b8ab4b3c5b8667581f73d8c4aa06499dc

--
Lee Jones [李琼斯]


