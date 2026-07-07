Return-Path: <stable+bounces-272421-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sr6hH1ACTWq3tQEAu9opvQ
	(envelope-from <stable+bounces-272421-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 15:42:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF80971C0BD
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 15:42:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=TkG9zTyI;
	dmarc=pass (policy=none) header.from=uniontech.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272421-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272421-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E40630831C2
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 13:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A441DECC;
	Tue,  7 Jul 2026 13:34:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2510417377;
	Tue,  7 Jul 2026 13:34:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431282; cv=none; b=Ym9+Sx2XxNVQKLp4zRH3AFrmWrC3aWXbxiomFc6bGyi+R7D7zeqIG5z45pj5k9V4UcrsStczEAl7d5sowPfGpFtqqoB+4t7FtoAYWB4Y6aQLB/RqmhT/77+i1dMifh312cBCPniQnSm9hv5CTLsPxdiL+nl2kmAyX8OrfhB0cCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431282; c=relaxed/simple;
	bh=jUI1qV9VD5IxV0nXURWdYflHBGg6qxd/F3KLa5t7GZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnLRgc2avTGl2T/C0soRJvEqhBBZfr7TJGTVf8TqHU01vL+Ov2k7o+vEARus2ZqQ5o+IsKn69Kn0KWcRq6/ITsJSOFqjAizH4fvJX6JDGaR7LEB5D8+zhIhofDuHp+2hJfhKHEKqKHJVsZdktwSO+vmzZ0hB133PhSsVm7NCsIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TkG9zTyI; arc=none smtp.client-ip=52.59.177.22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783431040;
	bh=FuSCBLVvv4L1GcyaoN9C6ajZQbigk6a5pztB/Oe/m1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TkG9zTyIECk8+ZwfncAnExscAguG4/4EiBzthkN5A4YrpnJWDh9k3k5JQkkUxUhjm
	 meeLZIEO55bYopYq0BCbbZXnS/rC4WiAvCRUkMPl6dcZEGCVuj2KwCO3g+4KxaZEo1
	 neut0YiTLCY/bDvcfa3ZEy34DIaEeeQRnlMpY+GU=
X-QQ-mid: zesmtpgz3t1783431021tf8d3d2cc
X-QQ-Originating-IP: Ag94DlRjyrKwRRZEb/rWu8LTRKzMEkpw5cJctes/Xmo=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Jul 2026 21:30:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11051013519330704719
EX-QQ-RecipientCnt: 11
From: raoxu <raoxu@uniontech.com>
To: sfrench@samba.org
Cc: pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] smb: client: fix atime clamp check in read completion
Date: Tue,  7 Jul 2026 21:30:17 +0800
Message-ID: <527C2DB5ABAE200F+20260707133017.1740557-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MtZUceor8KoR7QWpNJ9mSu9TmZxIv4ITP0dzyYoEgP2gPYCZ53Usx7LN
	GeUEzdkHQ1EWYGkcx7BlGMrCrLUzeaqQ0MieOj0VD1n5YrYH9mXnmcqYjpcAxUwj9XuRl+v
	aI5KUhRkodszAv9qZYf8Tdfz4tiKhy+rszA7bdZ3UU2VGdf9iOtuiXlwA99rAHz2fwlpK9E
	3DxTr5HPZvlJSqcstJI7PKmIxyw/0B831+Rvu+ymn5jbRgiLIfg57npgUtBwy70XfZ2FQdr
	NVAa7d+VMSn2kHxiLURcUBGiV4rHghKcEhL5DZCQc7CzitCWuDnTonXg/Pk6+Qcl+o7GUv4
	z5ejm5EtBvwcqxcW4gFO/StGO2V9Ma6+qk3on2WxK+TlYM6fhqhM2WLPCJhUuSRzxkEEWfG
	VEnNXucqM1T0WUV6eXDqpB/tnu60XsmiX0TTVUQqfoKzY57TAteubBjIZWb09BKMkRtQ2+u
	/34EFrjCeh9sLibay8T9dqebhn0+NIpidlWXas+vc8EX0WfAl30coxk/qsUq+mhHvOdNpGC
	lRIWJ3tHoxosIx6aago6Iafo57WAOO9nztmD4jSu122UGm3Ai66aXRorwJkaYBqLOZspxqr
	UgVm1orYO6nEuRpW9Fvjp3uddmUmq1aZMMgQku4HADzNdP/KhnAGP95FqWmMS2SQAsWWtgI
	RzkZuRQg3ZsasAZPJU5rDYYrRhtvB4duHd+z3GAawEVehSNHyhAdUxAxCfj1QtoALL9PSCD
	H1ApCb752LZjScaalWYLgwhCq0Eke5fHc29q9qJ681cLiSzGmhIeIuQhrkXSzPAl+55R3sj
	43ofsuUhEKAd5XV+oEm21jpHwVm4MO5QebDXVW9y1VXeuXAPQNJRV5j2YsF4O/GhqmNCmxg
	PFiusE8QPJy4jEBzBXKID4FNBFEtW3tAfhIKWuGuxLOWKOxtJKBP+JybQ9HQP79xzrB4r1M
	dOxm55uCfhNGRX98u4V3UFAJr3g6oRTItH319hAMuoijMdoZcI+ZqXORtelDjT9YSbKMVeY
	cv6OZPI+3/MOLIMkIlkEolqXKMjLicwFY31FYlwu77TcZaDBSA8JvP6+gm6loGQhVlJ3jX7
	5TIcE7gMSkfbEcJsGQWziseKNyCwofqzw==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,vger.kernel.org,lists.samba.org,uniontech.com];
	TAGGED_FROM(0.00)[bounces-272421-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-kernel@vger.kernel.org,m:raoxu@uniontech.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,uniontech.com:from_mime,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF80971C0BD

From: Xu Rao <raoxu@uniontech.com>

cifs_rreq_done() updates the inode atime to current_time(inode) after a
netfs read.  It then preserves the CIFS rule that atime should not be
older than mtime, because some applications break if atime is less than
mtime.  That rule only requires clamping when atime < mtime.

The current check uses the raw non-zero result of timespec64_compare().
It therefore takes the clamp path for both atime < mtime and
atime > mtime.  The latter is the normal case when reading an older file:
the newly recorded atime is newer than the file mtime.  The completion
handler then immediately moves atime back to mtime, losing the access
time that was just recorded.  Userspace tools that rely on atime, such as
stat, find -atime, backup tools or cold-data classifiers, can therefore
see a recently read CIFS file as not recently accessed.

This is easy to miss because the bug is silent: read I/O still succeeds,
no error is reported, and many systems either do not check atime after
reads or mount with policies such as relatime/noatime.  It becomes
visible when a CIFS file has an mtime older than the current time, the
file is read, and the local inode atime is inspected before a later
revalidation replaces the cached timestamps.

Clamp only when atime is actually older than mtime.  This matches the
same atime/mtime rule used when applying CIFS inode attributes.

Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 fs/smb/client/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 58430ba51b10..62605928d2b8 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -301,7 +301,7 @@ static void cifs_rreq_done(struct netfs_io_request *rreq)
 	/* we do not want atime to be less than mtime, it broke some apps */
 	atime = inode_set_atime_to_ts(inode, current_time(inode));
 	mtime = inode_get_mtime(inode);
-	if (timespec64_compare(&atime, &mtime))
+	if (timespec64_compare(&atime, &mtime) < 0)
 		inode_set_atime_to_ts(inode, inode_get_mtime(inode));
 }

--
2.50.1


