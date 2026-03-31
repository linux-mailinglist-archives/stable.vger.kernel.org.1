Return-Path: <stable+bounces-232311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDKoF5j/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-232311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6CD36DF7A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6BC5230E3C01
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6872D73AD;
	Tue, 31 Mar 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t4SlnOQV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EAA2D0C94;
	Tue, 31 Mar 2026 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976422; cv=none; b=i2FEBfQQEXpsHF2pqclSP/8uuYvAUmDH1LXcGJ1zpGM3l4uTc7LHExwAAveuaCyBaC/Bc+8WW78fgTc/i+A8sxT74FtyXD6MTH7vjezgLknGUIKLTLqmWjOKL3Wxpmrwsnok9zZ8dWqzIfxpEsZjT22c2muWECGfgXLW1RP60hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976422; c=relaxed/simple;
	bh=CKkO1HYE2wf/UTaoNItdaWQN/aUrz4/xYyoKIjVMsFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5wrzF6KFyER8vhczuJccG6h9QkEom/kbUvhEqyQfEievx+8Gzm3LW7zvA/quEJ1DYzihPTdOYUqB+qRw/A2fBBSlXME2zoG0W7i4a0ayhy8nULGwDA61KZ9ssAU4C1WSjs875rSwbGuoVBzKi5GjrqfTIRZDQhEUysQ25vqKSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t4SlnOQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DE9C19423;
	Tue, 31 Mar 2026 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976422;
	bh=CKkO1HYE2wf/UTaoNItdaWQN/aUrz4/xYyoKIjVMsFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4SlnOQVRLr89sxc2RJz9Ocp8NtKLk7ixPjL6JoEvBF8rlpSf2mgkXL7LvTqpu0zq
	 5cmiDwEtUAmgfNOu+d7V8HHVxK/HGcBgxq3DGatzNMkhpp6nunNvsNU35bx4SbWB/v
	 7Aekn82eY+kiRSeAus+FMMUgzf71+ROBAzUtnDyg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Anas Iqbal <mohd.abd.6602@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 086/309] Bluetooth: hci_ll: Fix firmware leak on error path
Date: Tue, 31 Mar 2026 18:19:49 +0200
Message-ID: <20260331161756.650255229@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-232311-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,molgen.mpg.de,gmail.com,intel.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: EB6CD36DF7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anas Iqbal <mohd.abd.6602@gmail.com>

[ Upstream commit 31148a7be723aa9f2e8fbd62424825ab8d577973 ]

Smatch reports:

drivers/bluetooth/hci_ll.c:587 download_firmware() warn:
'fw' from request_firmware() not released on lines: 544.

In download_firmware(), if request_firmware() succeeds but the returned
firmware content is invalid (no data or zero size), the function returns
without releasing the firmware, resulting in a resource leak.

Fix this by calling release_firmware() before returning when
request_firmware() succeeded but the firmware content is invalid.

Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_ll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 6f4e25917b863..c4584f4085766 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -541,6 +541,8 @@ static int download_firmware(struct ll_device *lldev)
 	if (err || !fw->data || !fw->size) {
 		bt_dev_err(lldev->hu.hdev, "request_firmware failed(errno %d) for %s",
 			   err, bts_scr_name);
+		if (!err)
+			release_firmware(fw);
 		return -EINVAL;
 	}
 	ptr = (void *)fw->data;
-- 
2.51.0




