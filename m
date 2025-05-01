Return-Path: <stable+bounces-139377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74993AA638C
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 21:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFCC9C3597
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA629224AE8;
	Thu,  1 May 2025 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SF7MU2DQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B066215191
	for <stable@vger.kernel.org>; Thu,  1 May 2025 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126633; cv=none; b=JpyxagBmpVfc5FzOudhu9UlfTVpOcBaFPXla1Jv0Q9LylVQ4m5Z03qHPPROyyCvPXLHhXexmYr9gh03mHCR/s/xxBTBmP6yKJDKz6v2dhfCyHO64tIZIXdF/1NotgxrRJu/frG4eHWCguIE5HRpfdy4T3xA7V12wtxqNUugGvzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126633; c=relaxed/simple;
	bh=3MLD2v71SMYzIgDYrduwJm3d2VNJMeVn0kq00mBaLQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmYxLLGUjtfEMpQdWuaVA1jYTn4ZPP2jWn7fWSXFrsqQR3Vvq1mdXEbv0FXesMZmshmQ1XzmldEfi961zC5f5XeCisOAQEaeYJ9EPYwDmCRPsIW/lkkbQ+IUaZOT4kNAxDp4HrKN7LJ549NG9BuLPm/1JlMtY5b5iLexpDwFivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SF7MU2DQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BADC4CEE3;
	Thu,  1 May 2025 19:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746126633;
	bh=3MLD2v71SMYzIgDYrduwJm3d2VNJMeVn0kq00mBaLQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SF7MU2DQGFmRBE4cd38ShjtZYlGdP9vKjvzUeP/3SzfahzaudWeYlA2PVO1kvvNNC
	 mHyX0mQOmIdo7+lDxO7cPBChMZr76bHy/+jeWHatujJBRFUAjJWOfK6a703EuWmaDi
	 +eNuThcotpwG6JSCIPQyCZcJfkaF9H2yUKPwrW7bfATN8UzpPk6RVw0yAyahIPYPPx
	 iIMLgoAM/czrLPS8PBi1uWAztBxC0Ei1ArkW3he78EU1GIp5eH+nCth6EogO6fKwC5
	 hp1muhldVexwLQolbNOeY35kUnM26lo8agE+8h5m7uL2zfjVPXt/adTd9b7iXjAcQ0
	 dOHHb6uCr+07w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH stable 6.6 10/10] selftests/bpf: extend changes_pkt_data with cases w/o subprograms
Date: Thu,  1 May 2025 15:10:28 -0400
Message-Id: <20250501092116-7d1349d31b9ff3dc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430081955.49927-11-shung-hsi.yu@suse.com>
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

The upstream commit SHA1 provided is correct: 04789af756a4a43e72986185f66f148e65b32fed

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shung-Hsi Yu<shung-hsi.yu@suse.com>
Commit author: Eduard Zingerman<eddyz87@gmail.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 473c5347355f)

Note: The patch differs from the upstream commit:
---
1:  04789af756a4a ! 1:  dd1d64fbef827 selftests/bpf: extend changes_pkt_data with cases w/o subprograms
    @@ Metadata
      ## Commit message ##
         selftests/bpf: extend changes_pkt_data with cases w/o subprograms
     
    +    commit 04789af756a4a43e72986185f66f148e65b32fed upstream.
    +
         Extend changes_pkt_data tests with test cases freplacing the main
         program that does not have subprograms. Try four combinations when
         both main program and replacement do and do not change packet data.
    @@ Commit message
         Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
         Link: https://lore.kernel.org/r/20241212070711.427443-2-eddyz87@gmail.com
         Signed-off-by: Alexei Starovoitov <ast@kernel.org>
    +    Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
     
      ## tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c ##
     @@ tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c: static void print_verifier_log(const char *log)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

