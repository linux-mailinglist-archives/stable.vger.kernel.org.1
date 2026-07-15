Return-Path: <stable+bounces-274781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xrQFB9NIV2pyIgEAu9opvQ
	(envelope-from <stable+bounces-274781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 10:46:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA1575C054
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 10:46:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274781-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274781-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2CFE830321BF
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB983CFF7F;
	Wed, 15 Jul 2026 08:46:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166883C5837;
	Wed, 15 Jul 2026 08:45:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784105163; cv=none; b=jXlTqqVP1tWmdyN50ATMiAJRXYCC5bK6XHVgRZ2o9Eh+QUxXOGTxEcHcnEgZvwmwn3GqdvbWCgQofsWKyq1Tnc+tr0K/DXAKqcsDlIJNw8f0Q44xpzB9JdXZTVOftV1TzeS7cDnBh7EpKAs4/enf9Sw2fn8vMG0RR/mw9U+58Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784105163; c=relaxed/simple;
	bh=vV9ILCIHa8DA9dqcDB5Qy/Oy0enErrDKKSBtFki3rMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ss2XE1rMcmInRLyd/YWdVjrRkSL/5jvXC+liEYuJVP3Wl7UCzdDp+ViHEXA/CsAlLmBJt9xmTkFREj/ikyKcwWBhArw0UpUEIL6ZZieRxWmSPpD/KMsVBGl7gGQW0WGuUkxoz5Nvc2huUESYaWKh41Wj2AHKMazWNwlqiHgRKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAC3Gt68SFdqrnpHGA--.26287S2;
	Wed, 15 Jul 2026 16:45:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Hannes Reinecke <hare@suse.de>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Robert Love <robert.w.love@intel.com>
Subject: [PATCH] scsi: libfc: validate FCP response payload length
Date: Wed, 15 Jul 2026 16:45:48 +0800
Message-ID: <20260715084548.45278-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Gt68SFdqrnpHGA--.26287S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4UWFyUJr4fZr4fWw17KFg_yoW8WrWkpF
	Z3K3yYyw48Wa1FyFsxGr1rZFyYva4fAFyUCan7W34fuF43ta43WFykAa4j9rZ8Jr4IvFyD
	XF4ktr98WFykWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	d-PUUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274781-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:hare@suse.de,m:pengpeng@iscas.ac.cn,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:robert.w.love@intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pengpeng@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iscas.ac.cn:from_mime,iscas.ac.cn:email,iscas.ac.cn:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADA1575C054

fc_fcp_resp() checks only the fixed response templates before using
device-declared response-info and sense lengths. A short response can
therefore pass the existing fixed-header check while the response-code
read or sense copy reaches beyond the current frame.

Validate the response-info span before reading its response code and
validate the combined response-info and sense spans before copying
sense data.

Fixes: 42e9a92fe6a9 ("[SCSI] libfc: A modular Fibre Channel library")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/scsi/libfc/fc_fcp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index a5139e43ca4c..6a1489be2617 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -882,6 +882,9 @@ static void fc_fcp_resp(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 				if ((respl != FCP_RESP_RSP_INFO_LEN4) &&
 				    (respl != FCP_RESP_RSP_INFO_LEN8))
 					goto len_err;
+				if (fsp->wait_for_comp &&
+				    plen < sizeof(*fc_rp) + sizeof(*rp_ex) + respl)
+					goto len_err;
 				if (fsp->wait_for_comp) {
 					/* Abuse cdb_status for rsp code */
 					fsp->cdb_status = fc_rp_info->rsp_code;
@@ -897,6 +900,8 @@ static void fc_fcp_resp(struct fc_fcp_pkt *fsp, struct fc_frame *fp)
 				snsl = ntohl(rp_ex->fr_sns_len);
 				if (snsl > SCSI_SENSE_BUFFERSIZE)
 					snsl = SCSI_SENSE_BUFFERSIZE;
+				if (plen < sizeof(*fc_rp) + sizeof(*rp_ex) + respl + snsl)
+					goto len_err;
 				memcpy(fsp->cmd->sense_buffer,
 				       (char *)fc_rp_info + respl, snsl);
 			}
-- 
2.43.0


