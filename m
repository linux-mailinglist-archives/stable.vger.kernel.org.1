Return-Path: <stable+bounces-124229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0485A5EEC6
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A90219C0BE1
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB922641E5;
	Thu, 13 Mar 2025 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGtJFife"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA369263F21
	for <stable@vger.kernel.org>; Thu, 13 Mar 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856486; cv=none; b=ZTnfQ4MzOQQsvO+7DJSRSWTXU3lKHLi5Xt7KzkwN/xxO6IYckDWSIBMIQ1EezKXXTj8xV9Me5+okjlPELm4cLVsPNUq45/gpmcGy7SdCJFfITe9wzDqWhJlI0ohyXEcQmV95TVXw4QHZqjBjeYYELKLPxJMsc08sjMl92m5WzQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856486; c=relaxed/simple;
	bh=5r0+VtfU9dmyHqjhwaf36+vCTFpBd8f1mr9ayJDvNOc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DojHiucWXI6o5QLXrTr7BuUKURED10vu82naO6yINYNtQm/8ZrTxV7MR/gd2DmWfxSl5bKYcik0MQrzJE2n93GccpugiLsLq3QUGio0OCAjd54n90Xb6Q3g4Hhcd4Py5vkezTRUwrcVRxs94NK272vOEB1aNQo/OeoP6qMwC93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGtJFife; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7ADC4CEEB;
	Thu, 13 Mar 2025 09:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741856486;
	bh=5r0+VtfU9dmyHqjhwaf36+vCTFpBd8f1mr9ayJDvNOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PGtJFifeC5zG9IrVCuN462AZ/aWNm9eeREVCRxpBLACDYtmInn57pwLsKnWmcq5fU
	 a1xRtiY6/k0x1Stero9V7S55R/yExCw0aIaLkDnEQyxd8/GuMxLa2fUz2eknzK2VG+
	 dofkO7Z/GBo1EwrXaXHRN/BSUTWo5GpMhNq1D9CIuk8nbiFRfJWpoUmfsucp4Pg6pv
	 D4g0ys/baix+qVkW7D9GBLVt40HUKMW6i00xhYz9S4KF7XuF/8/8dlZKXm3/Ry+5oC
	 YO9UWMmMvkogzNZ1enOy428Vy+UmjqOf3tyfmSwlJveQE6m4QtKq0+SJnit2tztzLv
	 ja8C23qiRAz2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	magali.lemes@canonical.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4 2/4] Revert "sctp: sysctl: auth_enable: avoid using current->nsproxy"
Date: Thu, 13 Mar 2025 05:01:24 -0400
Message-Id: <20250312234346-16861af9d09542ad@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250311185427.1070104-3-magali.lemes@canonical.com>
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
ℹ️ This is part 2/4 of a series
⚠️ Could not find matching upstream commit

No upstream commit was identified. Using temporary commit for testing.

NOTE: These results are for this patch alone. Full series testing will be
performed when all parts are received.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

