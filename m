Return-Path: <stable+bounces-53833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3879290E9E3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 13:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47DC28A5C5
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 11:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A27213E04B;
	Wed, 19 Jun 2024 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9UnC05P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A8157478;
	Wed, 19 Jun 2024 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718796972; cv=none; b=X87qYTNnpezrBwZfgA1ZS2LR5uh6cEqRzVVc1DC2zqmKpfrzcRqLhMM1pBnRvejUSAfpeK7b6p2RHKZChXvGAIbbWCkGaQpCc1JlgipAC4TAHFfC5kDlUJUJnNQYQcdt6HDgXPsoWywHs/+D0HOWWU+5zT+ktYUc45o/R7JP6dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718796972; c=relaxed/simple;
	bh=bJoUrQep+Xld5CWrSeUQDKonP5r/o9cAywy+GxrQR4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZMvSz02uiL7tJoTMRCQudgD/YIID45p1pA2lPBcxuuCmiGs0BDYqV847jbFPRzXNghZHUFBjPKmx5ubzLh2x/LMxXhwz0rwZLyEvbgN+XXVltpT/SjcUPDrvUH7b1889YFC8EOqQjTXg/IqGi+8HBZd60Xgyb+2Z0gx2vwXmYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9UnC05P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31E2C4AF1A;
	Wed, 19 Jun 2024 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718796972;
	bh=bJoUrQep+Xld5CWrSeUQDKonP5r/o9cAywy+GxrQR4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=l9UnC05PwBWOHL7lJetZ4WReM9XTAQBkpd4xhSydIsvLnqqj8by0ODArJtRPQ9Y+T
	 RJHzPsVeX1K/P013InlOZY+l3BdBSg2AWnRFEgI1Rs+kJ0Uq5vh4If24xu5uQ2DqQ0
	 1Y+sc3OJ2gdSEEpQQ92iyFoyQJGnI+n9w35UOMLTtmhHSRUXUHsrIBJnkd7xdDucik
	 oCnQrmgsq1zywqHi2/gXZNPqOtVmjxx1HsPQjD/h/v5UeOmn/t1gsh75NIQ+g97OBN
	 V6AAZa+YtBD3hXhsZQDZflqueprnmc3sY1XFDphe+wku1cXpyia3IbUmz38uoQsrlZ
	 cO3fgGn29FdrQ==
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Jian-Hong Pan <jhp@endlessos.org>, Niklas Cassel <cassel@kernel.org>
Cc: stable@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20240618152828.2686771-2-cassel@kernel.org>
References: <20240618152828.2686771-2-cassel@kernel.org>
Subject: Re: [PATCH v2] ata: ahci: Do not enable LPM if no LPM states are
 supported by the HBA
Message-Id: <171879697042.2747608.12473669104731916394.b4-ty@kernel.org>
Date: Wed, 19 Jun 2024 13:36:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Tue, 18 Jun 2024 17:28:29 +0200, Niklas Cassel wrote:
> LPM consists of HIPM (host initiated power management) and DIPM
> (device initiated power management).
> 
> ata_eh_set_lpm() will only enable HIPM if both the HBA and the device
> supports it.
> 
> However, DIPM will be enabled as long as the device supports it.
> The HBA will later reject the device's request to enter a power state
> that it does not support (Slumber/Partial/DevSleep) (DevSleep is never
> initiated by the device).
> 
> [...]

Applied to libata/linux.git (for-6.10-fixes), thanks!

[1/1] ata: ahci: Do not enable LPM if no LPM states are supported by the HBA
      https://git.kernel.org/libata/linux/c/fa997b05

Kind regards,
-- 
Niklas Cassel <cassel@kernel.org>


