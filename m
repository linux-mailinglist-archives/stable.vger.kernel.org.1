Return-Path: <stable+bounces-225218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLyiEvYss2ksSwAAu9opvQ
	(envelope-from <stable+bounces-225218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:15:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B58A279D88
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E8262301FDBF
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F6538C41A;
	Thu, 12 Mar 2026 21:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eolSopzT"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57763603C1
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350125; cv=none; b=PqhctuGDuae5Ss+2gw0SYUNeNV8gy7HrN7cJ73oQa5hTPEZzDnWJcawOp5Mc7yRTXmRAlB84aDCE2HZvTfDgqRetDxsOGNH/DGztTuaws5wmFupaH9Iuo62OMV9lqF0/qe2wQE3Wl4uBJVIZkbLyfaQ31JCyQ/4eZ2jm6JoEgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350125; c=relaxed/simple;
	bh=EdyZWxoywiGkoxPvBufylUOq8C71Uqcu+Rnfl8Xh8zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BLtZ0mIS4wWRoKD5O9i2Pmrn3gfDhEF3jwXlh6QKtBRnucwJfowCUnnZv6O2KlyFxP6fZGhlYjEH0fPd6ZKfKAIEQOnleD5VlALoVSmWWndTQtlnQuRqdDBsx3HZvsyazt6njXwOxjereeRQnsX4Xjg8kydlfHAyHAeYMVuCXWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eolSopzT; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd767d2d70so160025285a.3
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 14:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773350121; x=1773954921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6I0Vq1Tl+Jo39N58IrwVNoCJt4B+2Bjz6e3dij+7e4=;
        b=eolSopzT5ldI+Bo3BWICjCSdjCtb/UqFqh/y8kqMoKX/4DNjpyHfQd/K6QPcGkWR7z
         yrILt/ZoLmEIAV35oQi4dYAUt1OrfHBWlouwbcJo3JcZ5UidrAaBa6JTaOzdnIjjQnaE
         U8RCW+RH7K+e+HHqYlRdI6GuGllUu+xU4jhdacGlrSBWdiy0bq4rApgTzdLznqh8Bu5S
         tGWA+NxG8YxvDkVOrfXNXWZXKpSb0mp8NBH4crzEof75PcCXTQHAAJxhpkM2QD5XZsw6
         flDRccKYZanq6yaZaX4/taBE7VnTwo1E6lncueQ3rAIUDHnO3hjFZA4lfXi/3yPEwgZe
         +dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773350121; x=1773954921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6I0Vq1Tl+Jo39N58IrwVNoCJt4B+2Bjz6e3dij+7e4=;
        b=Ky4PB5+YlxVpLI0nB4UmKDbWPymzFsZZEKMNZtCMPR9tvDqYRBRffkU08dNQ+q2Xfs
         nsXca5DJxXxz6bVTidA1oNbLGq9GsvHZDVOhv+NYIFlEvIWxTklkuXNpVXt4Y7e6npTL
         slKCUcmnEGP5s+2WaaJW1nkfUZ70v4xaDPg+VeP+2m6yVsOKdVcoEtJJJqkYKqqD6WDo
         fCNb7G/PXTQ0UsU5IgKrPRKiQteUws+J6siV8I7f3Nzx+G4NbCRJaxHvo8Y5ufJc1/0h
         HNetL1gJrAIWqHPgK3hYR7VotpQiJ7V+hlFtFeLwrVhAqsDWmIZhH+hh7nszxr4XjZaP
         uU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXDm75VIMGnICv2HV5riJDOXUuNGfPYGkLJ5xKkjDDSt2gD8/9062thZynmpgKVfYwfmPqCma8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztcppj/8eL/1p2OnpsIKNKadA8J/tvHw9X+hYGOf9r0d7ckemL
	2Jw8btEFDsUn0pOjbqk2x/gBcxG8zmHVitDKoerlNcVTcEdqeKid/TpR
X-Gm-Gg: ATEYQzyEjZtXyAr8FRf+x48Su3Id+ytMzih3DmWTiQq4os5AkE+KZobm12j+WFSwp12
	I5wuoFKu/MdkzETXWVs42gsSFsfjgzK2J+flZaDv+e4q8o5wwE/Pcm3DeA0ocuYeyg6W+vP8MYW
	TUFjQaRiV9YMI1gPFtlgpju2B9PEk3L/MaFhJtC+Ji9dKA7D7A2RxhqJH+4DE8m38bG9EFaFXAO
	GLSqHx/JnYxKQEHjS3efy/iWnfdma5ycPLLOrLlL304bvSBPMsOJW2IhU9LWq4fM20CyuLdI8ci
	rDKR961xI/DmiFDRDbAsHNAYL8Q7GEdBn76WqIQQWA+YJYmDUcusjBnKsnKXcqRi2FxT2yaAoWQ
	4QuXWNiFUPDcaIiSPaoM1169Ckt5e52Ia/7yCX8mm/Ygz1OLHRELdro8eGQUzMXxHpxL83R4kdk
	qvmkHSxa0TP2hp+BlyNjaNE0AuP0BiDUnVkNmiyCs/32nSOmYbZW7DTCI3Xr8nNLvlClR2d2WNL
	JTin71HTHI464QLgY1o
X-Received: by 2002:a05:622a:1214:b0:509:25ab:f545 with SMTP id d75a77b69052e-50957cb1bc6mr13008261cf.11.1773350121263;
        Thu, 12 Mar 2026 14:15:21 -0700 (PDT)
Received: from localhost.localdomain ([129.170.197.126])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5093a146218sm38781001cf.30.2026.03.12.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 14:15:20 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	kyungtae.kim@dartmouth.edu,
	stable@vger.kernel.org,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH v4] usb: typec: ucsi: validate connector number in ucsi_notify_common()
