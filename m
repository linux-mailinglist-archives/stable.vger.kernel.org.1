Return-Path: <stable+bounces-145990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF649AC0233
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38E41BC3922
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECA18BEC;
	Thu, 22 May 2025 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYJLwgu4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA842B9B7
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879623; cv=none; b=rIFENFEekCmdgSq4qq4HMTFzE6g6+yeazm01fZ3ERIjod28GAN7KTCOI0jsWMIUQlD/FbzlPqnjUCk9Jtactkf7QBhta70nv411+JfufGxlHQ56mTo/jZJwzYL4LM/O45KMo4ugIrwW6VYEDLh+9hjooPzzeB7C7GsRkj42zgl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879623; c=relaxed/simple;
	bh=YCPP4mQG8zuMZ3QQw32GNqSpjby+tGED4B+1v7/NODs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sj7WqAhIGDSpCyE68U9FEOXAi/SrJJadMYpEvSOLyyNCZ2nuxH3o5A72x63AQrDbpfM5Ms3aeWSkfMNgWwb6NqDplWutPAowAn61IpNeNSyyDDYSpkJXsnNZ9TJH+5Qf2bTrX8F+On55br9Z5psli0KVQmrt5MutCOTfhtPi7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYJLwgu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FFCC4CEE4;
	Thu, 22 May 2025 02:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879623;
	bh=YCPP4mQG8zuMZ3QQw32GNqSpjby+tGED4B+1v7/NODs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KYJLwgu4mEQoxneR+F7AfRv7UF+532YfOpuhUv9Lq95WtYfBwcGmtrFp52F0ABdk9
	 FLQ6g96m9DCxuwuh/f2538BCwEn4r4JZyhCknUXqLG52Wzca2rf1eb2//Iz1W6xGLa
	 3C9ip8FvV8FDazuLxKBrZY8JMXy+Ibcd7iBgKXf9EamYuyLVou33y6gtyokKCdCx9k
	 0QTGZzdBTO98BqfaudJlpMI1NhWlWsp6BLfYWDwapHVVh9ivzUzp3rCwfEe8KgdRbt
	 lh3oJ/hXCV3bo+wzt0ffj7eyQnSC4tkv4rR51WDeKVJXvb7ootcT9i6yfV0QIRhFTk
	 QYLoC+1jGv7DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1 12/27] af_unix: Iterate all vertices by DFS.
Date: Wed, 21 May 2025 22:06:58 -0400
Message-Id: <20250521203819-55d7b9c0b00d3047@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521152920.1116756-13-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 6ba76fd2848e107594ea4f03b737230f74bc23ea

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  6ba76fd2848e1 ! 1:  81c21430d5b6f af_unix: Iterate all vertices by DFS.
    @@ Metadata
      ## Commit message ##
         af_unix: Iterate all vertices by DFS.
     
    +    [ Upstream commit 6ba76fd2848e107594ea4f03b737230f74bc23ea ]
    +
         The new GC will use a depth first search graph algorithm to find
         cyclic references.  The algorithm visits every vertex exactly once.
     
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-6-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 6ba76fd2848e107594ea4f03b737230f74bc23ea)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: struct unix_vertex {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

