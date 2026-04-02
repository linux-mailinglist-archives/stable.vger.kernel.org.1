Return-Path: <stable+bounces-232967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOQWMiFAzmlQmQYAu9opvQ
	(envelope-from <stable+bounces-232967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:08:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 063DC387781
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 12:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CCDB303527A
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 10:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AEE3DD50D;
	Thu,  2 Apr 2026 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b="ErXhcK0R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P1mtd33L"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE053D3D09;
	Thu,  2 Apr 2026 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124342; cv=none; b=sAHfoL1wt+fH9Vku0w5VZQdMp+jzsozsVQx+G2fwaqLB25fDfSYhvlHimVI07TjZr0WS3lzbe+WxhUJC7AuU15yE2e2vs5iQJyb9LH06dumX6f1lmEHXUuPuaY8OlDjxDUEPsDQCAIMdh2ENlCI8jqrrRXMl5d6ok3qvc7ysGiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124342; c=relaxed/simple;
	bh=b2JNMs0NZ18PorNCvdnpqWu24AHCLQdIaeRbgJrvROE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=dvRdmCRUxg6RdmrCAsNQ9YsUr857ctBxjBTr4TRjh9wQx4sGx9h+nZmH1jtq1nmAKe4CCM4DQuZlDP3+j3sdqUr+b3FiHMHM3Xzj19Q8mBVtB+RN+Qmz7R0QYLYLsnByj0YIdLk2L9jzY9mxqljSupLGeJTAhXb92LUhc/XXihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh; spf=pass smtp.mailfrom=barre.sh; dkim=pass (2048-bit key) header.d=barre.sh header.i=@barre.sh header.b=ErXhcK0R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P1mtd33L; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barre.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=barre.sh
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2ED5E1400034;
	Thu,  2 Apr 2026 06:05:40 -0400 (EDT)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-06.internal (MEProxy); Thu, 02 Apr 2026 06:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barre.sh; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1775124340; x=1775210740; bh=OB
	IVJ+q0wfIwTSriESzZgxCy2O/5HaujjjBF4P444r8=; b=ErXhcK0RECxP2OB3on
	tW9Tzcd5SZESNv+s9HtDTpHY34Y4sSAjz62inSyLtIg4FUt75oDRWog9iaHGI/Li
	X5KIgSnVqlHOEkhTyscjSCuSn2yzclGm6bDUNCEfIEn6yiMzHZ9x+S1zVM1dISXC
	qpKF8DvhbNcsPOdN84zV00nD80IEJkTSh6QVlomXht+Cudscev929a04E/wcTruQ
	pKdQ1norj0HSiwD0Hxjx912PsnYmiVjkAbDgb2oKUmn+oa8qvRnGpdGJSiY6/B0C
	E64e5iL8dP66UdP9utW+MNZglq5LyVxwRinRbKO9n9YaIMrjZO8lBhzKydPPsX1s
	1mDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1775124340; x=1775210740; bh=OBIVJ+q0wfIwTSriESzZgxCy2O/5
	HaujjjBF4P444r8=; b=P1mtd33LjSCeV7UO7GiTLidBqXgmJI9MlI6Jt+40A+Np
	Meu3zWI9D/kj7xjf9/3PYpfGu8tnMBclxxTKI6lqPTYXT1M6LMBbMU2DQ4Womkeg
	rktgu8cvNB/tJNCde1xiKTP3JctDyaMfTq243FkKgIgh8LvQImdVRJvNFtpncpm+
	b1kgQHP+Rcm8eGfNXuf1LAJFWmiQr+skUecW04yzlQ6c8SRQsFuLxHhl6JqkVmLW
	QOS0eMp1S3Cg3Oz+13AbgQz5eMVaIiFQYPboQWN2jQLNq7judKpGeLU30SNcoewI
	l6oi9v8eppFgXFoAi/EYWn8ntoDUdI54Hnm9H/IgwA==
X-ME-Sender: <xms:cz_Oad3FWf8mIl_q_tjrsplR3G6K9ScU-PvmqHHwxurtDCTwhVzevQ>
    <xme:cz_Oae6gSEqELibO7c_vSRqHGdJGGHIdpNCYJ9HtjVpD9ZqcuTjZ4SUi0Wd2E4cLp
    R23Qqi8ZzDyiX1ZDsRakaClt-0fWVxhsw29EfxWmwQXMr8D86wxPds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkufgtgfesthejredtredttd
    enucfhrhhomhepfdfrihgvrhhrvgcuuegrrhhrvgdfuceophhivghrrhgvsegsrghrrhgv
    rdhshheqnecuggftrfgrthhtvghrnhepjeffuefggfeuieehtdegfedujeektedugffhge
    dukeegfeeggfeludfhteefhfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhivghrrhgvsegsrghrrhgvrdhshhdpnhgspghrtghpthhtoh
    epkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghsmhgruggvuhhssegtohgu
    vgifrhgvtghkrdhorhhgpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshi
    htvgdrtghomhdprhgtphhtthhopehluhgthhhosehiohhnkhhovhdrnhgvthdprhgtphht
    thhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvhelfhhssehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepshgrnhguvggvnhesrhgvughhrght
    rdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cz_OaemYHESD7Dy3sisVS7d8GUP3lOf7T0WwbBZa3aw2FtatnKJmZw>
    <xmx:cz_OaYZRDun6q6Y5OKr24vz2DbWNGTk2989AIiOIOVlNuXV99GpX9w>
    <xmx:cz_OaQTv_PrcAIPaKlmfVCAsJ-ReNadjyHEGxNw4nvMuFqc2C9aH5Q>
    <xmx:cz_OaSsSrPnuiwyKMWcw-GI_bxsbh1BdMCEaz98OuUjIQRSryNyg6w>
    <xmx:dD_OaWSn6LGsGTk_NoCo5EOoG__rPn2EV44qiFEXswBS2tnqzLaBqXeu>
Feedback-ID: i97614980:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 87FE8B6006E; Thu,  2 Apr 2026 06:05:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Apr 2026 12:03:12 +0200
From: "Pierre Barre" <pierre@barre.sh>
To: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org
Cc: linux_oss@crudebyte.com, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, sandeen@redhat.com
Message-Id: <0ddc72da-d196-4f01-8755-0086f670e779@app.fastmail.com>
Subject: [PATCH] 9p: fix access mode flags being ORed instead of replaced
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.65 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[barre.sh:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	DKIM_TRACE(0.00)[barre.sh:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232967-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[barre.sh];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pierre@barre.sh,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 063DC387781
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 1f3e4142c0eb ("9p: convert to the new mount API"),
v9fs_apply_options() applies parsed mount flags with |= onto flags
already set by v9fs_session_init(). For 9P2000.L, session_init sets
V9FS_ACCESS_CLIENT as the default, so when the user mounts with
"access=user", both bits end up set. Access mode checks compare
against exact values, so having both bits set matches neither mode.

This causes v9fs_fid_lookup() to fall through to the default switch
case, using INVALID_UID (nobody/65534) instead of current_fsuid()
for all fid lookups. Root is then unable to chown or perform other
privileged operations.

Fix by clearing the access mask before applying the user's choice.

Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
Signed-off-by: Pierre Barre <pierre@barre.sh>
---
 fs/9p/v9fs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 057487efaaeb..05a5e1c4df35 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -413,7 +413,11 @@ static void v9fs_apply_options(struct v9fs_session_info *v9ses,
        /*
         * Note that we must |= flags here as session_init already
         * set basic flags. This adds in flags from parsed options.
+        * Access flags are mutually exclusive, so clear any access
+        * bits set by session_init before applying the user's choice.
         */
+       if (ctx->session_opts.flags & V9FS_ACCESS_MASK)
+               v9ses->flags &= ~V9FS_ACCESS_MASK;
        v9ses->flags |= ctx->session_opts.flags;
 #ifdef CONFIG_9P_FSCACHE
        v9ses->cachetag = ctx->session_opts.cachetag;
--
2.51.0

