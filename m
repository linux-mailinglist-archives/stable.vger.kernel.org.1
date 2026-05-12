Return-Path: <stable+bounces-246348-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KtuDtJrA2of5wEAu9opvQ
	(envelope-from <stable+bounces-246348-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BEE526B22
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D620306E4E9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB922D060B;
	Tue, 12 May 2026 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wxTLLzzF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DA13EDE41;
	Tue, 12 May 2026 18:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608994; cv=none; b=Jx0DDyBd08z4ZguhV9qbPr+C5JmdwyZLLQaiqg9io378gk6TbVU9wnGT6rrEopBJIbBiK1J+l9kIDPhpsaA7T31nE/YZoIQO1C7DuUBB8lkiHngIjajjTnge0cw5Wg1tuVfzGz88DRFxsr1GcnQ9qEgVoiPOLdjGDbcecIokptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608994; c=relaxed/simple;
	bh=pDYkTDJGhEozPCFRbsZXjgH2v/BdX6WdwqB81A60nrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nf3fSa85SpbHN7gbkvdukNkPnt1/0NhrOABuf/oxss6S4hCd2VKRw9GoSa9UahnqjwbJZuig2bw8T+JcKNDOcrYd4ygLh0OuFIuUVX6gPpYQaBFFU+IrYx98wMtARRvoeAJOfEWunMv7XpB3BPJEYT/oyJPYgB0o1mcgj26Nxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wxTLLzzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEB6C2BCB0;
	Tue, 12 May 2026 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608994;
	bh=pDYkTDJGhEozPCFRbsZXjgH2v/BdX6WdwqB81A60nrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wxTLLzzF+xPoFGW3zQ7TgGoiHfAQ9kB2oDZoLBz5SicB1rmMKxqBpDubb6E5mqgP0
	 Pmp4sECzs1RvMHbiPCQ/fj3omE7jR/tbbD3Oz1axKktPeUDuTPeE/LJ0qHNEOqwLqR
	 t5R4lLzgqcy9H8AH3S4G3DXL3A0o48j0cJ0QDzyM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 7.0 004/307] ipmi:si: Return state to normal if message allocation fails
Date: Tue, 12 May 2026 19:36:39 +0200
Message-ID: <20260512173940.214354977@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 15BEE526B22
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246348-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <corey@minyard.net>

commit 09dd798270ff582d7309f285d4aaf5dbebae01cb upstream.

There were places where nothing would get started if a message
allocation failed, so the driver needs to return to normal state.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_si_intf.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -497,15 +497,19 @@ retry:
 	} else if (smi_info->msg_flags & RECEIVE_MSG_AVAIL) {
 		/* Messages available. */
 		smi_info->curr_msg = alloc_msg_handle_irq(smi_info);
-		if (!smi_info->curr_msg)
+		if (!smi_info->curr_msg) {
+			smi_info->si_state = SI_NORMAL;
 			return;
+		}
 
 		start_getting_msg_queue(smi_info);
 	} else if (smi_info->msg_flags & EVENT_MSG_BUFFER_FULL) {
 		/* Events available. */
 		smi_info->curr_msg = alloc_msg_handle_irq(smi_info);
-		if (!smi_info->curr_msg)
+		if (!smi_info->curr_msg) {
+			smi_info->si_state = SI_NORMAL;
 			return;
+		}
 
 		start_getting_events(smi_info);
 	} else if (smi_info->msg_flags & OEM_DATA_AVAIL &&



