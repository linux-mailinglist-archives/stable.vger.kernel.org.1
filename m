Return-Path: <stable+bounces-220432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKX+GoI2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:40:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050901C6171
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6048930AFF17
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DBB480DEA;
	Sat, 28 Feb 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jT3i7IJ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513B3B3C1A;
	Sat, 28 Feb 2026 17:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300322; cv=none; b=FKpJw5+vWgT1yBezoPg/8Ovpo67JLdSuPGqIjFzWOf0UhUJG1yTv5c5SzPkEZQcDOjqxHOeL2kel9/BTq9QxBE9pR/SwN6xQLaLOBvtfox9qxZdXdOXlxf+yDTsgEuGSGXuJdG+ptyjTF0iZtnAUCEgATITI9zlvPfWCqGyc10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300322; c=relaxed/simple;
	bh=p0/zZUD++Cy59dQpIM9ZPgWXbqQmfQZVC5X+V6bLGmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bohXIekAFaQIrXy0/fzKf0UopZFZz/Mq/qwv8gPLhLO9+aMMksKdN7FXxxFtgNnjVF0S1Qtv55OkU4kl4NKqdTElUwzfDR0NkXwPXdc06HhgwFFS01Oa2E66x+EDiiRzSkrguLunZXiB+0pNZ0jCq88XojC1CzJAGGexqQ54R1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jT3i7IJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225BDC19425;
	Sat, 28 Feb 2026 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300321;
	bh=p0/zZUD++Cy59dQpIM9ZPgWXbqQmfQZVC5X+V6bLGmQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jT3i7IJ/YIoi8O5EiOBGy2SEc80BclKYifqTea9qZburtMR3aoo98YPuRS5bP4Piw
	 O8+pmW+mHt7+41o58XA7Nrop2USGT1m727gzZljAJoanwZfrIWluDBaoHIQIaiwFbS
	 TzjlsYqPq3Zdp8XduF5vJfaSLOt+ICj5x6hST7qBMloQg8DpfvzkdmVghwEexDgNwK
	 L56dpjcd7uk8ZW4nHAAQGDf1aVrycEjEQh5gMJtms3kgY0vg1jkUFLnlwiz/cA1cUD
	 gOtdDzgbpDmf5ynebSfH+TYKcDUwXbDxVLHL8YBj6IaSf5YlOolqyPH007uqxMI3gE
	 vFzKL+d3iARzg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Aishwarya TCV <Aishwarya.TCV@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 353/844] mailbox: pcc: Remove spurious IRQF_ONESHOT usage
Date: Sat, 28 Feb 2026 12:24:26 -0500
Message-ID: <20260228173244.1509663-354-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220432-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 050901C6171
X-Rspamd-Action: no action

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 673327028cd61db68a1e0c708be2e302c082adf9 ]

The PCC code currently specifies IRQF_ONESHOT if the interrupt could
potentially be shared but doesn't actually use request_threaded_irq() and
the interrupt handler does not use IRQ_WAKE_THREAD so IRQF_ONESHOT is
never relevant. Since commit aef30c8d569c ("genirq: Warn about using
IRQF_ONESHOT without a threaded handler") specifying it has resulted in a
WARN_ON(), fix this by removing IRQF_ONESHOT.

Reported-by: Aishwarya TCV <Aishwarya.TCV@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 0e0a66359d4c3..713022aed2e2f 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -459,7 +459,7 @@ static int pcc_startup(struct mbox_chan *chan)
 
 	if (pchan->plat_irq > 0) {
 		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
-						IRQF_SHARED | IRQF_ONESHOT : 0;
+						IRQF_SHARED : 0;
 		rc = devm_request_irq(chan->mbox->dev, pchan->plat_irq, pcc_mbox_irq,
 				      irqflags, MBOX_IRQ_NAME, chan);
 		if (unlikely(rc)) {
-- 
2.51.0


