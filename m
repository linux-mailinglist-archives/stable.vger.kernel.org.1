Return-Path: <stable+bounces-239612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO4yHUVm5mlmvwEAu9opvQ
	(envelope-from <stable+bounces-239612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:45:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBCE432080
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B622A35F2BD0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752F633C192;
	Mon, 20 Apr 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lq+VNH6U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36ABF3321AA;
	Mon, 20 Apr 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700703; cv=none; b=uFUYZFcLhM8eEHjczX0ZqEIq3XOhNSzrpoiJ65M/wQETea3KHlRo5cpEm4tsp2BIvLkrVV6RWBlbFmHTI39HImrTsV0tYJtG8VBtyDxm3qEKlARflDQ8mAQ0Aopvz6boJJZKLnkzE5N+estGmNgnBh4QMOOTugDB0+8L+HLdD20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700703; c=relaxed/simple;
	bh=j8rVcvnRCvOlfSqs8eo6JIIkKrnwJCNQK/lNj6gQye0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oaNOV1D3tWKhvayQCO2ie/1fkcWdKwdvi650p8uo7ZyTl2BhPIPC49GRj9b1HfXNhD2wsqqcN0c1+Y8KvXYFl+qANqsDiQF3MkGoZJx6pLYGv6Z5+SsqTCqd4ujGHs/1BfAaFGyi4sZCm06O5W0CP46XiT5p+S6C3hrhzZsAXsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lq+VNH6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D8EC19425;
	Mon, 20 Apr 2026 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700703;
	bh=j8rVcvnRCvOlfSqs8eo6JIIkKrnwJCNQK/lNj6gQye0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lq+VNH6UV8iEpmZGcbHrPNtjxPUCrTiyudY767HukI6PoXjDhKPgXKVGj20CAEExA
	 fPL6K+BA8rKwfjZqgv9OIW0U9h0z0r5wdj2kq6uTqVEV3EMFa36OlyLejTGQ4DYu2t
	 qixLUgyiDsU7HqoQ5pQxlEAWD6tvqBIOpLP2J8Ik=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Nikita Travkin <nikita@trvn.ru>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 054/198] soc: qcom: pd-mapper: Fix element length in servreg_loc_pfr_req_ei
Date: Mon, 20 Apr 2026 17:40:33 +0200
Message-ID: <20260420153937.561025506@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239612-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,trvn.ru:email]
X-Rspamd-Queue-Id: BCBCE432080
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

[ Upstream commit 641f6fda143b879da1515f821ee475073678cf2a ]

It looks element length declared in servreg_loc_pfr_req_ei for reason
not matching servreg_loc_pfr_req's reason field due which we could
observe decoding error on PD crash.

  qmi_decode_string_elem: String len 81 >= Max Len 65

Fix this by matching with servreg_loc_pfr_req's reason field.

Fixes: 1ebcde047c54 ("soc: qcom: add pd-mapper implementation")
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Tested-by: Nikita Travkin <nikita@trvn.ru>
Link: https://lore.kernel.org/r/20260129152320.3658053-2-mukesh.ojha@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/pdr_internal.h | 2 +-
 drivers/soc/qcom/qcom_pdr_msg.c | 2 +-
 include/linux/soc/qcom/pdr.h    | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/pdr_internal.h b/drivers/soc/qcom/pdr_internal.h
index 039508c1bbf7d..047c0160b6178 100644
--- a/drivers/soc/qcom/pdr_internal.h
+++ b/drivers/soc/qcom/pdr_internal.h
@@ -84,7 +84,7 @@ struct servreg_set_ack_resp {
 
 struct servreg_loc_pfr_req {
 	char service[SERVREG_NAME_LENGTH + 1];
-	char reason[257];
+	char reason[SERVREG_PFR_LENGTH + 1];
 };
 
 struct servreg_loc_pfr_resp {
diff --git a/drivers/soc/qcom/qcom_pdr_msg.c b/drivers/soc/qcom/qcom_pdr_msg.c
index ca98932140d87..02022b11ecf05 100644
--- a/drivers/soc/qcom/qcom_pdr_msg.c
+++ b/drivers/soc/qcom/qcom_pdr_msg.c
@@ -325,7 +325,7 @@ const struct qmi_elem_info servreg_loc_pfr_req_ei[] = {
 	},
 	{
 		.data_type = QMI_STRING,
-		.elem_len = SERVREG_NAME_LENGTH + 1,
+		.elem_len = SERVREG_PFR_LENGTH + 1,
 		.elem_size = sizeof(char),
 		.array_type = VAR_LEN_ARRAY,
 		.tlv_type = 0x02,
diff --git a/include/linux/soc/qcom/pdr.h b/include/linux/soc/qcom/pdr.h
index 83a8ea612e69a..2b7691e47c2a9 100644
--- a/include/linux/soc/qcom/pdr.h
+++ b/include/linux/soc/qcom/pdr.h
@@ -5,6 +5,7 @@
 #include <linux/soc/qcom/qmi.h>
 
 #define SERVREG_NAME_LENGTH	64
+#define SERVREG_PFR_LENGTH	256
 
 struct pdr_service;
 struct pdr_handle;
-- 
2.53.0




