Return-Path: <stable+bounces-264319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kPaUKBBzMWqXjgUAu9opvQ
	(envelope-from <stable+bounces-264319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:00:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3086919C6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:00:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=TEH8BfqJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264319-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264319-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 91F06304E161
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D78A44E02A;
	Tue, 16 Jun 2026 15:54:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0444CF4E
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:54:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625292; cv=none; b=GBfVsl1KXId1FFvAF10NRw1QaiUiVVHxrPIrwCm0clwuUgdPKzzo3t1xLLNEFgsSto2+z8sNqLsOWPoSx1RjVr2hxkkkshPJ9yLINnppw9YN3BtHfPHNDa/Noawy17ab/Uy6qgABFphL4aNpVQGoOdtLaMGE+nbVQw4thJSsI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625292; c=relaxed/simple;
	bh=EA6WyWG10ZiYG3Ibe7F59PN3ZW0L1VzaSTTaHdsrgM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ukV32hpTPIZrVErM1DzuXbAgC+jEIGuJmp5lfXMOpQ+JXNfEpknPW9PH+MQY4KX9RunLaASLY/DjIKeYDIIRKMLFbYUJ2qbCjFEiDjvF4ZTTF3aWNgFBpBBJ64SMzbm03dcWejdazkgD62fGPhtsdCcsNC5g0jpcX/hjGzkH06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEH8BfqJ; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-37c5bb1de23so574022a91.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781625290; x=1782230090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yC4/3ZYS5Vh/O2LjV/2TjbHuntR+M/N/R6QJ97IDDdA=;
        b=TEH8BfqJzgt+EgXweLrcxxppYakWEtm5AkKExjKZ5V3h/lVQeTiZbvJBRogVFzTExB
         /ETYZe17z+8KRXh5c3gTphn+Oc5SO4vjyDvkKQLb/EfCBm1PgI579Q/AAubt8eWeiGxH
         ruStdZ+I9ZfxwJwMhF7EQAg79mLGyuolS+/m89jXg2AXcNte6EC+MQyU+GqNidHUkAGe
         tWelA0Suyc7LVoSnNPoPuQzHci3eV3UdvqCXciYDwvL4ZtPwJh5aI/Y6xgHd/bSOmSC7
         EXZQ7T3OSKTb85rnmYqlInRV42FRxh6KUmJvcliUBY2JfB+s9gqgM/R2SMCxRZTUgWdf
         fMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625290; x=1782230090;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yC4/3ZYS5Vh/O2LjV/2TjbHuntR+M/N/R6QJ97IDDdA=;
        b=YnkhY9bIYSbUeUEkHVRbHVWYwA0zZh6cO7RKn1kbFcSRtq13wcA/eYCR9lybwOAdCT
         Wo0pdyXe5SMvf21PV7CBgBt+V/i4oF/Ki+K53f24712pPXa5x85XvvqQ95Y9fnfOgbZZ
         K6ztPRl2IE0yAsZd3Bi8rmxH6w/4MrRiuZ5vhB/aVxaEula1CODa60raRJ6WUfgmISfJ
         Mzihi5Lu9IQsZJi4lu9acoQagd2Nj1kP15+CWh2SrMiwZDw7duYz8rHfhYj9vrtPc6pf
         GvykfzBlrG1QZmkAmNl4BTW26vEmkhZ1WkX8yY3NLF//WB30Kj7xMJxLZb6p+6Jf46cV
         605w==
X-Gm-Message-State: AOJu0YxEHj1SRArThEi5Unb+opt4ny/xEvIe5Z3N9WarOFk76psB5aHx
	qXh9wtwSD7tu2tTd+G/ANEyfRHDSoWD1T+x2ZUDzayOvEQxg8MXXVUJuOUfOT1jm4kgaUoRdFmb
	BZtMDbGOq1EuoxI8bXXlaJQDOba8Gt4OrxLCD2Um3IFRofDB+9KcxCvucqFI7BadrFSmshiMrEd
	Ct5MnH2Vd27wbwmTkZnXZnZiWdFRShtsYMPTTJmdZNpg==
X-Received: from plbkm5.prod.google.com ([2002:a17:903:27c5:b0:2c0:b7cf:e7ab])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ec3:b0:366:3517:1a95
 with SMTP id 98e67ed59e1d1-37c924904efmr107925a91.0.1781625289948; Tue, 16
 Jun 2026 08:54:49 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:54:30 +0000
In-Reply-To: <20260616155432.2093908-1-kpberry@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616155432.2093908-1-kpberry@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616155432.2093908-8-kpberry@google.com>
Subject: [PATCH 6.12 7/7] bonding: fix NULL pointer dereference in
 actor_port_prio setting
From: Kevin Berry <kpberry@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bestswngs@gmail.com, chenglongtang@google.com, 
	joneslee@google.com, kpberry@google.com, pabeni@redhat.com, rnj@google.com, 
	sashal@kernel.org, xmei5@asu.edu, Hangbin Liu <liuhangbin@gmail.com>, 
	Liang Li <liali@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:bestswngs@gmail.com,m:chenglongtang@google.com,m:joneslee@google.com,m:kpberry@google.com,m:pabeni@redhat.com,m:rnj@google.com,m:sashal@kernel.org,m:xmei5@asu.edu,m:liuhangbin@gmail.com,m:liali@redhat.com,m:kuba@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kpberry@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-264319-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,gmail.com,google.com,redhat.com,kernel.org,asu.edu];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B3086919C6

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit 067bf016e99ad72aa4ff869d6dec1fd62a9c6202 ]

