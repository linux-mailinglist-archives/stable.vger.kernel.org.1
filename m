Return-Path: <stable+bounces-121642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419AA58A44
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC773A8B4E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80E17A2F0;
	Mon, 10 Mar 2025 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6XHrlXc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA05156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572861; cv=none; b=LBH5LfaMbtbfcFEkK2ZANmNOmfNwMEzch0lTMSMyOxtf6c7fDb6w4oOX7GM/09cD6YpZV6UO8gcmwf1AkS0+PI6f2dMNPUiXp5kvkD4SfkIc3lA8Y+eJkoK2E/DNZBOpkCQ+OlVjMHgNwWSpcQHW+24MqhRP1czwUncSbUAI13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572861; c=relaxed/simple;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Op0gy+rqQQbMNpxK2SKXuSXk9yOq1bpbMDCQ5NNprOkOOHtkW5N9XgPV+SHcdGFUx/rh1xB68G+LGWkLU+GU8jd3xB1yzmtfG8fPwfTfTZn0sGnYgFuj51/1aaXMywDDGkLDfQiAQ8jD4b5Yxc08drFPCUxMAgfjadTucngdfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6XHrlXc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D33C4CEE3;
	Mon, 10 Mar 2025 02:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572861;
	bh=0HDvXsquJe35RxC/4exG6QdLKMdNUeFZF5pNc1hetFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6XHrlXcPhgFk4dcsShJNcym5Shp+Ks20QYqOLi7nPtnECAqwkZwYDW1yPXBXstIb
	 Zey/BcDPMrgMWqPnQ01cg6TtBNaZG3awPNWh+GbZQF84BPUeKgG6iFWsMkSVKRO3fT
	 7DDtVa+eaWtMj75rsJKiZQTt+If+8UC49UY/5islupdP7RLgwcmVyx5PXC4wAKf82a
	 4qPwPrQUBhV0+Nx97vJU3jmaHYj+H+kC/IKSTSoH9xSyKyXH73WBELkGnsG5t1uAcH
	 3NyyJAnjChkG/HBbulYHXEXRq2lp1H0v2I0loG7+4QALr6LX4GDDUO5lcfqG8heb80
	 Te+HHN9frt82A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	apanov@astralinux.ru
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v2 6.6] mm/mempolicy: fix unbalanced unlock in backported VMA check
Date: Sun,  9 Mar 2025 22:14:19 -0400
Message-Id: <20250309161724-f4ff3a6d814de1be@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307122737.10400-1-apanov@astralinux.ru>
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

