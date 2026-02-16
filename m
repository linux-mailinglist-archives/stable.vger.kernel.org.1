Return-Path: <stable+bounces-216664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kImgDrfBkmkSxQEAu9opvQ
	(envelope-from <stable+bounces-216664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 08:05:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F42141307
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 08:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F78300D97F
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2C02609C5;
	Mon, 16 Feb 2026 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aeS4tgoj"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DB18C2C;
	Mon, 16 Feb 2026 07:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225520; cv=none; b=i1m8gKyG2uGndISbCiJt3uRl4pEbvHlaqaqACKZGN71hrYhXp4JeXhDxhOTI2YIBPqhqxFTzgGnturHoo4i3o7WOTA/VuMjC3etgoKUlDqC9r0kVdHKAiO0QP3egJHfcQ9j6F2Kk1so8qmr+4yQNcyblOf/ZDLeRvIM/Eb/W1Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225520; c=relaxed/simple;
	bh=9qNw/zDR7mcFIhjEdxURl42kfNjRDjBaMFVn9IgQVQU=;
	h=To:Cc:Message-ID:From:Subject:Date; b=T3oCBiE++7RU1QIDVrMJItIhBsfVCkdOKmMgnn/KbAq3ycaKP0M0iWeCG7rJx1xQqO/54Qz0iORnc9ESwC7VzqUoFak4DD1I2XVyn/xIldQkNPIerkRyZCTkJ/txwJro/Tnnyp3X0cY0skOOVudb7+An5OBnHYJ0QxJp7I2UcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aeS4tgoj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6445C14000B2;
	Mon, 16 Feb 2026 02:05:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 16 Feb 2026 02:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771225517; x=1771311917; bh=SqSMnR1aNHeLFEbaIrIJdQySfKhX
	CHZWc8Vomx9GKhE=; b=aeS4tgojApQXR2hzTYJTvi/eh5mPAyi0sdjCOrRaeEYC
	CmohH+mqxYzTxws4fv6JtyXD98tDnz3gBwS3gSHUHiTPTLLSU1rdvYlNgxe5+yZE
	xn+1mx4jS/Ac30NAhiZZ2DhnAN/99ApOa/zjtqCEkJGgFJbGsUo6JhtpapBhBaHr
	gpKBFNTWEV+MtNge3KZMJ4gO8syPRLxB058XSnkabLCQ49rD/TlLxM1q1ko6SEA+
	MDJ223ZbMwT7o7LPd9GBX4TL6XrAxtVhMkacmifj99CSvhu96A4c/+Fi0gNnsfXY
	SFMxjrPiKTnE3WsutsP+OSqAkJdbmXAdYoGQ+of4aw==
X-ME-Sender: <xms:rMGSafu06X_84LrxxZa5HPWSYAAf82VRziHSiAnwbyPrE0gGNQ1fFw>
    <xme:rMGSaTBxMyMhkEPl-2bi64wIDxL8ZJmc-SfUm8tkCigLnelpkYWSi85c7TzwSL38Y
    AIQ7qBuuD8Z-E_XE0PXYJ9OJ4TG60jIoOE90QHi7c5VVNeGJ_i06L8>
X-ME-Received: <xmr:rMGSaWYm9rPmoQ-4qrRoZFxClK-O9TrytPapaH0PAsh-PvHqW-shO9OSoytkT5WDPio__C3LzzBVPRzoygpEvtdd94nk-JVXA0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeivdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekffejgfehheehkeekffffveekteevvddvveelhffgffetteefgfeutdehleetheenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdp
    nhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhiqh
    huvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrihgthhgr
    rhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtg
    hpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvges
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhhrghruggvnh
    hinhhgsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhht
    ugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rMGSaeWy4q1bRth2zeRvN7PhjhaNZeEFtDfXBmts5lsf8Q39VRBwdw>
    <xmx:rMGSaVMZ3LjNHQ_ZaV0lSrmopi-jfDeyZnBFB3i6de38won0740bnA>
    <xmx:rMGSaYYQndhKMHGWEULjbW-SyiiQ8vWEufJgLPkjV2BBOvcYmFrhnA>
    <xmx:rMGSaU9pR5BptDKGzFeE4Fdc3OveaPopGEBXQpEyB6rsL8EA_DnMoQ>
    <xmx:rcGSaZg5QLDK6SeihI8K5VyTZIwYmT7GmkAPYxnb8XerNDJ_31VJSmw3>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 02:05:13 -0500 (EST)
To: Miquel Raynal <miquel.raynal@bootlin.com>,
    Richard Weinberger <richard@nod.at>,
    Vignesh Raghavendra <vigneshr@ti.com>
Cc: Kees Cook <kees@kernel.org>,
    stable@vger.kernel.org,
    linux-hardening@vger.kernel.org,
    linux-mtd@lists.infradead.org,
    linux-kernel@vger.kernel.org
Message-ID: <e11761ba31af4fd1d310f40f9b6a1753a0227025.1771225290.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2] mtd: Avoid boot crash in RedBoot partition table parser
Date: Mon, 16 Feb 2026 18:01:30 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216664-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fthain@linux-m68k.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 94F42141307
X-Rspamd-Action: no action

Given CONFIG_FORTIFY_SOURCE=y and a recent compiler,
commit 439a1bcac648 ("fortify: Use __builtin_dynamic_object_size() when
available") produces the warning below and an oops.

    Searching for RedBoot partition table in 50000000.flash at offset 0x7e0000
    ------------[ cut here ]------------
    WARNING: lib/string_helpers.c:1035 at 0xc029e04c, CPU#0: swapper/0/1
    memcmp: detected buffer overflow: 15 byte read of buffer size 14
    Modules linked in:
    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0 #1 NONE

As Kees said, "'names' is pointing to the final 'namelen' many bytes
of the allocation ... 'namelen' could be basically any length at all.
This fortify warning looks legit to me -- this code used to be reading
beyond the end of the allocation."

Since the size of the dynamic allocation is calculated with strlen()
we can use strcmp() instead of memcmp() and remain within bounds.

Cc: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Link: https://lore.kernel.org/all/202602151911.AD092DFFCD@keescook/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/mtd/parsers/redboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index 3b55b676ca6b..c06ba7a2a34b 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -270,9 +270,9 @@ static int parse_redboot_partitions(struct mtd_info *master,
 
 		strcpy(names, fl->img->name);
 #ifdef CONFIG_MTD_REDBOOT_PARTS_READONLY
-		if (!memcmp(names, "RedBoot", 8) ||
-		    !memcmp(names, "RedBoot config", 15) ||
-		    !memcmp(names, "FIS directory", 14)) {
+		if (!strcmp(names, "RedBoot") ||
+		    !strcmp(names, "RedBoot config") ||
+		    !strcmp(names, "FIS directory")) {
 			parts[i].mask_flags = MTD_WRITEABLE;
 		}
 #endif
-- 
2.49.1


