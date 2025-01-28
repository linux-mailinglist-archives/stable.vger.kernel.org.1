Return-Path: <stable+bounces-110985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F899A20E51
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC0F3A1CF0
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759C61D89E3;
	Tue, 28 Jan 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXm6Kkup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D781917D9
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738081072; cv=none; b=n8EMsJw3qrBJGjYRK9B6idlgjlwfzsDnG4yRyl0N0UXmDwSvlX4cFJoxWHqJniFXtCAQw0VudthpRKhXn1JiFXLJITpEUTq01FcoNdHNKj+DUrc9tk55LrIyxFc34QsykuU4meHX8j/1cK2wvsTIp8/Zua26Rc/RT81cizfayTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738081072; c=relaxed/simple;
	bh=SCqoTzK0oZGVhhBCXdv/TDr8nzH7IL9ieJo379Ba7zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dOqR/GsWr3XnoL+VCc/bOCredNzIyTm/xYZQsyju80pIxXHR64fJsA2R8+0Tju/YcCdezuXPHY58V69neEJxtjwkEAgIWqaIOCJpGI4QKrfpgCXjVdZTLHyLjeP6/WFdks0KSZUsP6IqlujQVQIG0rDFSlqtupd2KurERu39Bjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXm6Kkup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1D2C4CED3;
	Tue, 28 Jan 2025 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738081072;
	bh=SCqoTzK0oZGVhhBCXdv/TDr8nzH7IL9ieJo379Ba7zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXm6KkupHXX8jdcd4aPKrEVC8/oqwFPizrGAPuAmqVaoRMsdA6HKT7WiePDa4i1s/
	 n5HqKfH+G8qezNKEnDzCUQWqQoYTrtXYap58j+6KkK/yY4W4OOTUQu1k9HLGucTxMb
	 OLn5QNq3+Y/URMTx8fqG84jbCt9IuG0w42f44qaH4og2go56AKMBnY3Pn/WSsauikW
	 NDpYdity+7ZNdxeRWg5Ms59smxGAYZfWDnU9JG6dg3dbRCJe4bufiecvI3HG2kVdet
	 xqyegH9xBEdjTaleVyJFbGUBN1gSQ3PtEsBwti68IbHc1yhObYcKwBwwMQZ8Po0K2E
	 WUZf9tdAFplpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
Date: Tue, 28 Jan 2025 11:17:50 -0500
Message-Id: <20250127160647-d7263fe855e166d8@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250127182955.67606-1-eahariha@linux.microsoft.com>
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

The upstream commit SHA1 provided is correct: d2138eab8cde61e0e6f62d0713e45202e8457d6d


Status in newer kernel trees:
6.13.y | Branch not found
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  d2138eab8cde6 ! 1:  6ee86d3429520 scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
    @@ Metadata
      ## Commit message ##
         scsi: storvsc: Ratelimit warning logs to prevent VM denial of service
     
    +    commit d2138eab8cde61e0e6f62d0713e45202e8457d6d upstream
    +
         If there's a persistent error in the hypervisor, the SCSI warning for
         failed I/O can flood the kernel log and max out CPU utilization,
         preventing troubleshooting from the VM side. Ratelimit the warning so
    @@ Commit message
         Link: https://lore.kernel.org/r/20250107-eahariha-ratelimit-storvsc-v1-1-7fc193d1f2b0@linux.microsoft.com
         Reviewed-by: Michael Kelley <mhklinux@outlook.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
     
      ## drivers/scsi/storvsc_drv.c ##
     @@ drivers/scsi/storvsc_drv.c: do {								\
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

