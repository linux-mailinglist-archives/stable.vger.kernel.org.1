Return-Path: <stable+bounces-104489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB069F4B56
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 627B116F477
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293651F131A;
	Tue, 17 Dec 2024 12:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW/9AjyE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82E1F03DE
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440135; cv=none; b=pivmv1zgwf/k1UcHkG2HuwEKdkO+jX6fKZIx1LtJ2nM5U7PSY63oY15WOt2uwOnqh9DVWnIASF6oNkZ3OrAO7DnwuHmHPjoNtDv2t3oVekV2mgtU+eNQWuZVgYmKi/XneCOS8gmVQm31peSghIAF3iiFGyoA1gB9YVP2GlUC/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440135; c=relaxed/simple;
	bh=3gZbILM0RkhDMy2craYdZuen2po2j3Jypswf2Ll1gqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjeQV3Z5sJh5M3JEsv/opx54TAMP2H6+QD/NN/D8vA2n4kEG/UWKky++wzj0h2svy5F4WLMcCOb6C/43DV3AgUznqzpQ1cfvz3899xkUohqjxfcjYRc4p1vL19zXlBcEYp9/LRkO8Fx2vBAEbXXMe3sMRkdlDfA0EU25YXo4v60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW/9AjyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CA7C4CED3;
	Tue, 17 Dec 2024 12:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734440135;
	bh=3gZbILM0RkhDMy2craYdZuen2po2j3Jypswf2Ll1gqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LW/9AjyErDfN0PHMSH0OXEV0jnInjaAegNntwSGWWf9WFPCKwgB65lv0pmJt+pLrd
	 spjQiecKjIsPk61Gf1xnZLoQyXDlLS7M1o/KmL3egud8v8or1KIwPJjc01TSbBkzu2
	 ZqYMN8FhukckoEv6nYu9ce5+eBJ8Vm+UEWzflSXiExfv2KWYN5M5Vwp7prOTI7p6DB
	 m+bCqrvQn3cBIeX2OFR4fn+gXGp28eK6FlZIrhPM8lbxIR4iDaTjTFylDjOwZ489mM
	 K/lyezqpOBsW4OdCzG1gLKdYjMsrVV5gl7VhgJ5LKHo51ImnsspqV8girdCUVK2O26
	 Ayv1PLKq2VGRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 v3 2/2] selftests/bpf: remove use of __xlated()
Date: Tue, 17 Dec 2024 07:55:33 -0500
Message-Id: <20241217072839-6e5727dccd9844ad@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241217080240.46699-3-shung-hsi.yu@suse.com>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

