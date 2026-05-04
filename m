Return-Path: <stable+bounces-243077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFV0IPCl+GnQxQIAu9opvQ
	(envelope-from <stable+bounces-243077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:58:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0EE4BE33A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 15:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1ACE3300C3B2
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA943D9DCF;
	Mon,  4 May 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DoolCvDf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F35E3D6481;
	Mon,  4 May 2026 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777902958; cv=none; b=QO68f6TUBzI13xDIfB+yosSZNuMl4cLUISJ+WpG9zrCKBfwGz39HVwvaPRPxGA86HZaCZvFGlG+gbFBKfRBY7TCO8hEsnnfP4TeKMaqUPdbngtx7ZetKGwEYR0mf2SOdcVZhIyp4KyCjNp+2xFcxu+wT9ZO24zqT4l2py4DSq5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777902958; c=relaxed/simple;
	bh=qhoC865OZNC/9LwHg3O0d7xPvB75hi15rbtzmWz7L38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8F9yMeO2LSCJYeH6rueE3h4VlPGJbU/L70szKnBQTvfFj45o/HEPnSsTRN5NeCywSktaeMxaUF3pE+z8zE3MqlKWpNYBcChQJk3/7Wn+KcyYh9ZGnIXq0qP8aKvISlL7iRqpdwXGQlRVlDMsj/hOj8aDRKUSmCGU5E/bE65emg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DoolCvDf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B71C2BCB8;
	Mon,  4 May 2026 13:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777902958;
	bh=qhoC865OZNC/9LwHg3O0d7xPvB75hi15rbtzmWz7L38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DoolCvDfhZfCngacm8e/si3IxtIQA2MgT1HmLGg1zjtAguZ6HuzdezzmzvNv008c8
	 Zxfmr2l3StnvhnuA5g1Zbh65uwtSgvcQQajj4NZO0eYzKYvn6yhkl/ia+DJqwJAPDl
	 c/ID0qmy0xFLRfLvsOAoUqItVvf7w4s9MCVCVm9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 7.0 048/307] of: unittest: fix use-after-free in testdrv_probe()
Date: Mon,  4 May 2026 15:48:53 +0200
Message-ID: <20260504135144.641095099@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6A0EE4BE33A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243077-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:email]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Liang <vulab@iscas.ac.cn>

commit 07fd339b2c253205794bea5d9b4b7548a4546c56 upstream.

The function testdrv_probe() retrieves the device_node from the PCI
device, applies an overlay, and then immediately calls of_node_put(dn).
This releases the reference held by the PCI core, potentially freeing
the node if the reference count drops to zero. Later, the same freed
pointer 'dn' is passed to of_platform_default_populate(), leading to a
use-after-free.

The reference to pdev->dev.of_node is owned by the device model and
should not be released by the driver. Remove the erroneous of_node_put()
to prevent premature freeing.

Fixes: 26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260409034859.429071-1-vulab@iscas.ac.cn
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/unittest.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -4317,7 +4317,6 @@ static int testdrv_probe(struct pci_dev
 
 	size = info->dtbo_end - info->dtbo_begin;
 	ret = of_overlay_fdt_apply(info->dtbo_begin, size, &ovcs_id, dn);
-	of_node_put(dn);
 	if (ret)
 		return ret;
 



