Return-Path: <stable+bounces-134894-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E74FA95AD8
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCA33B72EB
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E98717A2F7;
	Tue, 22 Apr 2025 02:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhc2EFuj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D633C9
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288145; cv=none; b=PohwJ8R8oLXNDZMt9uvAK6NpiZl+F8Gx8cpwz5SyCwgBZe5MzRWiKAOveS6cp+JTEP1dGJ0OJusseDK+d3LqHocaR+e/0qGzTfp+UsxCpeHdR+7i+axloQRj+F+3ry6ZljRq9nTo7rvrd+06ZioS8KLH7oi43BEkyuJbhaD4IYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288145; c=relaxed/simple;
	bh=iQvJoeaLEJ5qoOdLC4MBbyGVVDV8k95hF3gk8G+vb4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPI42nCTV6JEI0msicjtB/qmj8+35Iskc3MtCks7KbX88G1aNs3praxFvf5uQYLHgSZmvxsrnVe7zrYxJyDDqchaI883knRgZblSoSuoJVIS/SGUXUFQlJfCOnNA5ZErW1uOcBXJF4M9QXKk6vQyVdghnkV528Mn+Wa0zix9Zbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhc2EFuj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D62C4CEEC;
	Tue, 22 Apr 2025 02:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288145;
	bh=iQvJoeaLEJ5qoOdLC4MBbyGVVDV8k95hF3gk8G+vb4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhc2EFujLCXySXH6ZMxtKZiX6e7uDs1A968B7Qg+Z71Wz38zoiCnKoLNhQjtZKXGt
	 UsTXry4Qp5kdWKqU6g3r7ANIFUAIorVGfPZXnRMfUFnrkSa7wnVdOZUwSHQnLLCv/C
	 GVNpA3VTjVEc1MwAazJy7J8ydxBMDXoilbytFeiDEs/b0KWo4SJxVdEQLFbftKfaZ7
	 XbmIErtOh5Nlo+MZrbEodi4VZY2s3XRuv87wd5Ge9pXQA8MeRm0jHwkluRlH15TNs1
	 Y+YS521+2ot+i7eBDM/DXCzeyA5gFBse1ELbic2nRlM8WKDDC7ygyDVwnQh/nJEBJk
	 nJCDlge7eoxMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	kuurtb@gmail.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.14.y] platform/x86: alienware-wmi-wmax: Extend support to more laptops
Date: Mon, 21 Apr 2025 22:15:43 -0400
Message-Id: <20250421193911-7d80a50e28ae9d1b@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250421170451.11279-1-kuurtb@gmail.com>
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

Found matching upstream commit: 202a861205905629c5f10ce0a8358623485e1ae9

Note: The patch differs from the upstream commit:
---
1:  202a861205905 < -:  ------------- platform/x86: alienware-wmi-wmax: Extend support to more laptops
-:  ------------- > 1:  44e43dfcdd33a platform/x86: alienware-wmi-wmax: Extend support to more laptops
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.14.y       |  Success    |  Success   |

