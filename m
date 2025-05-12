Return-Path: <stable+bounces-144016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB78AB44CE
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 21:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8A34A05F5
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96133297B90;
	Mon, 12 May 2025 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUPVsdc2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567CF23C4E5
	for <stable@vger.kernel.org>; Mon, 12 May 2025 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077605; cv=none; b=t+EI7VGQPbmmIR+PRV/2IU2syWLTN8eGQICA7kmvRQeu2+gEH77twy1VsMFJtjCj+pKXvYvkPjfwNmHIXdJxdLEo32uq98phWfV19XkOG+KIzWytYcjk1mKTr5Q4cpInGn9PAv7+raA788aNnAUKknGSwm9FBNLne9GUUn9O4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077605; c=relaxed/simple;
	bh=R631XYlemmChCabjfiKvAxQKCp2XC7GlIUigUNbeus0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzZ3CpZvFwyDVoQJf3XzTj0nyWpWV86MYTGopOKccvZCeF8fl4HqCvZaAIFhobvalvRjBR19SZJpofpbQGEtsyS1McdUj8HKQVX4cREDs1lmFThik3iFushgKasOeXHdnxZ29qwfH703x5mvh9nTgrMMSRJCLuT++2MlSP/qiRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUPVsdc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DFAC4CEE7;
	Mon, 12 May 2025 19:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747077604;
	bh=R631XYlemmChCabjfiKvAxQKCp2XC7GlIUigUNbeus0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUPVsdc2+mMPklKkgnzq0KmJlCft3F73PuWpHZ9EUO5Z2F9RnvCIFWjvXdH7jQYTc
	 5u7a9DGE+U05YqCnQIfMTQh2ocTCH1vKV8Iky2j8FKRTBpP896BgpbGCuUZz+Nhras
	 uU5rQSn0FFWR+AS5oyPaonLe9tiGGiocFOEXk+clRYrrzoQeQsjfRdMU43e+HSjVL0
	 L0rPQwgfmWZK8vkCSr3sKvYejCowzx/hElDmeRK8fXEAY6K8QS18JlkILVYpImn3AN
	 w8mrLx90MxeOyYkpjuwrKTv0taUSeIuNjfr4aJDSGGqy12T13I9c96JQNIhzJqwJhM
	 6zwoaoEVnpvIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y] tty: add the option to have a tty reject a new ldisc
Date: Mon, 12 May 2025 15:20:00 -0400
Message-Id: <20250511191610-4932f82a8c4c3256@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509091454.3241846-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 6bd23e0c2bb6c65d4f5754d1456bc9a4427fc59b

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Linus Torvalds<torvalds@linux-foundation.org>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 287b569a5b91)
6.1.y | Present (different SHA1: 3c6332f3bb15)

Note: The patch differs from the upstream commit:
---
1:  6bd23e0c2bb6c < -:  ------------- tty: add the option to have a tty reject a new ldisc
-:  ------------- > 1:  950937a4f0aeb tty: add the option to have a tty reject a new ldisc
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

