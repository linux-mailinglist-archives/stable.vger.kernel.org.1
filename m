Return-Path: <stable+bounces-256402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLZsCzatGGpymAgAu9opvQ
	(envelope-from <stable+bounces-256402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6693F5FA169
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A48BE30C4B17
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C928033372A;
	Thu, 28 May 2026 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YGnD/yUf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683F433F8B2;
	Thu, 28 May 2026 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001597; cv=none; b=Avhz5wUnl9KsSv54Jq0c/BmyjlpFtLSLo7ahGXulv4cRrLVu6WgSHAVU5MlBiRSpG/pPnqw0eU11XQ0CUwBkH6cpy//fIDGcpc01R4ttMfDD1S85jcUM3P/mELXvZRegFEtjwGAxdYnbRicqQsjl2a6tHIAMyh7sKO2HmXqLJCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001597; c=relaxed/simple;
	bh=1tLMbaTTb+RfjGOeLzsTSMZijFgvG8jCosFuvkFayjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DS1gWBFRDwYadswWSPf1O/C4uhRNXlM2wQzIAGDixihTNi+1CO7ksyDZ933maRWmh6K8zg2o4CwiXrVHCrLC/Y901V/9osF7Y5r+Sf/mIJY7jYV/p1z5i8y10eSULM+4O5tiYg+TrYYkXQAyLMH5sBCuETuzo/GmUTTT4QiPz+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YGnD/yUf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64DF1F000E9;
	Thu, 28 May 2026 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001596;
	bh=9lDmch3+jVgjTqlJpVl1HATJpy2iUJbd5358EK+STTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YGnD/yUfyztyU2QAJICQ0W79XoM+hNM4lYR122LlhXGp74VxaBO+VHt4GGI6fQyiF
	 Bdk1SMowgSspa8gfmCXpgKMqWNO2MqvfkwxSsTpi3r0cdJkj4gnM2kiFjqJJa2EVRL
	 5mbRrTPxSyztJzhdL8sKhKkUQLzXHdzjSUzor9x0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 183/186] pds_core: add an error code check in pdsc_dl_info_get
Date: Thu, 28 May 2026 21:51:03 +0200
Message-ID: <20260528194933.931373089@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256402-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6693F5FA169
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit a1e4c334cbc9a80578c3784f8a3e7076bb19578d ]

check the value of 'ret' after call 'devlink_info_version_stored_put'.

Signed-off-by: Su Hui <suhui@nfschina.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Link: https://lore.kernel.org/r/20231019083351.1526484-1-suhui@nfschina.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 3d4432d34c19 ("pds_core: ensure null-termination for firmware version strings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index bee70e46e34c6..dfbd6d39136f4 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -126,6 +126,8 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 			snprintf(buf, sizeof(buf), "fw.slot_%d", i);
 		err = devlink_info_version_stored_put(req, buf,
 						      fw_list.fw_names[i].fw_version);
+		if (err)
+			return err;
 	}
 
 	err = devlink_info_version_running_put(req,
-- 
2.53.0




