Return-Path: <stable+bounces-218179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGOVCCVRnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4041C18EEC0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4296A3051A85
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABCE251793;
	Wed, 25 Feb 2026 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RU6gdTWy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7DF21D596;
	Wed, 25 Feb 2026 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982965; cv=none; b=J9/xBtUNq3bKGEUpdueoQqFYnzZpi1hGeeyYi5OKdbKGnTeD6c9CJj6b0yQoFSQeEb8RdHGmrNYPv429Ax3CkwjJ7yb2vY6cojm3CxvVLsCniUlcyc/4vBsK0I05dKZQ4qjFQhtumSk4ZwV7k4uB98bhCwMw5APNruhJrIcmMbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982965; c=relaxed/simple;
	bh=WSbXUZv4n0WU+5slDiR1aps6G8S47g2J6DJMj/reuNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3LgwlPWmdhbVyZPIPK05jhX1w4TCWK0PF4IpBiFChD4JTyGjx27h4vo5GkP6rjdFNvw9qB0hYSy91IXyYUVTHghUSb1FGfBNEwyh5iJ0F4c/CnstvvISxNUtZggDDhT8+B6C3JdvteaOWnCJvte1UinYxxrzYCkeRl6Rd8tNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RU6gdTWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3FAC116D0;
	Wed, 25 Feb 2026 01:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982965;
	bh=WSbXUZv4n0WU+5slDiR1aps6G8S47g2J6DJMj/reuNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RU6gdTWyGtUzOO/J/uuirAiY9ky+5vhvMgHxFYG0wOAO14gsVH1MmUAaYXLVT83wS
	 7RFhSMvAdsyw/jnPGqmEBa3tFyZRgMNBYTIaFN4gc2dCtte6RO3h6f7DRiQyqrXlyR
	 KJM3dn8H4PzjhcZayacVZ0q39YkI5DfxXwbeAhaI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 141/781] soc: qcom: smem: handle ENOMEM error during probe
Date: Tue, 24 Feb 2026 17:14:10 -0800
Message-ID: <20260225012403.126598835@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218179-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4041C18EEC0
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

[ Upstream commit 0fe01a7955f4fef97e7cc6d14bfc5931c660402b ]

Fail the driver probe if the region can't be mapped

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Fixes: 20bb6c9de1b7 ("soc: qcom: smem: map only partitions used by local HOST")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20251209074610.3751781-1-jorge.ramirez@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/smem.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c18a0c946f762..d5c94b47f431f 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -1219,7 +1219,9 @@ static int qcom_smem_probe(struct platform_device *pdev)
 		smem->item_count = qcom_smem_get_item_count(smem);
 		break;
 	case SMEM_GLOBAL_HEAP_VERSION:
-		qcom_smem_map_global(smem, size);
+		ret = qcom_smem_map_global(smem, size);
+		if (ret < 0)
+			return ret;
 		smem->item_count = SMEM_ITEM_COUNT;
 		break;
 	default:
-- 
2.51.0




