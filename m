Return-Path: <stable+bounces-233219-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH60HX3uz2mt1wYAu9opvQ
	(envelope-from <stable+bounces-233219-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:44:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDA93968E1
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D157F307F3C5
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A943C871F;
	Fri,  3 Apr 2026 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pnadlJP8"
X-Original-To: stable@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029F43CCA1D;
	Fri,  3 Apr 2026 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233886; cv=none; b=AIjQgjELvgTT7Ro9vN2LnqcHMXawt/jv+T4TrCMD+etv/paG+L8LxytCgvkddZrBySJUjMHQbTO0nZ2fG8YfQltByTp3/ptFnCKb+2MkfrynN2+v9XCkR16+cE2gjDuzasLjWBWNWDWqbVylURHnMNCDe1c5i0dmUuz9T7P5T9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233886; c=relaxed/simple;
	bh=DwohHeR6He+C6jeEH9sUwybI3hfKZHSZ9HBA1p58eXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R4A4xdPnLomwTWog88ceuCNc7kFIbjQPDbprBki7/kZNoB2mWkjWBImJ0nccPqO2C7x3VLoVe/xFRKRUqYwRg7D3lFdtSSYOEMBF07fwXjs7d5OFgBkgR2YENgH8+GY4Y+marcevCz5r4G7p/5WoWlUAEJnhrmtmCm8MWGPigzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pnadlJP8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775233882;
	bh=DwohHeR6He+C6jeEH9sUwybI3hfKZHSZ9HBA1p58eXY=;
	h=From:Date:Subject:To:Cc:From;
	b=pnadlJP8ZcS8Imw9YrQRGC3f2TNPiQlKINKbsQtqP5xLBK3b6dgfwnJfPRHxd1b6R
	 Lw0o85n1INQXIYyguZhyUqLXwdW+dp69TUvEEfh4IgWua3reVR6nFV0MGy2KYV0khG
	 /dssda377FG3yYrZI9ckQX9IrkwznluRUzuMJ8XQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 03 Apr 2026 18:31:02 +0200
Subject: [PATCH] sysfs: attribute_group: Respect is_visible_const() when
 changing owner
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-sysfs-is_visible_const-fix-v1-1-f87f26071d2c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqCQBCF4VeRuW5gXc2wV4kQdx1rRNbYY5GI7
 +5al//h8K0EiSqga7ZSlI9Cp5AiP2Xkn214CGuXmqyxlSlNwVjQgxXN8XWjNH4KmLnXL19K15n
 a2qKtzpSAV5Q0//Db/d94u0H8fIi0bTvCSPhXfgAAAA==
X-Change-ID: 20260403-sysfs-is_visible_const-fix-74bd09223a65
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775233882; l=1665;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DwohHeR6He+C6jeEH9sUwybI3hfKZHSZ9HBA1p58eXY=;
 b=/QTYnQmnzXz1SH3soqIB6CMOi1Ys68J8fSh/Eva/hkxqQplf1IZDILysuFZUzz+y4Cmynl3cT
 h0bgfK6w77cD8F1PFy+khkEAKtkZihEU16la5nL9P+CoYmuTeRrTFUB
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,outlook.com,weissschuh.net];
	TAGGED_FROM(0.00)[bounces-233219-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,weissschuh.net:dkim,weissschuh.net:email,weissschuh.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 6CDA93968E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The call to grp->is_visible in sysfs_group_attrs_change_owner() was
missed when support for is_visible_const() was added.

Check for both is_visible variants there too.

Fixes: 7dd9fdb4939b ("sysfs: attribute_group: enable const variants of is_visible()")
Cc: stable@vger.kernel.org
Reported-by: Michael Kelley <mhklinux@outlook.com>
Closes: https://lore.kernel.org/lkml/SN6PR02MB4157D5F04608E4E3C21AB56ED45EA@SN6PR02MB4157.namprd02.prod.outlook.com/
Link: https://sashiko.dev/#/patchset/20260403-sysfs-const-hv-v2-0-8932ab8d41db%40weissschuh.net
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Currently there are no implementations of 'is_visible_const()' in the
tree, so this should not affect any code.
---
 fs/sysfs/group.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index e1e639f515a0..989edd6c6c23 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -517,8 +517,11 @@ static int sysfs_group_attrs_change_owner(struct kobject *kobj,
 		struct attribute *const *attr;
 
 		for (i = 0, attr = grp->attrs; *attr; i++, attr++) {
-			if (grp->is_visible) {
-				mode = grp->is_visible(kobj, *attr, i);
+			if (grp->is_visible || grp->is_visible_const) {
+				if (grp->is_visible)
+					mode = grp->is_visible(kobj, *attr, i);
+				else
+					mode = grp->is_visible_const(kobj, *attr, i);
 				if (mode & SYSFS_GROUP_INVISIBLE)
 					break;
 				if (!mode)

---
base-commit: d8a9a4b11a137909e306e50346148fc5c3b63f9d
change-id: 20260403-sysfs-is_visible_const-fix-74bd09223a65

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>


