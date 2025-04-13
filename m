Return-Path: <stable+bounces-132348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992EFA872AC
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757733B75D1
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68921D7E37;
	Sun, 13 Apr 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEcVyPmV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874EC14A0A8
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562817; cv=none; b=f8Comy/5P2cSoIvgVANjJZPSLK/bHgIk8m+DknXFG+eh5Y5NXpIISTDb7XQWfwLRC2nK2I4ZpES8yTd3EVsfMi0qvJ46xiz8t+FRamq+bIF69KDYonhJcBvfVgWHIA1Rk8Y7/KBhlINjnzUC3mY+wMgNrfDDGCSqkemzMZ+/rdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562817; c=relaxed/simple;
	bh=CgrwdR0deT6E9LV5ckDKSRnLOx0o5X4LfAOhLB0eQo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsfAk8kEgHmW0A3q9ku1V/pCJDtKhT88WyvNzqg6/+blxBDLY+aaUSZb4z2eW3ddaCraXieFKgQI+udCXU8PpMSFQTmFyaCrkY1kS0TQWQlcImG34zoG1kHpNaGzj9ae0O9dw8yDgLhJ1JryilktEcD+vpQL7hvBsmwVSuJHZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEcVyPmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0E3C4CEDD;
	Sun, 13 Apr 2025 16:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562817;
	bh=CgrwdR0deT6E9LV5ckDKSRnLOx0o5X4LfAOhLB0eQo4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEcVyPmVSQKc0Zvqb66x9viwJecQUokrGe//X3VRMWwgEdUrYDueBVJ7JPkJURIXe
	 50PMinDCuLq200PkhDDek+3k2qc3KRcDOrrIsaVUOH1++xBvrb62m4IOJpQbXXZ+6P
	 R212wt81vbQD7Pt6xRcfM1jdLITYDtrHeWk3YV+y5Eeew7VOZbB6fzwW62jdbpbXlw
	 pwt4NE6T2InqaG9DqoLq07ZX4Yo7m0q6HeERmsrzgQr/BnasGjMY+rNNwNhiwNvVap
	 hpi1YBO6FmJoTEaJ90MQmmWzoY/rQtXHMJK2I84uo9U6d8NEAmD28QV+Kcr4gfNXgg
	 dI0g+eCfq/jKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: cel@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.13] nfsd: don't ignore the return code of svc_proc_register()
Date: Sun, 13 Apr 2025 12:46:55 -0400
Message-Id: <20250412101937-75abba5459cc3892@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411141412.27052-1-cel@kernel.org>
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

The upstream commit SHA1 provided is correct: 930b64ca0c511521f0abdd1d57ce52b2a6e3476b

WARNING: Author mismatch between patch and upstream commit:
Backport author: cel@kernel.org
Commit author: Jeff Layton<jlayton@kernel.org>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 9d9456185fd5)

Note: The patch differs from the upstream commit:
---
1:  930b64ca0c511 ! 1:  23c220e9285a7 nfsd: don't ignore the return code of svc_proc_register()
    @@ Metadata
      ## Commit message ##
         nfsd: don't ignore the return code of svc_proc_register()
     
    +    [ Upstream commit 930b64ca0c511521f0abdd1d57ce52b2a6e3476b ]
    +
         Currently, nfsd_proc_stat_init() ignores the return value of
         svc_proc_register(). If the procfile creation fails, then the kernel
         will WARN when it tries to remove the entry later.
    @@ fs/nfsd/nfsctl.c: static __net_init int nfsd_net_init(struct net *net)
      	seqlock_init(&nn->writeverf_lock);
     -	nfsd_proc_stat_init(net);
      #if IS_ENABLED(CONFIG_NFS_LOCALIO)
    - 	spin_lock_init(&nn->local_clients_lock);
      	INIT_LIST_HEAD(&nn->local_clients);
      #endif
      	return 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.13.y       |  Success    |  Success   |

