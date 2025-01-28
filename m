Return-Path: <stable+bounces-110984-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D02A20E58
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 776051670D8
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD31D6DBC;
	Tue, 28 Jan 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oblb8n5k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932601D6DA3
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081070; cv=none; b=EGI0dmZ18gnACSxm2PQzoA4EzNuMLWqlFhicQP6In/ta8+MwLvUu4x17k93MrxgKc490vA16wPYzN6377o013pytKP+pEQLt293pf1OZWcf1TN7scUzfaBhiKTP2JOoV/xoLHO/I+fb1SArvZRk5TNKk4I3YuN4C8gDs+cykq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081070; c=relaxed/simple;
	bh=4DlCpmFg3KozFMUzjlhagLor+X8WPm7AFOynGY/Tx74=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2cSDmqoc0IBwCNSfCMZAvV1are7GwanvEWQKDEN8rlv/sPqCOj1aC2H9xWCdACd78zODwjuisYr6hcsJpvzXSgBwZjUcCv7iuDcfccHfZX3mnHTbdkkByTgUFnxm4Ohnu4NLZKFNhTIUWIJ9RSgPQAjxxoF1iKXZLgC2uvNvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oblb8n5k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92285C4CED3;
	Tue, 28 Jan 2025 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738081070;
	bh=4DlCpmFg3KozFMUzjlhagLor+X8WPm7AFOynGY/Tx74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oblb8n5kCzXMRI4ldD9Z6ppoXH15qZNxpDdc1NTpIsdgReffZjWsAbvwC0BGWFdMK
	 lUHNnNh9LXzSQ+ss+7ExEIOC0rNIUEq066VzD10vZ4JeWlZ5OUpWpUytI4EVpddFZa
	 ZtUNq0iephfEgOCmJiePBHDHJ+Uo1KOh2SZwnP5epYcpFjEaEjzE0g8IOmnsYgLGLA
	 28hXDAibZ9vz7ZH7nyUUVJYw/98vvZv8Y9FoTf1m5vB5IW6ogJj1FCRYLFVHWMZSaf
	 bd7MebzirHmmqjKtF+rXYaJBuv5u/VFpsRkt8ZTyLCNnpwFWgwgOJnan90qCiDC2un
	 3g4ZbTH8P126Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5 1/7] drm/rcar-du: dsi: Fix PHY lock bit check
Date: Tue, 28 Jan 2025 11:17:48 -0500
Message-Id: <20250128110854-c8d22a7d9ef8497f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217-rcar-gh-dsi-v5-1-e77421093c05@ideasonboard.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 6389e616fae8a101ce00068f7690461ab57b29d8

WARNING: Author mismatch between patch and found commit:
Backport author: Tomi Valkeinen<tomi.valkeinen@ideasonboard.com>
Commit author: Tomi Valkeinen<tomi.valkeinen+renesas@ideasonboard.com>


Status in newer kernel trees:
6.13.y | Branch not found

Note: The patch differs from the upstream commit:
---
1:  6389e616fae8a ! 1:  00d555d12d5aa drm/rcar-du: dsi: Fix PHY lock bit check
    @@ Commit message
         Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
         Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
         Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
    -    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    -    Link: https://patchwork.freedesktop.org/patch/msgid/20241217-rcar-gh-dsi-v5-1-e77421093c05@ideasonboard.com
     
      ## drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c ##
     @@ drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c: static int rcar_mipi_dsi_startup(struct rcar_mipi_dsi *dsi,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

