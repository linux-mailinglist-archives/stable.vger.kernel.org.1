Return-Path: <stable+bounces-232415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GUTCL4AzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-232415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:13:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC3236E37A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A43830939F4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7128A2FF669;
	Tue, 31 Mar 2026 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WKgp17zq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571E2D63E8;
	Tue, 31 Mar 2026 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976688; cv=none; b=ZCnJCp7khtSOvGs7qDkI/tF0Af5tsBUg71DnXpJKDdLKJTY8WQ+E0l6Wwl7IRtR5tnFLTq+CisfWIPAQh8v2xCqTiMcyO63OKCpGlG2NfJfAmxRdGlnv01iq92jUae7S0ALxdzEZAbgIiIRPUaDu+iNT4NeoakWI1X2//nSZEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976688; c=relaxed/simple;
	bh=UOkuhUtHctsWpNqHzjqjQPojaY4tKwe1KojdkYauTqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+2OHY5eSZW6zTkMCBXy9KrRtUvQ9O+BYisYEZImCaKXyW2wbOwqltRVAk+dSPbCaN2JwutCZyU5lei1F5SlvUNFerGG2ztrUEznJZrgvLNyIBHYSZ7Qku7D1z9931l7V5jai5J7yEjWajcM3QGzowBrFdqz63pkSuxaMZdDli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WKgp17zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF3BAC19423;
	Tue, 31 Mar 2026 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976688;
	bh=UOkuhUtHctsWpNqHzjqjQPojaY4tKwe1KojdkYauTqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WKgp17zqViMJcmsE4BkPUqy19FnlA8wmd85sLbBaknBhNyxot1B/n7wtvTwlNhxXi
	 Kg4fix8oV5FNLSXGmFG7q0uV5kY61I34fTZ7QI/kH/BT/7VNBMUWKMdcBdpZY/xfUZ
	 edtaaqrKRYy9vilzH4bYO9CS5isLsrX4vr8e08Zg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 189/309] ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload
Date: Tue, 31 Mar 2026 18:21:32 +0200
Message-ID: <20260331161800.415278555@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232415-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: ABC3236E37A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

commit d40a198e2b7821197c5c77b89d0130cc90f400f5 upstream.

It is unexpected, but allowed to have no initial payload for a bytes
control and the code is prepared to handle this case, but the size check
missed this corner case.

Update the check for minimal size to allow the initial size to be 0.

Cc: stable@vger.kernel.org
Fixes: a653820700b8 ("ASoC: SOF: ipc4-topology: Correct the allocation size for bytes controls")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20260326075618.1603-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/ipc4-topology.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2880,7 +2880,7 @@ static int sof_ipc4_control_load_bytes(s
 		return -EINVAL;
 	}
 
-	if (scontrol->priv_size < sizeof(struct sof_abi_hdr)) {
+	if (scontrol->priv_size && scontrol->priv_size < sizeof(struct sof_abi_hdr)) {
 		dev_err(sdev->dev,
 			"bytes control %s initial data size %zu is insufficient.\n",
 			scontrol->name, scontrol->priv_size);



