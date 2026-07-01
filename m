Return-Path: <stable+bounces-270121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QVuFOiPcRGr92AoAu9opvQ
	(envelope-from <stable+bounces-270121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 11:21:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDBE6EB8DD
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 11:21:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=HRscMH2h;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=1mucl8Ro;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270121-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270121-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C6A630086A8
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 09:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF43EEAE7;
	Wed,  1 Jul 2026 09:21:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D723CFF44;
	Wed,  1 Jul 2026 09:21:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897690; cv=none; b=pue6gmjE53lV6O73jz/OVvRBCN66g7U9WeYKPT2kRkT7Ferqr/A8f1h8Pfhu6nKxg+uiiRryxG5pnSvCJgXiIQcN6qv8iSDEzOrKx/SfPoqvIYfvxqfMYXO9WBM9XB7NRkoGDzWu+mH66hIIio8mgukgZ7tWEsJkeB2Ooam91vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897690; c=relaxed/simple;
	bh=Itu0zuJP1QIEVm1n4HhqMKHpUvYrOj/M/IwsB44LALk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lSLCTfOcXWKHaPxWzYQ7CL9SyWJ562gbOy+5+QTeLkDkFf7FWufgpKTC+nC6zvGBLJwPKvpcPTpy98allDmUx/OzLMV4VmcqS4t2N7R1b0yjRxviAXKL/N0Ln39S55TDN0kuwySA4sEWVvnyrPjMHHDLSMw+pcRvUQgf48huCFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HRscMH2h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1mucl8Ro; arc=none smtp.client-ip=193.142.43.55
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782897683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1P4DveztDZLFBBvdim/QuvRX0fea6opwzUnSRtwBTe4=;
	b=HRscMH2hEk4eFGUvQRMinz684fRtcSCcw5V4/tuazqcpITge1r2Snu5ZI+GSEypf/FhoAe
	gsWFPF4w2pOX5O23bj2A2+e14GOFmVSVjTKZvi08LkUmrZbtLxJ1OraI9Wncb9xqZGX+AO
	g6ZDnm5A8e5WjwCjwI4iqVxJtiocghy/ugPMlcC+1sJIClQg452i7tJQtFNf9fjluEklNQ
	uFhQusHiZ2NC6sJS3O+GxMdpc5FLTgu2mH2Kpo63VWowLFvaj7yNbSxWtptLBxH9vELxuf
	1GvndWdqvp1PKehu/TMkzZnrOO+JRJZby0rz8z3odwxwPgH3+y8Ld1TWsxKhuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782897683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1P4DveztDZLFBBvdim/QuvRX0fea6opwzUnSRtwBTe4=;
	b=1mucl8RoLD4zN8QqUTRXyO6tbfnnY213qFutYvpjOm9WGT9iYQgw5j+FSXl6olxZ2KdUPx
	82boq77Um+Bh9kDA==
Subject: [PATCH 0/2] riscv: vdso: Do not use LTO for the vDSO
Date: Wed, 01 Jul 2026 11:21:21 +0200
Message-Id: <20260701-riscv-vdso-lto-v1-0-89db0cd82077@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNtxA5eRRykphqQVhopgvTuF
 sc3/P+CchZWmLoXMhdRSbHB9h34Y407o2zNQIaccYPBLOoLlk0TnndCWkfvgiFrHUGLrsxBnn8
 4L7V+C4C6dGAAAAA=
X-Change-ID: 20260630-riscv-vdso-lto-2a5c6f021162
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Wende Tan <twd2.me@gmail.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 kernel test robot <lkp@intel.com>, stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782897683; l=689;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Itu0zuJP1QIEVm1n4HhqMKHpUvYrOj/M/IwsB44LALk=;
 b=yCwSaWupVhWoA1E000vsVKYKin3V7oT+/pgmoTsgEDzbWh4agJ/uW0jiPhkilk7osRTAnBdLr
 UeBAOy5J1XlAH/cyvV+0ARleJLysbJh/5lo/rEMlwYZhWWTIlGTd5dt
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:nathan@kernel.org,m:conor.dooley@microchip.com,m:twd2.me@gmail.com,m:palmer@rivosinc.com,m:linux-riscv@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:namcao@linutronix.de,m:thomas.weissschuh@linutronix.de,m:lkp@intel.com,m:stable@vger.kernel.org,m:twd2me@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-270121-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,dabbelt.com,eecs.berkeley.edu,ghiti.fr,microchip.com,gmail.com];
	FORGED_SENDER(0.00)[thomas.weissschuh@linutronix.de,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFDBE6EB8DD

With LTO enabled the compiler assumes that the vDSO functions are not
used and optimizes them away completely.

Disable LTO for the vDSO, as these functions are hand-optimized anyways.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (2):
      riscv: vdso: Do not use LTO for the vDSO
      riscv: vdso: Simplify cflags remove logic

 arch/riscv/kernel/vdso/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260630-riscv-vdso-lto-2a5c6f021162

Best regards,
--  
Thomas Weißschuh (Schneider Electric) <thomas.weissschuh@linutronix.de>


