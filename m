Return-Path: <stable+bounces-144231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE85AB5CAD
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49E1719E796C
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9E52BEC5A;
	Tue, 13 May 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV6LG9IG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5032BEC3F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162149; cv=none; b=AladlfDdQDnJN4ZM96cra0pkx8n/tKY5fIul29SdRLU1gYgvuEGB5QcP+jTKcnjzoLvOVrwN8xrEajlpEPyURvJE3lw3dPTyaX+wac/ZhX18fo7A7zOqAnw1bXao+bSkf7vuGYDNNTNReVG+dtJQPDWyBG6LHtXMcyuzgujmHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162149; c=relaxed/simple;
	bh=VTe7cuo0rxS0MeXuZADYulUC//l5+0hINheEVgTIgpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZD3jeAwA5bN+r4UKu9oVDXNpt5as3tl9lMyWoqnjUlVnb16/I8d4DQgo/W7DbnazFiGxjsVpQFJH/5cWh2U5Nc/CadRF/eFe1/1rZEwuu1R/rrp7x3LAEfwtkL6SFAHOjX8Rt6GYa7sMDzBgD5VD1u2Ew5shTl8VdIAb8KXKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV6LG9IG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C4AC4CEE4;
	Tue, 13 May 2025 18:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162148;
	bh=VTe7cuo0rxS0MeXuZADYulUC//l5+0hINheEVgTIgpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fV6LG9IGLfh8dt8UuPux7zUTUgu1D/0/kGI0IGYiyEVoBPKq25YensODIp2T28Bjw
	 13r+a56YLjbk/uWjiv/iesa+w/r8f0m1jd3Uo6IlMz68WB+9er4vxucOW1oB3Gqxjk
	 IzbMQX01WvlZaQQNrrbGUh0NIfH5LzTWoqe4VEcdsy1NlUahsejNP+/l5dcn9quzkw
	 KwG1huEnOGpjf4sfVwuYVYQHPohY7gQgNEz0cRXrJp1qJJgFXPACGqVhUH9UuJSfKr
	 6/GsxhYhNSpZXX8gSmTwq+rp2hT0/I8a7xXtxqaE3wF5ClthYn0OU6Rxp3slnwajXa
	 dN/YXNcXIu5nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] selftests/mm: compaction_test: support platform with huge mount of memory
Date: Tue, 13 May 2025 14:49:05 -0400
Message-Id: <20250513105329-68756ff87eee441c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513025848.33491-1-feng.tang@linux.alibaba.com>
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

The upstream commit SHA1 provided is correct: ab00ddd802f80e31fc9639c652d736fe3913feae

Status in newer kernel trees:
6.14.y | Present (different SHA1: cc09dec6cce3)
6.12.y | Present (different SHA1: 72669f82feb1)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ab00ddd802f80 < -:  ------------- selftests/mm: compaction_test: support platform with huge mount of memory
-:  ------------- > 1:  4281d5a25f233 selftests/mm: compaction_test: support platform with huge mount of memory
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

