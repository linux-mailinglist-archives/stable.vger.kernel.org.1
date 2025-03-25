Return-Path: <stable+bounces-126014-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC016A6F421
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 12:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC87A16E4DA
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 11:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838642561A2;
	Tue, 25 Mar 2025 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CELftPFq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A8255E47
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 11:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902409; cv=none; b=A1okxj60d6R0B+zDDPj1jhNsWbV/BYinkNcl2GfahorobAnzuiB5CMf8QdmQW2poFJOFzDJQk/aHzSdkPKxlsrscnAERYBg+7hJhnXZPo4QbrbAH/HO2dQ9VjxEitlfQKH7ifIkbGH0VMnI3hCYg0ixQXnLprrue/XjwfCkrpuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902409; c=relaxed/simple;
	bh=U+IveAyWdM9y2WETFLsA/NNWn/tlrwtnpm7TVXM2FI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twPNRMH1NHu3wgKHhO9LXpT+mwjLi226ANt+K6gXJi0vOJ6QTD9fYl5HRxQb+PN/nK8rRXCkf/gD/GczlIRsFUAOADCQfFIlM2NZpRcnEc6vADqjPjpf1Syb5cXj68AUDE+0bjIg/pFnMeDqXds276II9wsDKloENH+GDjwinXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CELftPFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52116C4CEE4;
	Tue, 25 Mar 2025 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742902408;
	bh=U+IveAyWdM9y2WETFLsA/NNWn/tlrwtnpm7TVXM2FI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CELftPFq9unhzkGo0oGYcZul3ppDd+9VzFGcUHwHoQ1SFkXFAiSCu1CsFHmv6AHUQ
	 RPFfDBKvuw889KzmigMJpnXggqMqAHKNbaKhhUMpofniMu15TcQ0hqzijQYuJ9LpxK
	 i+jRHOAhHdb4dvIiLNzv/KKlXt8u38P8yH542DWP4VNK3HRCBu+ei+Y7yopOEBRMeL
	 VKoHtbPKIbo1AEDBdlk/oROAvP+PJKC/QN3yJ7dGg5z12MuJqmHfEgW7ZJnEca6OJ4
	 2OY5TYmLD67dFam1mGMs8yQ+s/PdW5sc1OdKH7gDv9OSbyGgLnzjGES3eZ/e+Uh0Sk
	 0h1ZQruJXdodw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	aurabindo.pillai@amd.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] drm/amd/display: should support dmub hw lock on Replay
Date: Tue, 25 Mar 2025 07:33:27 -0400
Message-Id: <20250324234654-d463f40a9a48609e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250324164929.2622811-1-aurabindo.pillai@amd.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: bfeefe6ea5f18cabb8fda55364079573804623f9

WARNING: Author mismatch between patch and found commit:
Backport author: Aurabindo Pillai<aurabindo.pillai@amd.com>
Commit author: Martin Tsai<martin.tsai@amd.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bfeefe6ea5f18 < -:  ------------- drm/amd/display: should support dmub hw lock on Replay
-:  ------------- > 1:  344a09659766c Linux 6.1.131
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

