Return-Path: <stable+bounces-194891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A523AC61F72
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 01:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A11C3A4AF6
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 00:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68DE4315A;
	Mon, 17 Nov 2025 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtiFCBpN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AA74C9D
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763340422; cv=none; b=Ydvk0EGqZ1xunHSUvD0v7OWLQJmI3IPsM9de5IbMsUC4Fu2GR6yvw5LkKYtEQlTmRM7yr8PrK2rOjC/8InR2l8KcRtT5trAMfOpOlgOtRjB43hS+P3W5mseinHZ77iWf4ah0FOusNfXI5PDtubQTLhwQBXPtU8O+KtxJAPCW37U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763340422; c=relaxed/simple;
	bh=CUPTKBgw0WdF7nGsD7yxeah7Cl8OgUDUMve2dz2HbuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5dPzK/eePJRz7ECA//ePTiwAs4zbW9YHx6qeS4Zj87xnh1xNZrnY600U12IgA1Yq2hQa7X0f5d1xFFS7I4XAJEzgTfg07wtn7RjOsYZ9adSxaYza6n3/VM4lr/rGZ8ZQYaVgpbIQfOaK7ORlEEEIJ79a1h1adopeF3Bq37HX4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtiFCBpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00EDC16AAE;
	Mon, 17 Nov 2025 00:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763340422;
	bh=CUPTKBgw0WdF7nGsD7yxeah7Cl8OgUDUMve2dz2HbuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gtiFCBpNjuMXeHRtsqp6hWBY/xfZQhipwfLJg6iMcE+g0HPeW5aq9ctct2hNTRFdJ
	 WMeOezztPLZT1XHZODgeRe9nIRmQJA04QNEcs6z2POCgfDs9ohj9h36In9WM7uDKz9
	 zxpQdmqW7AHdxGAyKl0D4u0fePdOpYB1gCG4YR+8n8HWPaSWDAhNfOZ7RszFDZA3qs
	 cdmKAR5HPje51bNZD7aF+q8AzDXngLT25qsCAPpTBp/FVfBdg1WKQFpjY7PDNptfBI
	 gzFQ2oe82K1xRg1lM/MCQeCF0MfCymdD9/QHi/OJ2xyL7i0BFreCW+0ASAMsX8Dg1n
	 WNTjN15ubGE+w==
From: Sasha Levin <sashal@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.6] lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN
Date: Sun, 16 Nov 2025 19:47:00 -0500
Message-ID: <20251117004700.3737059-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111202941.242920-1-ebiggers@kernel.org>
References: <20251111202941.242920-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: lib/crypto: arm/curve25519: Disable on CPU_BIG_ENDIAN

Thanks!

