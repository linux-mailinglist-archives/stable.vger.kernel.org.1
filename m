Return-Path: <stable+bounces-93980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC49D25EA
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC2A282D56
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160881C3314;
	Tue, 19 Nov 2024 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIw8gw3f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD211C2DB4
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732019486; cv=none; b=Z78MicWL+9O25soZq8/45Ggz43ztOI0+YeHHH5Rv857tq8WMJTzbVaneDVkYm8Gi3EuITNHflnlavCQUgRnggDEMDsNCqcBP+JFAHINLbRk9BlPHJF/WQhqmxHLBzkgX0ubOp7yEXFhkqwhqfu8qA0LlfDxszoYB1CMUxKOhON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732019486; c=relaxed/simple;
	bh=rViKhp1XRpg3KuHPjJOgiIJOpCg0O3CeGFBL+rDBqxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMiYVrX+YJBkNMcBplmU0aeX1m9IihGIxWkUAuhhnsjzUlh21k+oqOqbVAv+Or83KH0+bUDgUvjH7ukYqByqC6Tru13yls5j56IsPwTvVDTnrJ7UgFFRjxx+ArMXDgIV66Pz2oPAiJlzhkvCvQUBKZi5hni2JDuNPQLwQ2rP5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIw8gw3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F59C4CECF;
	Tue, 19 Nov 2024 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732019486;
	bh=rViKhp1XRpg3KuHPjJOgiIJOpCg0O3CeGFBL+rDBqxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EIw8gw3fmhnlNqKBjSNMQWNfolrTHBrBlHBmih+pPSjIv0pcDuKAe1eNsT4b9v2Io
	 HepRI2Um36R0jUA6OPa1NtdvNrNepAIFvfOz2pkRAuvPAPZ3DEHuhd824fwItPU8jw
	 h2P7Q0wQtRVqSRC9Ys/Xf3gbZOT61YQnyaW526iSuNilL0/vSGpjPe1TVwdtRdFEkP
	 FqrdUjxeNXPnxTw/ldyN+kc0FBQ5thqa00Tsu+bZU4bmUyBkwNFEvyB+exqApTh7W8
	 aIzUC9dlZvepSfvOWNON6XDt9mNIfKF7bwks5qH8maA442NfBV9x8T0557m9UURMkX
	 ynhJwZD00uCPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 2/2] nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies
Date: Tue, 19 Nov 2024 07:31:25 -0500
Message-ID: <20241119020537.3050784-3-xiangyu.chen@eng.windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119020537.3050784-3-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: 7a87441c9651ba37842f4809224aca13a554a26f

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Commit author: Eric Dumazet <edumazet@google.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (exact SHA1)                        |
| 6.6.y           |  Present (different SHA1: 0f1061332030)      |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 01:54:59.787740708 -0500
+++ /tmp/tmp.ibDHk7fa1x	2024-11-19 01:54:59.783429415 -0500
@@ -1,3 +1,5 @@
+[ Upstream commit 7a87441c9651ba37842f4809224aca13a554a26f ]
+
 syzbot reported unsafe calls to copy_from_sockptr() [1]
 
 Use copy_safe_from_sockptr() instead.
@@ -42,12 +44,14 @@
 Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 Link: https://lore.kernel.org/r/20240408082845.3957374-4-edumazet@google.com
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Signed-off-by: Sasha Levin <sashal@kernel.org>
+Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
 ---
  net/nfc/llcp_sock.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)
 
 diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
-index 819157bbb5a2c..d5344563e525c 100644
+index 645677f84dba..cd0fd26196b8 100644
 --- a/net/nfc/llcp_sock.c
 +++ b/net/nfc/llcp_sock.c
 @@ -252,10 +252,10 @@ static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
@@ -78,3 +82,6 @@
  
  		if (opt > LLCP_MAX_MIUX) {
  			err = -EINVAL;
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

