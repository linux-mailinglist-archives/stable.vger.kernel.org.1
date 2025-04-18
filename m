Return-Path: <stable+bounces-134612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC26CA93A31
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0551B670B1
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E03E21421B;
	Fri, 18 Apr 2025 15:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwoBLWPo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232F15624B
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744991865; cv=none; b=EgknBF4iu1quvh9JAB0GO1JuEz6T1UdHNrua5H/WOEErQBzi8LkwkKb1WWmRG4E2Gmb1yppMHB31T7EzILgVLko9+rgt0yuSRkRah0FZRwd2WhjaveqMfqCjTu8/BGtbuqKQ3TBNwBDZxWsiPSsdjPBo8dZ6HRJwi3QFHMHrulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744991865; c=relaxed/simple;
	bh=F1R5fIBjLEVOw0K8LCtdzq/yHNqsYaFxWD59c+iBF44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBOHEPqYgihnvoFfatsIDcw1vn5XOYH5toEZZTJeKFvv7DyFZ0TisVoZuvYM8rx/CIj5ddOBktWEU/f1HKSpS+q0HDs5AMWDcpQtagJK32N6OWqQblgxFw7yu8n2Ap426ix5qeSPAzSV88+2Vq/B4fmtze6FlmHSWOZmTEn30Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwoBLWPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC01C4CEE2;
	Fri, 18 Apr 2025 15:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744991864;
	bh=F1R5fIBjLEVOw0K8LCtdzq/yHNqsYaFxWD59c+iBF44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwoBLWPoc57bgHhWo4oj6B1JQ1xmqoDM73Ol63D6VdXzx4b5MQfOGIqhUle7fpbV7
	 //xURMZnloSdykIg69rVPndaqO0+lL4m29f2FK7mQimcHTdCkRXru5NsHmH95Bdn2K
	 hfCCgWGUc3BydhrG5bW1FAWR3+zmw1I5UDJufrI3/xEaQwJg0BuuYeA7+2knM3fxAx
	 RG29UM38DXVu1ncjSGhp6AkXB1+OOblZ9hfXnMTO3uBPril+MkysXUg1eIO+5t9IvN
	 IwOtnFuHqlbyDiLyJj/3u8EFQEwoVatbA/qOhKMmoppiT54v1uP5Hqcb89UK6uRTeT
	 t5N55oAXrsXPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alex.williamson@redhat.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.1] mm: Fix is_zero_page() usage in try_grab_page()
Date: Fri, 18 Apr 2025 11:57:43 -0400
Message-Id: <20250418082441-f6f898a7a903c124@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250416202441.3911142-1-alex.williamson@redhat.com>
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
| stable/linux-6.1.y        |  Success    |  Success   |

