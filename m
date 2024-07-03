Return-Path: <stable+bounces-57558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA332925CFC
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756E11F20EC6
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74082176AB6;
	Wed,  3 Jul 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EkPfttqb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32144176AAF;
	Wed,  3 Jul 2024 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005248; cv=none; b=JRNtgYNPJ+nBlp9xEqOnRZDuYbItnARE1bkYGkA1HMiBhcdqJg9mq33NTBzl+SfdcHf9qRcp2rw82+Rm+UOnX82NZvoQdhUsGkpmoI23smS9wasq+P4vcD/fKBHYIjW9vUvHjoX+SRtst6zOSWoz9VACtOjzFjPeYMzVN2dU15U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005248; c=relaxed/simple;
	bh=S7Gm3OwtFgK9f8h3UgZ0vkis5D4P7mfs/IxjbE7SFcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iX5KBsoV5x3CFBC5IZgTpIWaHztQnwxFA/JzH1rSdiYKO8nu6Lrcub4KX9NRHeyjeQSucX6fZmcCUFfeCcZVvdmAeV428H6Q5ghd0nfAYUq5RdzgenfT8i0GrBpV9f1kPwNdo4KnermdRdkMNN6Oetj40vEefFbpwBRxfZgws2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EkPfttqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA881C32781;
	Wed,  3 Jul 2024 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005248;
	bh=S7Gm3OwtFgK9f8h3UgZ0vkis5D4P7mfs/IxjbE7SFcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkPfttqbyGI1KTpKEiBwc0pcgl4Zg8KwM8MghX+S1G8kTXFDHNhUvfCxPPL8StE/+
	 ICxYGmEFVyxA7M+/JSm5R3FirzDOVeJA58+Y5BHtXP7gD5qk76JfzG7LTMh+1ab00T
	 9tl6btyU/QJE2x8e40Dcete47G5qZHT6dk9ZK2qY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Noam Rathaus <noamr@ssd-disclosure.com>,
	Eric Dumazet <edumazet@google.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 018/356] net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP
Date: Wed,  3 Jul 2024 12:35:54 +0200
Message-ID: <20240703102913.789349453@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f921a58ae20852d188f70842431ce6519c4fdc36 ]

If one TCA_TAPRIO_ATTR_PRIOMAP attribute has been provided,
taprio_parse_mqprio_opt() must validate it, or userspace
can inject arbitrary data to the kernel, the second time
taprio_change() is called.

First call (with valid attributes) sets dev->num_tc
to a non zero value.

Second call (with arbitrary mqprio attributes)
returns early from taprio_parse_mqprio_opt()
and bad things can happen.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Reported-by: Noam Rathaus <noamr@ssd-disclosure.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://lore.kernel.org/r/20240604181511.769870-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_taprio.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index e40b4425eb6b5..4a0986843fb5d 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -947,16 +947,13 @@ static int taprio_parse_mqprio_opt(struct net_device *dev,
 {
 	int i, j;
 
-	if (!qopt && !dev->num_tc) {
-		NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
-		return -EINVAL;
-	}
-
-	/* If num_tc is already set, it means that the user already
-	 * configured the mqprio part
-	 */
-	if (dev->num_tc)
+	if (!qopt) {
+		if (!dev->num_tc) {
+			NL_SET_ERR_MSG(extack, "'mqprio' configuration is necessary");
+			return -EINVAL;
+		}
 		return 0;
+	}
 
 	/* Verify num_tc is not out of max range */
 	if (qopt->num_tc > TC_MAX_QUEUE) {
-- 
2.43.0




