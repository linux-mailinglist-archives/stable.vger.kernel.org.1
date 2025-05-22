Return-Path: <stable+bounces-145973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE7AC0219
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68AC51B64F24
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA20D126BFF;
	Thu, 22 May 2025 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVgXPmBY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9C84D34
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879514; cv=none; b=mlhcAIAtqhPHgygruLFIpcwmdKKsQzTbQfoFtbzvx9jzxD2njPbvn4SPgbteekTcd1H7ejDGdsQQQdGTaJdiZ4Bs3a3BzDaqDRTa6HFrUxdpO88m811/0hk5q5M7YWIkDk4pXPmR14W3Iy4L0pATtsB5/7LWIiTlcQvUY3RgUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879514; c=relaxed/simple;
	bh=2fAgNr39788oLJKIAkbX5f/K0PmwrlJSBRzyeUYgC84=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6I/rE67/VhNB6vlZT/c9BGPdV2w+cpCSTPcBh9ajgCXOPRsnMqYcFPU414A/CCsylgRenWXZufmEUlsHDB/13AGH/7YCCfgDX2kQ++n9ginjBN0qNDu/6HdcnOcqcRr/7zRXWHbTnuEhDozmc5kgYY09x8qX1hod13/FzynKxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVgXPmBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEA9C4CEE7;
	Thu, 22 May 2025 02:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879514;
	bh=2fAgNr39788oLJKIAkbX5f/K0PmwrlJSBRzyeUYgC84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OVgXPmBY84AtQo1LdRA9CWUWBu0fXfxt9hHd1+4z4mPf6Us6gv5AYwGPc3OdHlOlE
	 g8wRJqKDjlHcBpnrXUn8rdISR2055GmSGlZ4oS2vFomedGVEzVFJgH6lzE88J6mcva
	 W6W2FQ6lWGz+aTZBfKcS/Ww8OUyzabT3AUx7OiY2PHD/WZRheIysnRyruVLT0rEdF0
	 HQRsFHKGGNpAs0W3HRbsDT42tI9mqXoxUlsoN3VzEgyhWnj2VlzPat6Q34ZkOj/Jf8
	 EVnASubair34iUZs0ai+lDCwVTXCjgQFfM+XsJopOXdsFwqn+feTBoUGuKI/3DXx0S
	 kNal1vp6ZN7jQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 18/27] af_unix: Avoid Tarjan's algorithm if unnecessary.
Date: Wed, 21 May 2025 22:05:10 -0400
Message-Id: <20250521210543-a805415e11660195@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-19-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: ad081928a8b0f57f269df999a28087fce6f2b6ce

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ad081928a8b0f ! 1:  ecaebb7bb5591 af_unix: Avoid Tarjan's algorithm if unnecessary.
    @@ Metadata
      ## Commit message ##
         af_unix: Avoid Tarjan's algorithm if unnecessary.
     
    +    [ Upstream commit ad081928a8b0f57f269df999a28087fce6f2b6ce ]
    +
         Once a cyclic reference is formed, we need to run GC to check if
         there is dead SCC.
     
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-12-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit ad081928a8b0f57f269df999a28087fce6f2b6ce)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## net/unix/garbage.c ##
     @@ net/unix/garbage.c: static struct unix_vertex *unix_edge_successor(struct unix_edge *edge)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

