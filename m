Return-Path: <stable+bounces-254870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PaJMFkrGGrneggAu9opvQ
	(envelope-from <stable+bounces-254870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:47:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 406515F181B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 13:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A46131419F5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 11:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053173E274E;
	Thu, 28 May 2026 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="olO4rdh1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994A3E5560
	for <stable@vger.kernel.org>; Thu, 28 May 2026 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968512; cv=none; b=ciCbmG+KV1BNFH3rzp7ggglQhMAyIK+AKjd66nkHcx//k0P0+6J3Bfaoloum7g4epq61r+k0Y5q6bprx6m5pjUAHk+hUuxs0fFREkT1fh8mQpF1wSvV/IK1pXSt2WM5sq+DkzQKc+ZrYsxIh6o18IR4wKpzXz9mDgR8j+5220Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968512; c=relaxed/simple;
	bh=db0KnqkhvAnPXg7h5oV2/5Hba5fc5Og3S6TA5ANW4as=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L0MZcNaaZv7tk7zNWXq04HmnCwb89xyVodtC4YPvC8rlaxLn0VSYmPbcIsE9ItkD7zagxGEdiLaN/0gB0o6gcdSYjZdOGeSqUgKhxHopXam/6OzIC6/QMJqCzEUfczlPiRIw+9px9omwohdJ2gRNrqE+fjfXwlfafgNWTjVu+Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=olO4rdh1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F571F000E9;
	Thu, 28 May 2026 11:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779968511;
	bh=FTS4voF35pkUNJ8VvY0AcJOKZkNozOW4SB5igb0wGNo=;
	h=Subject:To:Cc:From:Date;
	b=olO4rdh1gdCggQgn5qqd1w8lyzuhKzt10x8qMEOR2qG1htKyd9WXkY1ue6F+teBtJ
	 90BYe+9JQ2/q2gQu6VoeoD1W/E4xDGyeZuzwRZFjsHsgqhDKailhPBFe+n89Ss3dTh
	 U9/Uw38cic8mk2FCI7x/NbEwBSdDj4AryqzQ60Uk=
Subject: FAILED: patch "[PATCH] KVM: arm64: vgic-its: Reject restored DTE with out-of-range" failed to apply to 5.10-stable tree
To: michael.bommarito@gmail.com,maz@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 13:40:55 +0200
Message-ID: <2026052855-rockstar-desktop-e9e5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254870-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 406515F181B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9ce754ed8e7ab4e3999767ce1505f85c449ccb07
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052855-rockstar-desktop-e9e5@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9ce754ed8e7ab4e3999767ce1505f85c449ccb07 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Tue, 19 May 2026 09:25:19 -0400
Subject: [PATCH] KVM: arm64: vgic-its: Reject restored DTE with out-of-range
 num_eventid_bits

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

diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 2ea9f1c7ebcd..1d7e5d560af4 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -2307,6 +2307,10 @@ static int vgic_its_restore_dte(struct vgic_its *its, u32 id,
 	/* dte entry is valid */
 	offset = (entry & KVM_ITS_DTE_NEXT_MASK) >> KVM_ITS_DTE_NEXT_SHIFT;
 
+	/* Mimic the MAPD behaviour and reject invalid EID bits. */
+	if (num_eventid_bits > VITS_TYPER_IDBITS)
+		return -EINVAL;
+
 	if (!vgic_its_check_id(its, baser, id, NULL))
 		return -EINVAL;
 


