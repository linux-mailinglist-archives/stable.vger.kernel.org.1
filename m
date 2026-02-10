Return-Path: <stable+bounces-215676-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOQaA1hUi2kMUAAAu9opvQ
	(envelope-from <stable+bounces-215676-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 16:52:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B31F11CC62
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 16:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0875C3005997
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 15:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1972381714;
	Tue, 10 Feb 2026 15:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF9J1YA/"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F53632C33E
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770738771; cv=none; b=rO8Dyifyh2nbw03MFlLP4nKw35870LvAIj8rSWL1TBoBPvawBhT7lk+ARyCDKOb6AfJKedc+MwvG9HedzTe4/MOkJu3nKLCD5ari1K+OfpUnDmdf8URvUGP9krHwRYjs0B5oST/zMjXdjsV4dxVtGn5swGvrna5Tzi6yEKzT9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770738771; c=relaxed/simple;
	bh=+JHjufB3LEg/r3kx5N0o14L2zrHU9TKE8m4ej17mLC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FEXtth9alhU/dJyb+1o4uplfQgWnken/vPMxZEs0MUi6XaaRxUpt8QEOh3Sp7PDQ3iHiV40GNFf2SUXWBcZxprfRbEs+G5L8BXhDQ9ubFVxpk3VT7ZAjGS+0Nwer8JNpIeRT0vHM7oVCmi4zZd8uFJ96YqV/csaUxrD9IS/YjaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF9J1YA/; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7964fb9ae3dso21707557b3.0
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 07:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770738769; x=1771343569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsdoeDEVnIgEyOgR/pPJak/Bop4P70sJ/00MCCs+jug=;
        b=QF9J1YA/xSZx15oP8H4+eZfjRVlLuqDjEsfMeV6guK43eysgXw6oseLhsxfncEiwmU
         Sca7vav3KinlP2r+YSjLlwTDqMZAbZXwqYyGatPXFcn2UifqqvtHfdUDjyh2D+r/y7Ce
         dVo0cSJreGdGlN4B7xekMARu41OYHzehm0EJnUwffgTXTBPuDE+Gg9MEJRf7wOZoo/Lr
         UxCaRT6IjjKIIRqsYfYvmwg6nsq0VmDkhP7D/MOP1LxlY+lzx17fcSnZn0X275nYPJhO
         rI9gW4CHM/YlZc1dTTewJcQS1rqrJOiVYiMXEGr0+2Yo1fKD/v86TKkK3HFbDBtskJUw
         n6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770738769; x=1771343569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsdoeDEVnIgEyOgR/pPJak/Bop4P70sJ/00MCCs+jug=;
        b=Cb7k79m8AauPdJChyVPrn7MxIvmL9TrNsavRRqh2Xa3BoXXb9Tc+xQnCsQjHo4nOZ5
         0RsMWu0EtR4Zc+cgXSTK6v8jXyPstz6qWyCuSj1daho9vH47E36r0Ey7OvugzTK0DyR4
         GiCu/4mm5v41gBPMq71/Kk4J7VwLc/pQNLrUVKPnpWLrB3RFazjl3o9L3aObCFmBVTa2
         aVUH2UWik6SxMOOlUUkmagejaLf50wHG1iPgzfy8x0TCCy4+ugqI3jFVhocAg+/fQhxH
         kjPkEQC9j7jDZn4Ue5jb2vEYDVDWuiydjXxzGToiOGM5B5XkaZXh5gE3wRPnAW8QeKCX
         w+eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpV66NgEzyNUaHHaOImRBj4xCP13Krq9LLwsfhBaeQVDbjUzjjBP7MEsop+mJiEbYNay+0PzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwijOtgL7jJ4FaGxttXaaY/6YFHQJU3pM3fTtS+hnWkzAZFwJ4
	5mVGXygdaLnyYAGWUHXyoN6XSVX0DDDLTtCq+7Z3syBGOZDFIHKWJaPt
X-Gm-Gg: AZuq6aIY9IcNrfgIX3jnb4+7PrUvbQXbaXE89Kio+NhSg5rR8CMJGvVcSY0eeYvGdAq
	dADXiPmGMMs+SrSUnjtD6QogQB8RhPVx9I2W8sbVcWGXUproyXS8unmEjJXmj9vlHBdrGV6RLLc
	tLymZr1nFk+seirDEAlg7NA6xXERhqwmgy1+f3WyfL1jakq/CFY93eTpvdO+YqnsfgkNcgyFP3K
	qxoBPInQzIaJUwC+H27hJpxFC9hK+SIACnhlZPfoqp2g53FeaA+Ve5bfUHMHfqfPBMPESwrYaIV
	Rsx+UsTcvxnNKPjr5jNZAOjazYIbJ6440HJMj9WqCk+K606sad2CrGWf+qlsy9XNUiikZOG7m3p
	O+mn12w8Y/an/P9wq41osX0AcMc0U6SL7Hdo2plFSu+tsNxrtYO8ubnzI4sCeC9kqv95L81iLNn
	myQGIu50FNcYizYQW8mPHkkKPXu2eX67UD2/Z0CV3LpjUjTkdNlKqBAa1b
X-Received: by 2002:a05:690c:60c1:b0:795:294c:fd2c with SMTP id 00721157ae682-7952ab3faf5mr115261447b3.43.1770738769451;
        Tue, 10 Feb 2026 07:52:49 -0800 (PST)
Received: from fedora ([2802:8010:26eb:6900:67c8:420d:6b48:1a65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-796506f1dddsm42994797b3.25.2026.02.10.07.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 07:52:48 -0800 (PST)
From: Gustavo Salvini <guspatagonico@gmail.com>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	Vijendar.Mukunda@amd.com,
	tiwai@suse.com,
	stable@vger.kernel.org,
	Gustavo Salvini <guspatagonico@gmail.com>
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for ASUS Vivobook Pro 15X M6501RR
Date: Tue, 10 Feb 2026 12:51:56 -0300
Message-ID: <20260210155156.29079-1-guspatagonico@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[alsa-project.org,vger.kernel.org,amd.com,suse.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-215676-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guspatagonico@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9B31F11CC62
X-Rspamd-Action: no action

The ASUS Vivobook Pro 15X (M6501RR) with AMD Ryzen 9 6900HX has an
internal DMIC that is not detected without a DMI quirk entry, as the
BIOS does not set the AcpDmicConnected ACPI _DSD property.

Adding the DMI entry enables the ACP6x DMIC machine driver to probe
successfully.

Cc: stable@vger.kernel.org

Signed-off-by: Gustavo Salvini <guspatagonico@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 67f2fee19398..f1a63475100d 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -696,7 +696,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "XyloD5_RBU"),
 		}
 	},
-
+	{
+			.driver_data = &acp6x_card,
+			.matches = {
+				DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+				DMI_MATCH(DMI_PRODUCT_NAME, "Vivobook_ASUSLaptop M6501RR_M6501RR"),
+			}
+		},
 	{}
 };
 
-- 
2.53.0


