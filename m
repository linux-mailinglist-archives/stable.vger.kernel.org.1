Return-Path: <stable+bounces-142947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 819DCAB079D
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 03:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4DA188CA0D
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 01:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D65013632B;
	Fri,  9 May 2025 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="refTb0Om"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A171FC3
	for <stable@vger.kernel.org>; Fri,  9 May 2025 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746755547; cv=none; b=EIB98VGrhXVlEenGowMJeKZe2OouDhXtKiZBafJTEU2HQVZEUPR3uSvYAhlIsMFLG6CboRPERwlM4vTmdy7lMO/wL9QHljqzGQBVDVNLCjBfvYJF2Va0KoA57n04j+YQd5LZWxvhjI/CrHiyYTQ2pUsXPlB8E3Mm5OEW1BuDLjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746755547; c=relaxed/simple;
	bh=F1R5fIBjLEVOw0K8LCtdzq/yHNqsYaFxWD59c+iBF44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XSbh7isKip4lm8Dfplb/ri6zNyu3sDVjpEsf4PscyrQW1PXeFbz9Y+9FcxlKSuood7qI7ZU+T02u/+9t74p4kV40h9TMthsEUPty/KgB1Sj6/0DnGhFWXsIESLrDqJ8hJnpXdgo6owK2eC53UtkYRbpTyvR1fVu+9KHvOTHx38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=refTb0Om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B41C4CEE7;
	Fri,  9 May 2025 01:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746755546;
	bh=F1R5fIBjLEVOw0K8LCtdzq/yHNqsYaFxWD59c+iBF44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=refTb0Om5CxOKaiHR2vnCtgK8f0MktAP2gOqmJWQ3g93yYVJIzFWJNSUS5Xh2616F
	 VzhSge2oeLFfaynUkcXvam69w6c0FhVAN+RRhryvrKn2h4eEXtGcMM4ynfOIVSsEPM
	 FLJVr7aNWI/t3NnWmRn5xH1j8FCiWlOYhveP6g0L+c8H5u/QFtn/xzokaAFhyzlzrp
	 2fruuVac2bCyqGtxj+xUAMtTcPPwBfz70q4YcB0wvQXls57n8rffUooAFr9BYoqlLM
	 kDhZO5+ycQIzZpXadg4ZBuxVn7O0LlR/Y6XN8SdOcppF4g36loKyUN0A4p1cHtTalc
	 OaCTLxNeaIiXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	agordeev@linux.ibm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6 1/1] kasan: Avoid sleepable page allocation from atomic context
Date: Thu,  8 May 2025 21:52:22 -0400
Message-Id: <20250508133736-adcad475caa820c3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <aabaf2968c3ca442f9b696860e026da05081e0f6.1746713482.git.agordeev@linux.ibm.com>
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
| stable/linux-6.1.y        |  Success    |  Success   |

