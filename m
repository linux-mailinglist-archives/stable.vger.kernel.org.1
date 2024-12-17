Return-Path: <stable+bounces-104405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61659F3F49
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 01:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 791E2164916
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 00:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD2E1E505;
	Tue, 17 Dec 2024 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GN54zB2J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CCF15AF6
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396135; cv=none; b=eSvo/6x1hFqk7241xXJxCcRb6q3kRAh9YAH0AuUrwMdMtTZKe8w9tYRpMmliNIerfr8ZMBcC/XHfedurxGbx3uztduNuvrfR5SXV1HUimJuV8P97dKIF4vbfq7W5fmIOIC5ri7fNf7IxqtDtVymxwZ026T4DjoyRpNRnWDXx6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396135; c=relaxed/simple;
	bh=/9oiUsixqooCOZJNrEfk0KNdMECHnl2HK+Z5v4tIR1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eUP0lQpBMklIlZdZ2RkJXn2IGkfWD8prtjuIaNKSnKCfRc5Y6FsiB3Uq2sa4lLfpejOHKzujZkIBoydGqH+1qm/A3ZCQbWFeAEI4tFDKmDKQ92HtGjNnHuBB8NqOdbq8aNn47ArTsams+sQXVhvjfcy/wdveI2awgyledgOjKao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GN54zB2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5831C4CED0;
	Tue, 17 Dec 2024 00:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734396135;
	bh=/9oiUsixqooCOZJNrEfk0KNdMECHnl2HK+Z5v4tIR1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GN54zB2J3sjpeN5xOIhYTs6m1ZwR7Vw8V1imUa8GL2hlNuJJ3WFIuIFPn0sGO/2Z8
	 DcrTV0aNVi41HqI8aEp4Glj51KA+/mW4J8aLlpKtSBi+8DX8cjKTw6YjdtVDdCr+8R
	 uIqsR+eZ5EUMRoropQj+lXKWFuJjs7fmrLnhOQSnRt3JTsftxxaUqGR2TtIpz5g4wj
	 4bmbuj0kBlwGH/BeoPOWdz9ZFMLdX14nuCZ7CmXSvLHb5ZH14cktvZVpg3PyO+IkT2
	 jIzpTuWrx1I2cXPQpYvkw/GXSX+aLZx8U+Hk8BkdA3l3jht8LY6FZDmRDqoeGtxlw5
	 vrh6to06AbEkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Raghavendra Rao Ananta <rananta@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] KVM: arm64: Ignore PMCNTENSET_EL0 while checking for overflow status
Date: Mon, 16 Dec 2024 19:42:13 -0500
Message-Id: <20241216192504-417084fa29a60118@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241216175403.82853-1-rananta@google.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 54bbee190d42166209185d89070c58a343bf514b


Status in newer kernel trees:
6.12.y | Present (different SHA1: 8b6916f4cf7d)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...

interdiff error output:
/home/sasha/stable/mailbot.sh: line 525: interdiff: command not found
interdiff failed, falling back to standard diff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Success    |  Success   |

