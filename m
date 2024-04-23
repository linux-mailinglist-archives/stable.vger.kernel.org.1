Return-Path: <stable+bounces-40816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72468AF92E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B3C1F22BA2
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9637B1448D4;
	Tue, 23 Apr 2024 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LLYJnbxJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F720B3E;
	Tue, 23 Apr 2024 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908482; cv=none; b=LYR6k9xvyvirJLXAkXcle16SdcZ864vNR3our/0BUWNMP3XFw03lqhsmZX9JXRSFV9r7pl1z5nF6uYX87Cbhps32MPcIWFsBIeQzbOlmtGeRRr785Mg9AqDIyrqAUApxLBq3s1AhzdrngI1Tk+DYyMmT/1VzkOjZe6VuQnvmT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908482; c=relaxed/simple;
	bh=z5CwRZU23E3V5UhGjAuNJrMffkE1T7f8c5CQuI49/TI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hncjap9NM/r6YfL8gnhjlYj4OUZJ1LLmO7dR9vVeZ5VvFLSdKEcn2tc1azoAQ6ayqcDtsV0iYV3PwJHsxBDdXTbjme9H+s9M+4KfXmXRFFGbrN8n2QB6/3uLbsppXbSwAiJecuJu5bJPJZOMOQTSJwmYrgg/mDm5JIpxXhKALXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LLYJnbxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28142C116B1;
	Tue, 23 Apr 2024 21:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908482;
	bh=z5CwRZU23E3V5UhGjAuNJrMffkE1T7f8c5CQuI49/TI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LLYJnbxJbiFmDHf2efClvIvmLuUKDdJO6YZ8DmeMlE7FRWZG+KmTrQ4Onlctm6iXq
	 Qu8pKonkfRUZAARJRFoq0QIZNb8KwrrEWaS0YVahSEhtV/aOjb6lf+5ZGkTaq0eCvu
	 RyFwqnnAsxoycnyU/l/DemEdUo+sjNXGa3Tlgf1I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 029/158] octeontx2-pf: fix FLOW_DIS_IS_FRAGMENT implementation
Date: Tue, 23 Apr 2024 14:37:31 -0700
Message-ID: <20240423213856.818713473@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.824778126@linuxfoundation.org>
References: <20240423213855.824778126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Asbjørn Sloth Tønnesen <ast@fiberby.net>

[ Upstream commit 75ce9506ee3dc66648a7d74ab3b0acfa364d6d43 ]

Upon reviewing the flower control flags handling in
this driver, I notice that the key wasn't being used,
only the mask.

Ie. `tc flower ... ip_flags nofrag` was hardware
offloaded as `... ip_flags frag`.

Only compile tested, no access to HW.

Fixes: c672e3727989 ("octeontx2-pf: Add support to filter packet based on IP fragment")
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 4fd44b6eecea6..60ee7ae2c4097 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -688,6 +688,7 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 
 	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_CONTROL)) {
 		struct flow_match_control match;
+		u32 val;
 
 		flow_rule_match_control(rule, &match);
 		if (match.mask->flags & FLOW_DIS_FIRST_FRAG) {
@@ -696,12 +697,14 @@ static int otx2_tc_prepare_flow(struct otx2_nic *nic, struct otx2_tc_flow *node,
 		}
 
 		if (match.mask->flags & FLOW_DIS_IS_FRAGMENT) {
+			val = match.key->flags & FLOW_DIS_IS_FRAGMENT;
 			if (ntohs(flow_spec->etype) == ETH_P_IP) {
-				flow_spec->ip_flag = IPV4_FLAG_MORE;
+				flow_spec->ip_flag = val ? IPV4_FLAG_MORE : 0;
 				flow_mask->ip_flag = IPV4_FLAG_MORE;
 				req->features |= BIT_ULL(NPC_IPFRAG_IPV4);
 			} else if (ntohs(flow_spec->etype) == ETH_P_IPV6) {
-				flow_spec->next_header = IPPROTO_FRAGMENT;
+				flow_spec->next_header = val ?
+							 IPPROTO_FRAGMENT : 0;
 				flow_mask->next_header = 0xff;
 				req->features |= BIT_ULL(NPC_IPFRAG_IPV6);
 			} else {
-- 
2.43.0




