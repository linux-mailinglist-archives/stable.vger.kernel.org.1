Return-Path: <stable+bounces-110987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C5BA20E5B
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11656167381
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5291D9346;
	Tue, 28 Jan 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRF04nqW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6909A1917D9
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081076; cv=none; b=mXvy1TWf9Fb9eKz/jQLF6+Nxhm9FVmGJIbcsQr0VNwKgUwQ5cquoWsCdaXwlJMasTIzyzM8PC1kii1MVYSVUk0QMtbHK2H8ZaTwVXZRh0tkn91Bkd/p6Yq7lmb6z2quSIEECJOFUNI/UAFMRLuLag3eVNHvl1xUFsx1YWvNcGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081076; c=relaxed/simple;
	bh=PYhRlFyavZBlnjAnpVLOpSMq7SwDLXsUPQoFrfmo0RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f4BfnlzennxzAjuRsVdq8v3vQQKV5350wbPEei7cdY2anghXJePyMYrOq7eb9AbwDvBZngnT/urp+2dLc45LrZ245Q2FRzlQU6PSd2neyL+86WjsX1nbKMfkWVvQbB2Agkv8lP+jzA80SVYqtTOgDzuRKvpXZvKwTK4I7R8NeKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRF04nqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDD1C4CED3;
	Tue, 28 Jan 2025 16:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738081076;
	bh=PYhRlFyavZBlnjAnpVLOpSMq7SwDLXsUPQoFrfmo0RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LRF04nqWP96o5BeEnzhkPg6ONZc2Ew2wLb7ptZ3UjHSujPshM1jNQ/t2TVILtgb35
	 GCycwvii6BxjSrqFaVTeBwUp7w1c+358qTGNsGFcYCEkng3Yvbl5HAgNz4iVVT1IWD
	 BGQPAoridXDNrAGmLzVG/nliox9Me3eMFfJYuMwVmyLgCCAAs4X2WjKa0QfHlWEfpA
	 vw35mrf50F39OtbCj6lHXLTYiWVscmGBWJgDa4W27HkbZp9pC8Ea7C79E41SsuCQeQ
	 xwLybRMSTuFRwQH6KDJb+glsX06q4U2DPq35K3C6pYnX5aOXJDj6d7Ggy2jFVKwBnD
	 JVz6XyFuWvsXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.12 hotfix] mm/zswap: fix inconsistent charging when zswap_store_page() fails
Date: Tue, 28 Jan 2025 11:17:54 -0500
Message-Id: <20250128110006-f15e066923fa45a1@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250128174938.2638-1-42.hyeyoo@gmail.com>
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

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Failed     |  N/A       |

