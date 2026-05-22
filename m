Return-Path: <stable+bounces-253661-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIpxF5enD2rCOQYAu9opvQ
	(envelope-from <stable+bounces-253661-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:47:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 246265AD8AA
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25A553015735
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0847328642B;
	Fri, 22 May 2026 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q60+lN3z"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B42C027A
	for <stable@vger.kernel.org>; Fri, 22 May 2026 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410784; cv=none; b=prfMVD/I8fQ6vJXZsg+MlWQ+Y2DFnvq1VY3BQurI2RhYEIiwnd2Qx5OsJXPL329fA4Pr14hW3hH1zmU7bOzZDiIShGXaxJUqlqKGkNm8YrhHP8I0EILWi9Bug5bqpF9SowYLTNz9I35Gl1u+EQvGk+4ZtT72UAZ249bOEfpd/zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410784; c=relaxed/simple;
	bh=9A4jVnzDv/usUlFeq3EuOnxuhB9rRPwyxJzmHvtAJ74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAtekdXnlxqlOUvhzA7emSK9eHphuNQs6WS8F15rqlobH9fSgO2FXyogdNhpWXOz/fGefII83H5FjA3qfxvhRQX9ZnhfqWgOpm9YX27c0PNPdHFoBSlxlda9Sn9f7qLnGyxLG3IAPo4ENNWj7SQi4ueZN/iVnI+vGiYbS1zT7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q60+lN3z; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso14269157a12.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 17:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779410782; x=1780015582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4lmM74WsQVb7gsWrSGGOh3OWSwYycbJASwr5KvwFMI=;
        b=Q60+lN3zipYnXsA6wSIcTjYA+dpfyKVP3st61dgNRhlpdocOQkvqyvGvdjvoYurquI
         TnUbG0AOXDZvNLVhDgEBYqf7R9EgQ1lTPbjkB0pO+KPB6ysNaipx6ZYnyVnKCOhf8xxU
         8TxwCawTb/aRyruWB+KRB+eFqY1M7Jru7r3q3u6sWSau7ON0ywaj9AY5UXUY2b50vhLw
         u6qu/nzkcki5h77uhm9uNmW4kl4RH28f07z7AKYnuaLEBYDdlkMh3fVWGE/MD4lz7XJv
         934SS94nQmG/WciFO662t2tkMcz0A1zUFhj1p/94oKUTubaRaqDMbl0CfGfenBjiqegJ
         QnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779410782; x=1780015582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S4lmM74WsQVb7gsWrSGGOh3OWSwYycbJASwr5KvwFMI=;
        b=Rh4L1jAp7mEzbHyBXoKESb3B6eFLjFPP/GgTk98DLJnf61aVYhyX1cECyb7y4bLSRn
         F0GlqrnhPnyKqu/1Rat1Xc2z/Jur8OcQ17YJLg6+2OwfJ7fvIyJgZMZ7t6859wqcyJqX
         ad1jXSFuO0Mmv4i3MTxW8MdaAdWo8F1RDCWhUlctccK9/dqmCjbvpsXAdP1kCEbpCIl1
         gp8kUbK6wjzWEsxnWqxpg04QBiayoA+YY5yfEyLZaElOfcbhcjTr2kjgEBufwaxaIxgr
         3I3Ann6/OhCgihgVh5kD0iVc+IH//TYBAWR+aqGDog6klyRhw3xWmZpA6hhXcKGlxwbY
         v8IQ==
X-Forwarded-Encrypted: i=1; AFNElJ86M3t5HfoKvMwPHhztOhipEYqpAjuOC2dGtDi+Aa8rGl0Atkhw/B7TaKaMLffm4mMZGGh/T0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0oR6HEhKw5ufl1afKWyjMV1xa96X00/6VAFTRBcRHcf8U5dvy
	JYixj5+IsT2HBIYP6lUD5i+Nn+xiYRnAGh3zn/c9Dz+JQa1mxaSkBcrM
X-Gm-Gg: Acq92OHXbFA2o8W4wchg+rumlYc3KHy6iAVvjZ9Ip1H/VqShps8aZH5EnFxOie6NjJA
	hB5WGwgruCWCWnzJSeR1IdFOs22OgleZggqac7cka8L5SAbLa3wNgOZ6k6JcAoz+/OUpRlXZ+pZ
	0pCbfn7p6EgN+Jf3mwDiJnSdJSJHr+Uu11wdweWbno/DuWanqiyuTBThk8BQPUN7alqXHG9Dpju
	naeZXERd5P0Nnhiu2BoURP9mlfIuF6rJHvqvqxYD0xysU/aRQkIDqdrlEuGC3gVcHIqWSjia2LO
	eR8xDywaGY9WXSklqkmEW1NmNdEO+RzuxwQeG3u5KwAREUM/fXtVLmEyObCiBAHu89/i3suCadu
	DkS6anOltLTwG/tgqAjhy/Qsn/jEkdLIK+VJck+AeBCXLJHUGNiQoGXnhuznep8DgCHm3KFcoX4
	j3ga2qIFJzJUDyRC9ZFaAeNhoEDxeySAYuz/raN4x/c19Oti9cnUj48sJuaXFKLHxQeY0JYoaEe
	plFgsWS7Y74MGiBxG8Q24Fe5sMcWhOfou5e+ePIBHxiF5uGwZmyF8vAY3S/636HH7nt+Gzed8s8
	7/rxQBHeEGMNMjNv/qCaFmrJVsGd
X-Received: by 2002:a05:6402:3594:b0:676:e619:2be0 with SMTP id 4fb4d7f45d1cf-6889c44e2a0mr484221a12.8.1779410781772;
        Thu, 21 May 2026 17:46:21 -0700 (PDT)
Received: from ahossu.localdomain (ip-217-105-56-94.ip.prioritytelecom.net. [217.105.56.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-688b72cbbf3sm3535a12.0.2026.05.21.17.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 17:46:20 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	luka.gejak@linux.dev,
	Alexandru Hossu <hossu.alexandru@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 5/7] staging: rtl8723bs: fix OOB read in OnAssocRsp() IE loop
Date: Fri, 22 May 2026 02:45:29 +0200
Message-ID: <20260522004531.1038924-6-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522004531.1038924-1-hossu.alexandru@gmail.com>
References: <20260521130330.754181-1-hossu.alexandru@gmail.com>
 <20260522004531.1038924-1-hossu.alexandru@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253661-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 246265AD8AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The IE parsing loop in OnAssocRsp() advances by (pIE->length + 2) each
iteration but only guards on i < pkt_len. When a malicious AP sends an
AssocResponse whose last IE has only one byte remaining in the frame
(the element_id byte lands at pkt_len-1), the loop reads pIE->length
from pframe[pkt_len], which is one byte past the allocated receive buffer.

Additionally, even when the header bytes are in bounds, pIE->length
itself can extend the data window beyond pkt_len, silently passing a
truncated IE to the handler functions.

Add two guards at the top of the loop body:
  1. Break if fewer than sizeof(*pIE) bytes remain (can't read header).
  2. Break if the IE's declared data extends past pkt_len.

Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index c646dc2a1741..68ce422305ed 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1406,7 +1406,11 @@ unsigned int OnAssocRsp(struct adapter *padapter, union recv_frame *precv_frame)
 	/* to handle HT, WMM, rate adaptive, update MAC reg */
 	/* for not to handle the synchronous IO in the tasklet */
 	for (i = (6 + WLAN_HDR_A3_LEN); i < pkt_len;) {
+		if (i + sizeof(*pIE) > pkt_len)
+			break;
 		pIE = (struct ndis_80211_var_ie *)(pframe + i);
+		if (i + sizeof(*pIE) + pIE->length > pkt_len)
+			break;
 
 		switch (pIE->element_id) {
 		case WLAN_EID_VENDOR_SPECIFIC:
-- 
2.54.0


