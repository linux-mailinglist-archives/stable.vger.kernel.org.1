Return-Path: <stable+bounces-118918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B85A41F77
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 13:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13ECD3A87C9
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D442C233722;
	Mon, 24 Feb 2025 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy/n9czl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EA2233710
	for <stable@vger.kernel.org>; Mon, 24 Feb 2025 12:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400708; cv=none; b=RsbBt2vkMqiIIcz8RDJ8DcoDZxMhvqfzPn4J+HGWvy/ECqOVDCFlftBSFLUXIvGKXzRyduUKkoHGiJGvE5rvWwhpz6VFhYIVOUGdGDY8a/0wPZbOPTPmfRlqc0lJBJYFwRpG2GOCG07qJfz7aMbWqVAdJMHjOwHK4YQxZkcRqDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400708; c=relaxed/simple;
	bh=N5mYUEf1Q7ecFXRXQ1Gdi8oXpkHBhoFVpD4B9DAXVZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAabb8yYJMAGIjHYgrPkYqVNEzKlOU3CDFhVfEYMcat/OSDTQRKPkI/WFLkL9lmLrOwXp2lRgWdhwswqwlHSwZh+WNykV33ONwviZM0UixIyBFkmH5GeZsPm1pLMRMNuySf/Obw2eFFETtuS4Mqq5XqvxgkrdYEYwrc58zkO53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy/n9czl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9F3C4CED6;
	Mon, 24 Feb 2025 12:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400708;
	bh=N5mYUEf1Q7ecFXRXQ1Gdi8oXpkHBhoFVpD4B9DAXVZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hy/n9czlUkzYTNFsBUL0JK3Glnk3tgbVs1Htmuwe10P64GAkb101fX0Pq/sKU+LpI
	 u+WHS0H0t1Mz68vHaEy15pIEH8ubqba7f3b6OkFb+QZZW/zs0si9pD+xc5XkZ9cajG
	 Z00hrs0VSxNtOMDa02mHInZyW7GQUEl1cXZ0nes1+tXRTXmP3OexRjeGx2MNCsXA3s
	 w0de3d2O1L5XEr78LrD1clbXdjubA/PhzmifQXtjc5RcJTLCTVSIL3wC+N29DqFJQu
	 TpiON7dw4pUtNp0Z9bexiw1zi0RXMLgXlVu3533lM6e4sm8CseyGmW/q+PSml/Q77l
	 C84UiM3KwlpgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	cnsztl@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
Date: Mon, 24 Feb 2025 07:38:26 -0500
Message-Id: <20250224071439-4cf6e833ab05c6a7@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250224105422.840097-1-cnsztl@gmail.com>
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
⚠️ Found matching upstream commit but patch is missing proper reference to it
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

Found matching upstream commit: a6a7cba17c544fb95d5a29ab9d9ed4503029cb29


Status in newer kernel trees:
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a6a7cba17c544 < -:  ------------- arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
-:  ------------- > 1:  2d087bdd21e9b arm64: dts: rockchip: change eth phy mode to rgmii-id for orangepi r1 plus lts
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

