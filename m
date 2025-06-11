Return-Path: <stable+bounces-152424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28F3AD56CC
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75DC1BC5F50
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D037F283CA3;
	Wed, 11 Jun 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSMQVv2+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD3B288C97
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647765; cv=none; b=PoVJF8xVongkNWC4HNsDf8bz0aZZAJGg7fj7KvTOxMozNGpyVFJNPSr7Rt7Uh1iS+CCj37KAxd6oU7D147ptf48RQKpWrDmUhafPP+ItXnmYO3yzaeBuRH+XhLCbwQv6hUr7TjfHurxBpfQboDDrvE9cTWN3i0Xz6ZAAQLKUQPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647765; c=relaxed/simple;
	bh=LRfoGXP+uItb/PAEW2lhJZ8QHQk4pKJzAyEeF1Fp2Ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdTT/ssftnuiUPtCI3P4UAOdj8EetUrNZtSfDr6ie4IYeaMAx0vRPyNioUOl9h1aLSJghbW8OF3PHCz7ReF7zA2XJjeMFPH/lvRe8qxOwjTjn5gD9REuuEGwzWBUbCh+0mnKRUhD4UpfpJVmCfLxJBZ/w3wm7LeKk7hu7goWmj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSMQVv2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F03BC4CEEE;
	Wed, 11 Jun 2025 13:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749647765;
	bh=LRfoGXP+uItb/PAEW2lhJZ8QHQk4pKJzAyEeF1Fp2Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSMQVv2+RVhv14OfPEjpBn7BPcvlFWJic8t3Ddt0ekQz1Kc8I/O3pojBQWPxeKOAd
	 InCoYdgENKu3GOD5g9I0fLZslyZArIkpPRHYXuX5e0qtWifkhrnUVcDYt/O7n3rPQT
	 0OBduRHB1II29N39VXRBAKRSuQFQRu5IOnxnwHdrj33JEEw+2x57stxiuahslkLVJi
	 uWk8IsHB5thVFx5Xbt3f6WrQzySRDS8VfDTF53sdwkam8DL9/C27kGkvEZQClyK1I3
	 /9hySdGe/XwY2TReWKxEFro7Pb2aA9r/x4TyJH9xUZqQ43o803jyEQTAwRApzvjIN3
	 GKF1ytzWuNbmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	farbere@amazon.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 5.10.y] net/ipv4: fix type mismatch in inet_ehash_locks_alloc() causing build failure
Date: Wed, 11 Jun 2025 09:16:03 -0400
Message-Id: <20250610140448-6fe26902e6ff9755@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250609043259.10772-1-farbere@amazon.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

