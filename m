Return-Path: <stable+bounces-100026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED56D9E7DF9
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 03:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA68A162AA1
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 02:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFED4A24;
	Sat,  7 Dec 2024 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUT263i+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2233FF1
	for <stable@vger.kernel.org>; Sat,  7 Dec 2024 02:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733537239; cv=none; b=GJp/P198QW230HTFHJSw5Pd9TMCm9sxjK7b51XtcpZzOWD2L4+dHEBN5HccAz/kS0rOoAfpSvWT5x2yqiZW/Rv0o5bcjhz0Qw0hbCA5pgyameRi39+sDV3p6wuF7Tga6Nuf4zSrSv7mgEoKHXBFT4XRlUo6uGpLb6lbP4KBkgZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733537239; c=relaxed/simple;
	bh=3gZbILM0RkhDMy2craYdZuen2po2j3Jypswf2Ll1gqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGrWni9JbwMLPi8Fb8jXlLvi9lBeyplXd9A5uhfg1ObYSmiGQUxAwZw0zxGsfRhDcQNJkHUWEb85AV3ChpbgyOJFkv6W/hpcYr0ag/T0Oly+9gtBRDCNnpqeqWSwZ6+viaMNdDs4jpV4VFuv4WNYEzae4el6jWUiiMi/+do/+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUT263i+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B1AC4CED1;
	Sat,  7 Dec 2024 02:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733537237;
	bh=3gZbILM0RkhDMy2craYdZuen2po2j3Jypswf2Ll1gqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BUT263i+JBaVrFmaRGO48VasoFCz7OlFMtBNlG4oc/4AZa4k4nr9aXp/ad/BW1Na6
	 8NCBqSY3Rx9SF8rf1vpXogEbObU7cL5KsbKsCTsvWiI5yWw5ev1NFHP3PlDCtEhAlY
	 dQPetRDH8Och20wfQDVU0No76Kwn311xcEKaB0eshVxwqzAzmRUvywAX94pixu9v2f
	 KZqiKqZMv5AgycHNvna6QfAbNNkVSNMUkEitcJ40WfOK7Un+QyYTxQNHg+oiLgE8WP
	 7vD2jj886HaduwGJddR2CDnn8MROE63p3g6PPVme6/SLBupzONPjjPjcNYnIYWpNuB
	 uO8hJKTiXi+Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] KVM: x86/mmu: Ensure that kvm_release_pfn_clean() takes exact pfn from kvm_faultin_pfn()
Date: Fri,  6 Dec 2024 21:07:15 -0500
Message-ID: <20241206194919-d712dcb3c663fcc8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <Z1OUJyni0aZQPHMG@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

