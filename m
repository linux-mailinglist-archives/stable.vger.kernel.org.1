Return-Path: <stable+bounces-154763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA14AE015D
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABA0019E40AC
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5CF28312C;
	Thu, 19 Jun 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tayEyLCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF329283126
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323794; cv=none; b=KJR+O3ZlCc3/UiBJtY6TxqLfgdn3WWNXNo+C0wDqOAMttEvwdmVHcOtZEdOCTQJt8J0Y3XKheltnaGagDmpxwlgZzbqWG89LfaBQavXt6Ef1dNuFbk2h3JayEgvXuLgvhgfGppQIRRJ8zQ/03L+y0TU+8KkQIQ1R+CPhpVtvX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323794; c=relaxed/simple;
	bh=0h9gQcEG0UyuBxlI+g27zuLyFeXOprtyo8Ixko6WUsM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F34l9wwMEW+rlVtOkkm0D/bwwTktN9dW07zbIFRUICHV927QaXr7okq92lT0g4huumlvSbMnv/OQPaF5gowsI/ekdMju5liXa3wUrzHUpULzXh4TZ9KeMKSRfJr8xpSCnYknGEf4fniVoxSSAwiDQARTmd5hXsJ8M6ZF7K4KQYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tayEyLCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 514EAC4CEF0;
	Thu, 19 Jun 2025 09:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323793;
	bh=0h9gQcEG0UyuBxlI+g27zuLyFeXOprtyo8Ixko6WUsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tayEyLCca/BlR8RF4SrUOxtTr9bDCUH87+2Nh9NHgNl//hl2/AfwbVt+LXqpjp0rc
	 zYM8DOHjHSGHgpvJzD5lck6RCuKc8mQRYid2JRk/lzNPTGhkMf9kZgvkxKl4nGVb3B
	 v5GekrAaToslZaVEE0PZsuuRmlU1uU4ybHnaNHzIvd1bVKVsE1EQze4jZWBvFmuAx9
	 QTajwsXab1g1qcP+DVnEvPIdVVs8YEaTt8bNfpOXGQxtfpXpzI+x65R3gwfxF5E9OV
	 2nx92TdX6hnfu7g/iE34KrT9OD6Ztg1cURl6XD7uSnfZUAX2BbdPsXrlLy6nRf+ynU
	 n7kcce0k6Odig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 v2 10/16] x86/its: Fix undefined reference to cpu_wants_rethunk_at()
Date: Thu, 19 Jun 2025 05:03:12 -0400
Message-Id: <20250618181407-e453f543cb25ed9b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250617-its-5-10-v2-10-3e925a1512a1@linux.intel.com>
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
ℹ️ This is part 10/16 of a series
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

