Return-Path: <stable+bounces-246576-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCyWL89vA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246576-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:22:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 423305276CB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C990830C380C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA836C5A1;
	Tue, 12 May 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IhcbP/ae"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53835284883;
	Tue, 12 May 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609579; cv=none; b=GAaKc0f3r5t8AmmB96d8zlJm4r6z46TbtyS5skD4lxfJ8EtTL4A6GxHXAc/bFcu+u4hRp4hIy3KJEc1R/W6O0HIwgWINo00SZNC6QjbIA0QQbGOCK1C9Xe0+KpHk1uKnfKlBuxGxf5oIiDukFPBYxpufO5gjMuuoQiLYD1ZuM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609579; c=relaxed/simple;
	bh=CFcGdLiCIYvd+kBpLpk1/9GN3zWqb26CqFiWeamJ2UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrV0BcrLUA5oQsVFLD9A6BcS+flsb5257PSfYfE2df80YYv6OY6LvpCFETjrdC0D1at/oXDRNuy8uGpPIV70nmgyRhzhr2v/xs5QAJvnZYeP3sCra4RyloKb5Gpdj093GFhQ99z/4NyGF2be5s0EuhaTBQbVJIDz/OpNwkXxYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IhcbP/ae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF83C2BCB0;
	Tue, 12 May 2026 18:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609579;
	bh=CFcGdLiCIYvd+kBpLpk1/9GN3zWqb26CqFiWeamJ2UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IhcbP/aeP84vJwILYWL/y4Saa/h6dfxEq9nSqvfV9P90LalcsH/aOpH2k4vU0S4mI
	 gfXLW9dmSUpUPCWvEFKBk5CL4N/fTXQt+5t3QVBVRzI/LnYAtPf8or1RGdo0N62YeX
	 uUQV74v+0iIBjLQYYjwXhIgOfc33SBj1lqjDh3Fg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 7.0 208/307] s390/debug: Reject zero-length input in debug_input_flush_fn()
Date: Tue, 12 May 2026 19:40:03 +0200
Message-ID: <20260512173944.507846258@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 423305276CB
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
	TAGGED_FROM(0.00)[bounces-246576-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

commit e14622a7584f9608927c59a7d6ae4a0999dc545e upstream.

debug_input_flush_fn() always copies one byte from the userspace buffer
with copy_from_user() regardless of the supplied write length. A
zero-length write therefore reads one byte beyond the caller's buffer.
If the stale byte happens to be '-' or a digit the debug log is
silently flushed. With an unmapped buffer the call returns -EFAULT.

Reject zero-length writes before copying from userspace.

Cc: stable@vger.kernel.org # v5.10+
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/debug.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1584,6 +1584,11 @@ static int debug_input_flush_fn(debug_in
 	char input_buf[1];
 	int rc = user_len;
 
+	if (!user_len) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	if (user_len > 0x10000)
 		user_len = 0x10000;
 	if (*offset != 0) {



