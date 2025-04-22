Return-Path: <stable+bounces-135185-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBEBA975D7
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 21:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDA73BBA1D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB26538382;
	Tue, 22 Apr 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZykRswCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82191219A91
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745351157; cv=none; b=cUG099pnViQkDF/cFdBql4kWan8CbVjGjnqfiUpnSOptVI4tC4Je4YY+uygYBx7+6xojBRXbPouONw2DehZs7sjiv9sbnHiMAhXCc6ftJ/eeDEzck0lIG5Z3GsPlhyK5W4IEV5JkYFJ8XGIvox8XD7PRJytl56TpIEh0BFuZ/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745351157; c=relaxed/simple;
	bh=w7GmPG7r/8MZl4slmEnrPFBidvz08xu1hK0ccNby1vg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rvz+/4fiWwCruYmipwcwZYSuco0IOdJAybAT0sg2Z+PpwxByeZNhFdQ6atoKXjdYYZ5VvM3gA8q9EKFAAD/7FUR5kPCeiVUg4ARpUwK1NsRVJN5vqsT9WS3i0Vz54+aHDrJm6O2aIkcgI+LdkJwUm6BO3Hb8cPWSLxdikygfCeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZykRswCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC31C4CEED;
	Tue, 22 Apr 2025 19:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745351157;
	bh=w7GmPG7r/8MZl4slmEnrPFBidvz08xu1hK0ccNby1vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZykRswCcu52B18P/dJOTeKKRq4xiplqwhBzm4eRE1KYQnzL/glXsZWdcSc+z2wmoV
	 9+LAwZiVplIME6QlVQ4xHObZ+dTVbTvzlW6S74L02L6eQcyL7gcWZ3PcOw013mUv/q
	 CrQpKzY+nYUharV09coKkNrrKf6oyCm2KsTHxsHuwxSklJ/SvTslcOp37bSKjiLvPz
	 mgR2jwgMjN4k6ytN67R06elRKyDHOZo/ikMIqpyaE/fsi3Tz2UnS+Zvcy3c9EO4ZN7
	 v6ah3dwjpya5WwuikqCWWpXi0WWrdFILG0G25wcyN2dNIyZytCdcpiJewV6o/mt2UY
	 EGKmQ8tpChubg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15/6.1/6.6] nvmet-fc: Remove unused functions
Date: Tue, 22 Apr 2025 15:45:54 -0400
Message-Id: <20250422114901-d91b46a9b40ebe2f@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <85E64841B89AA153+20250422084047.100708-1-wangyuli@uniontech.com>
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

The upstream commit SHA1 provided is correct: 1b304c006b0fb4f0517a8c4ba8c46e88f48a069c

Status in newer kernel trees:
6.14.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1b304c006b0fb ! 1:  b1866793ad4fe nvmet-fc: Remove unused functions
    @@ Metadata
      ## Commit message ##
         nvmet-fc: Remove unused functions
     
    +    [ Upstream commit 1b304c006b0fb4f0517a8c4ba8c46e88f48a069c ]
    +
         The functions nvmet_fc_iodnum() and nvmet_fc_fodnum() are currently
         unutilized.
     
    @@ Commit message
     
      ## drivers/nvme/target/fc.c ##
     @@ drivers/nvme/target/fc.c: struct nvmet_fc_tgt_assoc {
    - 	struct work_struct		del_work;
    + 	struct rcu_head			rcu;
      };
      
     -
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |
| stable/linux-6.1.y        |  Success    |  Success   |
| stable/linux-6.6.y        |  Success    |  Success   |

