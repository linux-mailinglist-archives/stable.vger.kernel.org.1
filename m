Return-Path: <stable+bounces-197018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA142C89E6C
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D2A3355FB4
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5AF1E5B64;
	Wed, 26 Nov 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKzpojkb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182671DE4F1
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764162288; cv=none; b=PbCkM0tIPkUohQwBO38GcGLZhSqPYOMKTOY01RZ0pd2wuHGclppT3QxniQIqotMsnVTNM8VCiUjAxRp8woWfNL/AIsGbuV9xZwCh84BVRg9VdXMhOQR2G5C+C/oDgzZMklvbIzkFRL3Dd5YxiVHT5oVDuNTVoSrNuB1Wtd8Nzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764162288; c=relaxed/simple;
	bh=17aXOz7dIp4QdC55kxqNCD+7/lh6naXTojMsoAbDFeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nz0uysmoqT3l6AjqFa939dau1nyzkkJEvNG/mTYT8WsEMV5VUTUla5GJT9c7JySLKvoqt4VpnQri9vYX4mLshIXebpml03Omkd9wA9tluqusS4MPnY5eKrlhf3AHN3KSvoIADo57orUrHvh7UIVjcIBL0D0tK8CMiSSibEDrrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKzpojkb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F2CC113D0;
	Wed, 26 Nov 2025 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764162285;
	bh=17aXOz7dIp4QdC55kxqNCD+7/lh6naXTojMsoAbDFeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eKzpojkbDdy94+6E+eqtr0Ctyu+cJJioeG6/uJR4ct+nTGOl1pQH7pfTiPBO+47Te
	 1t28sw6y0mhW1VqEGbmf5TYEX4v8GVJVnPjLUk69MyOsrJ7XCIS+ApU4HbjXS/kbZe
	 zVmVCbORsgaecbyQ1y6fNG4UJt5RPU29eWKZlVU8fnXFhQW3FuimhJDbOusxLMczjY
	 v9j3LIavscmmTpdpJfDwMzOaVhlmcFk/CcNTPpWqZU8QDKfErVlczEykA//GOWHO2e
	 +2LrnaE1K4yFGZoyMfqt7clCfnHFkKCSVij7LbkXSRxX7NitCy5vhZLxortTZn+qGc
	 RvUG4yv/9vrtw==
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org,
	"Isaac J. Manjarres" <isaacmanjarres@google.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/mm_init: fix hash table order logging in alloc_large_system_hash()
Date: Wed, 26 Nov 2025 08:04:43 -0500
Message-ID: <20251126130443.1371016-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120194222.2365413-1-rppt@kernel.org>
References: <20251120194222.2365413-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 6.1 stable tree.

Subject: mm/mm_init: fix hash table order logging in alloc_large_system_hash()
Queue: 6.1

Thanks for the backport!

