Return-Path: <stable+bounces-124635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA879A64EB0
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 13:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E573B3E37
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 12:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C60523957E;
	Mon, 17 Mar 2025 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/3uQ25y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47F189905
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214255; cv=none; b=moL62V9qJmRqzxF73podfGKmpOpuvfGkZZW+pC0LYv+Ays3Qm4HZ/jQGFw/JHchs9JLzw63Sleah/B27iherK2BQ1Js1/Opl0/Df+mD1MMIanHRmXqI+z2xakLoMMvNM2f6da7Tw+Zjq44nehc2L4hf6S0GRCgOquq7rASjnuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214255; c=relaxed/simple;
	bh=qvqEvQKHWDBwZOjm/iBzF3Itw5unWFc2zo+2bnLG2VI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YOJKkWgbAwqL+09MVagg2G0SBSjuSF3eHHZC/Chl330m48UzFbH4uX76vWQNLLx+jXE3JSYzv5PGGHrkSIjJSMBxvNuiZe9MWurHNqpogryd5xMLB3elx4yGPnVA5BK/D/HJoQrJxsEp+Ls8JkSIfzvxri5svg5o3t16Q+n5NN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/3uQ25y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF1CC4CEE3;
	Mon, 17 Mar 2025 12:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742214255;
	bh=qvqEvQKHWDBwZOjm/iBzF3Itw5unWFc2zo+2bnLG2VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/3uQ25ysFdpjVXCbXjww+nrxHciA5kY98d/QWEtyVqnWki5HV4G9NMkixlTAScuz
	 NYW0P0sxq1LlmCClY+aVIZNTSpxqFRurFpK9SAdsYPlpDpiu+z4+hHme/tNuuSbdX1
	 mDe+QPq6k5Q9Fg7ZUyZLgIZ1TRqEgdPDA1b9ZdmEdSI2+/lXtU199y+9DYD1Dh71mV
	 ZQor5EOalZ5nGohKZ6SHn76O9J4DvsYNVaK8apLsVkEIMLVb4eG+jSnlDEPrnrACHP
	 V759BJNtOSzA2hW0pwLcLIrKhkh32glBNhl6IBXvGKkA+jha+oXBsdYToPAgfMcXa9
	 +sP3MDAf/wWhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] rust: Disallow BTF generation with Rust + LTO
Date: Mon, 17 Mar 2025 08:24:13 -0400
Message-Id: <20250316152441-6fc5fb6b1eb6e14c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250316154159.2404145-1-ojeda@kernel.org>
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

The upstream commit SHA1 provided is correct: 5daa0c35a1f0e7a6c3b8ba9cb721e7d1ace6e619

WARNING: Author mismatch between patch and upstream commit:
Backport author: Miguel Ojeda<ojeda@kernel.org>
Commit author: Matthew Maurer<mmaurer@google.com>

Status in newer kernel trees:
6.13.y | Present (different SHA1: d0ae348de14f)
6.12.y | Present (different SHA1: 9565f4e43f2f)

Note: The patch differs from the upstream commit:
---
1:  5daa0c35a1f0e < -:  ------------- rust: Disallow BTF generation with Rust + LTO
-:  ------------- > 1:  fe3c31b5a6c87 rust: Disallow BTF generation with Rust + LTO
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

