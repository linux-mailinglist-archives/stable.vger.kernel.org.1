Return-Path: <stable+bounces-145022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DACABD0F2
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 09:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C00C1BA15EA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B9320E6E2;
	Tue, 20 May 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6MGeRli"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372AC1DF75A
	for <stable@vger.kernel.org>; Tue, 20 May 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747727548; cv=none; b=amBGHmt2WkJv6Ekmg8c+bRf4mBbm4vimPM/c4RXDe3+DIC4+y7dFSAu247kb/NYHO3wnyFdv9ncVmUcfvUPkjcWKdjNFEhqabGgXsBVu9G2ak1Xn0RVxCFwuU9qCxl4kb1lPwr7m/ZMZLJFp84PimJuV9oH6++yb9Ifbj8r78NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747727548; c=relaxed/simple;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pvVei/kPo/o+nTNhmnrZyixh9W15x3h61Ep2t/j0qgcUp7f4gjMGVcO8pFkHAbZf4UbVuahljA6lmgK/kM4tzIvLfBkUPfuUi66XXcS43tkhV45++Omeg7J82BGEUYBy92HRAGoH9lRDpj4o9UCCiq19DrQNxW0NOrhJoxyWNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6MGeRli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CD9C4CEE9;
	Tue, 20 May 2025 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747727548;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6MGeRlioKM6MltBSu/FVo+Wruy+S/DdGUTaMmn/rzMvRZkE1cyIdyQUFvjHMm8XI
	 /q+/O8sApGkrQngnChxVssunEoTraHsHv87QEEuzd3ChOMOdT5vPHpMEDQDnsDZad7
	 8k0gExVQCVFnM++sG/33nFyy3/fjlB9e+tCuqvG+LZ6hITMXwPD1pQuNrS+7dt5GEL
	 Y9qPDhKPrcEoSnGSHytfY6PDaagdVnc/rBlVC7cz4CIeRRTw4Jfigu/Jp69wcKzLf8
	 x6Ih37yzE0VUmosCpExVXdQ4UXx98irptqK/SCtnrQQQOqkyN45CyjRZ0MltZuewuB
	 hHLDtc2vlYO+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6] x86/its: Fix build error for its_static_thunk()
Date: Tue, 20 May 2025 03:52:26 -0400
Message-Id: <20250519184637-a74d9a8a9c96c117@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250519-its-build-fix-6-6-v1-1-225ac41eb447@linux.intel.com>
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
| stable/linux-6.6.y        |  Success    |  Success   |

