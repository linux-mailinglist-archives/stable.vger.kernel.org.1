Return-Path: <stable+bounces-93938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB55B9D21A9
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 09:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D80B22B5D
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B31AE006;
	Tue, 19 Nov 2024 08:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4CMfl2H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287981885BF;
	Tue, 19 Nov 2024 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005363; cv=none; b=lEbI70P5s1Yd08o7iGiAB8soPR4Bya2uAktazvZnwgX/9CVSxSbfAYA0WYEy+jEJOeRdRPJ9pRO39x8QTXTVEYPq7uIvCy/A3vpj8q4KKN2/C4/8j6t2jBMr0ZeOrNCLkl9zQEHdy4NU0Rowj1ffHqeTXVJyNS41rD+ouxIROgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005363; c=relaxed/simple;
	bh=yoV13LCX/YLZSPLOTNaEryit6zsTgZsfdIqDfrKEfjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhDv4mD9+tv60pecri8Mtn1daa5qly9K/Eo85+u4aLEoz35+uRZ3XoVLFYS2Km/DlQAxY0LhCY4ZMlHf7bYJlCaE52NoOP3s2S/Oz7R9rdOCHvGEl2oSO4dWerXgtHYVcG8ji29qy+FdIcsOwNlY2nhqqbsjwv0U+N0+vvom81M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4CMfl2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C95C4CED2;
	Tue, 19 Nov 2024 08:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732005362;
	bh=yoV13LCX/YLZSPLOTNaEryit6zsTgZsfdIqDfrKEfjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f4CMfl2Ha36YJlE5I4VDRatzM2A+7azf2QasIKx+wEyZY8DWoTqoVL9dVg/a4USU+
	 z2WiHNCl/l26ZUfQOe+hh0X7hkFTYOgiD3hpi5QT8FLLMCG0DY1Cne+YQvAdb2BOxA
	 PBmxOQk+QYi3fxFf/rbUTDN37/EZZzZUk+esxYEu4VnTm+a8edUxoEE/qpNKp/SIX1
	 kW6caioh6Mj0BJTp2OzEwJUO0GglHONrkWMMAb6r6Bzag2DRKpt/EPaEcOYTJ7kt+d
	 9mdiG/nkCUX0Qx0qHHeVLdDd1AKlJGEu0qxG14g40WsulnT/vAb6W6brk9RKCtF1Ub
	 Bsvw0Kbzlvi7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	sashal@kernel.org,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.1.y 3/7] mptcp: add userspace_pm_lookup_addr_by_id helper
Date: Tue, 19 Nov 2024 09:35:51 +0100
Message-ID: <20241119083547.3234013-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119083547.3234013-9-matttbe@kernel.org>
References: <20241119083547.3234013-9-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868; i=matttbe@kernel.org; h=from:subject; bh=RD/camdCYp9STQGdE0voBHs/a0Sj2Bm+bXEiUo1pazg=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnPE3kgzWvrJRWiysXbFfRPEsN2WnsSNkLcyrDL SdcdtGWpKOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZzxN5AAKCRD2t4JPQmmg c+M/D/9Xg09wJVKBNo7OoGdB27tNnXb/wFW1BcSLFE1btHIBjUwjPpwMIkyhLIIWF9UmfTQF41i QgomwDea2ZTH6oem57i2WPLPoSuT4aFdjwSaFH9IHdZb2piOtoVH8DBM8Gi6tAywvoitb5s6em7 O7WiQAnjmDr/b8bus4UJSFTwY/D51Z27zlJjClPhSIqYdpKjCNjuCPQ+wrtwd25AT19ODfrAgTK 4PQqrjBZo/HE3bBODBYsACyCkrykOQau9EPZ/vZrmhCfIDcTtLmoSrXS3dmMIu4p05UctWWrRUX DctxsEnuFI+XgTnPSTrcAlm1dJPzaJKyqJ/ShPQmLbRXvLsig8vUlz+NU0LUmkW9/B1T53Kg98X +i9U0fNE//t0NvymjwIIY2DousrsaLM8AdGZDuj0UksR7eEpt3vFRpHeojusWY8ZqHSSEhrEUZ3 CV+N2VmLZ8l84/avFcf1AKbLtBbRHRtg+VVcLm2vOjZgsv7HoYRd383zLFbyfabN41yT4+Hvhxy BahPBiK2eu2uX2dnAIMKKaU46WdC5tzlyF12t1db0cYC7Q/EmJVcdOYAJHo0x3S0qzkoG0aEnd/ CoeBTqhiYEKiJ8N7x+1OI2os4PpP471sJWTOKbSBG7NDqLcUxyTum/CR43dB9F4An9cAjmwe8ay RXgtmXEb8wF6Vrw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 06afe09091ee69dc7ab058b4be9917ae59cc81e5 upstream.

Corresponding __lookup_addr_by_id() helper in the in-kernel netlink PM,
this patch adds a new helper mptcp_userspace_pm_lookup_addr_by_id() to
lookup the address entry with the given id on the userspace pm local
address list.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: f642c5c4d528 ("mptcp: hold pm lock when deleting entry")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 530f414e57d6..ca3e452d4edb 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -106,22 +106,29 @@ static int mptcp_userspace_pm_delete_local_addr(struct mptcp_sock *msk,
 	return -EINVAL;
 }
 
+static struct mptcp_pm_addr_entry *
+mptcp_userspace_pm_lookup_addr_by_id(struct mptcp_sock *msk, unsigned int id)
+{
+	struct mptcp_pm_addr_entry *entry;
+
+	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
+		if (entry->addr.id == id)
+			return entry;
+	}
+	return NULL;
+}
+
 int mptcp_userspace_pm_get_flags_and_ifindex_by_id(struct mptcp_sock *msk,
 						   unsigned int id,
 						   u8 *flags, int *ifindex)
 {
-	struct mptcp_pm_addr_entry *entry, *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 
 	*flags = 0;
 	*ifindex = 0;
 
 	spin_lock_bh(&msk->pm.lock);
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (id == entry->addr.id) {
-			match = entry;
-			break;
-		}
-	}
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id);
 	spin_unlock_bh(&msk->pm.lock);
 	if (match) {
 		*flags = match->flags;
@@ -282,7 +289,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *id = info->attrs[MPTCP_PM_ATTR_LOC_ID];
-	struct mptcp_pm_addr_entry *match = NULL;
+	struct mptcp_pm_addr_entry *match;
 	struct mptcp_pm_addr_entry *entry;
 	struct mptcp_sock *msk;
 	LIST_HEAD(free_list);
@@ -319,13 +326,7 @@ int mptcp_nl_cmd_remove(struct sk_buff *skb, struct genl_info *info)
 
 	lock_sock(sk);
 
-	list_for_each_entry(entry, &msk->pm.userspace_pm_local_addr_list, list) {
-		if (entry->addr.id == id_val) {
-			match = entry;
-			break;
-		}
-	}
-
+	match = mptcp_userspace_pm_lookup_addr_by_id(msk, id_val);
 	if (!match) {
 		GENL_SET_ERR_MSG(info, "address with specified id not found");
 		release_sock(sk);
-- 
2.45.2


