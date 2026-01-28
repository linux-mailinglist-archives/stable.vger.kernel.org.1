Return-Path: <stable+bounces-212304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKfSGooxemkx4gEAu9opvQ
	(envelope-from <stable+bounces-212304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:55:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074F8A4BD8
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED08F30ED13C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91FC307AF2;
	Wed, 28 Jan 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gJFyg1H7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD7030B50F;
	Wed, 28 Jan 2026 15:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615069; cv=none; b=RpBUIZZLriqDhLiE0f3MDe5dWvjw8ReG2AMYL3MTOLnVzL5qFGvuM54oAefDI5pe8GVe7iNIWz07eofAw88KWqTpbwgIkY+Eait5vJ7EAtCd6g5pMA2Tb57QEWdAn0N7IHPKEg15kEX/bmnFUE1aCeWwthvWJTV7jEWvwMVu6Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615069; c=relaxed/simple;
	bh=GgzUevruHK8e/IFh241YkNMX19qQdymIqorFG8q42HI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YsvKL1j4LHmDSGtZcYiMxO808mTMY+BI7U8tCc+7Cy/vh1668Wp69NtSTPRQUQZOYAQKdNlyya+ELk6fPE2YaWYZPTia421af4CRQ0o/bBYu2o8V9hfEf2XIGpJEfxbZKqQW4KQwHUDAwCSi8ZlgV6YDf3jV9OQtJ+r7TU3JskM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gJFyg1H7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DA7C116C6;
	Wed, 28 Jan 2026 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615069;
	bh=GgzUevruHK8e/IFh241YkNMX19qQdymIqorFG8q42HI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gJFyg1H7eBTQNrGuqbtqQK/+AWamTRf0F0k3Jkx4XIxwf53J/sU+aHKkWHN2xS35P
	 sboFuDdylwq1zMoQM9BVTGIO7VM4tFMNfhTJCQRX3jv5rfgfnPAyiNsa8xkvBy96vM
	 2//RL5CfLWdmeKVZ2VvPR0Vo+LbAJy4QjaJZNsHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Himanshu Madhani <hmadhani2024@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 069/169] scsi: qla2xxx: Sanitize payload size to prevent member overflow
Date: Wed, 28 Jan 2026 16:22:32 +0100
Message-ID: <20260128145336.490891030@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145334.006287341@linuxfoundation.org>
References: <20260128145334.006287341@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212304-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oracle.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 074F8A4BD8
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit 19bc5f2a6962dfaa0e32d0e0bc2271993d85d414 ]

In qla27xx_copy_fpin_pkt() and qla27xx_copy_multiple_pkt(), the frame_size
reported by firmware is used to calculate the copy length into
item->iocb. However, the iocb member is defined as a fixed-size 64-byte
array within struct purex_item.

If the reported frame_size exceeds 64 bytes, subsequent memcpy calls will
overflow the iocb member boundary. While extra memory might be allocated,
this cross-member write is unsafe and triggers warnings under
CONFIG_FORTIFY_SOURCE.

Fix this by capping total_bytes to the size of the iocb member (64 bytes)
before allocation and copying. This ensures all copies remain within the
bounds of the destination structure member.

Fixes: 875386b98857 ("scsi: qla2xxx: Add Unsolicited LS Request and Response Support for NVMe")
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Reviewed-by: Himanshu Madhani <hmadhani2024@gmail.com>
Link: https://patch.msgid.link/20260106205344.18031-1-jiashengjiangcool@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 77c779cca97f8..a1c5ef569f9d8 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -878,6 +878,9 @@ qla27xx_copy_multiple_pkt(struct scsi_qla_host *vha, void **pkt,
 		payload_size = sizeof(purex->els_frame_payload);
 	}
 
+	if (total_bytes > sizeof(item->iocb.iocb))
+		total_bytes = sizeof(item->iocb.iocb);
+
 	pending_bytes = total_bytes;
 	no_bytes = (pending_bytes > payload_size) ? payload_size :
 		   pending_bytes;
@@ -1163,6 +1166,10 @@ qla27xx_copy_fpin_pkt(struct scsi_qla_host *vha, void **pkt,
 
 	total_bytes = (le16_to_cpu(purex->frame_size) & 0x0FFF)
 	    - PURX_ELS_HEADER_SIZE;
+
+	if (total_bytes > sizeof(item->iocb.iocb))
+		total_bytes = sizeof(item->iocb.iocb);
+
 	pending_bytes = total_bytes;
 	entry_count = entry_count_remaining = purex->entry_count;
 	no_bytes = (pending_bytes > sizeof(purex->els_frame_payload))  ?
-- 
2.51.0




