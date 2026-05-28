Return-Path: <stable+bounces-254756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LWKHrP1F2ofXggAu9opvQ
	(envelope-from <stable+bounces-254756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:58:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E71905EE27F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 09:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1CE31443A6
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 07:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D9532ED3A;
	Thu, 28 May 2026 07:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EeOgG1w1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79D3176EE
	for <stable@vger.kernel.org>; Thu, 28 May 2026 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954801; cv=none; b=pwxKy0euItRf0n7zmr647WGnW3vFVde+CYHJ3U0pEvCK51hJ6P2tNqS5eX9v+6hVp9r6+XRqTLbOvPCAZcl0q7fmfOfqkZczPeKIU0F4NjJi2tLpXmHQ9Btm9gEv7mc1Ml/JH93VTYLgp3KhVrxRhHfa8bwg3nJGuzty/Ta2gIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954801; c=relaxed/simple;
	bh=7xioVfUHSTVEzQzFwGFxXN3ebhqz2JunZecErObvBsM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RtdPe/U7nt17q47f2au7jiilGkw5dQURpE1nVZ6qIzh74mOWAxVnL9WWwFcu7VxsgRP/E7nfk8ybWNwE60GjsBJb0iwWMtSA1tgvyaYBC3gB5W3rhidPyECx7HhbBSRgxWnCUSQ0zzR37VFwBXbCYiEmdGQAhb9EkT0+EyOqbm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EeOgG1w1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F991F000E9;
	Thu, 28 May 2026 07:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779954800;
	bh=IsWKNHZBmki/OYcp4c6TxiQxwuFvtu0zlslgf4bKeXM=;
	h=Subject:To:Cc:From:Date;
	b=EeOgG1w1NkgBM8aCgdBVsjgohhwCMGUEHJH/gzXppYIWNA/h2BWdChabG3O9PhfOW
	 csksgVAtjF2FDLX2OakwSkVpRB3gCdTBils5Tv08JxOw39OAuxOlJ+dRkCy2adl5tt
	 5VdYw36+aJzqGhs0csvIOixJa0KuTjkYtUap+xyg=
Subject: FAILED: patch "[PATCH] Bluetooth: MGMT: validate Add Extended Advertising Data" failed to apply to 5.15-stable tree
To: michael.bommarito@gmail.com,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 28 May 2026 09:52:18 +0200
Message-ID: <2026052818-stubble-amigo-9213@gregkh>
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
	TAGGED_FROM(0.00)[bounces-254756-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,gregkh:email]
X-Rspamd-Queue-Id: E71905EE27F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d3f7d17960ed50df3a6709c5158caff989c8c905
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052818-stubble-amigo-9213@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d3f7d17960ed50df3a6709c5158caff989c8c905 Mon Sep 17 00:00:00 2001
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 15 May 2026 10:38:19 -0400
Subject: [PATCH] Bluetooth: MGMT: validate Add Extended Advertising Data
 length

MGMT_OP_ADD_EXT_ADV_DATA is registered as a variable-length command,
with MGMT_ADD_EXT_ADV_DATA_SIZE as the fixed header size.  The handler
then uses cp->adv_data_len and cp->scan_rsp_len to validate and copy
cp->data, but it never checks that those bytes are part of the mgmt
command payload.

A short command can therefore make add_ext_adv_data() pass an
out-of-bounds pointer into tlv_data_is_valid().  If the bytes beyond
the command buffer are addressable, they can also be copied into the
advertising instance as scan response data, where the caller can read
them back via MGMT_OP_GET_ADV_INSTANCE.  The trigger requires
CAP_NET_ADMIN in the initial user namespace; KASAN reports an 8-byte
slab-out-of-bounds read.

Reject commands whose length does not match the fixed header plus both
advertising data lengths before parsing cp->data.

Fixes: 12410572833a ("Bluetooth: Break add adv into two mgmt commands")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b05bb380e5f8..de5bd6b637b2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -9110,9 +9110,15 @@ static int add_ext_adv_data(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct adv_info *adv_instance;
 	int err = 0;
 	struct mgmt_pending_cmd *cmd;
+	u16 expected_len;
 
 	BT_DBG("%s", hdev->name);
 
+	expected_len = struct_size(cp, data, cp->adv_data_len + cp->scan_rsp_len);
+	if (expected_len != data_len)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_EXT_ADV_DATA,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	adv_instance = hci_find_adv_instance(hdev, cp->instance);


