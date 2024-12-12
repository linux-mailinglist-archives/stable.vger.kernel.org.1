Return-Path: <stable+bounces-102747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A129EF452
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B3B17A50C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDF8221DAA;
	Thu, 12 Dec 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P3ePuFAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1232139C9;
	Thu, 12 Dec 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022345; cv=none; b=VWuSNj1azSKCNiNxzAuG9RI2JRba482RZ0c/1pMCBksmZNz7OU0oxEKT+aPj+aSKD1UmpkNuIo6ZeCOp5BeRwWleSRdN2r38Y8bXeVMzk+th7JOYRKkFqf7q8JuPUWbD/ZbaMAVINszZ7eWVyGGShO8Ht7+UTC8HrX/G9iF+3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022345; c=relaxed/simple;
	bh=ANXhlodgivr95GieiGdRLArMtuLcZhCEQ6CSKZDO+Uw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klltXx9/AA/8ZBCTXgP39eDx/l/cCNdd3FtIbA5P7VBeYqie+sDTIQKXeG78lJ9UbjWdh6afmNZGGmIgn4lRv4lKu9AgPqHruzzp5EVZAqWPHZ3SDgDyiywOKgY7HPwAKmNF30oPGDLdlx0BXBbSUB/iR/PrKF1phn4LblqJqAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P3ePuFAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EFDC4CECE;
	Thu, 12 Dec 2024 16:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022345;
	bh=ANXhlodgivr95GieiGdRLArMtuLcZhCEQ6CSKZDO+Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P3ePuFAaT6kIgm+1rfc9g9xnhAPHpQtiPdcgu2r1JLHJQmMfnQ8jIJDfoN3UkDIY3
	 jF5dM7qaEg413hFE6OdBTewTZsZUKwqeRBrMHkHNYFNH6qUxIFOeS9uEZ/vBuAmYLu
	 Yn7YFzMxOL3neCIhXx9y/nhYET4HMnrRH6UKUO2E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maurice Lambert <mauricelambert434@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 188/565] netlink: typographical error in nlmsg_type constants definition
Date: Thu, 12 Dec 2024 15:56:23 +0100
Message-ID: <20241212144318.911846784@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maurice Lambert <mauricelambert434@gmail.com>

[ Upstream commit 84bfbfbbd32aee136afea4b6bf82581dce79c305 ]

This commit fix a typographical error in netlink nlmsg_type constants definition in the include/uapi/linux/rtnetlink.h at line 177. The definition is RTM_NEWNVLAN RTM_NEWVLAN instead of RTM_NEWVLAN RTM_NEWVLAN.

Signed-off-by: Maurice Lambert <mauricelambert434@gmail.com>
Fixes: 8dcea187088b ("net: bridge: vlan: add rtm definitions and dump support")
Link: https://patch.msgid.link/20241103223950.230300-1-mauricelambert434@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/rtnetlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 5888492a5257b..e5c15614e81da 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -172,7 +172,7 @@ enum {
 #define RTM_GETLINKPROP	RTM_GETLINKPROP
 
 	RTM_NEWVLAN = 112,
-#define RTM_NEWNVLAN	RTM_NEWVLAN
+#define RTM_NEWVLAN	RTM_NEWVLAN
 	RTM_DELVLAN,
 #define RTM_DELVLAN	RTM_DELVLAN
 	RTM_GETVLAN,
-- 
2.43.0




