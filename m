Return-Path: <stable+bounces-163317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3944B09939
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 03:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC61188F426
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 01:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544E13C9C4;
	Fri, 18 Jul 2025 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUdyzsya"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A92C187
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 01:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752802488; cv=none; b=W+5rSEtEJNoUnEX+cH/9damV8+ETlY6Bhma3EBLlbjdiy6rmzRmIeNiCnnqQiMlNvPQiQ9wHmJSRkFF9vGTDqdgwOxXBEdGxQeL/GBaluL4DiVSCEVrFhGJjrbbh+RF2OQn5/x1I9zUwWA47t4VtYmMQNwJAi4R/zPAsmjQNmBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752802488; c=relaxed/simple;
	bh=AHXPCXnn6OigZormfT8wbglRwXcYMzBp48lqZyeYgZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BOuTrYQtzpyj3kEngXal8VFvkp9krb2Aevzs4Rg4iuHYSLrYjuq+GqWJWHcOupOjA4RNfn8w3lUkMdnj31oli2H4WFR9rg2MC16m+je0cIfhW5Kg3p5x8G8kE9xcdhPLXM3tzud9V/bi1RZLRpNbg7Wf1vH7HuUTYZHBZ5IExu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUdyzsya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D531C4CEE3;
	Fri, 18 Jul 2025 01:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752802488;
	bh=AHXPCXnn6OigZormfT8wbglRwXcYMzBp48lqZyeYgZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUdyzsyaesi0jM87SAM54ic5yollIigJHGq/mcfEcCNrMRnt2PLF6HXyw6ebAD950
	 dyAmWYC0IIPmBahpR/Vq70Z+6oX0H0T1uWR7hxz61TWrfb/1POvL65nnAmf4IP6E7x
	 oXYSl0fUIbs1a9e3lWEPmQZcjWkRQbwVMYPC/M5/Iyf3T/OyqHOx6c6Sy+66VxpV7k
	 i5ziXStdU8kWxTtmv76wryTh/bq5r6W5qImsZyyowhwCqn1fIPt0ILvv1IHAv/U3g/
	 tmnVu+Jz754zNGjolRXnzyyYhZHs1srjiwNS3h9HgFzhNR6rj/b+S1ApyL6ODaR/cz
	 K02O/n6RCipsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y 5/6] net_sched: sch_sfq: move the limit validation
Date: Thu, 17 Jul 2025 21:34:45 -0400
Message-Id: <1752797234-a5486b31@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250717124556.589696-6-harshit.m.mogalapalli@oracle.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: b3bf8f63e6179076b57c9de660c9f80b5abefe70

WARNING: Author mismatch between patch and upstream commit:
Backport author: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Commit author: Octavian Purdila <tavip@google.com>

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.4                       | Success     | Success    |

