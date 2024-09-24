Return-Path: <stable+bounces-76950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B05B983C0C
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 06:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E31C2212A
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 04:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954C4208DA;
	Tue, 24 Sep 2024 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzAd39Vc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E841B85F3
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 04:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727151841; cv=none; b=NGrhjvSqRlPJg5QNhjqgXTQ5Tfi1nZtn+BROV0jrs5rRTm58j/ui6hnd+OwoYSeP0nHd5rS5GBEiOU/B8k5jZ3E9x9AsH6fW2Oo5DigI0O/vgwvM31NQls+/FUkjcWUUpikGe12GGApz+GKVM0SLxDDXC5x98sDJZyqXBnNfNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727151841; c=relaxed/simple;
	bh=b28e62BqKiXkgix93URN7LP3PQ6lA+8V/2dvupzj43o=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=uoawdJBbiUvU8SLlPC0ll9kQmxY4ZpIQs4nLotPg470qnki3ojaLDvq1a0Hi2+hma5yiF7BrzwAv0M7aAT++EitwfNLORe4MImQLp+qeklY2cOLzejt/cqveJ7axUK/EUWGZgq2T1jp2vMIVp10bnZ8apNiybdzxfBaCaEJlQuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzAd39Vc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138EFC4CEC4
	for <stable@vger.kernel.org>; Tue, 24 Sep 2024 04:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727151841;
	bh=b28e62BqKiXkgix93URN7LP3PQ6lA+8V/2dvupzj43o=;
	h=Date:To:From:Subject:From;
	b=MzAd39Vc2QOd+6nBy9R1Khtgs8W72dsItRXL6ug+5dxty7unuNFxxOc8QFbiAn4QG
	 trhewZMqj8TkDZwXF3vaaTdGw5BZul7CjP5cCabScejMvq5CaK+i2zlgFTsiH3RuN3
	 bq7rQtw8JkuaIGejSEEEbE9kZoeyKhvr74DCMkIYyK/WkK+HoLqqWamxbHcb+5NLsY
	 P38XwOWhwy9y85VdEdgdapjFXso3bmS0HG/TY1U3Qsn8T8uLV3jgXVdz5Gsoxz2fnX
	 yw/AJ6dYVhCrRTuFb5E7+lx+dmbAJJaXCe+hpP+AcW0iP+S4KaXC0dW1e0nw7dzAV3
	 JFfpFinYaCtZw==
Message-ID: <9c551c15-b23d-4911-99ee-352fad143295@kernel.org>
Date: Mon, 23 Sep 2024 23:23:57 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Mario Limonciello <superm1@kernel.org>
Subject: Fix regression from "drm/amd/display: Fix MST BW calculation
 Regression"
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

The commit 338567d17627 ("drm/amd/display: Fix MST BW calculation 
Regression") caused a regression with some MST displays due to a mistake.

For 6.11.y here is the series of commits that fixes it:

commit 4599aef0c97b ("drm/amd/display: Fix Synaptics Cascaded Panamera 
DSC Determination")
commit ecc4038ec1de ("drm/amd/display: Add DSC Debug Log")
commit b2b4afb9cf07 ("drm/amdgpu/display: Fix a mistake in revert commit")

Can you please bring them back to 6.11.y?

Thanks!


