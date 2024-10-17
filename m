Return-Path: <stable+bounces-86647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CCC9A2942
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 18:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C269F1C21B79
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 16:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A101DFE08;
	Thu, 17 Oct 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VskhPH9C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5921DF989;
	Thu, 17 Oct 2024 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183320; cv=none; b=fnKldrZ4fIv1WLxo/8xJCnF6rqyY7hlan18t+4bW8MYuS6njtNkT7YVit3SUJ4/W3kfhC184j1lJrGVtNs4afb4+SPP/fg3JWmS2SVg6ScTc1MUcy2ZXx42VMBlqBsPfBlzb1h3brRzFXdCL3/M6jTKaeySNMZlRWtvmOaGcGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183320; c=relaxed/simple;
	bh=QqrRnUwymrsqzMxSXyNZsLuECVKOAXLr+MYFiH2M1Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FC2Cxb6eFhUn8+xjSGgLQQZMbQtLpPK/ESLDKDj9l3kEt1B3hAOzeIZXJ5uRrrPNk7d2SorYtHc+K1NDPMOF3IufpvTIBEIj/KXJe2TbPlOsNWHLZMuBPXFYWCdth+h+SkyVP4P/7loChCwuzVFZK0GpRcRydGcqcC8UOb17hoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VskhPH9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E96C4CECE;
	Thu, 17 Oct 2024 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183320;
	bh=QqrRnUwymrsqzMxSXyNZsLuECVKOAXLr+MYFiH2M1Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VskhPH9C8+8Fezn+LmplL1DfXkP9BLZ/ZD3N4w/dUsQiEprnLoOGCxGOpmNfMWyKk
	 kjYCZSYWvtlhD7zm03OIwq/8GqyrcEVM5Z64X7bBdx6watf8/hKNp/dh1p6ASjc2AM
	 HiWovBrs99Gi8T8r0Ww2KFtIxrwCEXeEI/8AnLuMeaFcDlqUrfrb272WpXO5nywzF9
	 l1krSKNY64SFg6rTq/LbS7TQf/WF3vDR2wGJ5ws16MtzOqlm0ZjDmt+OML8kXS6F/6
	 DOSj72YczCYh8ZzQZXH6RPJgVEEqnuZup57T1zZHA1xcx0Zr0sGNpwh2uEQWdWR5y6
	 vrkbfagBbH0ew==
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aurelien Jarno <aurelien@aurel32.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1] riscv: dts: starfive: disable unused csi/camss nodes
Date: Thu, 17 Oct 2024 17:41:50 +0100
Message-ID: <20241017-bagpipe-mouse-340040a59684@spud>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241016-moonscape-tremor-8d41e6f741ff@spud>
References: <20241016-moonscape-tremor-8d41e6f741ff@spud>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=697; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=YRrnZgb3occ2u8F1+5WNnbGzA5NEL9mMGByZT9UlAU4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDOmCdn67Nm1hWLZiqfJBtfWsu/6yPHs4P0n3wqnlR4KXf +tvuD11UUcpC4MYB4OsmCJL4u2+Fqn1f1x2OPe8hZnDygQyhIGLUwAmcuYkw/8qm3eLzFzcGY0n /HxurFnOJ7f21uGHi7deOHuo/0KkS8hxRoZG7iksD76eLff4ez/jcp3kiqnOVYH+Dmd397pUvpr 6u4ELAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 16 Oct 2024 21:11:15 +0100, Conor Dooley wrote:
> Aurelien reported probe failures due to the csi node being enabled
> without having a camera attached to it. A camera was in the initial
> submissions, but was removed from the dts, as it had not actually been
> present on the board, but was from an addon board used by the
> developer of the relevant drivers. The non-camera pipeline nodes were
> not disabled when this happened and the probe failures are problematic
> for Debian. Disable them.
> 
> [...]

Applied to riscv-soc-fixes, thanks!

[1/1] riscv: dts: starfive: disable unused csi/camss nodes
      https://git.kernel.org/conor/c/2e11e78667db

Thanks,
Conor.

