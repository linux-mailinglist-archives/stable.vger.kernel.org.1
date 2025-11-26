Return-Path: <stable+bounces-197040-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D66B6C8AD56
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 17:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B8244EBB1F
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDCE33A719;
	Wed, 26 Nov 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grovtAUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9F13321A4
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173269; cv=none; b=tHhY/CgaSglrXUdKIdG6Z+TZxFlAN6ev3mkX69aoHET3+fdoXfjQ+V9DNHov1aN46P+zf/Y4sAOrS7RvlW/W9em5Mvh2meJJHlSoHFA6EP5Z7pj3Nbmo92kjEzyL45N9Vd3ZPBfSHXYmokk4IIdL3TBRXHBruae5Lbe59pOfVYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173269; c=relaxed/simple;
	bh=0S2kMUIXOC8Tt+FBNCS+V6tcNeNpmKS71au6IjV2R7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swj784JrTMCScU2J77YY+s4X7mOMc56CfSV9qOvFnEbHvygcR08tjbSObof3+EdZvrz0WlS8dwriZegu/ShtR0vPtSGIXFbWzPoDSPyb7Ap3mZ8QAvNrx1DYiDbDJEhxw4E9Cp/fW7jKYOkldE4SGWgI8kYP5PrUc9ee5P7UIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grovtAUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61469C4CEF7;
	Wed, 26 Nov 2025 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764173269;
	bh=0S2kMUIXOC8Tt+FBNCS+V6tcNeNpmKS71au6IjV2R7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grovtAUtKSxobHLF7Kj4oHTgGdww+uTjto22cwZgcJmWY9we6PtowvomZF/N5K48a
	 u9h0KDGiTW5I3IY0itT9iJFcYy3IFEK1U8/ZBQwXP4XCP3z35zhJwkW9ggryt82liO
	 ZBemmv8pU/V1lp5J9GpSONr0u/9xUyVBI8inwY6sl2+Phk8zlsTaHvFuWdd3EKW0gl
	 2u8kmzBgwm8XAtlO8g0wKoIKyxhPOLJ2xcHwytRwIAMg/nbUvglsDGKJhyI0s4Q+VR
	 fbYCp/Pr9ilpG3ygK1csebAdnJO9fb0wH98+1NpjldBVWAcLjEx6xlY6cOFh6zfzfy
	 6WovrVJsD2kmg==
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org,
	"Isaac J. Manjarres" <isaacmanjarres@google.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.10.y] mm/mm_init: fix hash table order logging in alloc_large_system_hash()
Date: Wed, 26 Nov 2025 11:07:47 -0500
Message-ID: <20251126160747.1404704-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120194041.2365029-1-rppt@kernel.org>
References: <20251120194041.2365029-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 5.10 stable tree.

Subject: mm/mm_init: fix hash table order logging in alloc_large_system_hash()
Queue: 5.10

Thanks for the backport!

