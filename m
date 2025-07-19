Return-Path: <stable+bounces-163433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B30B0B005
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 14:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F2717610D
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C3028726A;
	Sat, 19 Jul 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgZK+PhL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3626B973;
	Sat, 19 Jul 2025 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752929351; cv=none; b=TvBAP8H7oaYdcOpK/sCRmeGXPKsp5RbDNNxKoLRG6JoibBcGxnU3xZ3F86nQhnbCAEi5N1UOL3lb8fPkbMUn3Rw5m1j+nqi8M3w6E6gkL8KutX3KaAUWI4ydSVIN0CGfCSrAgJPqxazLc23N3CqhYIjMvM4hmVSa8xdvaau7NHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752929351; c=relaxed/simple;
	bh=JhG4cUlhKgYFQz3cgZNnjli9ESfpxaxEnJSPQZbW0Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RH1PQHDE7QcO1esQMgVUCEFvCaOJmUmXWG7Vcv3QuWvl3RmivX1rmbw1atrrQlsfk6yv5yEgz9/5JM56PWDSGqSH03u91fQJTorx2dpVGu8Hf+ZetSMSATc9b8maFKHNbgcZLPwdsUoLr4BemR35wbBxKlbXF8lVvjDshTAuRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgZK+PhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCECCC4CEE3;
	Sat, 19 Jul 2025 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752929350;
	bh=JhG4cUlhKgYFQz3cgZNnjli9ESfpxaxEnJSPQZbW0Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgZK+PhL9KcwBlBqF6apnlNa9jTsn3quUdEnM1NNxcGjj7WCF1J3z92e4dN0sAC0j
	 e/O5xo//Jx5pfrivRhHvDCqY/xFbG5X5Ff/uzMnBg5lMOjGBFCSHXTWDwAIBz/LgM+
	 pAlyV8aNhc5OMFxT/tLpFMP2Zo46Lx6SKS7YCOyPAmL6n3m2H+LU80WB6g8NRbzQIr
	 HZX1JMS4SoTk7FcMYFGlsc7e4OZv78ZlfKL4KbV7fg/X1cBQK9LC7M+H9YK9GMAEM3
	 Fu/6O2P8t2eRnWbq5WWkDY2nFtssRp3/AQu4qgAvEVtePejIGNaDdv+iNgloeF7wii
	 CZ68vIUfIdtXw==
From: Sven Peter <sven@kernel.org>
To: Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nick Chan <towinchenmi@gmail.com>
Cc: Sven Peter <sven@kernel.org>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: apple: t8012-j132: Include touchbar framebuffer node
Date: Sat, 19 Jul 2025 14:48:40 +0200
Message-Id: <175292930372.11148.7080198294186970764.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250620-j132-fb-v2-1-65f100182085@gmail.com>
References: <20250620-j132-fb-v2-1-65f100182085@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 20 Jun 2025 18:35:36 +0800, Nick Chan wrote:
> Apple T2 MacBookPro15,2 (j132) has a touchbar so include the framebuffer
> node.
> 
> 

Applied to git@github.com:AsahiLinux/linux.git (asahi-soc/for-next), thanks!

[1/1] arm64: dts: apple: t8012-j132: Include touchbar framebuffer node
      https://github.com/AsahiLinux/linux/commit/d1cf32949f9d

Best regards,
-- 
Sven Peter <sven@kernel.org>


