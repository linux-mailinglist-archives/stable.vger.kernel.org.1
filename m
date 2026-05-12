Return-Path: <stable+bounces-245955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOQNB99oA2qa5gEAu9opvQ
	(envelope-from <stable+bounces-245955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:52:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDEE52640F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E35BE3061EA3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDEB3D5C06;
	Tue, 12 May 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LihPSdtl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811D2EBB84;
	Tue, 12 May 2026 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607986; cv=none; b=VI9eedyaldaxWlYlOhHyuocoAvAIu//Xf0IylEe344zWBykS6VfjbXejXVBQSd3TKQjKGJcq/jJ2r8WA13TkJO+HCwyEP3YYaSqxJbkNiXpcHe/TK/TqKMnmWhyUE5JScaVHGg7yD4PO5fkchli8Ou+RBfrJguSqrFbMo+vzpgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607986; c=relaxed/simple;
	bh=cD/QSpLjxAW0kAegwhCaitGrqXgaBASMGCWFkM3WgEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGJqO3k0rtKq0gDSp6rYsDsbRos4TN7x0zTGsiuoZG10mTijCkHXSr+haEQlSgfw0XFFivJqoBOuCpPqGwDV3bRmCID5UDzXOUtfFrWt3pUNuw53dVMYnxNdoyi5k1lC/kcw9amU4TFSathTyx+mc8C43MWUcgwCTJw58QOluD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LihPSdtl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D52BC2BCF5;
	Tue, 12 May 2026 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607985;
	bh=cD/QSpLjxAW0kAegwhCaitGrqXgaBASMGCWFkM3WgEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LihPSdtlSA8Hj1kMWvEsgtEnLZm+hLRNe0iapYSfqBNFsdRtLEyQ2plkeqLDKkwgr
	 8Nu7O6UetqY0xP1INy6ImFxPabCn6NC4M3c3PJCqlhun2uX1cDloCoyRxoqy7PvItM
	 iJ3xtiO2d6VQOfDPDdnOEeBagD4b1Et5/4GVmdAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 113/206] ASoC: qcom: q6apm: remove child devices when apm is removed
Date: Tue, 12 May 2026 19:39:25 +0200
Message-ID: <20260512173935.248434717@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5BDEE52640F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-245955-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

commit 4a0e1bcc98f7281d1605768bd2fe71eacc34f9b7 upstream.

looks like q6apm driver does not remove the child driver q6apm-dai and
q6apm-bedais when the this driver is removed.

Fix this by depopulating them in remove callback.

With this change when the dsp is shutdown all the devices associated with
q6apm will now be removed.

Fixes: 5477518b8a0e ("ASoC: qdsp6: audioreach: add q6apm support")
Cc: Stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260402081118.348071-3-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/qcom/qdsp6/q6apm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -781,6 +781,7 @@ static int apm_probe(gpr_device_t *gdev)
 
 static void apm_remove(gpr_device_t *gdev)
 {
+	of_platform_depopulate(&gdev->dev);
 	snd_soc_unregister_component(&gdev->dev);
 }
 



