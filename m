Return-Path: <stable+bounces-114327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22067A2D0F8
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 23:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD5616D60C
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 22:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489591B4223;
	Fri,  7 Feb 2025 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+tRwX8Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0977E1AF0AF
	for <stable@vger.kernel.org>; Fri,  7 Feb 2025 22:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738968663; cv=none; b=c9U7F0qKAvR7/tFPpUs4uZ+0GIt6Lp1UhQweTjNurjLLD+CPl+RgL6IbXLNmctD2yEaPuVxTDuhcuuLImlLIKoJOj8wSs4+GnmaAJPXrO3MKdQ2N4UQ1vsje3bH8eYPklr6zqyGIQcWkNYUBBDLDfLm5aGadNO/zLbBbMCw3R6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738968663; c=relaxed/simple;
	bh=i6DqiG5ZWXr/yhiHgc3aa281+TZhhgUI5o1Tsriydt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LyctnPfTJyWyMDE2/aNN2hagf5aJgmHvhWKRDnrdmJB4TBmlOZJTBDrS2CSHcZJSTMXSL498JivEMB2K4mLcqjkmAasv1ZHfKzBpZnVPW06L4JUgEQ7jhHroqYLvj9LYUM7J7mlkscXYdqXGmCZGu2gPVS5GV49iTo6V6ILdN/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+tRwX8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6BBC4CEE2;
	Fri,  7 Feb 2025 22:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738968662;
	bh=i6DqiG5ZWXr/yhiHgc3aa281+TZhhgUI5o1Tsriydt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W+tRwX8Q34k70jdqZSeDMTY6ZRRGSrpayNSC0ahTDUCGX3Zjovi8nSOwvejT+xFZg
	 ZL4TkdSLG+bfvCIVtJ021YNQcMOP1803KgR8FzllrvAHFygYPw8d1fNvGYchh3Nwdi
	 TijmaFj7HjOhrsUEhhsJejCs8V/F97T/orLnEBeiaq/r/4w2Qj2Vaw0ozw61Ys8gg8
	 G7q1ZtCjaHY7I26Zr6HJB9JC/h7sQm7JbkU87DWJAP/cuH5sqRKqED9sN9iCYI9VZq
	 IXvvIDV+qP9HOPguWRsRZStMpfhB5NtvFqUQhqX+h5fsYs1eh0WWRJApC3EoRI3t5o
	 LcfSqEnxdpj6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Koichiro Den <koichiro.den@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12 1/2] Revert "btrfs: avoid monopolizing a core when activating a swap file"
Date: Fri,  7 Feb 2025 17:51:00 -0500
Message-Id: <20250207164751-e4959845cb6fcace@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250206162217.1387360-1-koichiro.den@canonical.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Failed    |

Build Errors:
Build error for stable/linux-6.12.y:
    ssh: connect to host 192.168.1.58 port 22: No route to host=0D

