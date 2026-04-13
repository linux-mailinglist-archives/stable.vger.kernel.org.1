Return-Path: <stable+bounces-237213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIHKOv8g3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:59:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741A3F071C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C69663087B81
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE231619C;
	Mon, 13 Apr 2026 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Shsrp4Bq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA2314D26;
	Mon, 13 Apr 2026 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098877; cv=none; b=UrtnJLyCZnBOZpf93h8K3nn8Y3QS8eD0lvJfQ+qV9yCU0cGoWrd7tZopYwZcCaxa+r0UDJiHTWeixG/agsYWn5/XiYfG1lmIAAjOOkzXmo4RQBCHVGECGynqJZGHsNGLXwsNIQJByBUsKCyEGgcDfS0GOJ4VB+GTU5CD2ZGoa50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098877; c=relaxed/simple;
	bh=QsyZX2gdVnVpAK2VuxYyvGTOvN35q4ULlIAd1JjlMQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBzBb9kw6rwFgRchj5uP98tSis9g5Uoj407KVKAfRtv+iTioULsgY3fcqhW+KHgNYUiJzpel5sKqtwmDp2Gm8bb/0A6Fdw2Z0tyE7RkVLs+PEbXTF/8EtmEAgalhsz66cUYL+SWO5rV+9pWeZwdor91CNlxKJZSOFqbWZS3NtQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Shsrp4Bq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D18FC2BCAF;
	Mon, 13 Apr 2026 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098876;
	bh=QsyZX2gdVnVpAK2VuxYyvGTOvN35q4ULlIAd1JjlMQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Shsrp4Bq1HtwvsKWxOMpdQd9nTwvk/NZpO/xBRF1PmRwR/M4MY3dgz67EK6fPhgKP
	 vIMKVm2vqnkcB0XrFRADuHFEoabg9bXE9WtuuXBr/FnXfjq/2IPIqkNEZlfA+DauDR
	 Aqyv0HNyzIM2BExKrlqv8dQYEmdr28QzJ01YA6ks=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <gu_0233@qq.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.10 106/491] mmc: mmci: Fix device_node reference leak in of_get_dml_pipe_index()
Date: Mon, 13 Apr 2026 17:55:51 +0200
Message-ID: <20260413155823.011755814@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237213-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,qq.com,linaro.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dma_spec.np:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5741A3F071C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

commit af12e64ae0661546e8b4f5d30d55c5f53a11efe7 upstream.

When calling of_parse_phandle_with_args(), the caller is responsible
to call of_node_put() to release the reference of device node.
In of_get_dml_pipe_index(), it does not release the reference.

Fixes: 9cb15142d0e3 ("mmc: mmci: Add qcom dml support to the driver.")
Signed-off-by: Felix Gu <gu_0233@qq.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/mmci_qcom_dml.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/mmci_qcom_dml.c
+++ b/drivers/mmc/host/mmci_qcom_dml.c
@@ -109,6 +109,7 @@ static int of_get_dml_pipe_index(struct
 				       &dma_spec))
 		return -ENODEV;
 
+	of_node_put(dma_spec.np);
 	if (dma_spec.args_count)
 		return dma_spec.args[0];
 



