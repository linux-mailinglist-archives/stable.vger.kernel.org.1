Return-Path: <stable+bounces-50650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C711906BB4
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE9F1F2207B
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794EB143871;
	Thu, 13 Jun 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sumcBu80"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C5C14389D;
	Thu, 13 Jun 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718278985; cv=none; b=uulhbcND9wPxOaGK3M/PSnB9V5/qXFxNZfqaB69dbhk/AXB6KUcT1nclp2YVPXtszzU/zakzIodw2Yl4WeLMJx1ZP05/BbF1ilYpzbMoZLvs9qhmbnoRm3q6wlq5xBDfe+yIzFVbQsLTgdbF3WqseEMSyFhrE8cPtYAvIhE5c/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718278985; c=relaxed/simple;
	bh=UPva8IuiQaJ/S+hLNYv0g8kLr1Zfibp3YbLT1du5BKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNXlhMzTx/iq6ihTu/sOILRX2S0iB4HqEWdBN6z2Z5qsQjOaM4/59s4nkzJFk2AoZ8fwcSQt8WNyJKBwpBevhx36ZknGJkJJSXxM3He1uh+GANyOIHReLyPrbUXgqzIN9NciZNtDmpO0G6U5emEub6Ui0cHeOg/7aEShuP+Jb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sumcBu80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE50C2BBFC;
	Thu, 13 Jun 2024 11:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718278985;
	bh=UPva8IuiQaJ/S+hLNYv0g8kLr1Zfibp3YbLT1du5BKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sumcBu80UcSBXBpVf1bn3Xv9ZT5/B1ud/1RcNS6zhH2vx9lKawlWM65FhQX7Kwa9v
	 KZ3ldhge4mGiEHlKiI5RhjddS5MyQQua91KH9HixfRUPpda0xZqhS9FqP81YoPwz8r
	 IPQaWIdevHE9CgOgsk0hQSKagzKi+025Xpg3khMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Roded Zats <rzats@paloaltonetworks.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 136/213] enic: Validate length of nl attributes in enic_set_vf_port
Date: Thu, 13 Jun 2024 13:33:04 +0200
Message-ID: <20240613113233.243793580@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Roded Zats <rzats@paloaltonetworks.com>

[ Upstream commit e8021b94b0412c37bcc79027c2e382086b6ce449 ]

enic_set_vf_port assumes that the nl attribute IFLA_PORT_PROFILE
is of length PORT_PROFILE_MAX and that the nl attributes
IFLA_PORT_INSTANCE_UUID, IFLA_PORT_HOST_UUID are of length PORT_UUID_MAX.
These attributes are validated (in the function do_setlink in rtnetlink.c)
using the nla_policy ifla_port_policy. The policy defines IFLA_PORT_PROFILE
as NLA_STRING, IFLA_PORT_INSTANCE_UUID as NLA_BINARY and
IFLA_PORT_HOST_UUID as NLA_STRING. That means that the length validation
using the policy is for the max size of the attributes and not on exact
size so the length of these attributes might be less than the sizes that
enic_set_vf_port expects. This might cause an out of bands
read access in the memcpys of the data of these
attributes in enic_set_vf_port.

Fixes: f8bd909183ac ("net: Add ndo_{set|get}_vf_port support for enic dynamic vnics")
Signed-off-by: Roded Zats <rzats@paloaltonetworks.com>
Link: https://lore.kernel.org/r/20240522073044.33519-1-rzats@paloaltonetworks.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cisco/enic/enic_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index bfe0e820956ca..6ad1734d96777 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1152,18 +1152,30 @@ static int enic_set_vf_port(struct net_device *netdev, int vf,
 	pp->request = nla_get_u8(port[IFLA_PORT_REQUEST]);
 
 	if (port[IFLA_PORT_PROFILE]) {
+		if (nla_len(port[IFLA_PORT_PROFILE]) != PORT_PROFILE_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_NAME;
 		memcpy(pp->name, nla_data(port[IFLA_PORT_PROFILE]),
 			PORT_PROFILE_MAX);
 	}
 
 	if (port[IFLA_PORT_INSTANCE_UUID]) {
+		if (nla_len(port[IFLA_PORT_INSTANCE_UUID]) != PORT_UUID_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_INSTANCE;
 		memcpy(pp->instance_uuid,
 			nla_data(port[IFLA_PORT_INSTANCE_UUID]), PORT_UUID_MAX);
 	}
 
 	if (port[IFLA_PORT_HOST_UUID]) {
+		if (nla_len(port[IFLA_PORT_HOST_UUID]) != PORT_UUID_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_HOST;
 		memcpy(pp->host_uuid,
 			nla_data(port[IFLA_PORT_HOST_UUID]), PORT_UUID_MAX);
-- 
2.43.0




