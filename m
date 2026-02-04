Return-Path: <stable+bounces-213876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC/5Oa1lg2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:28:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66AE8A96
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E53FF306D149
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9068D41C305;
	Wed,  4 Feb 2026 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PCpuhHzN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468C221F17;
	Wed,  4 Feb 2026 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217809; cv=none; b=E7Mx5qfWwM9RdiY11pj+YvptTYFFBI3E6zS4Wm+Li8jskAzUrHIzhol8n1FmqrpIdz8BKN1KgGZOaSaMlJ4ItJbHJ+l59B//Bq/kCf+2SFs9f9xglSnrpVu/ZC86xLIProvDXOQEYo0Xkcedg8Q3YmlpMff+TkXHz8CqkabBwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217809; c=relaxed/simple;
	bh=wwJgLVyEKSYQ5jdm7TDHWsNrTfHZiGflEtJeMiVHQiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1MJLGAbcyRCWNZGfRs14M22fxFkQXFZ4KK9xVaKObaDRaJX+lUf4kF9dwgx2U0U4kfeUDdeAIwB4CG+WcAEYZemt62f7jGe9SnLZGlGSWa36XearCvyuGTiBbF6p7oJyIDISJAZAKIobN5fvLV5gRT+Uy/SkMy/awVhtQbK6AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PCpuhHzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED8DC4CEF7;
	Wed,  4 Feb 2026 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217809;
	bh=wwJgLVyEKSYQ5jdm7TDHWsNrTfHZiGflEtJeMiVHQiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PCpuhHzNUrYG7L8hrnTuuHrqkS+ToGk1RgmBrq3P0WbwTpxx3XUNewomRjubrpKJI
	 pgyJ1cPkJUDarjh/kkueA9QE/hn3ia3d7i+PkJPsaU64AMVDLze9jaF2kIOLiDXBkF
	 E8+LKSUU6CgzIxmFkf+gpeospV/DXf39nu4xCZZ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Wolf <wolf@yoxt.cc>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 091/280] ata: libata: Add cpr_log to ata_dev_print_features() early return
Date: Wed,  4 Feb 2026 15:37:45 +0100
Message-ID: <20260204143912.931171738@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-213876-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,yoxt.cc:email]
X-Rspamd-Queue-Id: 8C66AE8A96
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit a6bee5e5243ad02cae575becc4c83df66fc29573 ]

ata_dev_print_features() is supposed to return early and not print anything
if there are no features supported.

However, commit fe22e1c2f705 ("libata: support concurrent positioning
ranges log") added another feature to ata_dev_print_features() without
updating the early return conditional.

Add the missing feature to the early return conditional.

Fixes: fe22e1c2f705 ("libata: support concurrent positioning ranges log")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Tested-by: Wolf <wolf@yoxt.cc>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14bcfebf20b8f..98d610c37e8c7 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2597,7 +2597,7 @@ static void ata_dev_config_cpr(struct ata_device *dev)
 
 static void ata_dev_print_features(struct ata_device *dev)
 {
-	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK))
+	if (!(dev->flags & ATA_DFLAG_FEATURES_MASK) && !dev->cpr_log)
 		return;
 
 	ata_dev_info(dev,
-- 
2.51.0




