Return-Path: <stable+bounces-145970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0A3AC0214
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7953E7ABB2B
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DF12D7BF;
	Thu, 22 May 2025 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQvKTMTc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815301758B
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879504; cv=none; b=SZoMY0X+TNAngneLoHpHe8PKJ9KNukb4HkYml1k0LjXVBSYeQipiXQlD1rPx4a+hCoukTcUP9+88ZhllWEBmLEIErVNNivunDWZCk3ksLwIzZt5ltTDLogS/J5NQ4q5tHvunxCIft+Ctgf+In3Ngxo1Pfkh6W0wKY80JrXCtKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879504; c=relaxed/simple;
	bh=BsWDpT14swdXduuRRI8UkLSaiSCboYqnuYYqM/7JS/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UVgadt7UVXWMKMlviyDqwj9A3DDj7iKibkfHktC/n84psCcl74Ez9AqM8wepxI4n4/o/W0HoxyyHgQVfNHNxA+wdwT+59mMZAC3v6P2JGdhXTjyEQXKO947CgIoi7+gkAWfGHwiR0vTXm6f6cjUW7Nhikd8Wo0V312LcYiXswJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQvKTMTc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93580C4CEE4;
	Thu, 22 May 2025 02:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879504;
	bh=BsWDpT14swdXduuRRI8UkLSaiSCboYqnuYYqM/7JS/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQvKTMTc9P8KuDHNpNGsHTr5GL/TBRyicpf5td6kvqo8ty9G+Y1UqsNJ0bYb7ay5X
	 oGkJyQGHpU4PjO8JLO6XKX0IAgA/pIUTgBXx4WP4xGGEwHUyINsi4Z65AwD+ouGNl1
	 tdK5XTNzYkGrvhBzMyHYz0lD3LG8waTjqknSeutILcHmiN1kHkrt+IVBJ+6+hGyEkp
	 YUOw2QAFq9Hyl+B8QsNzSmOWkaDzJsraT6Kv7H3EsXt1ktX15te9iZ4sAf3wQ1Xe63
	 GzqzgnTj3dBSPuRxDpaKkYL+aGh2hsPHvRu+sO8WO5CPKCz0kOuPi0DgEY2+pm3PLn
	 +y0KSGICnQvhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 16/27] af_unix: Save O(n) setup of Tarjan's algo.
Date: Wed, 21 May 2025 22:05:00 -0400
Message-Id: <20250521205634-e03bd2df8085af1a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-17-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: ba31b4a4e1018f5844c6eb31734976e2184f2f9a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ba31b4a4e1018 ! 1:  e40450e8778d8 af_unix: Save O(n) setup of Tarjan's algo.
    @@ Metadata
      ## Commit message ##
         af_unix: Save O(n) setup of Tarjan's algo.
     
    +    [ Upstream commit ba31b4a4e1018f5844c6eb31734976e2184f2f9a ]
    +
         Before starting Tarjan's algorithm, we need to mark all vertices
         as unvisited.  We can save this O(n) setup by reserving two special
         indices (0, 1) and using two variables.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-10-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit ba31b4a4e1018f5844c6eb31734976e2184f2f9a)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: struct unix_vertex {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

