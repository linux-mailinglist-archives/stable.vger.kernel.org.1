Return-Path: <stable+bounces-224171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJGDB2X9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B172624A407
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25C683034B01
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5F31197C;
	Tue, 10 Mar 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZAfaJAy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B30313E3B;
	Tue, 10 Mar 2026 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141302; cv=none; b=XTcNOFvprIXIaR9zAIsgIe9/80bZAvXecxZrR0ukONewlTaUNrhJNp4QzXa8kKCuyUI4YNQm9G/+52rOUTDgUNhuc+4G3YixCHkU33IRyxnCczIbTNow3Ytl6Nxe/Vq3eHvCcg6rdhCxSYhHEeRjYBSlzgdfPoOXPGDJBrWC6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141302; c=relaxed/simple;
	bh=9NVMAFvwT3+RjsGo6n7bcBiu9bXtOTxh87GR7Y+PjBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBP8VYngb1tdtFpaqnv0j3HbnBtocyM+5lQ8zXkDy5pEDLNr+OHEYspsSFxP55TpJrYaubelur6PhQ61OWEdc/Fh5efCoVCHz5mPBEWjaljk6FXBU4BwNGmree9jUi/C93l39spOujnjshLculKuYMCCogjQ6tZg47uf4z+nzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZAfaJAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE69C2BC9E;
	Tue, 10 Mar 2026 11:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141301;
	bh=9NVMAFvwT3+RjsGo6n7bcBiu9bXtOTxh87GR7Y+PjBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZAfaJAylLC4wPM2D3FFj+NanJM9IXY3pgTONAO//3ODau0GCLGHSsPElyCwhjUzM
	 cCsjW5yuk+qjYN9YzEWZQZVRN45oEoMKsopVFj/MtA74WQ9NAEluwfyTkaskZHGPGR
	 2FOiHZNTzovht7Qg1bNX7mCCEdwEgzcNk3fbA9ovsGry2ImnRbUNAUrMdGxnswu7ZT
	 FIU5u284N+nMi6eWzC/PHNQlSVnXWBn+Ip1YNQ9RWd4o6j8El3oOJcqZ7wkaEvBvOt
	 jEuwksTDoZV7xl+6f3UP1xNVRfoQUnKjRTOXvbHAoo0OhyyKSJsjGNIOwEvTwlzpvl
	 SjfWEgdpl37nA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: "Rob Herring (Arm)" <robh@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 306/311] accel: ethosu: Fix NPU_OP_ELEMENTWISE validation with scalar
Date: Tue, 10 Mar 2026 07:05:53 -0400
Message-ID: <228bb0c3243938f5bdd2e9551a6cd317dd85fa3f.1773140656.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B172624A407
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224171-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rob Herring (Arm)" <robh@kernel.org>

[ Upstream commit 838ae99f9a77a5724ee6d4e7b7b1eb079147f888 ]

The NPU_OP_ELEMENTWISE instruction uses a scalar value for IFM2 if the
IFM2_BROADCAST "scalar" mode is set. It is a bit (7) on the u65 and
part of a field (bits 3:0) on the u85. The driver was hardcoded to the
u85.

Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
Reviewed-and-Tested-by: Anders Roxell <anders.roxell@linaro.org>
Link: https://patch.msgid.link/20260218-ethos-fixes-v1-2-be3fa3ea9a30@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ethosu/ethosu_gem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/ethosu/ethosu_gem.c b/drivers/accel/ethosu/ethosu_gem.c
index 7b073116314ba..4e84481a29d2f 100644
--- a/drivers/accel/ethosu/ethosu_gem.c
+++ b/drivers/accel/ethosu/ethosu_gem.c
@@ -417,7 +417,10 @@ static int ethosu_gem_cmdstream_copy_and_validate(struct drm_device *ddev,
 				return ret;
 			break;
 		case NPU_OP_ELEMENTWISE:
-			use_ifm2 = !((st.ifm2.broadcast == 8) || (param == 5) ||
+			use_scale = ethosu_is_u65(edev) ?
+				    (st.ifm2.broadcast & 0x80) :
+				    (st.ifm2.broadcast == 8);
+			use_ifm2 = !(use_scale || (param == 5) ||
 				(param == 6) || (param == 7) || (param == 0x24));
 			use_ifm = st.ifm.broadcast != 8;
 			ret = calc_sizes_elemwise(ddev, info, cmd, &st, use_ifm, use_ifm2);
-- 
2.51.0


