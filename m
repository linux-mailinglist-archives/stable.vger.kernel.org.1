Return-Path: <stable+bounces-243653-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOAkOXWr+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243653-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:21:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0984BF309
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B32D5302FA19
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230153DE456;
	Mon,  4 May 2026 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfgt/ytm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1243DE43B;
	Mon,  4 May 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904434; cv=none; b=D7gf+JhEFCwI/+Wwx8kURPLt2Enj1ViNuoiH/4rMrnxOJX2SzjTiU+HGiyl6TJeo6x/sO6RLg8jWm6Iua6WynVowwplm6kv6BXbau1SMvCqPR+Bn8LwhggtNvFlYGp9Rb8YNbH1C8aKR4GiNtZr8ZyUwz+fZhaYTr1bhji9EklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904434; c=relaxed/simple;
	bh=O27VoE+Wn2bknyQDYFl7uvFUr+PAdMVIW0vcfdvQkAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGpuYqgL9CKs7Ezm+m1VvFmOb6wjT1QEYYSjmkeeVMxgty2iA6HEy+frPwXuSmPTcAw5Lz3VkEoOBYh1daSn2Pi54aujT1HAEADBfen8WJzidBt7KpgdwhEOzYePHmVEGs6mlPjO5DNvDZvGLxOX6N7kxJoJLNJ8mvvQOWDLnbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfgt/ytm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8F1C2BCB8;
	Mon,  4 May 2026 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904434;
	bh=O27VoE+Wn2bknyQDYFl7uvFUr+PAdMVIW0vcfdvQkAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfgt/ytmV2kx06X7ba5OKJBzKm8t7/hl0Whm4iNGu1gq4dfcQ4/EzcT6vvQl5s/BL
	 z0QGljKB5iRz9DwLsCioeTfMRt6ZVrLBnCD+DzVYnOkYWlWUzoJWWF07ueQVgZVp+u
	 BFLP4c0tZT+Tte7TTHy3mw2UaDyOsndfd0uMAt90=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	"Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 6.12 038/215] of: unittest: fix use-after-free in testdrv_probe()
Date: Mon,  4 May 2026 15:50:57 +0200
Message-ID: <20260504135131.568075380@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5F0984BF309
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243653-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iscas.ac.cn:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4095,7 +4095,6 @@ static int testdrv_probe(struct pci_dev
 
 	size = info->dtbo_end - info->dtbo_begin;
 	ret = of_overlay_fdt_apply(info->dtbo_begin, size, &ovcs_id, dn);
-	of_node_put(dn);
 	if (ret)
 		return ret;
 



