Return-Path: <stable+bounces-164810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA5CB12853
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 03:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE59F7A1E88
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789AA3595B;
	Sat, 26 Jul 2025 01:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDWpjcSZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393952E36E6
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491686; cv=none; b=RskqkiVFdPa2moXF0503ONWhoWjJQ2WFmqjr9Zm9ZWFG5RcDe425p25TvEXr4TPq2Fj8DK3NsO5bzmv3/Hp7+207LdlHtiIgvU9MQi3w3rQDESfvLVPvAe/OEl6N1cD3YugeeQxnclEaLDaquRs7HrtN38m8sBD9xNXZKtr97RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491686; c=relaxed/simple;
	bh=jSLKb3+gD5WelD95nHsczw47AVNA9z18vBAkuV09izw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jlh1llhwmTeiQcD0tj9p52Oleq1/oV9ZKkD6b33LCveaKHqGgpj5oPeyveaWaAmop+PEi1CjZkymIslCJoSCpburpy758f7XPjdCIMg6+Ke31PW3RvTfJoeyMwPnAUEIPzULZ19glTMRHLexgwqwNF8E2pgE+2c8zlFsY/p+z2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDWpjcSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325C1C4CEE7;
	Sat, 26 Jul 2025 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753491685;
	bh=jSLKb3+gD5WelD95nHsczw47AVNA9z18vBAkuV09izw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDWpjcSZ7B/XO0cGz6f3QHgcq80Z/fXgSBf+mbY1PiRLxmMXzIxsjBy97Bn281AZX
	 xDefXigtm+jca5u+/+7hPADOPLRWAhg07grQGrQp1cKA5ZymTPXZDBja78WUqu5cOG
	 1/12sHNCAsbl762Y0LkmUOGryVy5C5IKtoyd40HTvp5AGfopo/a49i3s50XKXnC7cV
	 XbYQz3vaL7A9OwIA9b3GYaGL8yGIA0xFszPyTSQ5/X9B+Pt7gxJjlkazxKPhkf9ZdV
	 g2fqjKtBIVO5NhfX69zxVCmsQXEHTAjXc3nO1Wl4L4+sYuPqI1Vq+cKzrMG3g6LdGh
	 Klb0y74Zxz8Kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: comedi_test: Fix possible deletion of uninitialized timers
Date: Fri, 25 Jul 2025 21:01:23 -0400
Message-Id: <1753471106-4189eaba@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181257.291722-9-abbotti@mev.co.uk>
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

The upstream commit SHA1 provided is correct: 1b98304c09a0192598d0767f1eb8c83d7e793091

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1b98304c09a0 < -:  ------------ comedi: comedi_test: Fix possible deletion of uninitialized timers
-:  ------------ > 1:  670acfccefbe comedi: comedi_test: Fix possible deletion of uninitialized timers

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

