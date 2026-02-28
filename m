Return-Path: <stable+bounces-220259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA/fEGwwo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:14:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5E51C58F9
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65F9330AC001
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D4F37CB25;
	Sat, 28 Feb 2026 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8SnaJvd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CDF37CB1B;
	Sat, 28 Feb 2026 17:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300162; cv=none; b=tUKdbvC8Ch4uaPxDCrRJBmH9405DeT2f6Ru9k5KKnKaDiDtJoheAMI62EJUdOC4mcy2v/dor520fYRdzukz2LaiW5qIU2WDu/OBriD7tWZfAXCzC6igbFa4CIdHzK1q9vFTPgfOnvqI3y06HesBoatfSpDr8mcqdJ3E5KY/QyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300162; c=relaxed/simple;
	bh=2/6HQfuQO/kySjY2/lJdcTulhRmwZNESNAzsv90qTx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJ1mx+tKxzCPWV9jQq4gEH3oJpApd0+fU3J7HBCo8AQnXLVH4H5c6worXXN8WVPW/UVz6cNKFaCieW8T2rrscFVtRf/Q1L9t+kmmAEaIVQqgIYkhn72noalILfc4c2zDwTDPVFk2PfaLIZavpHaPb5ufzLEdeFzPNnQGT2adNMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8SnaJvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AEEC19423;
	Sat, 28 Feb 2026 17:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300162;
	bh=2/6HQfuQO/kySjY2/lJdcTulhRmwZNESNAzsv90qTx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I8SnaJvdPmiG6X05bFC1H0zQ0JUSuhkincr+BWY1O6jXu4UWVUCfH+bTTkSPKAybM
	 MDec1/kAgZsxrp6umRW3azO8NTC/fWm4zxn1R5ehMy2eZLxB7+22XewAWm7Jhobvxa
	 xWy1wvTusyDieS/aNT3EjGLQHSF/WxA8lZoDixN/sC8PbgkrtlqzsfDhlyj8DTcvbs
	 RJMnyWPsXdeD6qy+YjNOAt0BO/ZMxfuUt8kkhHtJXBYa8FiB/xZhf3XrpDVOY8Uzmv
	 3BJ54Mg2qr5Gcuihk3d/5i6Ld4Nq0Lqnd952tua52DPh6BcLMb6TEtVjHl/pRrd43Y
	 oX+BGOcjc1hKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 181/844] media: cx25821: Fix a resource leak in cx25821_dev_setup()
Date: Sat, 28 Feb 2026 12:21:34 -0500
Message-ID: <20260228173244.1509663-182-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220259-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 5C5E51C58F9
X-Rspamd-Action: no action

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit 68cd8ac994cac38a305200f638b30e13c690753b ]

Add release_mem_region() if ioremap() fails to release the memory
region obtained by cx25821_get_resources().

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx25821/cx25821-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/pci/cx25821/cx25821-core.c b/drivers/media/pci/cx25821/cx25821-core.c
index 6627fa9166d30..a7336be444748 100644
--- a/drivers/media/pci/cx25821/cx25821-core.c
+++ b/drivers/media/pci/cx25821/cx25821-core.c
@@ -908,6 +908,7 @@ static int cx25821_dev_setup(struct cx25821_dev *dev)
 
 	if (!dev->lmmio) {
 		CX25821_ERR("ioremap failed, maybe increasing __VMALLOC_RESERVE in page.h\n");
+		release_mem_region(dev->base_io_addr, pci_resource_len(dev->pci, 0));
 		cx25821_iounmap(dev);
 		return -ENOMEM;
 	}
-- 
2.51.0


