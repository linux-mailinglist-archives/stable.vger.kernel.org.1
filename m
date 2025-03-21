Return-Path: <stable+bounces-125766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE406A6C173
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 18:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DF3189D1C2
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C85822D7AD;
	Fri, 21 Mar 2025 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsvKATEY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6D01DEFFC
	for <stable@vger.kernel.org>; Fri, 21 Mar 2025 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578012; cv=none; b=OjIBYgDIx1lLHOj4i6luFT2Kl1w615hFgmnky4n8LXPb3yKTUgjNpSqVXhBwnZVPTEhFF8S/2hFyeLexdITMFvS++RwU4v6hmeiHoqwNHADdzEtLGxaeOBJi32OS6FcR/6vOOM//XKGdt+g+4dfO48JNOaUcpI8RfwPuzWHVaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578012; c=relaxed/simple;
	bh=MXtos0Rj1AIc3S1ihnKz2ero1JElBckHQUSZrFdjd7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWznnCsJ94J9pMrZ1zPpqJb9G5j+TXknkIFV59+td7+4Rmtz/1pHy25mydknxSrVTH6gEsOf8rUSSprrnFP9oZ9/Z6oqRxhBWxLfK1N09BS9smDBL9vl2YWIffoG11EMpOZBAY8xHr1hiLyuAq1w0Rp/NKDy5GqrlDzUAsDtyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsvKATEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3ABC4CEE3;
	Fri, 21 Mar 2025 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578011;
	bh=MXtos0Rj1AIc3S1ihnKz2ero1JElBckHQUSZrFdjd7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsvKATEYlEBo5WTEopKh4PfisaCFvmAFLlgWSCOLGiwzaUc2ChvDZOT+zowCmMJvJ
	 mN7JaPt+sL0Ft9Or7m1rUyxSK1/mG2sLmYwYqzc5uVTruaHWDKXbgz9u1W1BlTniRu
	 sgFE/Ig1Tj1Sh2ZfEnW51duG2kpr5i6AbmgpClROgLhRm6vjJCad2CJxYGto9FMnSU
	 i6n9deMJk3rO/q/x/ta5wcvJXK9HJBXRZXFDT+fY/hN6EudyuQ/MqBgIdMBM3tbCKg
	 kw0LltuadU6eymz9x29DxveZ8Rhrl4qLKk/x54/EoJTYiD1Kh5ALbFRFKztYAAt0wi
	 ITBuJ7eo9VH8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 4/8] KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
Date: Fri, 21 Mar 2025 13:26:39 -0400
Message-Id: <20250321120559-bef5d079badf335f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250321-stable-sve-6-6-v1-4-0b3a6a14ea53@kernel.org>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: 459f059be702056d91537b99a129994aa6ccdd35

WARNING: Author mismatch between patch and upstream commit:
Backport author: Mark Brown<broonie@kernel.org>
Commit author: Mark Rutland<mark.rutland@arm.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: 73882a98030a)
6.12.y | Present (different SHA1: 5abf151bdb68)

Note: The patch differs from the upstream commit:
---
1:  459f059be7020 < -:  ------------- KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
-:  ------------- > 1:  874155bbd5e63 KVM: arm64: Remove VHE host restore of CPACR_EL1.ZEN
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

