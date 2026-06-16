Return-Path: <stable+bounces-264321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H9Z1JVl2MWrFjwUAu9opvQ
	(envelope-from <stable+bounces-264321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:14:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D82691D6F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:14:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=gmSG0hGq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264321-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-264321-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64DC1306914E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3C423A72;
	Tue, 16 Jun 2026 15:55:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E444CAE6;
	Tue, 16 Jun 2026 15:54:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625300; cv=none; b=lkrvX+i/IeXkEBqioFIMbLCloLSbiiOaRDlRn3X3Lq0BokMQCjWxXJ8mOhvhoBxG5zogmWUXpVKz1VSsnKIzNdPvYv99bB+gDltm14R2KFOmE8ReKjpIljO86UGeE7hhAY8gGGwMoOrR5aOgsAuUUqE7d1msZ4zMjNjsmZ2MtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625300; c=relaxed/simple;
	bh=G0Oz1UyF58N/cK12FxQSG53+In5X16rvb5NmhhfTcn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuHFTuz09NoV5RBFfK03zUIMke+yaGVVffYiqJofKZajfWUvJ3m8S3pmUps+v+SGNMIo+4xpCA5dxU7YLt92KQftmYjJyRZv3IRSrXCVmSDMFv0aKSm8cd5lMeLs602qOsMp35bVKm99Vwec5HVSufcZbOoiUR6fhfqPHGDMnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gmSG0hGq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F251F000E9;
	Tue, 16 Jun 2026 15:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625299;
	bh=6Vm+wZIXKzmicEf3P+yPQuV9Z/4988kmy/s6cJN5Yok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gmSG0hGqTAPqa8bCsSFDI+B5HLIrbsaY2MORrts89gD6FjXM/HnXf1jXcK9oILTxD
	 iyKSuNZiJc8h7uOheysQu4ZgGVkCMSaJtDOeYvoQMZYJKMPetFF3tDwMXnzb4aT85U
	 MnowHuN6OlRMjIeXAqglgqN2URst5NSMTL6bMeno=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 082/325] tools/rv: Fix cleanup after failed trace setup
Date: Tue, 16 Jun 2026 20:27:58 +0530
Message-ID: <20260616145101.807498566@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264321-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:namcao@linutronix.de,m:gmonaco@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,linutronix.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66D82691D6F

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit 33ec2269a4155cad7e9e42c92327dcaa9aee59a7 ]

Currently if ikm_setup_trace_instance() fails, the tool returns without
any cleanup, if rv was called with both -t and -r, this means the
reactor is not going to be cleared.

Jump to the cleanup label to restore the reactor if necessary.

Fixes: 6d60f89691fc9 ("tools/rv: Add in-kernel monitor interface")
Reviewed-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/20260514152055.229162-5-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/verification/rv/src/in_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index e4f35940374f5a..e6dea4040f8f4c 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -810,7 +810,7 @@ int ikm_run_monitor(char *monitor_name, int argc, char **argv)
 	if (config_trace) {
 		inst = ikm_setup_trace_instance(nested_name);
 		if (!inst)
-			return -1;
+			goto out_free_instance;
 	}
 
 	retval = ikm_enable(full_name);
-- 
2.53.0




