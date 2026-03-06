Return-Path: <stable+bounces-223378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPvWCagYq2kfaAEAu9opvQ
	(envelope-from <stable+bounces-223378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 19:10:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E467226963
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5056A3009E13
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330713D34AD;
	Fri,  6 Mar 2026 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b="PgYiYB2A";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JsPNbVlW"
X-Original-To: stable@vger.kernel.org
Received: from e234-52.smtp-out.ap-northeast-1.amazonses.com (e234-52.smtp-out.ap-northeast-1.amazonses.com [23.251.234.52])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B423B8934
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820643; cv=none; b=arlNfq9xTAX0qVswYwvyb3slPsfGQ0kc1Lo2eCep7Q2T/wbgo2++i2M5B7Yjoex3jhIBFkC4Uwa7yaLrqjf9euz0oyUKYs17mX5iHJGHozvWTioO1Udvgyr2u51v508AtFk09/gZPlsFPO4h4enq3Sh+EWEFk3f7BumBfelCSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820643; c=relaxed/simple;
	bh=KVLNn2ax+asM2yDOQBLsW9QcrFqP0O4tRwB/n0oWb9o=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=rom+T5EQIHq+VmJ5xUvo9xBP4Iow+R1aZ0wHyDu1pXFnzaN3fjM0fk0RWij52ok0ZoS/Ff8O1CZFGZLQQVNQ0VYQmxYbBRLevq+nfFYmtmsBzTOw1ihdspf96sjtmK6v96n4nWyA4z2sXRKqDlYsOZYuN1sr2xOVj2zafh8BumY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=send.mgml.me; dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b=PgYiYB2A; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=JsPNbVlW; arc=none smtp.client-ip=23.251.234.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.mgml.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=mgml.me; t=1772820640;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=KVLNn2ax+asM2yDOQBLsW9QcrFqP0O4tRwB/n0oWb9o=;
	b=PgYiYB2AcpXGBbgGWROM32CKUrpavFKTpq3eJl7jVp7O+C8Q1ckluInjneOi+zjJ
	jOMakibhONk90Sm8/1X13+BF3eLZMpwjLBitd8cmCJTi935drqtSn7D0Elr4FOnPVlE
	6FDjtf7JSzki/XYnO7OutzYEcTIPPUC9LO4VIySM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=suwteswkahkjx5z3rgaujjw4zqymtlt2; d=amazonses.com; t=1772820640;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=KVLNn2ax+asM2yDOQBLsW9QcrFqP0O4tRwB/n0oWb9o=;
	b=JsPNbVlW+Nnw+tUyJUeNVRHjTzzFi22hlQimb3NmFV3F5Jhv0ZmP5Gj436OTOpXK
	ggZuzsv4fKIc3QFLF9+T/fgV8CsdAomofLIR3GhYNMEUuDzhl2g1e0ePcjUVxKm74mp
	AuhG45GZi2QzR4PAPsBwBkH60gc0k7ZFeMNEXo8U=
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Kenta Akagi <k@mgml.me>
To: regressions@lists.linux.dev
Cc: stable@vger.kernel.org, sashal@kernel.org
Subject: [REGRESSION] 6.6.129 tools/perf cannot build due to eddddf4ed7f6
Message-ID: <0106019cc4583222-d98c40c9-2728-4d21-85b7-a90135726b95-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 6 Mar 2026 18:10:40 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.SskAFE1oaJ7KCjyyJFCV37nkSRmUZttpeGoevLE2CszduPSq19CK0OWqrkMmPMemkYWmFvQfvS6+lCR9ETv8vDWvEFaQZtUQ69n4DuGGNbGH4U7i+CnKWCHWm/HpilUFxPcCpCRFiQTHPHnKlfimqanQj7AjyJ2y8XQuaQGs83Sl+MS5tJ/lS6+Uh2zwyhRo:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.03.06-23.251.234.52
X-Rspamd-Queue-Id: 3E467226963
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mgml.me,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mgml.me:s=resend,amazonses.com:s=suwteswkahkjx5z3rgaujjw4zqymtlt2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_MUA_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-223378-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[k@mgml.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mgml.me:+,amazonses.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.958];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazonses.com:dkim,ap-northeast-1.amazonses.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mgml.me:dkim]
X-Rspamd-Action: no action

Hi,

It seems that build of tools/perf fails due to commit=20
eddddf4ed7f6 ("perf unwind-libdw: Fix invalid reference counts") backported=
 in v6.6.128.

util/unwind-libdw.c: In function =E2=80=98unwind__get_entrie=
s=E2=80=99:
util/unwind-libdw.c:323:17: error: implicit declaration of =
function =E2=80=98map_symbol__exit=E2=80=99; did you mean =
=E2=80=98symbol__exit=E2=80=99? [-Wimplicit-function-declaration]
  323 |                 map_symbol__exit(&ui->entries[i].ms);
      |                 ^~~~~~~~~~~~~~~~
      |                 =
symbol__exit

This backport adds a call to map_symbol__exit, but =
upstream=20
commit 56e144fe9826 ("perf mem_info: Add and use =
map_symbol__exit and addr_map_symbol__exit"),=20
which added this function,=
 has not been backported to v6.6.

I was able to build it by simply =
reverting eddddf4ed7f6, but I haven't tested perf though...

Thanks,
Akagi

