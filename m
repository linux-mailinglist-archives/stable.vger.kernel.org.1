Return-Path: <stable+bounces-197035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD8AC8AC0F
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 16:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA232345FA6
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 15:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2671133BBA7;
	Wed, 26 Nov 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIBsTJ2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C430C625
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172194; cv=none; b=qhZ8aWQGDUlxPTmh7GA3phHzmpUNpOoj+AqiGQEDkgdyLYK8lVuPF+Ahy2e8dPLa5TJaKwALrfdC9zyL9Nb8K9pcA8fpGPhLa60GAFbuVk+zeEeFmeyufKMcwljLHtQkErO3IGKGfhauK4XgWlMbkUK5VHqwacTOQnMK00Qpsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172194; c=relaxed/simple;
	bh=71SDsKhNGCzZKaKDKManfDGGo+fnDgpStNjyFiAfuDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brlMBTBguqaRlLmSajTUQ4xX7oG36orBLOSzFaTemdPopqsr1Gc1pbbrMsOzCVs6hXs+ibctkRfTFFQjDA6s9ZLlE69V1tl4TT66trzzHNIFHyGRpc6iGbF/r2C733fORuhuLoaqT7kRKn/Ko5FPK/9BxGrnq29riU34wyhMjYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIBsTJ2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D66C4CEF7;
	Wed, 26 Nov 2025 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764172194;
	bh=71SDsKhNGCzZKaKDKManfDGGo+fnDgpStNjyFiAfuDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pIBsTJ2L87QRwfYgY2yZWh4713pt9hGpFew4FzQf9YiKDE2mchbv27+oRR1o7/cMs
	 feaNBWscxWWmge3rh9LCpbu+lezhkQGifmEhjBV2N4s11HFLuxU/cNHReLKYogQNbK
	 3yUNC+pGLEJmuh8N+VlVxwO5K+PCsEO1Z+jxqJAJIeqgqLEnBiOvkryWAWSrpLT2YO
	 m9qYcM8vVO2T2ecFHVRB/6xbt2Z5ZAJ1dZRzqfmCz8SZS6mjKcllEnTbgL0vRZSQWf
	 /ZV7kdRpP+TZ9L8pNs1Rs+kFlUPuHp6IvmZPvrfV3OpAd4N7tN1omn0gcLpOdPsRVD
	 M+Uw66znIXciQ==
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>,
	Google Big Sleep <big-sleep-vuln-reports@google.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.15.y] mm/secretmem: fix use-after-free race in fault handler
Date: Wed, 26 Nov 2025 10:49:51 -0500
Message-ID: <20251126154951.1400407-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120193821.2353216-1-rppt@kernel.org>
References: <20251120193821.2353216-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 5.15 stable tree.

Subject: mm/secretmem: fix use-after-free race in fault handler
Queue: 5.15

Thanks for the backport!

