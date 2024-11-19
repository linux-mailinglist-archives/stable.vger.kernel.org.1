Return-Path: <stable+bounces-94030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0019D2887
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 15:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0801F23103
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92AA1CF7A0;
	Tue, 19 Nov 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma6C99Bb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EAC1CF5FF
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 14:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732027625; cv=none; b=I2Dn9zFu2mZsnVSKLheSoviFR+0qkoQi12PxjaUD431pCUXujSjMtpJJiPebsCAQZqL0f9846YIKA2cm9w2m+RmhosCcjwY7vub1FgPV1l1uWW6MQthK7WuTZDBxHpKHsOw3tV+BHn0rR6fNL8d3ahBHeZe4PsmUWH0lLklxAbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732027625; c=relaxed/simple;
	bh=k0d7OwFyHYf/1hgIIgBpUiuM3jjraXEQXZ9zzklPrsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfO1tCM0kISWV8XtlSEtKNsWeunQ77TyvDy/4SHSTblN/fbckqMUP7e2H5ea1BPZwCy/qfngsc7cXghkt47ZPzsnzwZnCney07gJScQMvdbikd1ST5mPtMWInRQaGrcKdvVdo9qtYjWqMfEyPkvMQvutJ/lnWeNI65AI2Mn2N1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma6C99Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847BCC4CECF;
	Tue, 19 Nov 2024 14:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732027625;
	bh=k0d7OwFyHYf/1hgIIgBpUiuM3jjraXEQXZ9zzklPrsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ma6C99BbL0gPnouz6EpSCHptc5SbwHYLaDFohKwyXzAe/nofouRPyvkmSRco/5WMs
	 TC2CM26r2H0LKJnSlHGXQiOHGbapQ2ZmciwuF+/BJvL8jNYj0493xVjM/KiQ+MawEO
	 5Qyads5QPRhRDqvxAXYsa4WJOcBih/tQOWV4MPgbJxhthu4A4v5V4JofbS2SejmkOu
	 LheMamvf9NYETgD/C92Po68BXy+uWSWtVrgUv7o4c66y+XHITudJzGYaI8UuP+WX97
	 U2lHBeKPKOH/j6lDlYkrwqsTK+AgBpo6N4rdZA28lDzt3Nx6BT6elkO7GK+oay9bDf
	 JdeSGoWgs//hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y 7/7] mptcp: pm: use _rcu variant under rcu_read_lock
Date: Tue, 19 Nov 2024 09:47:03 -0500
Message-ID: <20241119083547.3234013-16-matttbe@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241119083547.3234013-16-matttbe@kernel.org>
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

The upstream commit SHA1 provided is correct: db3eab8110bc0520416101b6a5b52f44a43fb4cf

WARNING: Author mismatch between patch and upstream commit:
Backport author: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Commit author: Matthieu Baerts (NGI0) <matttbe@kernel.org>


Status in newer kernel trees:
6.11.y | Present (different SHA1: b5e96b7d3dea)
6.6.y | Not found
6.1.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-19 09:33:43.354973891 -0500
+++ /tmp/tmp.FmHZdHILuA	2024-11-19 09:33:43.351973441 -0500
@@ -15,15 +15,16 @@
 Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 Link: https://patch.msgid.link/20241112-net-mptcp-misc-6-12-pm-v1-3-b835580cefa8@kernel.org
 Signed-off-by: Jakub Kicinski <kuba@kernel.org>
+Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
 ---
  net/mptcp/pm_netlink.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)
 
 diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
-index db586a5b3866f..45a2b5f05d38b 100644
+index 9b65d9360976..3fd7de56a30f 100644
 --- a/net/mptcp/pm_netlink.c
 +++ b/net/mptcp/pm_netlink.c
-@@ -524,7 +524,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
+@@ -529,7 +529,8 @@ __lookup_addr(struct pm_nl_pernet *pernet, const struct mptcp_addr_info *info)
  {
  	struct mptcp_pm_addr_entry *entry;
  
@@ -33,3 +34,6 @@
  		if (mptcp_addresses_equal(&entry->addr, info, entry->addr.port))
  			return entry;
  	}
+-- 
+2.45.2
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

