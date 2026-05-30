Return-Path: <stable+bounces-257851-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENDmEFUfG2qu/QgAu9opvQ
	(envelope-from <stable+bounces-257851-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:33:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7BD60FE5F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4550F301220A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179D33A9DA;
	Sat, 30 May 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lvk/D7wy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39207341AB8;
	Sat, 30 May 2026 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162385; cv=none; b=RrvIM4szBxtaTL847RP2zvjqYvVRnB7EU0/+7EiQ1xn2QJ13gVcqjXq6hEhtpMVpUKN5aXIF4stBjYnULyA9UnoaJaLr9WwIFBKtASF0fiD1qeXMsSw1bsQ7uruK62nf/W6M4amGNlesRnjzmCNkLoc2YhlumnWTPS9j9q92yB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162385; c=relaxed/simple;
	bh=GI88SGU3UYzzfEFcOAUC6ma7KVFuY1wZagn/0InZwtc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=orBSR7045VTebntnVFlLufX2iCug5/dE4A/DOjqX7brNPYLaDoozOSjvrlXYDD5XbSl5G6JPJ2ooFEtHhLVLGdz3Tl91b7lrb0LoaIERb7Pyey4em6bcq6bTBKshD9dC7ffQed00ni5wfxqX/W9qJ1tLxLVWtNiY8y/h02+gEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lvk/D7wy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4381F00893;
	Sat, 30 May 2026 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162384;
	bh=FrxV5NZ9+xQhxqLUpO2GoAi0EK7cHzxNU6TaNP2gskA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lvk/D7wy9/vfPd6ymqTwS7XBfj8++rQjHNKFxeF767dGAQA9zSj4kdp6kGgde99p7
	 7zz3aF9PCQklhSyXJPiASn5gFTMX5dSeSb5803/SgafImGZowptBi6/z7KdqhGXrL0
	 zZqJtQxCrICPJ8fY3uqv8MwoNiv1Fk9W7P35QtfQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Marc Zyngier <maz@kernel.org>
Subject: [PATCH 6.1 866/969] KVM: arm64: vgic-its: Reject restored DTE with out-of-range num_eventid_bits
Date: Sat, 30 May 2026 18:06:30 +0200
Message-ID: <20260530160324.591829272@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-257851-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: EF7BD60FE5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Bommarito <michael.bommarito@gmail.com>

commit 9ce754ed8e7ab4e3999767ce1505f85c449ccb07 upstream.

Userspace can restore an ITS Device Table Entry whose Size field encodes
more EventID bits than the virtual ITS supports.  The live MAPD path
rejects that state, but vgic_its_restore_dte() accepts it and stores the
out-of-range value in dev->num_eventid_bits.

Reject restored DTEs with num_eventid_bits > VITS_TYPER_IDBITS before
allocating the device.  This mirrors the MAPD check and prevents the
restored state from reaching vgic_its_restore_itt(), where the unchecked
value can be converted into an oversized scan_its_table() range.

Fixes: 57a9a117154c ("KVM: arm64: vgic-its: Device table save/restore")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Link: https://lore.kernel.org/r/20260519132519.2142458-1-michael.bommarito@gmail.com
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kvm/vgic/vgic-its.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2413,6 +2413,10 @@ static int vgic_its_restore_dte(struct v
 	/* dte entry is valid */
 	offset = (entry & KVM_ITS_DTE_NEXT_MASK) >> KVM_ITS_DTE_NEXT_SHIFT;
 
+	/* Mimic the MAPD behaviour and reject invalid EID bits. */
+	if (num_eventid_bits > VITS_TYPER_IDBITS)
+		return -EINVAL;
+
 	if (!vgic_its_check_id(its, baser, id, NULL))
 		return -EINVAL;
 



