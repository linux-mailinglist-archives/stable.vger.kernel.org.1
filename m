Return-Path: <stable+bounces-87669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FDF9A986C
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 07:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B86283381
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 05:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6913B586;
	Tue, 22 Oct 2024 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+SJPPK/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B5585283;
	Tue, 22 Oct 2024 05:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729575119; cv=none; b=cUf9cSsbCmt+1/qwLOJaW2fU/+LyBi/mEcjkJVFUqDJqYOZmaWOYKnSLS86smasjIpL8GGGQWb8YwZh752MyWH2ALu6vrNwSXfUCwkI10D75EaaI0eMpgqFimFdsfsZylqqrNIA4LIM4fjOy9EdKZnYS2EH8tW1lhAVzPHaM930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729575119; c=relaxed/simple;
	bh=mh9QedYCt3HTFEzVMeEAHY0QnNAXySFrFQF8d9IlB+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dlgwNqL/+vzr/lQQx33ccIyIt0EFy3EBTDAmL23sSi3zFEuVKoEApSM4CZazjREYvIiPvD5lLsLPe38d+cNeCZcJQvDKSvw1zfvGV0a0M1fxJ7/3CB4mxigPDaylBgADsTeiMeTBKWYWOujqynUHxXGdcTEEgbeX6Lw8N2++wzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+SJPPK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC6BC4CEC3;
	Tue, 22 Oct 2024 05:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729575118;
	bh=mh9QedYCt3HTFEzVMeEAHY0QnNAXySFrFQF8d9IlB+w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=V+SJPPK/5nh6LhJWRpPxB9xZMuL2jDS9P+9GqGwxSkqUc9JWxxTOt69I3UQ77dh63
	 /KaoOZOVuw+s2LSbHKDu8iiA+mDXNHNbYW3UNOnaCm+QRJiDLqXuyX2l4/rz1SJWbj
	 htCH69dVv7EdR0sbrfgWdD2QEZIvxlm/zpivoljuTk9OAeuqGBatK+4KIjifST2lWW
	 OWWG80X6U2S38jExpCoBOe7xMUl9YYQ7bmI/RGsbM90bbO4nHk2GAQ1y+rj8XNO+B5
	 9RKf+moU9BZXTs16ZnR96o2iBfSSZUHRzMT+nWgYfiWVxU1Pwe6mvSRCg8aToCI8dm
	 G+hPNKYTW9QHA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: festevam@gmail.com, hongxing.zhu@nxp.com, imx@lists.linux.dev, 
 kernel@pengutronix.de, kishon@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, marcel.ziswiler@toradex.com, 
 s.hauer@pengutronix.de, shawnguo@kernel.org, stable@vger.kernel.org
In-Reply-To: <20241021155241.943665-1-Frank.Li@nxp.com>
References: <20241021155241.943665-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] phy: freescale: imx8m-pcie: Do CMN_RST just
 before PHY PLL lock check
Message-Id: <172957511545.488725.11335675052541592569.b4-ty@kernel.org>
Date: Tue, 22 Oct 2024 11:01:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 21 Oct 2024 11:52:41 -0400, Frank Li wrote:
> When enable initcall_debug together with higher debug level below.
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=9
> CONFIG_CONSOLE_LOGLEVEL_QUIET=9
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
> 
> The initialization of i.MX8MP PCIe PHY might be timeout failed randomly.
> To fix this issue, adjust the sequence of the resets refer to the power
> up sequence listed below.
> 
> [...]

Applied, thanks!

[1/1] phy: freescale: imx8m-pcie: Do CMN_RST just before PHY PLL lock check
      commit: f89263b69731e0144d275fff777ee0dd92069200

Best regards,
-- 
~Vinod



