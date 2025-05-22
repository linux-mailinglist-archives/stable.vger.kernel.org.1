Return-Path: <stable+bounces-146013-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB309AC0246
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 04:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466A71BC372A
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 02:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEE53F9FB;
	Thu, 22 May 2025 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFjUPgN7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD11610D
	for <stable@vger.kernel.org>; Thu, 22 May 2025 02:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747879717; cv=none; b=D0v1rN1NoOOySezWe6qcYlvGR3YPkohOvkCk9rjuiTM+I/Lw/iHiR67Jt4XL2Wo2p3jtMhZ1Zk3gdSA+stRhZ+wKDVf8ERYIGcqfci2Wk+crB760ZYNOjF6ULaB1NkCxo2WgaWetiQERMl6zqm72Mm0K46/+WmGjpjyLyLunKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747879717; c=relaxed/simple;
	bh=0Z2z4PqyEobBMDt9wDNsWLnfV/jQuGPaXL4kbrETxzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdB4mz5MJnXDOOU9L7ojVLay7wTzJEC4V6etoOtNjWiEdOpDD+qCRm/kplO7IsNgCHCN2j9rnwCtkfSeG/utIbGDDTBs8QxVcGEGRAtpwyflzW1AYshrq8nnC3ZX0TDh0lTx1CnVuAb+NS6ZGe1lQ9AMH02vSr7vISTLwXOpr8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFjUPgN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B40C4CEE7;
	Thu, 22 May 2025 02:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747879717;
	bh=0Z2z4PqyEobBMDt9wDNsWLnfV/jQuGPaXL4kbrETxzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFjUPgN76DrTFg8FQrlBXxDBwGefetGV3MEgVSLXca3VU/wlth2PXJdxETVoET34Y
	 Yjay1XRpM/hrAoXNJ0exu+U2tTo4qTs7Tc4U/N1+AVyRQgvuxmbOgBDddG/3ZTC0PI
	 3st3nXl3g8jKqjbB3u3Iv8+VtzuQTEbCVJN7frX+t/3izD7pazINtk92VFe3J2Lwtg
	 b/Dbx8HL/by/v/jqvdozV1NSvoXxQiSVFTLNmPBMRgyiustV9rzvnPAXVb9G6W7q4T
	 4w1C28ZgYk8IhYJ+wpDCxHXl19klzM0yISSrt48gxm/MTIVqaUfRs7zbiqVPrpqENm
	 etiFKMyzhUQmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.6 07/26] af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
Date: Wed, 21 May 2025 22:08:34 -0400
Message-Id: <20250521165942-ccdb54e84ad2a13d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250521144803.2050504-8-lee@kernel.org>
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

The upstream commit SHA1 provided is correct: 1fbfdfaa590248c1d86407f578e40e5c65136330

WARNING: Author mismatch between patch and upstream commit:
Backport author: Lee Jones<lee@kernel.org>
Commit author: Kuniyuki Iwashima<kuniyu@amazon.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  1fbfdfaa59024 ! 1:  2f7b5fceb11ea af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
    @@ Metadata
      ## Commit message ##
         af_unix: Allocate struct unix_vertex for each inflight AF_UNIX fd.
     
    +    [ Upstream commit 1fbfdfaa590248c1d86407f578e40e5c65136330 ]
    +
         We will replace the garbage collection algorithm for AF_UNIX, where
         we will consider each inflight AF_UNIX socket as a vertex and its file
         descriptor as an edge in a directed graph.
    @@ Commit message
         Acked-by: Paolo Abeni <pabeni@redhat.com>
         Link: https://lore.kernel.org/r/20240325202425.60930-2-kuniyu@amazon.com
         Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    +    (cherry picked from commit 1fbfdfaa590248c1d86407f578e40e5c65136330)
    +    Signed-off-by: Lee Jones <lee@kernel.org>
     
      ## include/net/af_unix.h ##
     @@ include/net/af_unix.h: extern unsigned int unix_tot_inflight;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

