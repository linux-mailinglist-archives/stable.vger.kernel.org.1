Return-Path: <stable+bounces-231672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAKsDzf+y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:02:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B4736DB71
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2270631243E9
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F2425CEE;
	Tue, 31 Mar 2026 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s/KGvX4D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEAE3F23DD;
	Tue, 31 Mar 2026 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974770; cv=none; b=Hrjs0Mg8jlNWBbg7o+f7e9q13lEP4LgXgwTa6Fzax2XdmoErWhAQ1o7ipgiIive5/2BCJZxQML/E5xUqnP1vcaU02XXzzOAbc6pxdBRohDw+FwS/OkRd0E9fg5kDggwdBhLrifxaTyNjIMAVUL+Kx0toiInXdntw2t3v2inoko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974770; c=relaxed/simple;
	bh=lolrRmHXvOImeMEg6ER8DkTxeAq2N3rtfi0TDpyK9GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1gascfziwa+0cZSB/MSNrDY4bwK5F3NMIjIaZYAPIV30JCfdr+UGaeM8wEOSRdz0Smkw/yAKVCoqQLd2HynMAfRIbiHmPl1OmDv2piPaC4+x0GEqaSLC5gmVPnz5rr4wa350maSGzJtdhdP3cZiTt8siY5yG6x3S6dYUPkA/yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s/KGvX4D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661E0C19423;
	Tue, 31 Mar 2026 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774974770;
	bh=lolrRmHXvOImeMEg6ER8DkTxeAq2N3rtfi0TDpyK9GA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/KGvX4DqeH8pBH7Ck10LtlwXreEQP9vhQ6ds/KmMrCYHmR++14mB6ono5k26uTO2
	 vwYLoKKvFXqaZwdrUoXSbU4ZMLhFIH6KMGKZgiWbWWMT4vT4p3ghGruNd4OsMKkSdf
	 kc5gGIoVRaQscMZVCLcygIkB0QSELiQsvJ/ju9j0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 037/342] HID: apple: Add EPOMAKER TH87 to the non-apple keyboards list
Date: Tue, 31 Mar 2026 18:17:50 +0200
Message-ID: <20260331161800.270240890@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-231672-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.de:email]
X-Rspamd-Queue-Id: 49B4736DB71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 7c698de0dc5daa1e1a5fd1f0c6aa1b6bb2f5d867 ]

EPOMAKER TH87 has the very same ID as Apple Aluminum keyboard
(05ac:024f) although it doesn't work as expected in compatible way.

Put three entries to the non-apple keyboards list to exclude this
device: one for BT ("TH87"), one for USB ("HFD Epomaker TH87") and one
for dongle ("2.4G Wireless Receiver").

Link: https://bugzilla.suse.com/show_bug.cgi?id=1258455
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-apple.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 233e367cce1d1..2f9a2e07c4263 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -365,6 +365,9 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "A3R" },
 	{ "hfd.cn" },
 	{ "WKB603" },
+	{ "TH87" },			/* EPOMAKER TH87 BT mode */
+	{ "HFD Epomaker TH87" },	/* EPOMAKER TH87 USB mode */
+	{ "2.4G Wireless Receiver" },	/* EPOMAKER TH87 dongle */
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
-- 
2.51.0




