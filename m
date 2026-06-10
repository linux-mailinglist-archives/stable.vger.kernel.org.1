Return-Path: <stable+bounces-262474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dbZeJb9NKWrWUQMAu9opvQ
	(envelope-from <stable+bounces-262474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 13:42:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9405C668E3F
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 13:42:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UI+dDQhC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262474-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262474-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1967300088B
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C4C403AED;
	Wed, 10 Jun 2026 11:41:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6D83FF882
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 11:41:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781091687; cv=none; b=YHPBRho3iIMeTz4OFPfwNiPPBoJL9Ehznrfk2y6h2ObjTDKEHJahRWpr1+NMSNp72vJ5HAFtOUrts8fjTVzpwT5LC9pUMhf83z9kcqTAWxLqySBnwH92Qxm7gqDUHS1SU/UijaLRn/I01K5CM6SyQyS/wChZrrmdS8qLLpgkoDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781091687; c=relaxed/simple;
	bh=Kz5o+o4V/50TgyMsDM1u+PPBmb+aUdtA7Th63o/S4GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2i8KVZpPelPrW0I9RHJcQD7TlQb3/FScrL45lItecdTIY9b4yI72nPzdVaacamnXbHQl61tgaehNduRjsvpcTyV23BfKDOS5wN31dk/PtTgPx0SmsE4Un1gxbyroK11rKQu/vsZRAllqjjLLthkQACmNefn4YkCKTcK/cVDMgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UI+dDQhC; arc=none smtp.client-ip=209.85.219.41
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8ce9e56f68cso56328316d6.2
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781091683; x=1781696483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FNVXr9zawygTZbMFPpNLLMPEhT2gh4L5OBjQ+E7NpM=;
        b=UI+dDQhCBkL2djbo9jRTxvJto/ZNc2U7mZRKQcUdrIyg4ikS6tuNhWNNGfqabwz+Le
         CqOfZhKp4K6gESU/Bm6kCKNDsGx2HYmB35HvEh0P9UsIki9XhadTEQ+5WCr/JVlUgEA/
         zPD6Y51/QbXp9WSTb2pkrHD2zmDZufE/z+X+yu9HJE4w+8KF6A51rTkj3Zmr1fNVIYQ9
         XEM32Z0knRNdN+EfS2r3nRL4OFyFe/8w/kV5PBoYVzfXBes56cUewIWZctpM+5wyL2ht
         QFH6UfCi9xjovuPHwiZOH2Gg8VGcC32hwDhESH6+e4KmWgSeXWHh3OeV86f4oMG3AM12
         iMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781091683; x=1781696483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FNVXr9zawygTZbMFPpNLLMPEhT2gh4L5OBjQ+E7NpM=;
        b=F+hCmL0WniA13+U+uQyKjXSS+Ox6P7AbOyd2/J6bg8MBbW1k3T1dRxxHubssRAEPt0
         OzdAvQf7S7nClrtHBoFGHbgIbz9+5sgzjdsXsYsTyvQU0bHii2yZwRJhSX+wmvDooCVG
         /HfI9cnO0p3qwmiPW+mSxNy9QE3TIjYP3F4DooBwWTos3FrC8dqa0zJcWrSCQx7o2U53
         o2cSPVUH+cbFtHmpaea5ydFWxShaZ6enJ6Z23Kd4/V4QPqBUtBHJ1nlzk+vCUA3kptex
         Rp5LXCYLI4ARMLnkoQRdaS/x4prgE5dCzw6gr2qrgnxSs2WwxRz8oD/qVKjdmi7KlYTR
         LgFw==
X-Forwarded-Encrypted: i=1; AFNElJ84CxhCCDJVaLMbzSbir9aPd7kmRyW46mUWFbmETd7QRqzzsanqwGj4IOYK0zleozCpQRITCNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/IJ9VdXBOM3lGcwTrQR+GXu0HaSOMd8F2iHmjIJMvxfP98M8
	5NpTMa53L7Dw/cGg7MduS7w44N11lBPoKpjJZRLlFOgu6xbSdPfKUaw5
X-Gm-Gg: Acq92OHWozC76bO9p1NaWD9bWujmV2y4b/Hirrlryg6gIoOuOmmZ1VFF4uABSiRn8Ii
	rVIs68B2Lp1xcuaLtk7phZnqw2z8jjpDuj/if97hBJ19wsR2xVTpqna2hOuh5hl7+p3XK6OVQCr
	MCDOQtaYfZgESHqNMp641C3QqSJPMmFNMaa8KjG/882S3x53Mjg1MpvnxhA1eMxBfSN9oDfnVGW
	rpimwQrhoaV7s4dCeZI1OHXVKEG3aEbUf4BknyiTBnp99hK/ar8nEcyihf1nGex51s4BHop/e8D
	XwMsl0IGbJW3izid4iIrVPAjfKqKft1u+Uco2ii3EguwrJKgkuC6pafd9Jew2obpWGKvMvDFMHl
	RBLCAU15vOTnX1OlzqIGpwm400FKIR99xbm8HPu/RPJmz61ffBv/D5/pPL+MMwMAVl769TSPgjQ
	UUm5gvkKuX2Ep5Agd76+rULZy9kzfTCF9/HCTLSDQnWxJNlcWdG08MpH0PulKSgdBO+TLAnvvTU
	gr4Rdfszc7mNBTPrVrpfnRWYTeR9Mo=
X-Received: by 2002:a0c:f09c:0:b0:8cc:dfa6:3333 with SMTP id 6a1803df08f44-8cee613313amr408672466d6.32.1781091682895;
        Wed, 10 Jun 2026 04:41:22 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fc7dsm234124256d6.5.2026.06.10.04.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:41:21 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Justin Tee <justin.tee@broadcom.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Paul Ely <paul.ely@broadcom.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] scsi: lpfc: bound RPL ACC payload size to the response structure
