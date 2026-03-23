Return-Path: <stable+bounces-228902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IxvApRWwWmBSQQAu9opvQ
	(envelope-from <stable+bounces-228902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:04:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 733A02F5B9A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BBC33059E82
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526013B19A2;
	Mon, 23 Mar 2026 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jugzse0J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134C83AF650;
	Mon, 23 Mar 2026 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277443; cv=none; b=htJnN0aAoB2aqpNB0Ga8DlKTojKoY5A5/7uKvGE1nHt5DLPiCzArsTGuWr7SRB8U88b0Thjq5fABPjsErg3xCK4yEBq9PF+u7DigYzI639pKE9rQzg9MAVzpJJ/g8HnZXtWVVJOKXhabhaEYnf/YzIhHSxlyKBs4ot3cjEIa08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277443; c=relaxed/simple;
	bh=Dpg/Mimszz3S+GEdyopoZRBhDuRRcehKKhltk3Ckr6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA6MRXdsvgySIAx8oaPxVVS9b8Za5UeoBxMfFWkvE58hVYpjpZtkt6dteunwU3RyYd8aAejMMVf7dlOylm2RN+nkOEnb6F/sgrGNVa0iPn1x7oWqMLa/41b0y0vlKrLSFX4GfRyhK9053t6tRZ6Xf6sT34lOm9w5qZHSwTvVOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jugzse0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C9BC4CEF7;
	Mon, 23 Mar 2026 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277442;
	bh=Dpg/Mimszz3S+GEdyopoZRBhDuRRcehKKhltk3Ckr6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jugzse0Ji6rdBOJIsUsEQA29uy9gVJxE10HZUGhRY4Juc310M+2yAJmJiJqZkxjSw
	 IbLc3Dreb5P/M5oHv4208kp4VZb9I5zNziI8RnDGKoCCKtAMX5V6W5HDx+LF5L6qnG
	 P5KeLkzUpW5O5eWh/G5GMOXdjH93b+ft7jHa9XXI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Meyer <kyle.meyer@hpe.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Steve Wahl <steve.wahl@hpe.com>
Subject: [PATCH 6.12 442/460] x86/platform/uv: Handle deconfigured sockets
Date: Mon, 23 Mar 2026 14:47:18 +0100
Message-ID: <20260323134537.441852380@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228902-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 733A02F5B9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Meyer <kyle.meyer@hpe.com>

commit 1f6aa5bbf1d0f81a8a2aafc16136e7dd9a609ff3 upstream.

When a socket is deconfigured, it's mapped to SOCK_EMPTY (0xffff). This causes
a panic while allocating UV hub info structures.

Fix this by using NUMA_NO_NODE, allowing UV hub info structures to be
allocated on valid nodes.

Fixes: 8a50c5851927 ("x86/platform/uv: UV support for sub-NUMA clustering")
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/ab2BmGL0ehVkkjKk@hpe.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1708,8 +1708,22 @@ static void __init uv_system_init_hub(vo
 		struct uv_hub_info_s *new_hub;
 
 		/* Allocate & fill new per hub info list */
-		new_hub = (bid == 0) ?  &uv_hub_info_node0
-			: kzalloc_node(bytes, GFP_KERNEL, uv_blade_to_node(bid));
+		if (bid == 0) {
+			new_hub = &uv_hub_info_node0;
+		} else {
+			int nid;
+
+			/*
+			 * Deconfigured sockets are mapped to SOCK_EMPTY. Use
+			 * NUMA_NO_NODE to allocate on a valid node.
+			 */
+			nid = uv_blade_to_node(bid);
+			if (nid == SOCK_EMPTY)
+				nid = NUMA_NO_NODE;
+
+			new_hub = kzalloc_node(bytes, GFP_KERNEL, nid);
+		}
+
 		if (WARN_ON_ONCE(!new_hub)) {
 			/* do not kfree() bid 0, which is statically allocated */
 			while (--bid > 0)



