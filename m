Return-Path: <stable+bounces-246084-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AdqLzFrA2rf5gEAu9opvQ
	(envelope-from <stable+bounces-246084-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:02:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75852693A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB54030A2BC1
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F843BB110;
	Tue, 12 May 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rWHVDMlA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18A93EDE4E;
	Tue, 12 May 2026 17:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608317; cv=none; b=oKfZ23KvpVhIqkeQZPPXSGf79POEe9oIMocZeIxvSKdGK0UwvwMiRfZ/cZ37xpTFSO0YeCu9/MLjeE73yUuvIP3Ts4aGgja96l9xguO1ChlK30F35TlOcYXjt3/3JdQbXNyAsolbRJYmZ1Anv2rwAVPM4K35QcIZM+Oo7wd8Cuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608317; c=relaxed/simple;
	bh=Yti/0XRfdvxvrg/8tHZXLaEq0+pcYUYzctLDOYc6P+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaGsVS6/jhlh+d3iuVihCOXLQQ/qnotzu0BQLDqFsaD0N4A2WvY39J/mUbzmqoG+kCj0Ketzad8za+mskAWdCoMuavHmcTRp6j8wzfi4WHvRj13icEKt8TbH732cFGiuF8H02wUUVsy0F011V7zRnlYBafkiHEDzB54Y9TGzvMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rWHVDMlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2E6C2BCC7;
	Tue, 12 May 2026 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608316;
	bh=Yti/0XRfdvxvrg/8tHZXLaEq0+pcYUYzctLDOYc6P+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWHVDMlAKK4Q0fHgeDVYkK5Ju/HoDwvyQD39eQkUbHl9mx5uoIRvdZGMoQx9acRC+
	 SntAKuK1ZLsXvySHfjh20cyeGL4ZDMk7yILUBl+rMTr/PvyMCjEv3Wh3AeHYQ4fifV
	 mezfu+W2tDnQ3RCRgkNOujlbhRKs5JHhjYtie+zs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.18 004/270] ipmi:si: Return state to normal if message allocation fails
Date: Tue, 12 May 2026 19:36:45 +0200
Message-ID: <20260512173938.547767193@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3A75852693A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246084-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[minyard.net:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -498,15 +498,19 @@ retry:
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



