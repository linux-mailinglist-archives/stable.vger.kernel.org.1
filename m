Return-Path: <stable+bounces-136586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A171DA9AEEC
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AA27ADD34
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B8727C17F;
	Thu, 24 Apr 2025 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bchaPiyy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACAE27A93E
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501166; cv=none; b=oJC53G4RzRpW+EjWuD8eQGfERDuE4hhNYRD+9L643dbG4ri0btzJH6rNsQ/NCD0d1C/dg9kF5pKjB8LTkz5oyRd4ZcOd2mYrhOc9h9W5U5dnDyg49BOSlCMfchQ897Nm/YkCV+OFoPjSE6unvHMx6xj7McJ3cfLPIkoGZKG8J6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501166; c=relaxed/simple;
	bh=1+6/xiQJb+n3WhBUUC/8seaW5U5wn/G2kWxijWzYsmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp71lSU8qPnzaAg8F6Yh4m0BY/VPmbKDXmdaFCJM/IYP4QOz09f3uLcsAlfFNCXAQcUvqF9V4z3cESBwS5JiFX01/6DZt2Jg85SkVTpVLDRT9D8bAy31NWsas/bhuLE5wqaEqdTq/j7wwduv6P8a6Ftx0HxFdEZTzT7aiHxCmYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bchaPiyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E097BC4CEE3;
	Thu, 24 Apr 2025 13:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745501166;
	bh=1+6/xiQJb+n3WhBUUC/8seaW5U5wn/G2kWxijWzYsmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bchaPiyyEGYm+ItkRQhozYXS90MQQOUtlVpFn2xNaq1YoLsnmz9SAC99X1OBs383z
	 x06NqepD8J9bXB1PIvi+BufWbw2QH23xMQe90p8oQ0fgKGdzZs+a5mGwCO4vgAff+v
	 ijjGaTw3QNnGMNybMoj8TZ4+LPPCcZPXdYG9UFEIdsqQu7aGTbDvMQD1sl+0A6gTql
	 lc17lCPDnuyoDfn4HDoIUpii38BwsLjyKawNZUw3YEh5O/njmqhCiUn61/oa/Z7Um+
	 meDin/pIUlCKvplliS/qhN+p8ltPxh+fUq67e/WfYpsQ9832TBa8+0Afv3xtUJqTe/
	 OwB+ZcG0W7zJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14 v2] lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
Date: Thu, 24 Apr 2025 09:26:04 -0400
Message-Id: <20250424005206-f1d978e4da95512a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250423172504.1334237-2-nathan@kernel.org>
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

The upstream commit SHA1 provided is correct: cdc2e1d9d929d7f7009b3a5edca52388a2b0891f

Note: The patch differs from the upstream commit:
---
1:  cdc2e1d9d929d < -:  ------------- lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
-:  ------------- > 1:  57a6c70084dfd lib/Kconfig.ubsan: Remove 'default UBSAN' from UBSAN_INTEGER_WRAP
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

