Return-Path: <stable+bounces-152519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30E3AD6592
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 04:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2267817643F
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 02:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9931E1EA7CB;
	Thu, 12 Jun 2025 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VWAQd6CU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BDA1E47AE
	for <stable@vger.kernel.org>; Thu, 12 Jun 2025 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749694974; cv=none; b=nDDDLhDuLZRzzqG5xkiEBM/TTcCsTUmpkhpQz1VnwENBmJrpfEdRzU3o55zhFczW562pNspuw7g6mkJsjs/Wber9RR7QFCeQSD+bdR18uzsQo+riS8O24MRbal0/MMkAPeGGpFSXpqfeujqbRRf/VCyiAtDfDEJWRo7Cq66mc2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749694974; c=relaxed/simple;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0oQvEnO0I29KRqlHa9MIcxwpalmFjkLsNupOddJTJ0DzkuKq+IfSI1UlK8YIwIFvXSdH3GOojWCrKutNrCyDCOrJZyAK0M57OEHEFPWNL3PTT17qufOb/lauB37BxatNoFVT2/9GY38Oz/yqL+gejD5SAYaBpLYqEkg4cR5jA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VWAQd6CU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FF4C4CEE3;
	Thu, 12 Jun 2025 02:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749694973;
	bh=ofAjwtxJJ90hiXxaQO0TYvFGJ/CtVPmOp0RxlxCZStA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWAQd6CUZg5oQ0jimoxncHiGLgS7MYCVo+TpojTm7f91asCyOoDKx240rrAbvBRuZ
	 +tm0wkMNRT0BiCLsTfiS7/lKkpM8lRZaqRHxhEhF5cHC9/LPiEvzbwcqzX8htLmK27
	 ArjbJiOca7VNkWaiyto8o8fAL19/jum4h+lsYdc7e0kDOr63oWpDBzEUUpFgAR6KK8
	 lvLFfH4cbpj0BozrB4aAU60VMx/Pr4zX83gwfhPU9Mtt3sxtsfsousuFEgrKX4iVKb
	 6AFH5VWI6XBvvzMtxOXhtFMi8sa9XMfnKU714+MOCXKT5VT1HWzhEY7abGLDEOJvsN
	 92hhnFcvYFTeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	dlechner@baylibre.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] iio: dac: ad3552r: fix ad3541/2r ranges
Date: Wed, 11 Jun 2025 22:22:52 -0400
Message-Id: <20250611153723-67792efb94647fa3@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250611172852.821726-1-dlechner@baylibre.com>
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
| stable/linux-6.12.y       |  Success    |  Success   |

