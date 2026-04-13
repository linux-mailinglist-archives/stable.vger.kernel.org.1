Return-Path: <stable+bounces-237115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCe1Eswk3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:15:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 979233F112C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EF6931358AA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647ED30BF68;
	Mon, 13 Apr 2026 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qAAzaeB8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277CD1D5AD4;
	Mon, 13 Apr 2026 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098627; cv=none; b=E65z0k44sRMNGzYtyzji/G5avGp15uIwABugs8p3AnFetAiA2XzVFp6EWXGQxuhrZgT/KzecfMJOKLmWqBchyu3/wczt84YauEfHVZh5eGkuAgHDkWGM42aC8ZrwbjODN50afC1hpL5SRW1lz1r18g7YoDHUvgamMubirvc7ZeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098627; c=relaxed/simple;
	bh=q+vFSHHkMC7wCZWP3kQ/BcOndfjWZDP01SFipzYzNUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVUkL+xlQLYqV8tLY6SdtWL2p2zuiPxY3HAPIXnokjgwdMtIe/V2Usxc9y5yftlJlvkssIdQ2sxSuFbFRTRKo9G6XrsAqRrtlnscQm33r89Z0KPeAumQ7MgK6GeISKjhbNbtroi6HwjbU8k7KgH01yeilV5jB0+QU6+63FccP40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qAAzaeB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F90C2BCAF;
	Mon, 13 Apr 2026 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098627;
	bh=q+vFSHHkMC7wCZWP3kQ/BcOndfjWZDP01SFipzYzNUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAAzaeB89nf5T9VyVcn9ITYlZcv0rqZ7InzvM+1+TmO4pnVMhp3CiKoz/vBUGxGW0
	 KC7WFESwwZRuQkfuwE6lSXOa4e+4s2dnIvCNQfLKymGyS+DYCEVe5MF2P3Qzicvs+o
	 ID2gwEpQaPKfBv844bh4X8nwIuJB7gjlzColjO1A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-input@vger.kernel.org,
	stable <stable@kernel.org>
Subject: [PATCH 5.10 026/491] HID: Add HID_CLAIMED_INPUT guards in raw_event callbacks missing them
Date: Mon, 13 Apr 2026 17:54:31 +0200
Message-ID: <20260413155820.032099415@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237115-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,hadess.net:email]
X-Rspamd-Queue-Id: 979233F112C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit ecfa6f34492c493a9a1dc2900f3edeb01c79946b upstream.

In commit 2ff5baa9b527 ("HID: appleir: Fix potential NULL dereference at
raw event handle"), we handle the fact that raw event callbacks
can happen even for a HID device that has not been "claimed" causing a
crash if a broken device were attempted to be connected to the system.

Fix up the remaining in-tree HID drivers that forgot to add this same
check to resolve the same issue.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/hid-cmedia.c          |    2 +-
 drivers/hid/hid-creative-sb0540.c |    2 +-
 drivers/hid/hid-zydacron.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/hid/hid-cmedia.c
+++ b/drivers/hid/hid-cmedia.c
@@ -57,7 +57,7 @@ static int cmhid_raw_event(struct hid_de
 {
 	struct cmhid *cm = hid_get_drvdata(hid);
 
-	if (len != CM6533_JD_RAWEV_LEN)
+	if (len != CM6533_JD_RAWEV_LEN || !(hid->claimed & HID_CLAIMED_INPUT))
 		goto out;
 	if (memcmp(data+CM6533_JD_SFX_OFFSET, ji_sfx, sizeof(ji_sfx)))
 		goto out;
--- a/drivers/hid/hid-creative-sb0540.c
+++ b/drivers/hid/hid-creative-sb0540.c
@@ -153,7 +153,7 @@ static int creative_sb0540_raw_event(str
 	u64 code, main_code;
 	int key;
 
-	if (len != 6)
+	if (len != 6 || !(hid->claimed & HID_CLAIMED_INPUT))
 		return 0;
 
 	/* From daemons/hw_hiddev.c sb0540_rec() in lirc */
--- a/drivers/hid/hid-zydacron.c
+++ b/drivers/hid/hid-zydacron.c
@@ -114,7 +114,7 @@ static int zc_raw_event(struct hid_devic
 	unsigned key;
 	unsigned short index;
 
-	if (report->id == data[0]) {
+	if (report->id == data[0] && (hdev->claimed & HID_CLAIMED_INPUT)) {
 
 		/* break keys */
 		for (index = 0; index < 4; index++) {



