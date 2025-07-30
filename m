Return-Path: <stable+bounces-165549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 048A2B1649B
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6586218C3F1F
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5542DCC1F;
	Wed, 30 Jul 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GngksSLZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E61DFD96
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892931; cv=none; b=KqopUWog3IhhDEMrhTodDvKVxz7wey2i55RUypEfdlw9rfTcdW299kSiX3q93jTwFZq/WFtqwIr7R59Eto6L6y3r9AG7pldHENBtva6T/sdc9EyRlXKiZ78rwnRUEDmCRNWsjOsXh0XwgRP3SixS1vc6xBmYrJcPvEh+/lhhYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892931; c=relaxed/simple;
	bh=68LcEucZtMIz98wcMoIri9YQnPIykD8xh26m/46WYwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJdFpc0kYF/6NYyQb3A/3VGpNZrGLMux0RBqyWa1I1BQ7xNCFZBj2/A8gAkm0alU9idGPsV5V9H7N8iLc+8RuHJaM2f/OKQdKGBBZ1smHExvG8LqVn0maJDvqpnCeduo9B9ZBI9Jicd7yMRef9qkx0Ne6PQ2cLEYTRGyBy/hH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GngksSLZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2437C4CEE3;
	Wed, 30 Jul 2025 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753892931;
	bh=68LcEucZtMIz98wcMoIri9YQnPIykD8xh26m/46WYwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GngksSLZrErXjZg5bd0AIZ12tds+BEedld3zt7VMQtjcIcEPEjd5EVM2FAEnYQXfa
	 Suo/hyo2GUJpkyyvkU65wbZDA6TOEfQ8liUJEGDDPK/TPQrmyr6CXLOgSPYiEa1jr0
	 xSgDn5hAtU+zKI70/Xqb5gm3BS8/uJPO6MjaLen7pg990YFVN0EK3k1s6Tm/C9PIDS
	 kNt7AHUhSA5cJVAAtZue7rUzheHBusABM2iLaGANMTllNcNR9Y0pYot2ZRyna+ZG1r
	 RUtRv1WpLMRPbCXQVUQH4VIWBzrV0WB4QxjWWsvL9R6ymDAIOlYi+ABtg8a4ybH938
	 oQeHwYQqIc7qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/3] selftests: mptcp: make sendfile selftest work
Date: Wed, 30 Jul 2025 12:28:49 -0400
Message-Id: <1753887608-a99f9044@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730102806.1405622-6-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: df9e03aec3b14970df05b72d54f8ac9da3ab29e1

WARNING: Author mismatch between patch and upstream commit:
Backport author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Commit author: Florian Westphal <fw@strlen.de>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  df9e03aec3b1 ! 1:  2b0b67ac1f24 selftests: mptcp: make sendfile selftest work
    @@ Metadata
      ## Commit message ##
         selftests: mptcp: make sendfile selftest work
     
    +    commit df9e03aec3b14970df05b72d54f8ac9da3ab29e1 upstream.
    +
         When the selftest got added, sendfile() on mptcp sockets returned
         -EOPNOTSUPP, so running 'mptcp_connect.sh -m sendfile' failed
         immediately.
    @@ Commit message
         Signed-off-by: Florian Westphal <fw@strlen.de>
         Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
         Signed-off-by: David S. Miller <davem@davemloft.net>
    +    Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
     
      ## tools/testing/selftests/net/mptcp/mptcp_connect.c ##
    -@@ tools/testing/selftests/net/mptcp/mptcp_connect.c: static void set_nonblock(int fd, bool nonblock)
    - 		fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
    +@@ tools/testing/selftests/net/mptcp/mptcp_connect.c: static void set_nonblock(int fd)
    + 	fcntl(fd, F_SETFL, flags | O_NONBLOCK);
      }
      
     +static void shut_wr(int fd)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| 5.15                      | Success     | Success    |

