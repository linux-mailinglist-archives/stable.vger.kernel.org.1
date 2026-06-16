Return-Path: <stable+bounces-265434-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id spAANh6KMWo2mAUAu9opvQ
	(envelope-from <stable+bounces-265434-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:38:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DB569354B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:38:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VdaByOKY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265434-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265434-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 852EE31A59DF
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4EE47A0DA;
	Tue, 16 Jun 2026 17:33:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D6D332EC1;
	Tue, 16 Jun 2026 17:33:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781631183; cv=none; b=cMxLLzWm8VCUbqfmrnieAhy2AGVtzxjNwJaJ9Ht6obVQe9ZZH8N9hVHFAFEjScaON6JVLJVDs677+NpBOur3jycK+vZHQJHdmZLfycaZe1/KreTeAY3nM8rexZddchO+QOYUmNfDsj2xIxlKYqexEKC2pIux3B+7wkGVSl6IPzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781631183; c=relaxed/simple;
	bh=5BPSnhAOrQvPucqIuhpcnYss0+3G69/eEmkdQBaBcSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pc6sRLOju6SUdwWisWHdWJvRyL/D6gi/SYb7qCKSqCGEtq/sb8SHeIg1RpQ6/sRWY4lyqwlBvs/KSe6F9hD11KfgkSnUWFqy6RC0uKyIYAqu45WZ9FdFxgGGAbEkeCvZADkJEBCRCT2kR0WYnLJpCUT+UkpT9qEjgHUxT/bqo/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VdaByOKY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAF61F000E9;
	Tue, 16 Jun 2026 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781631182;
	bh=7mXIj/qs0qNdMD1Y1WOL8dsUlRQsiXqloKUEACWdcAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VdaByOKYSpcJp1BnDT7ot0/4uEJXaMj97yyyjC3HgFPji2bcuYRfxL+/AohAKMruU
	 XN9MTfExEUSUg/P3wR/S2LzzIU3B2ETqi6cFhmyAaBHPPIrch1nqwxpNKXSSOBHc0W
	 eLjLsrsIPlRx/vBSmF5eJJBlFnyyZKBVEE34nzkk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 6.1 139/522] comedi: comedi_test: fix check for valid scan_begin_src in waveform_ai_cmdtest()
Date: Tue, 16 Jun 2026 20:24:46 +0530
Message-ID: <20260616145132.599879437@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265434-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:stable@kernel.org,m:abbotti@mev.co.uk,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mev.co.uk:email,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 30DB569354B

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Abbott <abbotti@mev.co.uk>

commit 542f5248cb481073203e0dadab5bcbd28aeae308 upstream.

Commit 783ddaebd397 ("staging: comedi: comedi_test: support
scan_begin_src == TRIG_FOLLOW") neglected to add a test that
`scan_begin_src` has only one bit set.  The allowed values are
`TRIG_FOLLOW` and `TRIG_TIMER`, but the code incorrectly also allows
`TRIG_FOLLOW | TRIG_TIMER`.  Add a call to
`comedi_check_trigger_is_unique()` to check that only one trigger source
bit is set.

Fixes: 783ddaebd397 ("staging: comedi: comedi_test: support scan_begin_src == TRIG_FOLLOW")
Cc: stable <stable@kernel.org>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
Link: https://patch.msgid.link/20260422162138.36003-1-abbotti@mev.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/comedi/drivers/comedi_test.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -271,6 +271,7 @@ static int waveform_ai_cmdtest(struct co
 	/* Step 2a : make sure trigger sources are unique */
 
 	err |= comedi_check_trigger_is_unique(cmd->convert_src);
+	err |= comedi_check_trigger_is_unique(cmd->scan_begin_src);
 	err |= comedi_check_trigger_is_unique(cmd->stop_src);
 
 	/* Step 2b : and mutually compatible */



