Return-Path: <stable+bounces-234347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ2tMwKf1mkLGwgAu9opvQ
	(envelope-from <stable+bounces-234347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:31:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E26B3C0DD8
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD9B314108F
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E566FB67E;
	Wed,  8 Apr 2026 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QJsbfUqZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D693D75AF;
	Wed,  8 Apr 2026 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672623; cv=none; b=W7nNxVYVb8nsf1msFKf3tgx0tnrw0CjX2XeJ237EMlhnMD+ZRXr69eKj8Ij2xuG5NMiIsIBeYoLlXxv2Tt9D1MNq6dvEdV3xn3IdRCZKK4ZgJOwCYIBoZ+0qR0Yori/4i0chp9JR0WbT+MC55AF5pH5I5ZzgJUvK/t9CkcJyOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672623; c=relaxed/simple;
	bh=uNHttedLXi5ZVhlwr8yzmJ5I0mPc5zLHwPURtjjlMs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3nDm6J7qA2VKS2P5KmdvY2bGNbJH79cfgnvmffIms4ZCdvjQvgF254+aF5c8QdAsfyzDebVe5y2oNq1vChE86Ft0BPQ5oXDxWEKQjgKt1/1yaNjUfNHHgW0/p8ddxTru3kq5Dcr53KBRbamS3JZ3BJEzplwKs0LYIkF626gHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QJsbfUqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403BAC19421;
	Wed,  8 Apr 2026 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672623;
	bh=uNHttedLXi5ZVhlwr8yzmJ5I0mPc5zLHwPURtjjlMs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QJsbfUqZMcv1V93C/Bzj522RtrrqY+6QTytjxqLlBLS+xJa276tcb/kvI2YVdWV9l
	 7auzd2wZFhYiNPcEfEAHJADy3r5w9OtJOcQInty93ezIk6+Ub/6LurhWXMk1f7JuzB
	 AWuLWP2/OdjYeoGRVooVGOm+RU0V0q0cBSpmeipA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleh Konko <security@1seal.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.6 079/160] Bluetooth: SMP: derive legacy responder STK authentication from MITM state
Date: Wed,  8 Apr 2026 20:02:46 +0200
Message-ID: <20260408175916.145594162@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234347-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,1seal.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5E26B3C0DD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleh Konko <security@1seal.org>

commit 20756fec2f0108cb88e815941f1ffff88dc286fe upstream.

The legacy responder path in smp_random() currently labels the stored
STK as authenticated whenever pending_sec_level is BT_SECURITY_HIGH.
That reflects what the local service requested, not what the pairing
flow actually achieved.

For Just Works/Confirm legacy pairing, SMP_FLAG_MITM_AUTH stays clear
and the resulting STK should remain unauthenticated even if the local
side requested HIGH security. Use the established MITM state when
storing the responder STK so the key metadata matches the pairing result.

This also keeps the legacy path aligned with the Secure Connections code,
which already treats JUST_WORKS/JUST_CFM as unauthenticated.

Fixes: fff3490f4781 ("Bluetooth: Fix setting correct authentication information for SMP STK")
Cc: stable@vger.kernel.org
Signed-off-by: Oleh Konko <security@1seal.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/smp.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1019,10 +1019,7 @@ static u8 smp_random(struct smp_chan *sm
 
 		smp_s1(smp->tk, smp->prnd, smp->rrnd, stk);
 
-		if (hcon->pending_sec_level == BT_SECURITY_HIGH)
-			auth = 1;
-		else
-			auth = 0;
+		auth = test_bit(SMP_FLAG_MITM_AUTH, &smp->flags) ? 1 : 0;
 
 		/* Even though there's no _RESPONDER suffix this is the
 		 * responder STK we're adding for later lookup (the initiator



