Return-Path: <stable+bounces-105627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8F9FB02F
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 15:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9202216CA4B
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E9A1B414A;
	Mon, 23 Dec 2024 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZYA+vV/3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF72B224D7
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964535; cv=none; b=TM2I7NsuvTntgcL0fnLrqB/iZxB+JxjJDaWr4QSip7reaf7VM5D/BOJQN/osYEKxcqXdNFByTRyvsb+GOXekzaUmBvQWMTRxP6ADSLtxLJ6pbyAzXgwHSSyD8pJORGthvzV2jxa7Q11LJlIR5I/1Tun79enZaZqGCFHt7j+x+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964535; c=relaxed/simple;
	bh=lJ2AKe/l3YfncduMxDHWHkP6fA/GYdTg+mwzVO3M5mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obvu6TWWntbd9Wmcm7+UojtFGeRYbPb9OvSlpbKkP3E4m9285UVWBt+QpWlYqa6jSziKCqEH/yAIBnWxzvAjoSTJEr+uNy6vkpACQ7ACZwP161s/exVpRYRNKKjbvhzrvlIhwhFGse5XO8gu5HHo0QC9OwauxR1i08k6Nb9VeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZYA+vV/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5D1C4CED3;
	Mon, 23 Dec 2024 14:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734964535;
	bh=lJ2AKe/l3YfncduMxDHWHkP6fA/GYdTg+mwzVO3M5mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZYA+vV/3yxW8Y5kIz/6/ZqzonR6GQO0w6cC/x6V/Gq5LPi6la0wtJ8cggwM2h+AqO
	 Dv6f4T05acwDfg59pEBFp0nn8vRWzDAeYMIunIykgNecmMVESuE8bCPfAH6trQCAKC
	 vFLJhwKGzNPWKEkRGgUh6nBbMr0ZcIZvNDTi+zZl1zlwEZEoXHb+yWOQhnz8ZX9NBZ
	 Pa6sl2chaFTjuL0ICv2z9nZYygAOtBQey19nP2VgMhkQMOXUUDDsbi7nW7ScUjDIKO
	 SGNdMBnXbgmFZwqwiG3bistXL9hP8yot+YLKWy+HXtpGq0lM6XEsqMV7QGBnsB2dkj
	 4cSzxBwVPRxiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH] usb: ehci-hcd: fix call balance of clocks handling routines
Date: Mon, 23 Dec 2024 09:35:33 -0500
Message-Id: <20241223093223-4173e9cdd41aad4a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20241121114700.2100520-1-mordan@ispras.ru>
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

Found matching upstream commit: 97264eaaba0122a5b7e8ddd7bf4ff3ac57c2b170


Status in newer kernel trees:
6.12.y | Present (different SHA1: 0967e8e734b8)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly, falling back to interdiff...
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |
| stable/linux-6.6.y        |  Failed     |  N/A       |
| stable/linux-6.1.y        |  Failed     |  N/A       |
| stable/linux-5.15.y       |  Failed     |  N/A       |
| stable/linux-5.10.y       |  Failed     |  N/A       |
| stable/linux-5.4.y        |  Failed     |  N/A       |

