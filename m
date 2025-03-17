Return-Path: <stable+bounces-124631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75502A64EAA
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 13:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783F53ADCAF
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 12:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7301423815F;
	Mon, 17 Mar 2025 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmVog6nZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3287B189905
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742214247; cv=none; b=ppYbU5Gz1QfFT3AqYHc/CjgL3gKM/WL+sdHFZodwbUgaJnFiS5FpX15O4Cf7HldBEkzNJri5oQxPoRKtVr9nTH2enykUmfqoXXqv1jQI5oq1QQ3MxAAL4erUF4lLfWGM/xZGH/umLhcwmnoBfjvvQ+3j00i4Zir9GIWr1QNZJd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742214247; c=relaxed/simple;
	bh=sn/3Ph6rFfpiKHH7ZDoHYgNEDg55PERTcZcCjCedFpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXZa71ZFku3LIXX7qmG6E+Syg3yQ2ETDEpeBJ1N6NWCYdoaLhilXSNw/KwP+rA+sKqdrWDS9bKfoZ19gqPfg7ASUYYlZBkW+puXPrXO6zdtbfC4GE2K2zsuPlrI92Mquf8faw5h5Hb/dIn1SJRcgjTnJZlQmAv/Md5SmgkAzwh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmVog6nZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC76C4CEE3;
	Mon, 17 Mar 2025 12:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742214246;
	bh=sn/3Ph6rFfpiKHH7ZDoHYgNEDg55PERTcZcCjCedFpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmVog6nZimjryCNGepsMjz5Nc6ZF3ZXbQ82VP8EAfWquir4UBxbBs39+kAxrqlfR3
	 tBU37ShH6I9cFP9PyWwxTFr3591QF1lDKELu0nS3PaZXT0IbtyJVnZFwBKXV3ZLq1c
	 IWPlicDuTUoOnFzRe0AJrWJtkBbV3dUGMqD0cC795XGoAvqUn3cE0CcW3Uwf2fkO7Z
	 7RYQ8Z+/5oScK+iF9m0sLFKSn8TD9MdrFZ8lSMZF66L2oqHEEWE8VwMM8TNJ4w3oJe
	 QlhVnKylQvjb9T7EHVK8yTCfSuloKVNMTkg/LT6Q+oc9EuBSiCVLMK0UlDfUJLyLLb
	 sWsDuHhOIvPBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	arighi@nvidia.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
Date: Mon, 17 Mar 2025 08:24:04 -0400
Message-Id: <20250316145947-2cbc6c8a3fdb66f0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250316132626.48526-1-arighi@nvidia.com>
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
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

Found matching upstream commit: 9360dfe4cbd62ff1eb8217b815964931523b75b3

Status in newer kernel trees:
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  9360dfe4cbd62 < -:  ------------- sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
-:  ------------- > 1:  a3b16615d84cc sched_ext: Validate prev_cpu in scx_bpf_select_cpu_dfl()
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

