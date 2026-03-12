Return-Path: <stable+bounces-224804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM2qIl9YsmmhLwAAu9opvQ
	(envelope-from <stable+bounces-224804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:08:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A8126D808
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 07:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D67E301FB9A
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 06:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806237B034;
	Thu, 12 Mar 2026 06:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4mDGSgD"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF14E3624BB
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295709; cv=none; b=PirUqUXqJTPgsS4iLDpGc+TlXbkhHr93lOgAt5Vp9wfUyrjyaVr/c6JWRzRe8naPWbueUmOYp+h42Pc8+cUmaI3ewKKw7BQ6GZZRIQURai6BhaynHF5hMVYzwPswjNTREJQuqXj1d37lmWft/RA6hnop2RyeeeN9CEeWcajj3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295709; c=relaxed/simple;
	bh=i3NzfKMNL7tCBAg6BF56HuN1UX3KaECb7d9dUSxUt5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZazMX5CxD4JJymKP7fHLQeaPYMdsS1rz62YZa8KuS+2+TSf25rd8J2Meb9kjq0IISGuctIT2caFM8xXPhrq/mNrxg2QlxjMhgAM2faP0EXJv+G/Uxvf8rwKwSFSxstpWe4L98QM4tcOG7VD1BNdymU2bhBl88J268ph93SslOIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4mDGSgD; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-899f5d337f7so9464366d6.0
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 23:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773295707; x=1773900507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AuqHAr62ZNn8KR69qskzLNS25tm6vaheaTX24sWfXBI=;
        b=a4mDGSgDQJChPQEkXP7SBiFZLjeGeUf8C3ADLMBDc6+lKTiTZ4SbbHSehxtc4C67rQ
         fs1nHylAGh/z9cb+aQqp48/69VQXuawLpLcYOjUEiNFEM1G4QOLYHsy8/Z072fuj+F5P
         8BWeIxRoYCDHnPKUy6fugz96kL8HA0pdn55yyPyC8EWAnzV79AngN6h+e1YfKduk7SnN
         axak8MbH8c8tuv61XOePZ8lo2vEnSC8pE3OgNZI1rk0CyrtLLtCQ89aeLdqcXXtlqark
         Ktr9ZtgY9shMVSHRa1RUGkupyttCwXC21n8mGxjALva9WKVNQ/Aow+XowtCGOlJ7zl8a
         WkHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773295707; x=1773900507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuqHAr62ZNn8KR69qskzLNS25tm6vaheaTX24sWfXBI=;
        b=v96Q6DCDkDQTZfA+x3QRuD0IyqcaYWIuamO6rDuB6pxYkFktSfubmxpQNySVgcZm5I
         qvxrSX1d2M5KOwyMZf6t6ZrCPRoqjg3RASO/f7XnGZpGChJxC9lwDdIPPqpbxHv/eivf
         +uQq3L5PBLxDn7ujdfCuPVV0sklIK+uEkw5oLfktWHUMLeQvL8Zw2PnevuBPACSjaaZ9
         6RHeXyWR1MGs4mAuL8fmacFLl/3miCSYgC/8C1qyrmu4JDq9Z2AqpdGRalBNLmgmXeoG
         KY7rNVJuhKlIk5pW3ftO2vURlhvovG2Mgly+DQcMk+BqvGpSaIwvhDwMA1P2AZyE+Pkg
         5MYg==
X-Forwarded-Encrypted: i=1; AJvYcCUBKAfwc4VRPvQGVUOgVD+o0FEVmuGhOvj3TBA4jJ2Kz16iamxBos5QPGxJEYIhF/uhoAksS5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZwANvlCEBG0k28j/6hazZXnkjkLnuVvj7FUJWeBQyblT5r0H
	bw/XsiYypzBJTiyZIVieN1lW/GHpdlq4T9/SwBK94uers2fcqg4ph4uq
X-Gm-Gg: ATEYQzwhrxY9HehfZ/NqHcagRHM7kTnKoV8y8sG6E+8XxEcKVVv91SzJA+iZNZ/HraD
	GgPWu91eBmRiJflhs+eo/ADZ2dKlrh9ugolucju5RkQjp7QMUaBPACGc4Ce1nbsH+OrMT9Z9COr
	6bouy95f5i3KgEHk5qlef4pNKQaDctoMtdMEL19wWnCEHycg+0gDUC/v8YaCZESVfyi+7EfDzKy
	Cn/xEbS1BdVpbgHBjXfcHEYnTafo0Gog2Ndx1e6Hzllg8pYrdvC7Z7U8qn3rRB919iNmR1SIQZw
	CcIfQN8/VrIoVgewexbbfC4SHPrlPll8w66spmKef3eIPNwEpT3St936fcmcs0fU/yckATVzbg0
	/SwA1VvrfHdPUJpPrU3EZO6FqSc39RvpDlRQRbKEvJffuZQk7b+D9SK5I5gsJkI4Mp32Q2AqcC/
	FOKfpz7rfneh7SJbObZTZGt+00ZIQ+xLTEg/uwEZZ9MWUawgHUiYfKWz46lsgBKNFcX4NpPi+ck
	n1XoAHDRlsr9IExY7n4
X-Received: by 2002:ad4:5de8:0:b0:89a:929:3d2d with SMTP id 6a1803df08f44-89a72a23728mr32646356d6.16.1773295706971;
        Wed, 11 Mar 2026 23:08:26 -0700 (PDT)
Received: from localhost.localdomain ([129.170.197.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65bd5274sm28472836d6.3.2026.03.11.23.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 23:08:26 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	heikki.krogerus@linux.intel.com,
	kyungtae.kim@dartmouth.edu,
	stable@vger.kernel.org,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH v3] usb: typec: ucsi: validate connector number in ucsi_connector_change()
Date: Thu, 12 Mar 2026 02:08:15 -0400
Message-ID: <20260312060815.55-1-nathan.c.rebello@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,dartmouth.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224804-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17A8126D808
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ucsi_connector_change() uses the connector number from the CCI as an
index into the connector array without first verifying it falls within
the valid range. The connector number is extracted from the CCI register
via UCSI_CCI_CONNECTOR(), which returns a 7-bit value (0-127), but the
connector array is typically only 2-4 entries.

A malicious or malfunctioning device could report an out-of-range
connector number, causing an out-of-bounds array access.

Add a bounds check in ucsi_connector_change() itself, before the array
dereference, as it is the single function through which all connector
change events flow.

Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
v3:
 - Added changelog (Greg's bot)
v2:
 - Kept bounds check in ucsi_connector_change() rather than moving it
   to ucsi_notify_common(), as ucsi_connector_change() is the true
   central validation point covering all callers (ucsi_notify_common,
   ucsi_register, and backend-specific call sites) (Greg KH)

 drivers/usb/typec/ucsi/ucsi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index a7b388dc7fa0..b4f630154aba 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1345,7 +1345,14 @@ static void ucsi_handle_connector_change(struct work_struct *work)
  */
 void ucsi_connector_change(struct ucsi *ucsi, u8 num)
 {
-	struct ucsi_connector *con = &ucsi->connector[num - 1];
+	struct ucsi_connector *con;
+
+	if (num < 1 || num > ucsi->cap.num_connectors) {
+		dev_warn(ucsi->dev, "bogus connector change event: connector %u\n", num);
+		return;
+	}
+
+	con = &ucsi->connector[num - 1];
 
 	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
 		dev_dbg(ucsi->dev, "Early connector change event\n");
-- 
2.43.0.windows.1


