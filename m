Return-Path: <stable+bounces-202696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85100CC43A8
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 17:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8799C308717A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 16:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1FF340DA7;
	Tue, 16 Dec 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GPLy1Maw"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D534029C;
	Tue, 16 Dec 2025 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889434; cv=none; b=DANI2+YeTXidV5pFiuZc4iPkucfriIrMjbpAk2Z21EFMc+0wbQjwBFqbd0slC/P/4m1XiUMZ3a575em7pK9fGFnGkTHEwIjVhXyXONyyxgukqSSJpGQPXvEXHoZOPmzdWJALsUfMdbsi/mppjWogtvj0tqBZOv5Ph4GEKdJFO+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889434; c=relaxed/simple;
	bh=m/J/nUS2/6k0e8ixn+1Yvy1A1GNbKIrYYTkDriBeNCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLR8bZ4LhxvbS1GFunULDFCKbS+YQdNtzbWbs8syV2oDO0K9sVXs45rtx8CQxNKttxOjP5Qco2kxZYsGXldxK1NvW5cJDhKIAZppL6Dwbx5dFfSI+QikP367L5FnfdxMiXaHSbK36hMv8X3/6XMdwQRzWPyTvVLiPV37kxlxDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GPLy1Maw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1765889424;
	bh=m/J/nUS2/6k0e8ixn+1Yvy1A1GNbKIrYYTkDriBeNCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPLy1MawfPTbvM90jC+mVy+62K5qHW7kcFBjDDbt8fJS6Z+fx9vExg6DiZhc/Vhys
	 WZQTGou2B752Pxvqxbx1hzMwFKWb8CSKxS3qFn55gr/cVL886LAo94YYNsCP9fTfVR
	 gSgi2EbZivzN5OfMw4NOjLTV0NLrBtDErYnY2UBc=
Date: Tue, 16 Dec 2025 13:50:19 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-leds@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [STABLE BACKPORT] leds: leds-cros_ec: Skip LEDs without color
 components
Message-ID: <6b4ad836-7c7e-471d-a491-b0e8e68673b5@t-8ch.de>
References: <20251028-cros_ec-leds-no-colors-v1-1-ebe13a02022a@weissschuh.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028-cros_ec-leds-no-colors-v1-1-ebe13a02022a@weissschuh.net>

Dear stable team,

please backport the following commit from Linus' tree to the relevant
stable trees.

	4dbf066d965c ("leds: leds-cros_ec: Skip LEDs without color components")

It fixes a probing issue affecting users as explained in the commit.


Regards,
Thomas

