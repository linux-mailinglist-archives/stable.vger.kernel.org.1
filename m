Return-Path: <stable+bounces-185738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B667BDBECE
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 02:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB3004ED196
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 00:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53C91E0083;
	Wed, 15 Oct 2025 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMl364V4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C801DE2DC;
	Wed, 15 Oct 2025 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760488356; cv=none; b=ZWkM7L8Vab3aIrO9T5mIam1nkuTcOpv9e7iUOlR1ipZE3BnuGfioGynVqJP6hVCgYfkfU082JKU7W76ijx8RruX8S4mqYQpm8sv1kOXyiiAHOO+lnL/DhOO91dbpVAhgS2hh9pjXmCESKG3ni4YtgN1qLcXGZOZm2sRMVSFMmNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760488356; c=relaxed/simple;
	bh=EyQ6n6kLz174hXErkmUFQr35cTgFtYucHIhk2EuvxIM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pEe+ga/SvkUYL+OIFlcWpnd3kKV0dci69PhIB3UaEKWbY97xc7gZoxrEYAHhfJUmdCDS5R1HJ4MvKvvJvjUJwmA+5Nlt440q6ty/cfXMrdfgljgDmuISaSZUaVKWXHtOzuTrg6ujA4SP7hHG5GPS6AkGYTSL8wExB8H/vKI5Uz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gMl364V4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2950C4CEE7;
	Wed, 15 Oct 2025 00:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760488355;
	bh=EyQ6n6kLz174hXErkmUFQr35cTgFtYucHIhk2EuvxIM=;
	h=Date:From:To:Cc:Subject:From;
	b=gMl364V4yX0VH0WLLJ1sPWTrGOshGWNMfModLU29tOWS7MhqDPgPNc3J9wsqVSm2X
	 hsNhxR5K1vY7T0sJ0Iw0FGLUQLAkREZPEVxFr8YlKZSAoytGLR61QhOq50bmWi0q65
	 SD2E3d3y9uO7DtFN9wd9lvsP4cjlcI65LLG9DLS8zJZZIA8xzUXVJ+dsaIc339sTYO
	 /rIbsgDMTU5BipigVWj84Gibd5ngpuSmrytn0uECb3mT+MzYpE5DrLuvbHulqBCmnt
	 owLjSmpi4zJJMNyEPJYRefNyNGp92eXY+JxsYyyfd4IcFTYpw+dZM8v6l/nhMMNLMs
	 6vza+YE3J79LA==
Date: Tue, 14 Oct 2025 17:32:31 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Apply 2f13daee2a72 ("lib/crypto/curve25519-hacl64: Disable KASAN
 with clang-17 and older") to 6.12
Message-ID: <20251015003231.GA2336835@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi stable folks,

Please apply commit 2f13daee2a72 ("lib/crypto/curve25519-hacl64: Disable
KASAN with clang-17 and older") to 6.12 (and possibly 6.6), as upstream
commit 6f110a5e4f99 ("Disable SLUB_TINY for build testing") was
backported to those trees, introducing the warning for at least 6.12. It
applies cleanly for me. If there are any issues, please let me know.

Cheers,
Nathan

