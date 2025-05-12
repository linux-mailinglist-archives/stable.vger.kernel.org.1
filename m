Return-Path: <stable+bounces-143830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A36AB41F4
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39ACB8C0D93
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C729CB31;
	Mon, 12 May 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riPEmtL+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2053029CB28
	for <stable@vger.kernel.org>; Mon, 12 May 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747073103; cv=none; b=uUDZ0oEnbFhxODsZ7t46UK0HyLBYFgr8MH9kF2YHmC9h7euo6S3WqQS2Ve1pXNWaInFSvwDHCCniGgrcNQUNmFdlDxYhLcLBbFVcf0h0x7t4iTDidsqjVAaqisW2qqKtCdd3d6iGEHxDNn0RHl6XO76Eqk6rUGiCQuwEal89qqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747073103; c=relaxed/simple;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPAs6J5Mm5b+0JBxBxa5SOSMpIxhhvRrMvW6x5lYW+8wDbhQV9JSuHS+Svx6/l+1M4V1Tp6GmI+qxvlpJ7g0mpfg0uuZS+oLP3S3featsdhiJR7pICHf4CtpLX1DpfIY8um9N6e7COjKK6C3zg52JD9F6iRkEkjeRR5TelWXIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riPEmtL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E04C4CEE7;
	Mon, 12 May 2025 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747073103;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=riPEmtL+ftOk99MulUSC+IY5tzIo75umeflW8ZDFMwkAY2M0zOQz9Qu0M0AEleCOI
	 PjqlG4DKEmdQH8JFnqgoMS5H5I2UtDzb8eY+NiuackhZJaHvpYGJTZhS5nlk+/j+Ow
	 Wc2e9Y5W2r2p2vv/YV4jX4vdB/rAD/h8m3dzdzadbClp1MhWdrK0797sRqeVcStX0I
	 awGsQ8sM1jkDjm5Mws3fgVIg0xVrLR4vvKQYjDCNCpKVxWBsDWxz8DH+mhTGl+VCGb
	 8cQoFwnrxIrNRI0TiwzMeDjWlifi+5niuNsTs2ghA7GJnp4SAh8dRMFVqYFzrWVzyG
	 v3wooKTlwuIVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cristian.marussi@arm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] firmware: arm_scmi: Add missing definition of info reference
Date: Mon, 12 May 2025 14:04:58 -0400
Message-Id: <20250511222548-4c29aa3af82209d6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250509114422.982089-1-cristian.marussi@arm.com>
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
| stable/linux-6.6.y        |  Success    |  Success   |

