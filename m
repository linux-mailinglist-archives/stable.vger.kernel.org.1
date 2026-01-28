Return-Path: <stable+bounces-212595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIKKCOM7emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:40:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 689F2A5F7D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E1A0330868A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A64F2DF138;
	Wed, 28 Jan 2026 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iWjycgHg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2081AA8;
	Wed, 28 Jan 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616045; cv=none; b=P0AaWMM3h+nzWsTJMBI8Cd942i+zJ9IGjDfsN/3SzppqgRexIVIW9EpaYez/xhWDBLhyrjopJUeHWh3mrBzs9QQwDyu7wQ47//uiE0dY34NGYFmMXsd/DL8wT+lI4IP9KxeZB09qK07K4w8Y5XWR1QRFF9VnPhfxmCoW8SbucXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616045; c=relaxed/simple;
	bh=U5U+Dxyzbkv+frTwShZe3aDQQauM75213JRjwrOXeAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5ArjUfH4tF4zngiPnM8Xzr6VMXW7e4m6xGtvPhmAHc2deTwM7JOmkOWua8V9MknEE26fIhvZ1wV5qUf9UgIGNjZNdl3+9l/bLiMqAwlPSnP66m/uDA3SpJS+/C3HI0odafaDjNtg31j6fS4kPIykLN69T4vmnC/0eOiRPCdpHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iWjycgHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4697AC4CEF1;
	Wed, 28 Jan 2026 16:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616045;
	bh=U5U+Dxyzbkv+frTwShZe3aDQQauM75213JRjwrOXeAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWjycgHgYG2B4oC1GG7Me4OmzbcKpQWNey7EdZM/YucXiq89YkmmkTrR3KKPk96z+
	 arfJVLs21zaBfxgJvQwIKbqFFkXbCcbtcX9x1GyI/hYBRwYJgcpXHVXt/k7nb1zdHG
	 FIbfunXBg7iOVJGssLqDgetEBRwnUMRyosNHSHQA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Egorenkov <egorenar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 6.18 190/227] s390/boot/vmlinux.lds.S: Ensure bzImage ends with SecureBoot trailer
Date: Wed, 28 Jan 2026 16:23:55 +0100
Message-ID: <20260128145351.282542187@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212595-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 689F2A5F7D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Egorenkov <egorenar@linux.ibm.com>

commit ddc6cbef3ef10359b5640b4ee810a520edc73586 upstream.

Since commit 3e86e4d74c04 ("kbuild: keep .modinfo section in
vmlinux.unstripped") the .modinfo section which has SHF_ALLOC ends up
in bzImage after the SecureBoot trailer. This breaks SecureBoot because
the bootloader can no longer find the SecureBoot trailer with kernel's
signature at the expected location in bzImage. To fix the bug,
move discarded sections before the ELF_DETAILS macro and discard
the .modinfo section which is not needed by the decompressor.

Fixes: 3e86e4d74c04 ("kbuild: keep .modinfo section in vmlinux.unstripped")
Cc: stable@vger.kernel.org
Suggested-by: Vasily Gorbik <gor@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/boot/vmlinux.lds.S |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/arch/s390/boot/vmlinux.lds.S
+++ b/arch/s390/boot/vmlinux.lds.S
@@ -137,6 +137,15 @@ SECTIONS
 	}
 	_end = .;
 
+	/* Sections to be discarded */
+	/DISCARD/ : {
+		COMMON_DISCARDS
+		*(.eh_frame)
+		*(*__ksymtab*)
+		*(___kcrctab*)
+		*(.modinfo)
+	}
+
 	DWARF_DEBUG
 	ELF_DETAILS
 
@@ -161,12 +170,4 @@ SECTIONS
 		*(.rela.*) *(.rela_*)
 	}
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
-
-	/* Sections to be discarded */
-	/DISCARD/ : {
-		COMMON_DISCARDS
-		*(.eh_frame)
-		*(*__ksymtab*)
-		*(___kcrctab*)
-	}
 }



