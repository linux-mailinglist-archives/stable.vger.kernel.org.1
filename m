Return-Path: <stable+bounces-214118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FZOCf1rg2l+mgMAu9opvQ
	(envelope-from <stable+bounces-214118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:55:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C07AE99C0
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E363313D580
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8A74218AB;
	Wed,  4 Feb 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kfftPWIh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09362DCF61;
	Wed,  4 Feb 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218625; cv=none; b=s6KHuc1T8c0/sc8xdHQT18lrnvEcCXlgpTYyzWGmf6t2Z5FC7l8b0ClhqHIfFysMr7N8KrQncIJAuXq6FIeRdD9DyqBgMUL/eI967HJWPTEF9i1LljeAU4f21Xp17ShJ0VoMQrfeSefQ9v6yM3aEWT2yNZm2QvZtWxeiszFk/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218625; c=relaxed/simple;
	bh=JWRe7HshgIyW0e3y624+sqzgEvfcHaiejpa7fax2gvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+ftJWHrJXbvCeoYEiqI4JpUc1UToOyUjHSF92XiL0qZNL4oNQIZG99U5W3jKMOEG28vE/r1em33M+msyEXjQPQ8pjGkKiAL50iXXvWwWCFp79txw1TzIlgBbG8cIEZsNDRIYqWrGgf0HGDEQ3IAPK4lRrK1hbgmzlcfWz1qHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kfftPWIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1D2C4CEF7;
	Wed,  4 Feb 2026 15:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770218625;
	bh=JWRe7HshgIyW0e3y624+sqzgEvfcHaiejpa7fax2gvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kfftPWIh17jQF+PT3Ve0ps2a3OWeLEqJDcohemoXdusZJ4Sn1204N+CSI83DtDHY+
	 /mqBrbAXs8ifWmSb6IuIJIckMvdZe0CA9ZInzDGwioEJU8kRIKPLguca3z1XyYVR7y
	 kNpCAriwxryaarKTksqNn09x1u0nfXXBoDOvBUqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jianpeng Chang <jianpeng.chang.cn@windriver.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 03/87] Bluetooth: MGMT: Fix memory leak in set_ssp_complete
Date: Wed,  4 Feb 2026 15:40:01 +0100
Message-ID: <20260204143847.035302881@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143846.906385641@linuxfoundation.org>
References: <20260204143846.906385641@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-214118-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:email,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,match.sk:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C07AE99C0
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>

[ Upstream commit 1b9c17fd0a7fdcbe69ec5d6fe8e50bc5ed7f01f2 ]

Fix memory leak in set_ssp_complete() where mgmt_pending_cmd structures
are not freed after being removed from the pending list.

Commit 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs") replaced
mgmt_pending_foreach() calls with individual command handling but missed
adding mgmt_pending_free() calls in both error and success paths of
set_ssp_complete(). Other completion functions like set_le_complete()
were fixed correctly in the same commit.

This causes a memory leak of the mgmt_pending_cmd structure and its
associated parameter data for each SSP command that completes.

Add the missing mgmt_pending_free(cmd) calls in both code paths to fix
the memory leak. Also fix the same issue in set_advertising_complete().

Fixes: 302a1f674c00 ("Bluetooth: MGMT: Fix possible UAFs")
Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/mgmt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6d21b641b0d14..4894e6444900a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1943,6 +1943,7 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 		}
 
 		mgmt_cmd_status(cmd->sk, cmd->hdev->id, cmd->opcode, mgmt_err);
+		mgmt_pending_free(cmd);
 		return;
 	}
 
@@ -1961,6 +1962,7 @@ static void set_ssp_complete(struct hci_dev *hdev, void *data, int err)
 		sock_put(match.sk);
 
 	hci_update_eir_sync(hdev);
+	mgmt_pending_free(cmd);
 }
 
 static int set_ssp_sync(struct hci_dev *hdev, void *data)
@@ -6455,6 +6457,7 @@ static void set_advertising_complete(struct hci_dev *hdev, void *data, int err)
 		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
 
 	settings_rsp(cmd, &match);
+	mgmt_pending_free(cmd);
 
 	new_settings(hdev, match.sk);
 
-- 
2.51.0




