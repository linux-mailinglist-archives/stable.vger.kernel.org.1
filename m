Return-Path: <stable+bounces-144421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748C8AB7689
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 22:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187CE8C7BDA
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 20:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5852957C7;
	Wed, 14 May 2025 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwjQAK2/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36D829551D
	for <stable@vger.kernel.org>; Wed, 14 May 2025 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747253600; cv=none; b=QN7TFpPS/n5TCLFLRmCG2hpMVra+hWm6PtzyUJUyfzBRbXCI1xABZEyLVJJeoCz9/sGoqYN7WqUECEGzpsDua5iko04gSfguZcgxU4G84omq2NIzL7NadlW1HLfgPGFXnCkDLw4vnXtCwBEadMslRYYsDuII4bbU92G2asu3DVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747253600; c=relaxed/simple;
	bh=Q/SQV3LG3gPWlnHORGGVnQf1CRJwcLYpy+SPT2Ybyug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AU21N1OlsQfy4vrnTcGvTZbxzg0FuOXBQjHnBZBqvLqazmPg7Q1t8bLexLCi/yxcWboAvlC9bM5p7d5a4wtlCc9BS3MWbjvBsRJO/BV/ZyU6clM5VdYJMM8NmmfzYfet8rltw9VowUrGZnF72BXNW6aPgbpBOwO9a9mjkpuAjr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwjQAK2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C39C4CEED;
	Wed, 14 May 2025 20:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747253598;
	bh=Q/SQV3LG3gPWlnHORGGVnQf1CRJwcLYpy+SPT2Ybyug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZwjQAK2/Gmhiss+W3xw+MFzCUHj82yyFfAF7sxJoDqRVhhXeCcabNuLzYMClaKY3U
	 puBf4CHYKnclMsj27DSqM+D2ncukKreK7J45FAe8PLqpCT72lrompktwfWbX9grG8c
	 9NJ9rm1OJUq9AW8gJpZYGTGm0tOiI/YlMek1H/CiMVvXeJDwGzqW28p7lbPqeT2ffo
	 TNNk2ss2o3xGzA88NOFReu70JHfTLvitog/W2luoAwktGCtXdltXT8lv2qWaIr7KcL
	 wk3CJj9uFP9ewCkloQmu6I0pppbXXA4CGhmL+nVdCtgk96mCC7NGOICFTV8ztOMlYl
	 3rqoqLnDyF4hQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] x86/its: Fix build errors when CONFIG_MODULES=n
Date: Wed, 14 May 2025 16:13:15 -0400
Message-Id: <20250514101433-9f5018e4c18e6f68@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513-its-fixes-6-6-v1-1-2bec01a29b09@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65

WARNING: Author mismatch between patch and upstream commit:
Backport author: Pawan Gupta<pawan.kumar.gupta@linux.intel.com>
Commit author: Eric Biggers<ebiggers@google.com>

Note: The patch differs from the upstream commit:
---
1:  9f35e33144ae5 < -:  ------------- x86/its: Fix build errors when CONFIG_MODULES=n
-:  ------------- > 1:  e2d3e1fdb5301 Linux 6.14.6
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |
| stable/linux-6.12.y       |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-5.10.y       |  Success    |  Success   |
| stable/linux-5.4.y        |  Success    |  Success   |

