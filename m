Return-Path: <stable+bounces-231846-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNV3MZH8y2nDNAYAu9opvQ
	(envelope-from <stable+bounces-231846-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:55:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 216D536D6D8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482D9308A17F
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7576425CDB;
	Tue, 31 Mar 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="umH4cq0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6860642317F;
	Tue, 31 Mar 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975221; cv=none; b=Am3ox1WmSoBXvtEai93aZaJZrlmzTo/z9wxt0KiCEh6u2V8VmzKXOvGT3FJz8JRgcJTLdglibO8kPhQqFui5NZNjE031ibHKEp38YHhMVunyKSk3gFgofcnqYj5fswdfSnh0StQuUSpM6lsr7QtPOB/6UnqldzvNUwUyxs5jqwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975221; c=relaxed/simple;
	bh=wolcDTLeIQ1xypf5eQ79QjN3pysH4WCSwLJ6NfXxiuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVxPS8TU7Z23iZW4C+G03tmbZCF9DQbe+syigLLSahZJl45OphLjn82UfkZTxwGl1RyTLnFxUv9fBSXnKNnRmU6X07j++LwDqnGYyJm/eSadFvMdKWtgEI9wcxiMYx1bZiBSWyYuJWgc06FqNWXjVKzA3kcfbkM0V67ovbhF5sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=umH4cq0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9660C19423;
	Tue, 31 Mar 2026 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975221;
	bh=wolcDTLeIQ1xypf5eQ79QjN3pysH4WCSwLJ6NfXxiuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umH4cq0jMalHSii/M/BB+dl6YJDBA+xt31RpsJotcICk3kNlgPJ0fzo/mWOPF5O22
	 PlW27dAW/3c7cJnbEj1PU/sNYJ3rn+v+cmQEpfQVJBAv45WxmpVjIJuIbgE0IkbHr1
	 S0cAVRXEMHzGA0QJZHtEXKMe7vhIMwHZUZpt1zf4=
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
Subject: [PATCH 6.19 211/342] ASoC: SOF: ipc4-topology: Allow bytes controls without initial payload
Date: Tue, 31 Mar 2026 18:20:44 +0200
Message-ID: <20260331161806.743576377@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231846-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 216D536D6D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2889,7 +2889,7 @@ static int sof_ipc4_control_load_bytes(s
 		return -EINVAL;
 	}
 
-	if (scontrol->priv_size < sizeof(struct sof_abi_hdr)) {
+	if (scontrol->priv_size && scontrol->priv_size < sizeof(struct sof_abi_hdr)) {
 		dev_err(sdev->dev,
 			"bytes control %s initial data size %zu is insufficient.\n",
 			scontrol->name, scontrol->priv_size);



