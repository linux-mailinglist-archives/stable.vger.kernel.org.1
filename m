Return-Path: <stable+bounces-197050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D9C8BBC9
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 20:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0736E4E0452
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 19:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0874E33F8BF;
	Wed, 26 Nov 2025 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFWJnEtV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42333E34E
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764187108; cv=none; b=KKVdLskt6RgSBj4whIHySLRrBJT2RlKbPDg8cxehbovc0wHohYqWmPpoqhGykfmUpTEfBADvOoxETZt9ET0fiXdEO3SxEmuku8RS0q+rSovTKFaaKFpyn6oaQ/oQ3o1vrFtdVKCWdVzmavfQORHAxZANFdmzrh1kgHiO0ZQOOgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764187108; c=relaxed/simple;
	bh=ZyjwIRHUvXqeFzHfbJqP6kt7RNkoGDOxdkJWr8DaDKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9kJtBkHrmN41/Y9naXhBrwyxyg0trbdCLFomL5FTcOYi2dsJBizWnRbQy6bBQws2VDxOdMMblBRUfVFGCECQVi9nUvsUUGoDxrxsQpTDKdDJhUOqK/WzSFgMhy7WCPA7idqw3kTBqyZrX+ErPzew6xfj29Pf4LnzUzkJcWX+qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFWJnEtV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57ABC4CEF7;
	Wed, 26 Nov 2025 19:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764187108;
	bh=ZyjwIRHUvXqeFzHfbJqP6kt7RNkoGDOxdkJWr8DaDKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFWJnEtV1azWokifyMq7cwV7MOId97fxb9uIIK7B/JlTCYB2bSEbD3DO9k+OBvMfv
	 CGAdXGP1qP8anuRXi1X3S5CfdaqSYA6rNo6jo8y1ldmhapUUakZjtsl6wqrzpxpjpq
	 gwOnXuwIqJ4Lpm+bGslO46wCX2KtxNmdTuWoK+oUU8xy7q32y6KmoPBahAUoptLD7W
	 w6l9Bs6xt43vtYcjwg69Is9Zjti8XDxwQXWdlZZMVDIlLqb0OyyZk8YHPniMBXYPKd
	 /SXz6EiG2gYHdTZgxdl5d64Kb0GeSoBnHYzmzNZAnYeioxRAj8X5vDHSTHK2dJK8XT
	 JnPPOz2se5t6w==
From: Sasha Levin <sashal@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: stable@vger.kernel.org,
	"Isaac J. Manjarres" <isaacmanjarres@google.com>,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5.4.y] mm/page_alloc: fix hash table order logging in alloc_large_system_hash()
Date: Wed, 26 Nov 2025 14:58:26 -0500
Message-ID: <20251126195826.1437008-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120193422.2347150-1-rppt@kernel.org>
References: <20251120193422.2347150-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch has been queued up for the 5.4 stable tree.

Subject: mm/page_alloc: fix hash table order logging in alloc_large_system_hash()
Queue: 5.4

Thanks for the backport!

