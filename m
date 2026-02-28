Return-Path: <stable+bounces-220467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qInVDFc4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B84341C6439
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E345D30D45EA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90FD3BF4D9;
	Sat, 28 Feb 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMXMp3b8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9753BF4D1;
	Sat, 28 Feb 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300354; cv=none; b=uVlzhzGxSoYzuX4hHF54EcEaZumntb71URk1ZiLmh7UrBs/yQqcAZc/wQyTqdoQ11tk1gIrOGe1W7PTaZ4/+xDrePEYjcNTKEloQxAjXkWVWdJedU1GADq734PVwd3XHmFL2dlYW/FpQAm67ehP4nLeEoqf6/md07L7QjHhMJyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300354; c=relaxed/simple;
	bh=8LXErPPlZk5EBBHZQDaSNda4uB89A0brGA4+ZkFQRVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DEMapXxTyvMeXrXsemssEsggoTqgvcVsmZ9VCIrwpwyS1TacpY3OEF0bM/B3fxUjNDHhonSsoFWqYT6NBVr5sNMR4eIw4BVwibreH8/jDUXeIiTAK11u8wG94VyStq+X+LyQQWg8x1r1lbtZKXmpVbnff+SIFMqvmm4tyOiJtx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMXMp3b8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3BCC19424;
	Sat, 28 Feb 2026 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300354;
	bh=8LXErPPlZk5EBBHZQDaSNda4uB89A0brGA4+ZkFQRVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mMXMp3b8N0YSHaFzRHX3YYPk+JM/YLHYB3gNtEMQTCH8f0QwWDLKJR+6zN+ix9L0I
	 /DiJl1r+rGev6lAZXi7lMDYhxtjeN/p+Nagisqm76sfGKM9KHQLEfpj1LXF4ihgpMv
	 rQ6cBvCbZNZmfWmo70j0u76g7SMmxIVtOgRL3GoyKrmpcvSNMLj9d/PMX5yJDm6r+g
	 UVSArZI2y9bhfCpgGusrGX7ZQ6SU75MGqHwrZgSaW3gFh5NECGb8M6jynnbTl0/yYc
	 YJmKEveP8qlzHksSrE12jeUfVcyovpHupchooRcQURiGBkZN4IjQzuebE73i2E281Q
	 8mO1hIOjCK5RA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Diksha Kumari <dikshakdevgan@gmail.com>,
	Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 388/844] staging: rtl8723bs: fix memory leak on failure path
Date: Sat, 28 Feb 2026 12:25:01 -0500
Message-ID: <20260228173244.1509663-389-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,linuxfoundation.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220467-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B84341C6439
X-Rspamd-Action: no action

From: Diksha Kumari <dikshakdevgan@gmail.com>

[ Upstream commit abe850d82c8cb72d28700673678724e779b1826e ]

cfg80211_inform_bss_frame() may return NULL on failure. In that case,
the allocated buffer 'buf' is not freed and the function returns early,
leading to potential memory leak.
Fix this by ensuring that 'buf' is freed on both success and failure paths.

Signed-off-by: Diksha Kumari <dikshakdevgan@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
Link: https://patch.msgid.link/20260113091712.7071-1-dikshakdevgan@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 60edeae1cffe7..476ab055e53e5 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -315,9 +315,10 @@ struct cfg80211_bss *rtw_cfg80211_inform_bss(struct adapter *padapter, struct wl
 					len, notify_signal, GFP_ATOMIC);
 
 	if (unlikely(!bss))
-		goto exit;
+		goto free_buf;
 
 	cfg80211_put_bss(wiphy, bss);
+free_buf:
 	kfree(buf);
 
 exit:
-- 
2.51.0


