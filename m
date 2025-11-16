Return-Path: <stable+bounces-194875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D00C618FF
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63B83AE096
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B96930C372;
	Sun, 16 Nov 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFqDGjTo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9025333F
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313056; cv=none; b=AazhqMB726jdsrivrJUW7mw5SkEUIge8KVC6WfH5fYHirUOBoJSpw65sof6Y6tIdmnqh+/9ZYYO8L2kKvKhUt8KrijPywvhS31gNX+hcukaw23CZWlexeBXVGmCqJ/aMVBKAWkGGj8aAtVbNhBbuC5hVGrWI4ezubKMokccJdOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313056; c=relaxed/simple;
	bh=v8xVUh0legxqT0KCOulHRL/Wo1FSUCbl/5BMwmQjMq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1nEfp0nDbKoES4LWE7EOe/iHjBO4ElrrR9gb9FR7I0XNPSAr2QTckAu28wgVbptDG+DnjqBn8fVNODJv9QVldsh8m/07+C4qrSMglDqJnkAfmw3QkRpIfsrIsWrfsYoGSRTp1gl95rWYPLhYqJ7eD/Cap/dXGrWxahWz/ThtWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFqDGjTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C66C4CEF1;
	Sun, 16 Nov 2025 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763313055;
	bh=v8xVUh0legxqT0KCOulHRL/Wo1FSUCbl/5BMwmQjMq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFqDGjTomRSQS9ciZwTsd/Rs6sBW8qgJt57kvwi5xUEwd9qZhvunvq145Xoxinxb0
	 bBwN86bLL1ACvIxdYZIdHLqN40GpGDu/QvjLvOU99fR2kR8C6LtxPXZRjm6q/Y9Y6a
	 nrdLo41s76F6VX+O1XQYM/AQtRnOrbwPD1FqxXWOxCyqfo/SbVGFNbJymcOQGsN3qq
	 sJfTehsx/ldWxpYpRPrlSxEt/wSYM6o1TLl678ba7mMm8IEO8spQDamC3CJa8kBiLB
	 p1Ujbu5enCgceu/STVyBLSRpA7G9xmd6HQJEWtlirR2Fke2yScEItxRMtzd6b7hNZr
	 n+3xm7Y3k3z4Q==
From: Sasha Levin <sashal@kernel.org>
To: Jakub Acs <acsjakub@amazon.de>
Cc: stable@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 6.12.y] proc: fix the issue of proc_mem_open returning NULL
Date: Sun, 16 Nov 2025 12:10:54 -0500
Message-ID: <20251116171054.3605266-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111081926.8505-1-acsjakub@amazon.de>
References: <20251111081926.8505-1-acsjakub@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: proc: fix the issue of proc_mem_open returning NULL

Thanks!