Date: Wed, 10 Jun 2026 07:41:19 -0400
Message-ID: <20260610114120.3748526-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262474-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:justin.tee@broadcom.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:paul.ely@broadcom.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9405C668E3F

lpfc_els_rcv_rpl() handles an unsolicited RPL (Read Port List) ELS
request from a fabric peer. For a request with rpl->index != 0 (or
index 0 with a small maxsize) it computes the accept payload size as

	cmdsize = sizeof(uint32_t) + maxsize * sizeof(uint32_t);

into a uint16_t, where maxsize comes straight from the peer's request
with no upper bound. lpfc_els_rsp_rpl_acc() then builds the response
with

	memcpy(pcmd, &rpl_rsp, cmdsize - sizeof(uint32_t));

The RPL accept always carries exactly one RPL_RSP structure, so a
peer-chosen maxsize makes cmdsize - sizeof(uint32_t) exceed
sizeof(RPL_RSP): the copy reads past the on-stack RPL_RSP, placing
adjacent kernel stack into the response sent back to the peer, and for
a large maxsize overruns the command buffer.

Bound cmdsize the same way the index == 0 branch already does, since
the accept payload is a single RPL_RSP regardless of the requested
maxsize.

Fixes: 7bb3b137abf2 ("[SCSI] lpfc 8.1.2: Handling of ELS commands RRQ, RPS, RPL and LIRR correctly")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 4e3fe89283e41..555b2e4d78fb9 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -9250,7 +9250,11 @@ lpfc_els_rcv_rpl(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
 	     ((maxsize * sizeof(uint32_t)) >= sizeof(RPL_RSP)))) {
 		cmdsize = sizeof(uint32_t) + sizeof(RPL_RSP);
 	} else {
-		cmdsize = sizeof(uint32_t) + maxsize * sizeof(uint32_t);
+		u64 sz = sizeof(uint32_t) + (u64)maxsize * sizeof(uint32_t);
+
+		if (sz > sizeof(uint32_t) + sizeof(RPL_RSP))
+			sz = sizeof(uint32_t) + sizeof(RPL_RSP);
+		cmdsize = sz;
 	}
 	lpfc_els_rsp_rpl_acc(vport, cmdsize, cmdiocb, ndlp);
 
-- 
2.53.0


