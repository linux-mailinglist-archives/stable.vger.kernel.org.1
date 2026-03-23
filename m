Return-Path: <stable+bounces-228038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAY+ODdHwWnpRwQAu9opvQ
	(envelope-from <stable+bounces-228038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:59:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5816F2F393E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF26D308B739
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8683ACA5C;
	Mon, 23 Mar 2026 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yDvhhb8F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F11D3A6B88;
	Mon, 23 Mar 2026 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273940; cv=none; b=jb0AYEABo39ZCvzCVLRse6SJcT2IUTB6OA6AvmLLtnHDx7Z2dtrOcCcgdtpTPp+bpb/vGv65EGLIcZO7T7V1fBpMjlFeIza4/By9f8HoSGs+gK12VKHmVYFmh22PM4fZfSXX7czFahs2TX9TtH3N+QZLVz7fx3buVX0VXT+Ykrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273940; c=relaxed/simple;
	bh=eKQJKbyS1FSAiEQFKp5+kUb5g7Ns5hc8vIU0D7wGd3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNrj4t6rw3WY1lEKYqMSBHHGiItl1eNSmhJenGY2Ad3nJ6gYzGPH8wG+H/g4Jy86tLYXp34YqqsKSZBbG5YFVahrgEzS3CdOSiWCNdmiVLYlAUtMwALbkfZoGJ0D4NYV/sdkXMhVoUa2mT20N1uR0b199du9VbW1uyq2xX15hQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yDvhhb8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B91C4CEF7;
	Mon, 23 Mar 2026 13:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774273939;
	bh=eKQJKbyS1FSAiEQFKp5+kUb5g7Ns5hc8vIU0D7wGd3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yDvhhb8FAsXEJkJS48amcmUPYt9/TVAVoeA331XlgH4AkZJepFOWHagp/cgNi8dBV
	 2T/ofpuFUrEbvCSxA71qQsuRTQpHVI1h+SVdwxSTin5PaPULriuYftljq/bIBq/Jct
	 +y/0OsGkusE2LTvBflcmxBKlnaox2CFWP1hUHkUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 030/220] LoongArch: Check return values for set_memory_{rw,rox}
Date: Mon, 23 Mar 2026 14:43:27 +0100
Message-ID: <20260323134505.530530226@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228038-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5816F2F393E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit 431ce839dad66d0d56fb604785452c6a57409f35 ]

set_memory_rw() and set_memory_rox() may fail, so we should check the
return values and return immediately in larch_insn_text_copy().

Cc: stable@vger.kernel.org
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
[ kept `stop_machine()` instead of `stop_machine_cpuslocked()` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/loongarch/kernel/inst.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -260,6 +260,7 @@ static int text_copy_cb(void *data)
 int larch_insn_text_copy(void *dst, void *src, size_t len)
 {
 	int ret = 0;
+	int err = 0;
 	size_t start, end;
 	struct insn_copy copy = {
 		.dst = dst,
@@ -271,9 +272,19 @@ int larch_insn_text_copy(void *dst, void
 	start = round_down((size_t)dst, PAGE_SIZE);
 	end   = round_up((size_t)dst + len, PAGE_SIZE);
 
-	set_memory_rw(start, (end - start) / PAGE_SIZE);
+	err = set_memory_rw(start, (end - start) / PAGE_SIZE);
+	if (err) {
+		pr_info("%s: set_memory_rw() failed\n", __func__);
+		return err;
+	}
+
 	ret = stop_machine(text_copy_cb, &copy, cpu_online_mask);
-	set_memory_rox(start, (end - start) / PAGE_SIZE);
+
+	err = set_memory_rox(start, (end - start) / PAGE_SIZE);
+	if (err) {
+		pr_info("%s: set_memory_rox() failed\n", __func__);
+		return err;
+	}
 
 	return ret;
 }



