Return-Path: <stable+bounces-152427-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D4AD56BD
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 15:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013B0178892
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 13:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C2289364;
	Wed, 11 Jun 2025 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVsqFVOY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685252882BF
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 13:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647771; cv=none; b=HuMOBVutKrp/vDHv7vogOs1136EZlQY9JYY0rmT3Wy+mnFhZe4v/C+j/ZckRzSENurKsWfVMVJNbhZIa/dxmOdXYlHp19SSLgnIyn+Rb2MD0JbWDGaC/Kie90evOdFzWyufzh/RxnkdS21K8fKdlNkb25HC1uj+QV8EHJVYDJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647771; c=relaxed/simple;
	bh=HcD0LnNw+vcAJwhj6hNy1nV00hxUweeG8JQqbZi+ga8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugJIZCcCaR4BlNOA0LwWIGWwT6Nm4G/N4w1meuSzsOajGUChsln4FCwgeVFrdp7O4UHuSvyaOY1wOfOybH2fUrm0sIbED2+o45F5WJO3kCo5ZS48ZVbWQkCjy6+ONL7jkmWEx2gqAbDquXHNFJMhOcmREFV6CbE3MC+f0SmUUx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVsqFVOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8237BC4CEEE;
	Wed, 11 Jun 2025 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749647771;
	bh=HcD0LnNw+vcAJwhj6hNy1nV00hxUweeG8JQqbZi+ga8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RVsqFVOYhRm93AgY8PmzSjup/1eHIYoReEtkOKsHVMJiStuVz3sVMTfs2rRkRZo4U
	 F6tOG7uxyXUdasnUM7+e4BMTFQ0GNeoPKvIJlgaUpdYha3uXRiQJxDnqBsLlqQ1Z/P
	 YCeGTROkRJH+lxZ38alhPWe9ncDePWEtn+5/anh4I4eDX3j4OdMwVP1mA+wWkLt9bX
	 Q9hLnofuVAkIBHgS7Td3FCCDdLEtw7wiv7PRSIPd1p7Xvq+DTRloQfOPrgLeIS2b7i
	 ZVPgRIAbiey7wIhKe7NaJiQK8CNshjSoZHE0MHXDeEphLwJSkQ/Go1bs/ZER8+Z4B1
	 PeybTELvSC+rw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	shung-hsi.yu@suse.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 6.12 1/1] selftests/bpf: Check for timeout in perf_link test
Date: Wed, 11 Jun 2025 09:16:09 -0400
Message-Id: <20250610150600-484b48f7ef1ad86d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250609052941.52073-1-shung-hsi.yu@suse.com>
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

Found matching upstream commit: e6c209da7e0e9aaf955a7b59e91ed78c2b6c96fb

WARNING: Author mismatch between patch and found commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Ihor Solodrai<ihor.solodrai@pm.me>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.14.y | Present (exact SHA1)
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e6c209da7e0e9 ! 1:  8249587f33f76 selftests/bpf: Check for timeout in perf_link test
    @@ Commit message
         Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
         Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
         Link: https://lore.kernel.org/bpf/20241011153104.249800-1-ihor.solodrai@pm.me
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/prog_tests/perf_link.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

