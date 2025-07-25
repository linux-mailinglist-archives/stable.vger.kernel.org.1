Return-Path: <stable+bounces-164780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D779B12750
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711B4AC24EE
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10AF25F99F;
	Fri, 25 Jul 2025 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7NnNz/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252C1D9A5D
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485864; cv=none; b=cTDNaKJpo2rWxsnXE26Nz50j7laU1JAoYiYaiijRrNp3jbrrue62FB54CLtxc6SAcuvDiKU8ssdfrxUSvs5mxUz015V+4zchU0aRURuw4hzgfGUguuljb1fXqJ0fkd82zVY0/D3ZCCJgZL9HlVNe22NTSa4sIoulrMWc+atJSbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485864; c=relaxed/simple;
	bh=cpWYQkkXg4dt5OEdctc00hN5MRBpJbQKhC7Hjxb23eo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzsQgbc9Y6SSZxix0nCxJmwKpzdktlkpmWRA9aahYHt7nkz7+9KwJLrOxH1uQd2NRvESqRyVIpdOtciA4IsonawvrbVGjCFoMdZLbp9+/HlmRWdkVeEywNaR8tWrUo0y+NTJcqh/v5pH+RRMUwA4h9ym6uPwZisaRjzsn416uZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7NnNz/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A167C4CEE7;
	Fri, 25 Jul 2025 23:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485864;
	bh=cpWYQkkXg4dt5OEdctc00hN5MRBpJbQKhC7Hjxb23eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n7NnNz/vV0hWTtyjy4gNVwJ7yfBzIm4cxS2kmA2CzpXiJ69NlnCFt5rjaeqSJF90F
	 iNZy6OIJqbrd89TrTm2d6koH2z0LbNao4yAGz/fgC/Sqr/l7B8A8ZHkz7uKG3oL6K+
	 M0LFlDwai7T8R5YXWU8QplyhAKyJ6jIaoCvxbrH0o2RGryMj6AWHgv4dBKB0yiwrD2
	 5+khsMP6eB/8GSYeEl0Nacdi74ztyLtP3C6fAqJMgpJSQ1h5Sma2jTO5LM/VhmLTZA
	 qDlBEukEjS8sre/mdPdtjXpLUJZz7Zda6zpjcfExttPAvTsDrtWqo8rtbNebu7skgX
	 Qzq38aJ6CJoQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 2/8] net: sched: extract bstats update code into function
Date: Fri, 25 Jul 2025 19:24:21 -0400
Message-Id: <1753463624-d6ecce33@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724192619.217203-3-skulkarni@mvista.com>
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

The upstream commit SHA1 provided is correct: 5e1ad95b630e652d3467d1fd1f0b5e5ea2c441e2

WARNING: Author mismatch between patch and upstream commit:
Backport author: <skulkarni@mvista.com>
Commit author: Vlad Buslov <vladbu@mellanox.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (exact SHA1)
5.10.y | Present (exact SHA1)

Note: Could not generate a diff with upstream commit:
---
Note: Could not generate diff - patch failed to apply for comparison
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

