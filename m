Return-Path: <stable+bounces-217734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJsBMQM+nGklCAQAu9opvQ
	(envelope-from <stable+bounces-217734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:46:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631F175A9B
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 12:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC189300A8E0
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BF61A0BD0;
	Mon, 23 Feb 2026 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="ddAhWS7J"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7D21F5846
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771847168; cv=none; b=Cv9r4fWb/9qpyvKPCYaGhXoonicm0nJ4g5MyOgi6FRGI5hfia6GgZPAwmfmVnn4w02kZhy70FXMc5hFA68xdCTkxKGZxLt9ebl6jsj2K/chNygasqiP/fpsyr3yS6Nk3NdZI8qKeyGs1Sxucte5iliGaZsG+qSyEeRX7AjYJ5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771847168; c=relaxed/simple;
	bh=vgdOfHYHELlnJFoL3GM9WeoNXMGxfeFxlL8+UdQpeyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kb0522YOegujL9ZtP+8N7KTGpkwiCvNIgzc4R21Pw0hEniGrDsgfbtPQWibX2SVGzovBRJsmm4y2UgtLVLpG6ptE6F4yocdVkqovqurIY4yK6c5O9J2GlOxFQNPAtmrQKiVT/u7lH8YWJyHAR02k2yV+/cwXgYFmkk7hKYeCE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=ddAhWS7J; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1771847161; x=1772451961; i=natalie.vock@gmx.de;
	bh=PcoQpiSLqGlTbhPyGX90b6puX2R8XcKjDGh+e3FPiCA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ddAhWS7JyE6iOK4hIGEeN/GlC1jBk3A9Pki+D6JeM46YW2LyAN6pPvWquUdLzWLh
	 UShrULc4jJdAgYwWfyF6NqklHyKplt94ZkVO8Mx2SgPOrktLBZxcweOf0HGJaKrD6
	 epdXvi+IKbOWG8sjqoQTPZgiV2t00tcSb9CCpm5CtgJBxczGK7ZtYJkvl6EFhtalB
	 TRI11gX8HAMWUiVrldlMUQoa9M4wgIwQzRk8C1YarWeJgsLwV3mgeDouRlNcnbCmb
	 YzuuRZwZwvlhnTrSsKuaCBXyNmHCmEgNok+h0OaqGBk8kpSVwwcZVVKT//JhQFZjI
	 dgr1bTUVfB/kOAoZ3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rizzler.fritz.box ([88.133.252.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvK4f-1vdMyX3d0z-00quGp; Mon, 23
 Feb 2026 12:46:00 +0100
From: Natalie Vock <natalie.vock@gmx.de>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>
Cc: amd-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Use GFP_ATOMIC in dc_create_stream_for_sink
Date: Mon, 23 Feb 2026 12:45:37 +0100
Message-ID: <20260223114537.38145-1-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t/hBrkRfBrWp0UhQ+7vHjNRHLl8fnAP5mzvf7af82ZN/WoJ6aoF
 lGGeqkoL5Fj8PpO2zhIYe1bUtP2hUKAk1nUgL50JGLPj6OFuorcFe6vNUTeztY9RNGxpX1A
 erMTlSdi063XsizslhJ17ehbDOOIOGNuYsADHDXGM6yfWW2gB1KG9SUQNOyuDtlYU/iWiu/
 UJ6Fb6P1ZD8y3DsHJG67w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u/XyADBLK5A=;7c5cykvYvlksdq9yqoYC2PBT5YG
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217734-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[natalie.vock@gmx.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:mid,gmx.de:dkim,gmx.de:email]
X-Rspamd-Queue-Id: 2631F175A9B
X-Rspamd-Action: no action

This can be called while preemption is disabled, for example by
dcn32_internal_validate_bw which is called with the FPU active.

Fixes "BUG: scheduling while atomic" messages I encounter on my Navi31
machine.

Cc: stable@vger.kernel.org

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_stream.c
index 191f6435e7c64..87c0cf7e290ea 100644
=2D-- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -170,11 +170,11 @@ struct dc_stream_state *dc_create_stream_for_sink(
 	if (sink =3D=3D NULL)
 		goto fail;
=20
-	stream =3D kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
+	stream =3D kzalloc(sizeof(struct dc_stream_state), GFP_ATOMIC);
 	if (stream =3D=3D NULL)
 		goto fail;
=20
-	stream->update_scratch =3D kzalloc((int32_t) dc_update_scratch_space_siz=
e(), GFP_KERNEL);
+	stream->update_scratch =3D kzalloc((int32_t) dc_update_scratch_space_siz=
e(), GFP_ATOMIC);
 	if (stream->update_scratch =3D=3D NULL)
 		goto fail;
=20
=2D-=20
2.53.0


