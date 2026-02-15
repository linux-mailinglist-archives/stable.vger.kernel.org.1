Return-Path: <stable+bounces-216600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKSpK+oRkWnRewEAu9opvQ
	(envelope-from <stable+bounces-216600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 01:23:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D31113DD15
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 01:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 450B13012CC0
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 00:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902017B50A;
	Sun, 15 Feb 2026 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fAzw/vJo"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2DC42AA9;
	Sun, 15 Feb 2026 00:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771114979; cv=none; b=J7VGGZdDMac/13m84/RZ18CKoenTTINmsrf9t+jjgS3GGGrmS+cez/b+QxZxAOUjjZtjabraYdNOcQU54ypR1Le7+eNlSaNnbrTATIsFNH5kY09gKaKlBScssf5Lt2RFSxV657L86s6L+C1t5jSGFeBBSymvsuBbME5W+d0vUHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771114979; c=relaxed/simple;
	bh=oJT6TjXlSm4w7F9vF23Hoz9HGuEu0EhzhtQZT+102e4=;
	h=To:Cc:Message-ID:From:Subject:Date; b=cG9a8w/y2FU+ix5kD5kBlbow/bi4N/JauwhXSRW4m4O2AGnGXLQYA2yK0ySNOiDAPRpvexEMyDWSC381LsX6ZaXSdTL6Flso/9UpeZkj3/hWFZ4a9tb5FjTSiVM//hVpkR/6ORInPxTyHLWksK/8gxDN4Wp4G9iw4TrAjvaefOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fAzw/vJo; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EEA6F7A0010;
	Sat, 14 Feb 2026 19:22:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 14 Feb 2026 19:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1771114975; x=1771201375; bh=hc2F8xxBgw9KFLMT7GGYPqWvc2/v
	LKLhR9u451GcYGM=; b=fAzw/vJoD4OA++mzSv7rPKdhnwXiJFxFF8L1eN2Lnsdp
	8dsGqWc/v5Iny/jI+26i/HYJIVmk5QIDNGp8wjvDNSlCayGxAb/433cq06R6xVC8
	zpVFirCnEOeXk89Cd2KiS+eCjCPsK6frOKVx/hLb/aKmQDt7/eewhAQYQFZNPOCf
	T+Wa+cT7OyHAD9ZvIsYO5fquQVPcWsoflpy2mf5YsXCN0T18QUshBD/o5r9HEcKD
	93Mtde2G+1JTdYeOSjfmTlgyCUfeKHgHt+FNBQzSMhnioSLdMgc8oH1jV/9KfiGj
	bKDVQBH2ABn1FtRO4rw7SFnSqrYl3Manie1Z2D8J1A==
X-ME-Sender: <xms:3hGRaRFBSZ-wixRZ882PFQBCq2seclqI1OwLrLEFrBn-QN8M7LTf5A>
    <xme:3hGRaS7hHdQ99m5LFmr7hxVm8vtf2aLv52B7DbfklWFfxVvOTEpa5j4eHuw6mZ_CM
    EaE6WuCm7wM_hnqmEXlS51YnHjriSOmfUkbQ9UHTK3sXYdiZSXaG74>
X-ME-Received: <xmr:3hGRaXltFhfl8XPh2kMrmcBs_-93fWCVLJPVDy5dwIgtlpYHP-hJBHLJjsQK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddvheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepvfevkffhufffsedttdertddttddtnecuhfhrohhmpefhihhnnhcuvfhhrghinhcu
    oehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ehfffggeefveegvedtiefffeevuedtgefhueehieetffejfefggeevfeeuvdduleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinh
    eslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrd
    gtohhmpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhi
    ghhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshht
    rggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqhh
    grrhguvghnihhnghesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhmthgusehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3hGRad5T6ATE_vJgdFk5xWyKGWNArPEh3uG-VxlbzGzXHQBrgMJrUg>
    <xmx:3hGRaYQBCwOjV2BkMkwFfAROFHD_LTYiyvZ7sO69rVRcueGOomu-sg>
    <xmx:3hGRaby0vuUEW5XKErtaLXaxmE82IPweYfpI-MLPDCYgK6yxjzsfdw>
    <xmx:3hGRaQpFpGG7GUnYK-oOTPa_ewvSwIusT5iIAeCYQRRmFRm-4Yr8oA>
    <xmx:3xGRad8IAf8GkErZGecpHHYgVU64nmYTMllA1M_rYIj9p3VzcKTMgAGL>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 19:22:53 -0500 (EST)
To: Miquel Raynal <miquel.raynal@bootlin.com>,
    Richard Weinberger <richard@nod.at>,
    Vignesh Raghavendra <vigneshr@ti.com>,
    Miguel Ojeda <ojeda@kernel.org>,
    Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org,
    linux-hardening@vger.kernel.org,
    linux-mtd@lists.infradead.org,
    linux-kernel@vger.kernel.org
Message-ID: <92af570970aadee773f2b0b18179efef0f34be93.1771114891.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] mtd: Avoid boot crash in RedBoot partition table parser
Date: Sun, 15 Feb 2026 11:21:31 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216600-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	DKIM_TRACE(0.00)[messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fthain@linux-m68k.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1D31113DD15
X-Rspamd-Action: no action

Given CONFIG_FORTIFY_SOURCE=y, and given a recent compiler,
commit 439a1bcac648 ("fortify: Use __builtin_dynamic_object_size() when
available") produces the warning below and an oops.

    Searching for RedBoot partition table in 50000000.flash at offset 0x7e0000
    ------------[ cut here ]------------
    WARNING: lib/string_helpers.c:1035 at 0xc029e04c, CPU#0: swapper/0/1
    memcmp: detected buffer overflow: 15 byte read of buffer size 14
    Modules linked in:
    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0 #1 NONE

I couldn't see how memcmp() exceeds the buffer here, so the simplest way
to prevent the regression was to perform memcmp() on the original name
rather than the copy.

Cc: stable@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Fixes: 439a1bcac648 ("fortify: Use __builtin_dynamic_object_size() when available")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
I put commit 439a1bcac648 into a Fixes tag because git bisect identified
that commit as the source of the regression. But I don't know anything
about __builtin_dynamic_object_size() or its limitations. So perhaps the
real bug lies elsewhere. The compiler I'm using is this one:

$ armeb-softfloat-linux-musleabi-gcc --version
armeb-softfloat-linux-musleabi-gcc (Gentoo Hardened 13.4.1_p20250807 p8) 13.4.1 20250807
---
 drivers/mtd/parsers/redboot.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/parsers/redboot.c b/drivers/mtd/parsers/redboot.c
index 3b55b676ca6b..6e253f6c45c9 100644
--- a/drivers/mtd/parsers/redboot.c
+++ b/drivers/mtd/parsers/redboot.c
@@ -269,14 +269,14 @@ static int parse_redboot_partitions(struct mtd_info *master,
 		parts[i].name = names;
 
 		strcpy(names, fl->img->name);
+		names += strlen(names) + 1;
+
 #ifdef CONFIG_MTD_REDBOOT_PARTS_READONLY
-		if (!memcmp(names, "RedBoot", 8) ||
-		    !memcmp(names, "RedBoot config", 15) ||
-		    !memcmp(names, "FIS directory", 14)) {
+		if (!memcmp(fl->img->name, "RedBoot", 8) ||
+		    !memcmp(fl->img->name, "RedBoot config", 15) ||
+		    !memcmp(fl->img->name, "FIS directory", 14))
 			parts[i].mask_flags = MTD_WRITEABLE;
-		}
 #endif
-		names += strlen(names) + 1;
 
 #ifdef CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED
 		if (fl->next && fl->img->flash_base + fl->img->size + master->erasesize <= fl->next->img->flash_base) {
-- 
2.49.1


