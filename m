Return-Path: <stable+bounces-189163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E386C03088
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 20:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C823E1AA23CA
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 18:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CD828D8F1;
	Thu, 23 Oct 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCMGI8uv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F37F230BCC;
	Thu, 23 Oct 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244742; cv=none; b=jSHSfkzOvKytxzVxdpCPZxmloHc3WoJaJhD70JKDicgnTUN88wCnJUSW+bar/E6rES0FZCNIacC6dn4MBmA+hJauEsnxSDchXXFM6wJoqmgrat8UFwcI76Oq9txknrvvRWOzFvsvFLvIIt2MhK80qWeQ/7VnnJrCBIyDv0bNQJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244742; c=relaxed/simple;
	bh=CMLdyhpydVR0/Nx6iPY2zTrIJoMIDwh4t2xWU0ZSEq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBdz2YQ8tPPpJgL88dO7+4JJKg44lXod4yIQfHaE1vwrGJwXFjc8ijkpznBGlX6L2mgbmJ5/PcdAoWAVtZwyohq0v+T/MZP4Wt97nYEgHcvKm+mYqGAu52sXSv2KUfh0ST3roYZheyHjpW8DzoWceY3RcQPsrQgBzGqzSoKOhKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCMGI8uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86289C4CEE7;
	Thu, 23 Oct 2025 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761244742;
	bh=CMLdyhpydVR0/Nx6iPY2zTrIJoMIDwh4t2xWU0ZSEq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCMGI8uviTWrDUJwu13OthmrVIiNYPGmqEKz6srTaDiSoG+lzBU2ZoefXj3t77Wwv
	 C0Q1189DmcWWNvgMJXjb+3bciCyII2LVyE/3iYHg6yw7IyCCJz5Gv33OmwfDwa+kTG
	 CD+bElQ0GD+hSrr36Xc0J5UlBLXlwaVjOE8k1xUoY3W6+ZoKUEeUhasDge2lnj+FZP
	 Y3YfjTmYxQZl1VbK92QiRrJN33npn41Zg/YdVuXpYkMWGGcvLHqasZXywz+shuzYxg
	 P0aUlrTtmGFDgowhBIPrArbaEcRuulLW5g2/D65V7SZ/jJRyyjsu+8VSwZdmr4b6N3
	 UExTM1ZqDWdYw==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	stable@vger.kernel.org,
	Valentina.FernandezAlanis@microchip.com,
	Cyril.Jean@microchip.com,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: microchip: remove BeagleV Fire fabric.dtsi
Date: Thu, 23 Oct 2025 19:38:55 +0100
Message-ID: <20251023-feminism-rewrap-39719eb7832a@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021-dastardly-washbowl-b8c4ec1745db@spud>
References: <20251021-dastardly-washbowl-b8c4ec1745db@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=575; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=JhXib/kn2jozWLbz0WSVdzkOIm/eAov7GTmNvhuhfhA=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBm/yuyZ1TesPGn/5NQ/h538J4qzTlzbuLU0S2+unHkip yaH4uoHHaUsDGJcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZiI+l6GP3wNtyrXVtpFNBdO OF8z6UnKaXH+On4n0ze6pS9dmJ9piDH8L8s9/+3g7CvvtFbOZ3ogeMSj0/JJ9ryJHNYv7yWs1jV KYwQA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 21 Oct 2025 16:38:37 +0100, Conor Dooley wrote:
> At the time of adding the fabric.dtsi for the BeagleV Fire, we thought
> that the fabric nodes in the Beagle supplied images were stable. They
> are not, which has lead to nodes present in the devicetree that are not
> in the programmed FPGA images. This is obviously problematic, and these
> nodes must be removed.
> 
> --
> 
> [...]

Applied to riscv-dt-fixes, thanks!

[1/1] riscv: dts: microchip: remove BeagleV Fire fabric.dtsi
      https://git.kernel.org/conor/c/5ef13c363640

Thanks,
Conor.

