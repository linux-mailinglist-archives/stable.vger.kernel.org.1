Return-Path: <stable+bounces-100674-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E2A9ED1FD
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F21166676
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4307B1DD873;
	Wed, 11 Dec 2024 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVRHGxh7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288D1A707A
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934801; cv=none; b=cm9ElGQovy8WTXfX8o5/ezg1MKv3eo2iSz/7bHlnaPEqcKo+0MKPk+UFZQema1c/VGuml7N6aCQzPdpRglom3PfHoCnl54nB+SRuOFBrBL8Lkh1QpR6nbcoEpqKpPZZRt7eT0NRDP7rYiWwD4BEfbu1pOlyjMEr1fvPE/+HhsnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934801; c=relaxed/simple;
	bh=90LF/y35ppkmXoRN0KYQi/E+2/hRHkfcc8HEXANNSlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPMD59RRGZukaSGnor7XIqSV1YKefXwTz5f7DomMUGxq8kEaswKskzJ4UU7IeHwEPlGJmbxftlM/g3THHpf1EOcP03x6tb8XpcxjlUkDsyb7vqZ+QDMH/Gg8K9lj873yGwlNEAaNSdxhLZXRcSAFAQrGGkAMA9kbmZ4RNqmsFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVRHGxh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC63C4CEDE;
	Wed, 11 Dec 2024 16:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934800;
	bh=90LF/y35ppkmXoRN0KYQi/E+2/hRHkfcc8HEXANNSlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kVRHGxh7Deay0lUUEjxqikrR2SDAaon+yT8eYrbvY27GRus/nqnlIoVYzq1njbEDi
	 t0TDuBbqLD21WBQIrCLynWP1owWGdJVp8e7JmAgmcHPyJdf8sHr6IlQhwjzjVPjevl
	 RGiFszIIVVNTXlNE31J7794gREpgD6XLk+CqLsa6YDB4kND9uZdIIaMAs00l8drVha
	 HN61DWXWef/HmcA90htdgTWMmQa9dDjVbGwaXRPD97ovUzCRbgTKppvaBFKUqWFryE
	 iN1unOotKR4GnaubBp5x7eIVxHterJ1M1Hrgbier/x8UD2yeVLlDEdtzxN4PkGlV7s
	 eg9YKXV1/piOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ziwei Xiao <ziweixiao@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 v2] gve: Fixes for napi_poll when budget is 0
Date: Wed, 11 Dec 2024 11:33:18 -0500
Message-ID: <20241211090316-cc4d525a0bf02fd8@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241210235914.638427-1-ziweixiao@google.com>
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

Found matching upstream commit: 278a370c1766060d2144d6cf0b06c101e1043b6d


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: ff33be9cecee)
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  278a370c17660 < -:  ------------- gve: Fixes for napi_poll when budget is 0
-:  ------------- > 1:  e087e88ff8e6e gve: Fixes for napi_poll when budget is 0
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