Date: Thu, 12 Mar 2026 17:15:03 -0400
Message-ID: <20260312211503.1915-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0.windows.1
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-225218-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,dartmouth.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5B58A279D88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The connector number extracted from CCI via UCSI_CCI_CONNECTOR() is a
7-bit field (0-127) that is used to index into the connector array in
ucsi_connector_change(). However, the array is only allocated for the
number of connectors reported by the device (typically 2-4 entries).

A malicious or malfunctioning device could report an out-of-range
connector number in the CCI, causing an out-of-bounds array access in
ucsi_connector_change().

Add a bounds check in ucsi_notify_common(), the central point where CCI
is parsed after arriving from hardware, so that bogus connector numbers
are rejected before they propagate further.

Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
v4:
 - Moved bounds check to ucsi_notify_common(), the single point where
   CCI is parsed after read_cci(), so bogus connector numbers never
   propagate to ucsi_connector_change() (Greg KH)
 - Changed dev_warn to dev_err
v3:
 - Added changelog (Greg's bot)
v2:
 - Kept bounds check in ucsi_connector_change() rather than moving it
   to ucsi_notify_common() (Greg KH)

 drivers/usb/typec/ucsi/ucsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index a7b388dc7fa0..10261992f020 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -42,8 +42,13 @@ void ucsi_notify_common(struct ucsi *ucsi, u32 cci)
 	if (cci & UCSI_CCI_BUSY)
 		return;
 
-	if (UCSI_CCI_CONNECTOR(cci))
-		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+	if (UCSI_CCI_CONNECTOR(cci)) {
+		if (UCSI_CCI_CONNECTOR(cci) <= ucsi->cap.num_connectors)
+			ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
+		else
+			dev_err(ucsi->dev, "bogus connector number in CCI: %u\n",
+				UCSI_CCI_CONNECTOR(cci));
+	}
 
 	if (cci & UCSI_CCI_ACK_COMPLETE &&
 	    test_and_clear_bit(ACK_PENDING, &ucsi->flags))
-- 
2.43.0.windows.1


