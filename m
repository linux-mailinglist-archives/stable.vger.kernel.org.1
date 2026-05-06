Return-Path: <stable+bounces-244355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBdBGKwL+2mbVQMAu9opvQ
	(envelope-from <stable+bounces-244355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:36:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186C4D8B4E
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 11:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 131733054304
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 09:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB073E559E;
	Wed,  6 May 2026 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Iu5v3UIw"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0811530AD0C;
	Wed,  6 May 2026 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060068; cv=none; b=gCzW++2WHKl4trnEe/gj7a9ciJKSmfX+r7KnRoBjoxsI4Vpr7yzUwaAJ2mY0V77bv+lRXaa2k0d/mNGiWVpYZDSnODc0ZXeqfSZlpExM3xV0qv4/k6Y3FyNloDNvghkp2AaO0nohLeF48yE/BikmSB0mDHjlKMk/LYWLHz2BJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060068; c=relaxed/simple;
	bh=2SbNXowNHpvWPIiCfe401PTzplou7NoVrJmAVIt+aLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AShyAuCx7ejrxbGBvxpA8keHW92UrrPGGx6E2aiSNC95Um3LVje+tba2pfR4q8jv6E47uamINJSiYaN6LZLN+vljjGS2PrNU0/h9p9LkxGkGoXqXPK//brybG24+3+ismvLPvFwVOkIsOdU/uE4zPgcjYW9cUjaJiGvHPIiNGsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Iu5v3UIw; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778060028;
	bh=J6oht+sP+4WEJo5bT3rgLuTOd0k0qN1hF4d444/Uq0M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Iu5v3UIwJj2djy39Jo2xusG+OkuEizNvrTJKcm5u4VftHOpQauGifCdtagFPoaGPE
	 a5Xu2iQsxv876ad3X05Hvw5T8FuEsLorcfvRLk5/zyuiRk4dGlbAc2+bybWlPaiXqS
	 98Xd1w66Vp0IpWqD5QRfjbAf/BIqU8f8vWjpjaLg=
X-QQ-mid: zesmtpip4t1778060010t49f08edb
X-QQ-Originating-IP: axCIc/X3jw/VG1gBCJ6Fy/52PHOb782UTf1Pg4xqLek=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 06 May 2026 17:33:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18334382572935874406
EX-QQ-RecipientCnt: 7
From: Wentao Guan <guanwentao@uniontech.com>
To: oneukum@suse.com
Cc: carvsdriver@gmail.com,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH RFC] USB: cdc-acm: Fix bit overlap and move quirk definitions to header
Date: Wed,  6 May 2026 17:32:13 +0800
Message-Id: <20260506093213.1473262-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OIjQjTDPb0/fr08D/+2dJw6Ttq2NhP3fIi3FNxcW9mi8Xs8kaHrar6ma
	VtslOPDMYHh7qKzUAeRBP2zYhZoh/jCgUwfDihOh6Xya5nG0wTzTtlML6jxme1y97FOgBNR
	v5d2ON0MYz15FRb5WaZ3+6Ug8dVCT42t1UZ/7fkGULizEmayll3FduIxk+C5p1tDQuSaRQe
	kUhWLcwbsO6YwAG38aJhMaayt/j7oQs3RsBS7gieoWCtkggSk8nVni1yUJo+9E3A9dQIkoT
	wzVEnzf2G+JHoDvMR8FF2ZUvFv56utHXk0puiChb+6BYIDjzJi3fZ1ZO02NFUPMfVvwVGTP
	MhDxCOphWNBApfaDbQ7Mzzrgtni5u4XndG1YzPERDfq9AHKdMtpSKb/vFKbYj6vHeFzlbO/
	5r9ik8dhddY8rCJ2AwFGHsa8SNE2FiQ8Q54sTId7rTMxUcT8XDeXBNnUrHeeu25u/isg2Z0
	G1J5dtcF+I5UeLIXNjQMyE/ZWY2s3TWW1ykb/zOXWhAUd4BgLE2VmwUCgk+TVqkAluhNQRF
	xo/6CB4v/4ikrS1DRtquGulgXlkc5wwIKn7esvkyT9SDodFYfXA0cqi2+VLvjDDACwjU3up
	kAuHPdysoCmjfCMLzhUGegWrlCTPSzXx3sEZDTdgELov3IPWSgMx/DdQPlLMNGWnVWqTpH8
	yITJVP75Tg99gLDEnN7xDyNTPFaDfssNXOjXsi9Dj3u2NXCND2PPifQCxvilt7BZiNvXnjc
	bHa4FyJgv1h8HqF08W2WC7fpkOUhFwEOELPO6rYT88nsrmvwoQNJngMQQbpPds69G0vPxMo
	f6gJMfVOBYtInavaTrBDcAmv2Ehb4y+9howxyDyi+OBJhX2ngU8WFulDc0AO1wYSbp6QdkP
	BluVW81tScp7dJEXOzbAEUtllj9g6zsduUjnaoOX96zaeJhRdyb6wXloXhbb4FfJfjHsn2u
	wAvjzefcP1c4Y3r5gCO9ZDNusc4shU7T1dqhTRYpK+tFt3XSjywLpQuhHTpTb+VM0Z6Dt5k
	PaOidmUgkK1E8cNGYiiXnshkKsp9A=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 8186C4D8B4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,vger.kernel.org,uniontech.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244355-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uniontech.com:email,uniontech.com:dkim,uniontech.com:mid]

The VENDOR_CLASS_DATA_IFACE and ALWAYS_POLL_CTRL quirk flags added in
commit f58752ebcb35 ("USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10
INGENIC touchscreen") were placed inside the acm_ctrl_msg() function
rather than in the header with the other quirk flags.  Then, their
values (BIT(9) and BIT(10)) collided with NO_UNION_12 which is already
BIT(9).

Move the definitions to drivers/usb/class/cdc-acm.h where they belong
and shift them to BIT(10) and BIT(11) to avoid the overlap.

Fixes: f58752ebcb35 ("USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10 INGENIC touchscreen")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 drivers/usb/class/cdc-acm.c | 2 --
 drivers/usb/class/cdc-acm.h | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index c024011dc336a..d64751c42c2bc 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -114,8 +114,6 @@ static int acm_ctrl_msg(struct acm *acm, int request, int value,
 	int retval;
 
 	retval = usb_autopm_get_interface(acm->control);
-#define VENDOR_CLASS_DATA_IFACE		BIT(9)  /* data interface uses vendor-specific class */
-#define ALWAYS_POLL_CTRL		BIT(10) /* keep ctrl URB active even without an open TTY */
 	if (retval)
 		return retval;
 
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index 25fd5329a8781..01f448a783c03 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -115,3 +115,5 @@ struct acm {
 #define DISABLE_ECHO			BIT(7)
 #define MISSING_CAP_BRK			BIT(8)
 #define NO_UNION_12			BIT(9)
+#define VENDOR_CLASS_DATA_IFACE		BIT(10)  /* data interface uses vendor-specific class */
+#define ALWAYS_POLL_CTRL		BIT(11) /* keep ctrl URB active even without an open TTY */
-- 
2.30.2


