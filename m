Return-Path: <stable+bounces-134875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C7DA9555E
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 19:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA83188F2D3
	for <lists+stable@lfdr.de>; Mon, 21 Apr 2025 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B81E411C;
	Mon, 21 Apr 2025 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEjnqsu5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24B1C8611
	for <stable@vger.kernel.org>; Mon, 21 Apr 2025 17:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257196; cv=none; b=hdd0YEGFbnaBBDYKtzbLJ6DLrGHS2qfs+l4A3LuOjUbQB3jk1jT+40eM1c/d77k+A69NIkHebCr25wy8vTFel+0ZfPvUUqzD5WooUnm2954Ry3+Swev2ej9FDaeoCkPKP95Z8es+aoyLBrJyrUqKu1Agkm5FHFgffHWSI3F+XdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257196; c=relaxed/simple;
	bh=sHDr1Ub3FqinoCXpeGYipAZY0jEQqRcxJTmn/A8TwUs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uDwz0SHFkusfxRln8gD4pT7cLdX9fjafrxnMDe3lB9pGtSGH/sSmDD7ir16xQ2glW5jyo/B6tKXgQ6Go774l3SWNWKRi/7aHkpz6rTft+az9+xcwK1s9nhekNIJM0ocKT8uXSmcKrusMxh0PNyScB306NB6dqMTcAmYkqkD46t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEjnqsu5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4431CC4CEE4;
	Mon, 21 Apr 2025 17:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745257195;
	bh=sHDr1Ub3FqinoCXpeGYipAZY0jEQqRcxJTmn/A8TwUs=;
	h=Date:From:To:Cc:Subject:From;
	b=GEjnqsu5+4K0O9oKiFS1AWpgZp5npQD6dmtAm9r9T0IzI/GlR11yrtx0QtOZBVvgI
	 MINDUkON7R9aeaONKVq9o2C6M8wH676RrUVLukp3lWsNHkjvlSGS7p1fm+McbQwIHM
	 AuUMpG9Be52b1ojmZgQ9EsyTwMBGVBLQXs3OhP+yxHYjQaz8UxZKt3e4tB48DBnZ7x
	 1W7RZLs1EHPiJ8+PyAR3RSETRyeq11RNyCAfLlOe2Ol4z7XwxNQLMz1/hyL0GV6gTi
	 4DT+iXmAfXT+hbJwiVRoln83OyTle1b6P2tUFzeX8recNrAKK6KVnq48wG7uoBwEvM
	 V50IrN9xX9Ycw==
Date: Mon, 21 Apr 2025 23:00:39 +0530
From: Naveen N Rao <naveen@kernel.org>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Santosh Shukla <santosh.shukla@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
Subject: Please apply commit d81cadbe1642 to 6.12 stable tree
Message-ID: <j7wxayzatx6fwwavjhhvymg3wj5xpfy7xe7ewz3c2ij664w475@53i6qdqqgypy>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Please apply commit d81cadbe1642 ("KVM: SVM: Disable AVIC on SNP-enabled 
system without HvInUseWrAllowed feature") to the stable v6.12 tree. This 
patch prevents a kernel BUG by disabling AVIC on systems without 
suitable support for AVIC to work when SEV-SNP support is enabled in the 
host.

Thanks,
Naveen


