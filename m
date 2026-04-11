Return-Path: <stable+bounces-235751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC73MluE2mnI3QgAu9opvQ
	(envelope-from <stable+bounces-235751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:26:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 409373E1073
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 19:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE4D2305A438
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 17:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2167F3B9D8B;
	Sat, 11 Apr 2026 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9U5KlYd"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD913B8BA5
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775928339; cv=none; b=h+Db797p023nx4YsERZc6+EHVDYoQP4MW157Cslyl0bmpTl+7KRWDso8cwpPYdrL3PsKMgCra5IXklvGyrwy4L0WkoOXBPHVPpzVzVS99fTFsFgJsWI43APJoPaUVt8e/WO2C1a69XysM9v9PA8D/HXMqFum70GW4cjrEuIFuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775928339; c=relaxed/simple;
	bh=j94mFWjbkKu2SfgXtjVVeadZCeyo50R3PTde4lAW430=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQnyBTYzeZ823cK19WbezIqjx/W78FWqMh4RbfJr1mfBG1RJw52nP1LyTQXzn1bL4QAcgVcngwmYCOwZjzB8+g5jy6vw0ModgNsOPn3XQiVHgXqjlMdtYQp5VpECNxSpQOn+zUKHigpH5FG2eZTHsSzw83OMQCM7CMahdRVD/OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9U5KlYd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so48845935e9.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 10:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775928337; x=1776533137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDfeGg/IzGo7QFmb2x70gGWmofSyZDmc3jO7YwqEMdM=;
        b=k9U5KlYdwTckj8zNmPrfqJEOG8KH5eDHPEuZgYIF+E/GQj4USFqlZRfLLmtFPCWANB
         GXW36fjSEIohD34zKNKmwoFy17R3v9nVgpsxCooBDVzt+d+yv7IPxI/z089d5uLX4tS1
         ueDW9bK2AUCGDZ83HxatR5Xk+qt5nEiMNm/MTtNACb+MGiIqD92vDj6wSU4VZI8DXK33
         ee0Q3TDUdT37e8rWKbfFNYBRdzuO99/X2gH5/y3psBtTm7AfsSuMlWHar4Jss3GSKRN9
         qHfhIBSzXF4j6hkGFsSE+qftr8XLiJB5HDPAVSCTPe3lIL59sOMGkr/ctnsxhkP4DlFm
         xPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775928337; x=1776533137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dDfeGg/IzGo7QFmb2x70gGWmofSyZDmc3jO7YwqEMdM=;
        b=FusTadNVUxGiJ0LvDEsnb2leCpI2hiIkolStPhIuPk6bi+wFOjkRaWliP1vxofhf+J
         /o3+994KNnXahLkonxy3ma18a+1kRCM8nEoR30NNNyQ5D5qUqPt15fpAXAIQ0WXyGkw3
         ReIHpWoWzWOh3WNvvZ7wcYNovxgRRv2pGmHxFpVWxNO8W4/UxQfu1iNDxqjq4rIuKmk0
         SR1k+vPTOOxEcX9ywzGVRhofDzPgalMCNkHwVegjBKpp9lWyJ8RVxojKisq74+sw08XX
         I0/D6zcygHxJDgR+yeYlpLZIREJZSNL+WyzkE5Cwo6TzYwZVOewYIHGT4WdM7lvIiJ7d
         6IAg==
X-Gm-Message-State: AOJu0YzU36BLu1BKzpwm3YZ1o15DFBZGmwP63fhYrIrHF+ZMclrgLZKt
	tTj+Z88xXxwW6S0Buz55LNeiPSbOCZnlt7KAoJ6n0o3xd/GZxpVB3BOqBt0Sax1X
X-Gm-Gg: AeBDiev2Bje7KCSbth/8arDTvt4EHZmHhTaBSndEp66hONjnn/cXWtHl3EZ8EmjMKkl
	pau83Bpst6joq5mZzkxtQWeURgr0bQyO1jWQzqlcjTyENo1b3P0fGywCFZW3pcqJ8TNWEAlRgUB
	lgy+AI2mXkzV6DK2HG3U9YIPP7kx4TFDf4c++78bX/sjJXTaKMUlnRttEBxx8VqHgJQRUYaYCgn
	h9IYN2NDDCKogxsjtV8xR3zDO181nWhLAkoNPu4vQGT2dBBne12eK62HsDBUDvAlpF63bm/zLQs
	dhcvOGuBzxER3QCsS2MG4eozCaCy2BCqgOX1wJwE/amIAV2RtMdIzsLbDVKsZapz8glijLNJioN
	J4Za7k0y9NL0ltOM6hXsCqwiunFrTddGCud3WhKc/2xK1WNs+dvrOwLQEjcmIEv0FOkg3LhbjxH
	tI5MJODlMlPEQv1pLqaSaxdwRUFQpSmIMyMpIQIdI=
X-Received: by 2002:a05:600c:c0da:b0:485:4eaf:eb53 with SMTP id 5b1f17b1804b1-488d685c12dmr87347065e9.19.1775928336856;
        Sat, 11 Apr 2026 10:25:36 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67b4903sm64176515e9.5.2026.04.11.10.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 10:25:36 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 2/6] gpib: Add ines 72130 line_status routine
Date: Sat, 11 Apr 2026 19:25:07 +0200
Message-ID: <20260411172511.26546-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411172511.26546-1-dpenkler@gmail.com>
References: <20260411172511.26546-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235751-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dpenkler@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 409373E1073
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 72130 chip has a different bus statue register offset
and layout.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/gpib/ines/ines_gpib.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpib/ines/ines_gpib.c b/drivers/gpib/ines/ines_gpib.c
index c000f647fbb5..dd98cb261a4c 100644
--- a/drivers/gpib/ines/ines_gpib.c
+++ b/drivers/gpib/ines/ines_gpib.c
@@ -57,6 +57,34 @@ static int ines_line_status(const struct gpib_board *board)
 	return status;
 }
 
+static int ines72130_line_status(const struct gpib_board *board)
+{
+	int status = VALID_ALL;
+	int bsr_bits;
+	struct ines_priv *ines_priv = board->private_data;
+
+	bsr_bits = ines_inb(ines_priv, BUS_STATUS_REG);
+
+	if (bsr_bits & BSR_REN_BIT)
+		status |= BUS_REN;
+	if (bsr_bits & BSR_IFC_BIT)
+		status |= BUS_IFC;
+	if (bsr_bits & BSR_SRQ_BIT)
+		status |= BUS_SRQ;
+	if (bsr_bits & BSR_EOI_BIT)
+		status |= BUS_EOI;
+	if (bsr_bits & BSR_NRFD_BIT)
+		status |= BUS_NRFD;
+	if (bsr_bits & BSR_NDAC_BIT)
+		status |= BUS_NDAC;
+	if (bsr_bits & BSR_DAV_BIT)
+		status |= BUS_DAV;
+	if (bsr_bits & BSR_ATN_BIT)
+		status |= BUS_ATN;
+
+	return status;
+}
+
 static void ines_set_xfer_counter(struct ines_priv *priv, unsigned int count)
 {
 	if (count > 0xffff) {
-- 
2.53.0


