Return-Path: <stable+bounces-144240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A9AB5CBA
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61A7719E858D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C4B1E521A;
	Tue, 13 May 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDg6gyfF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A058479
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162188; cv=none; b=KtPNX2EVvQ2vzxekO4cvsnO6fNSbB2b6+h63X+ZliWGBNmia17kEspT4cmuemcYS3kNrR3tlpjXGUT2Y8cC+MPgv9CpTjly89lhR17Crmxqp5CmwpVgapolHZzpiw4bmBoZhWNE0DT5/tWs1/39jrc7xSHUgVoykctX/JQPwKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162188; c=relaxed/simple;
	bh=aczzzJcjewAP+6RKan2OAk/JYUcyxtcaTJSeZwpYCgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ql1ZlBw//5Y7QWDtXn9cfIYz/PYEZRKuiFUlCHhDF3qNboRt9y/aVcERWbvsOxwQNy3YjtBGVCJ8N3FI39a/vVPuXeaDepExHlQtuonZupd0fSJUERaODkf+1LxfWhv+tj3+Ah9s23uYTkoAqx3NBtHKxbxzBd1ZkZf3JMo/iQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDg6gyfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3538CC4CEE4;
	Tue, 13 May 2025 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162187;
	bh=aczzzJcjewAP+6RKan2OAk/JYUcyxtcaTJSeZwpYCgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NDg6gyfFYyfGkltdWAZ6N3zA9Cc/orensVwabQgvJOKcClBz5Et+Ag9UwLqQQa2+y
	 RsO08q9WSH9w+z+OSXSzj6NWvs7u28Rjd9AVzhmZCUTCCx7APOh8KinWrA6mfEJXZM
	 cW2cj0yIfGurDjyMz5Ha6uYQeJMC2ZaDmhF+eyN2MdRzN/3UsBIuPyM/cV44qs7Jtv
	 XoY1AytjlqKN1d+BX7Y2PYhpFpnBJ312eoPve9y02zs3fUXU13NW1ruDDoV8BKjutJ
	 q6hbKv7Il7Nc5+Q1XCgjxlSHEb0oKDbA0s4sOIcoQ2AaJXGWgK+3+lq0Y08LzXpgpg
	 eNYCZaZ4lmbcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aditya Garg <gargaditya08@live.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH RESEND 2/2] Input: synaptics - enable InterTouch on TUXEDO InfinityBook Pro 14 v5
Date: Tue, 13 May 2025 14:49:43 -0400
Message-Id: <20250513094633-1604f597cc222c28@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <PN3PR01MB959722F0D276D1E717B69275B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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

The upstream commit SHA1 provided is correct: 2abc698ac77314e0de5b33a6d96a39c5159d88e4

Note: The patch differs from the upstream commit:
---
1:  2abc698ac7731 < -:  ------------- Input: synaptics - enable InterTouch on TUXEDO InfinityBook Pro 14 v5
-:  ------------- > 1:  e2d3e1fdb5301 Linux 6.14.6
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

