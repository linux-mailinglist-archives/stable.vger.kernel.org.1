Return-Path: <stable+bounces-227996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJHIKNtGwWnpRwQAu9opvQ
	(envelope-from <stable+bounces-227996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:57:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2535F2F3800
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 312C73061BC3
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD33ACF03;
	Mon, 23 Mar 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZ+r3Utq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4616C1B4223;
	Mon, 23 Mar 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273809; cv=none; b=AQ8izpNiuoJ+ylNxrQt0/H9NyKnDfg/vDtnZ4WJwj1zuGL9rbrmUZ2I2rlXuoA32ObMyxO8l0StpY2eLxJaBRhJ6oCg0OcDmZP3c3FnvqRA3Z+VlG5GwcN/s1aKUcS0xrUKccoTy10oAx4mSnH8lsippPCRvZcF6ABO3iFlj2LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273809; c=relaxed/simple;
	bh=I4uB6UiW1vgzTDXtan3cLKYpUVhmpmWTJLNuxs/wGwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHd7Dwwl0bGs7KCAPCzyrNRtxV5ASjH2yFuqoGFXFpcLERMVNlHm0CtWrEFKyHrD2KNpdJBZmkFJSgvNLheuLpiXFdqmDZLSsEO3BELGN+UxruMO/gCymlf7NZn+UvnbgbEQHT974EcEfLwQ3CsoPPdZPJORNASptx8weeGhKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OZ+r3Utq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3EBC4CEF7;
	Mon, 23 Mar 2026 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774273809;
	bh=I4uB6UiW1vgzTDXtan3cLKYpUVhmpmWTJLNuxs/wGwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZ+r3Utqcj6/hcXSIy7ki3WcY112TV0aRz1IonM8H6Qe4KUCGbLh/DA6x1uJMoJPZ
	 bHfNRG7XJdvlFifEmj1jNrIrn7K9RhV3EMyVZ5AXBG6w4DGI77uznn+NiEztfXbDD+
	 BKs1rFROmeNr91QCJX4oRFhGAgTDI6gZDKxgmP/0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.19 016/220] bnxt_en: fix OOB access in DBG_BUF_PRODUCER async event handler
Date: Mon, 23 Mar 2026 14:43:13 +0100
Message-ID: <20260323134505.090797548@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,outlook.com,broadcom.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-227996-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,outlook.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 2535F2F3800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Junrui Luo <moonafterrain@outlook.com>

commit 64dcbde7f8f870a4f2d9daf24ffb06f9748b5dd3 upstream.

The ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER handler in
bnxt_async_event_process() uses a firmware-supplied 'type' field
directly as an index into bp->bs_trace[] without bounds validation.

The 'type' field is a 16-bit value extracted from DMA-mapped completion
ring memory that the NIC writes directly to host RAM. A malicious or
compromised NIC can supply any value from 0 to 65535, causing an
out-of-bounds access into kernel heap memory.

The bnxt_bs_trace_check_wrap() call then dereferences bs_trace->magic_byte
and writes to bs_trace->last_offset and bs_trace->wrapped, leading to
kernel memory corruption or a crash.

Fix by adding a bounds check and defining BNXT_TRACE_MAX as
DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE + 1 to cover all currently
defined firmware trace types (0x0 through 0xc).

Fixes: 84fcd9449fd7 ("bnxt_en: Manage the FW trace context memory")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/SYBPR01MB7881A253A1C9775D277F30E9AF42A@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2927,6 +2927,8 @@ static int bnxt_async_event_process(stru
 		u16 type = (u16)BNXT_EVENT_BUF_PRODUCER_TYPE(data1);
 		u32 offset =  BNXT_EVENT_BUF_PRODUCER_OFFSET(data2);
 
+		if (type >= ARRAY_SIZE(bp->bs_trace))
+			goto async_event_process_exit;
 		bnxt_bs_trace_check_wrap(&bp->bs_trace[type], offset);
 		goto async_event_process_exit;
 	}
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2135,7 +2135,7 @@ enum board_idx {
 };
 
 #define BNXT_TRACE_BUF_MAGIC_BYTE ((u8)0xbc)
-#define BNXT_TRACE_MAX 11
+#define BNXT_TRACE_MAX (DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE + 1)
 
 struct bnxt_bs_trace_info {
 	u8 *magic_byte;



