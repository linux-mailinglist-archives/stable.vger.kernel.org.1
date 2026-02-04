Return-Path: <stable+bounces-214141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC0HH0psg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:56:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD044E9A47
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D17A315F957
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980932D6611;
	Wed,  4 Feb 2026 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2o2hILtq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0840FD98;
	Wed,  4 Feb 2026 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218701; cv=none; b=mdhIlKsNITKU99ilNVIkz8rIH96oz/QW8/7p/BIOeQeEZDe1L0UApWza2WU6IRtZ6gDuzJb2ONo6RMunabXJbLuYcqaF4c0kw5OslPfukoKjIK9wlKRaVBrCRZVj/7rtGtua4Hm/9Lch8Ble40jg6552z1PmzXmWaf3tUY7/sRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218701; c=relaxed/simple;
	bh=pWjdrjUHSivLZm+HQiW2oM1oAGJlO//KI6ecpHF8doQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nF5ucly4nYH2d2nBovP2Ug4/2SyyRjChJB2ih0IZZ1oGpF5AKM3ZUIAjysODcJx9x8fZJo4wquln+enc24I2AywA3gmcU4wbuA1GtRtqWYvJ5L3pgUO/voougckckws0bKd9Iq4hT5jlA/wUeKqNBZDWYcE4z4zzmOkHXJ60+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2o2hILtq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4C0C4CEF7;
	Wed,  4 Feb 2026 15:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218701;
	bh=pWjdrjUHSivLZm+HQiW2oM1oAGJlO//KI6ecpHF8doQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2o2hILtqPShySMU5l9eAe+NyY4icx2XjuyHee501vO9IQ3qWBgkRxZzboR0ReDiFD
	 CfGmYnOZYfvAeWXbAaq+ysXCm7BpT8JBl+UNyaHO7QS9aAoe+haIkBt7xD10irKbPX
	 ZmNwrcfaQRZDY3ac2YqlJIVuaHUqGg/NA9938B7w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Han Gao <gaohan@iscas.ac.cn>,
	"Guo Ren (Alibaba Damo Academy)" <guoren@kernel.org>,
	Paul Walmsley <pjw@kernel.org>
Subject: [PATCH 6.12 35/87] riscv: compat: fix COMPAT_UTS_MACHINE definition
Date: Wed,  4 Feb 2026 15:40:33 +0100
Message-ID: <20260204143848.177407215@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-214141-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,iscas.ac.cn:email]
X-Rspamd-Queue-Id: AD044E9A47
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Han Gao <gaohan@iscas.ac.cn>

commit 0ea05c4f7527a98f5946f96c829733788934311d upstream.

The COMPAT_UTS_MACHINE for riscv was incorrectly defined as "riscv".
Change it to "riscv32" to reflect the correct 32-bit compat name.

Fixes: 06d0e3723647 ("riscv: compat: Add basic compat data type implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
Reviewed-by: Guo Ren (Alibaba Damo Academy) <guoren@kernel.org>
Link: https://patch.msgid.link/20260127190711.2264664-1-gaohan@iscas.ac.cn
Signed-off-by: Paul Walmsley <pjw@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/riscv/include/asm/compat.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/riscv/include/asm/compat.h
+++ b/arch/riscv/include/asm/compat.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_COMPAT_H
 #define __ASM_COMPAT_H
 
-#define COMPAT_UTS_MACHINE	"riscv\0\0"
+#define COMPAT_UTS_MACHINE	"riscv32\0\0"
 
 /*
  * Architecture specific compatibility types