Liang reported an issue where setting a slave=E2=80=99s actor_port_prio to
predefined values such as 0, 255, or 65535 would cause a system crash.

The problem occurs because in bond_opt_parse(), when the provided value
matches a predefined table entry, the function returns that table entry,
which does not contain slave information. Later, in
bond_option_actor_port_prio_set(), calling bond_slave_get_rtnl() leads
to a NULL pointer dereference.

Since actor_port_prio is defined as a u16 and initialized to the default
value of 255 in ad_initialize_port(), there is no need for the
bond_actor_port_prio_tbl. Using the BOND_OPTFLAG_RAWVAL flag is sufficient.

Fixes: 6b6dc81ee7e8 ("bonding: add support for per-port LACP actor priority=
")
Reported-by: Liang Li <liali@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://patch.msgid.link/20251105072620.164841-1-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Kevin Berry <kpberry@google.com>
---
 drivers/net/bonding/bond_options.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_=
options.c
index ddb3f06cbb75..4d01f1081956 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -225,13 +225,6 @@ static const struct bond_opt_value bond_ad_actor_sys_p=
rio_tbl[] =3D {
 	{ NULL,      -1,    0},
 };
=20
-static const struct bond_opt_value bond_actor_port_prio_tbl[] =3D {
-	{ "minval",  0,     BOND_VALFLAG_MIN},
-	{ "maxval",  65535, BOND_VALFLAG_MAX},
-	{ "default", 255,   BOND_VALFLAG_DEFAULT},
-	{ NULL,      -1,    0},
-};
-
 static const struct bond_opt_value bond_ad_user_port_key_tbl[] =3D {
 	{ "minval",  0,     BOND_VALFLAG_MIN | BOND_VALFLAG_DEFAULT},
 	{ "maxval",  1023,  BOND_VALFLAG_MAX},
@@ -497,7 +490,7 @@ static const struct bond_option bond_opts[BOND_OPT_LAST=
] =3D {
 		.id =3D BOND_OPT_ACTOR_PORT_PRIO,
 		.name =3D "actor_port_prio",
 		.unsuppmodes =3D BOND_MODE_ALL_EX(BIT(BOND_MODE_8023AD)),
-		.values =3D bond_actor_port_prio_tbl,
+		.flags =3D BOND_OPTFLAG_RAWVAL,
 		.set =3D bond_option_actor_port_prio_set,
 	},
 	[BOND_OPT_AD_ACTOR_SYSTEM] =3D {
--=20
2.54.0.1136.gdb2ca164c4-goog


