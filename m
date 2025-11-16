Return-Path: <stable+bounces-194874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CD2C618BA
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 925183574B2
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E4D30C62B;
	Sun, 16 Nov 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hql4hOMB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48450196C7C
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763311158; cv=none; b=bh5D7uS8M6zL1kay5F9QI00zWCFr/EvYHKyG8oX/aAhMcZFod2CtXF9MEkvZb8gEgvXytSXbsVsJ2iAq7e2j6/zZOO0gBDpCFEWS9lwBTB4z+32roS7cqbiVDx31ap1G8x48691WsKC5ncsYfz43k7JRsuJdBIR0p1DXI2iyIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763311158; c=relaxed/simple;
	bh=sqm5Tl0sKC4uITXh3AyEnLuZWp4G8nJtYlZtW3G7mCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbCbhGcd3+oXB+H8riw+gK6lH3xDf6UZVmxSw02p4jzaMce/MGAjoAyuycNGjYA5eUKwGDxi+Q6EbSjZmOjG/gAd8yfL3+bleW+Bp2Hirhd494gR6b98fKAgwiN/QAd8MykKlM9rEjqij5ux/zZGzOkV/RSbaDoJwtw9rg0LwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hql4hOMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4D4C116B1;
	Sun, 16 Nov 2025 16:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763311157;
	bh=sqm5Tl0sKC4uITXh3AyEnLuZWp4G8nJtYlZtW3G7mCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hql4hOMBODHtggo0zm44BFNXsJ4RFulSD35rc1EN2JvaFx+/zQ57Jw+gBSTEayQMu
	 cfBnt4JX70kP3DUcyrA+Mw63E34EEkz1yPuoxKGmwetEmx2pFkIVC3QMKq5vRU49Z1
	 BmxIk/oOXlrg9WhqOjhBswD5mduUbwHCGUuPbdz7Vp+B+R/U1voD2BrP323tovVE7h
	 mgMD8UFDB93hxIFQ2FqfPldWjJEoknkKBWTACxa52PNU9RoF2PlTHUEkdto8x45CKB
	 /MVLVflNGriujVpuexuJXM4x8GLP46mWcS5eLFLmdsllgI/vPOzzK92epHSbrqCTCc
	 PO+Sn8IUB6yQQ==
From: Sasha Levin <sashal@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: stable@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH stable 6.1.y] nfsd: use __clamp in nfsd4_get_drc_mem()
Date: Sun, 16 Nov 2025 11:39:15 -0500
Message-ID: <20251116163915.3588641-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
References: <176272473578.634289.16492611931438112048@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: nfsd: use __clamp in nfsd4_get_drc_mem()

Thanks!

