Return-Path: <stable+bounces-230163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDj2Ea6VwmkXfAQAu9opvQ
	(envelope-from <stable+bounces-230163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:46:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F464309A97
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06E583016AEC
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD873FD14D;
	Tue, 24 Mar 2026 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="zROQpkM1"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DB334D3B9;
	Tue, 24 Mar 2026 13:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359970; cv=none; b=eYGQ7CCvLZ8Sz9pdyhhltH9DwIZ78S6nak0dDAp7Fd/iBA39L56u26RgzvOjhUdKHpRvVHTlLR9DjFg+e7n8OprufllDJBvvbTh6hEBgnltoqHRqVd74xF9i3pRAsnCA/td6nZhdP7pe/ua3IcudbHIcyXRJBT0u3Sepd0t7K7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359970; c=relaxed/simple;
	bh=oHNkM4VKgurTg9rlwMIDBQKfPAYa+/1tHkDCCUjS+YU=;
	h=Message-ID:From:To:CC:Subject:Date:Content-Type:MIME-Version; b=k6IClINOVqy4ni0KEruRU+TH8JpJa+JFRnQDK8hrEKrnmzRinEZI/1vwuf5sQ2Lx67l9A+kEY7f8j7SVqUnW9KpdY9HUvQRW3b6clXrYakZtPwHSIjTU2kUAFOu2AgRp8GCG/hLsPh0YQcB9f10TtpbZVcnzG+dSrJQ/gE865Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=zROQpkM1; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1774359955; bh=4sTHTYkqT98YCnruH/w1X0fKZGEKl98lw5uVnIxLQ4s=;
	h=From:To:CC:Subject:Date;
	b=zROQpkM1gCdaOWjzVA57jOOgW0hEmaDfZ3hCCOdEWyAuYj7wCElmSrew02tP88+Bz
	 2vpJzpIijSakkcA1coYfUvoIj5JoS12PGfaWOL/QYpVs6soeDedz5SYw81kTngKyut
	 Z+FSxClUA5TEFuqGVvAKXFHsRguTco0Q7+rXsmjo=
Received: from SG2PR02MB5841.apcprd02.prod.outlook.com ([2603:1046:c01:910::5])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id B75014D9; Tue, 24 Mar 2026 21:45:53 +0800
X-QQ-mid: xmsmtpt1774359953ti46826kn
Message-ID: <tencent_EDC62D47C76FD4486F3B13D526674124CE07@qq.com>
X-QQ-XMAILINFO: N7Z3XQrOpILurQRAEf9OYZbwiWrjkFRXJMfciy2eL07748X0D50v5PuxmWLewp
	 8X/F+AhxT8mI1QffO9BOHpOxQ8KaFA+h24jGgEIgDwJqC72SSwVHPcrbo7ul4bknx+Oc40WJqr/O
	 UNGRmmLfUpVY6UQOH5+Y7PcE0s5OmYpZmvlqBbc/Mgdu/R/vpE2gGQC7Yu2TkCqXyiPXcMjnAJQJ
	 DDDDHxyxVhMMv3N+yzHCARJK4ItHKcasQYklOM0dW54XPIPrPW7EFKj1oY16Xg1tmoWGLrN104AF
	 8yzch9/k+h7tgKNlI8oP3AMJhe8INYOukvsKJ/9aCwhje9imu6kPmbISr+uz0kqraMmrSCygKSvh
	 QqSeSycr93mni+01wEwUdJr8JlonSx1qJATupRV2Mvy18wB5Xvq5lHXk7UKgVKgSZ99FKMogpFKs
	 Z5Z6kHtp95hsSTMw3i9NI835WFlsZZrExP/epQfKleJPJSzarP4wsrZhLKCe5RsRhFVk1vEQS2GL
	 dEnw+/BGuqKVAz+LI0EiwGMNIInqk4nsufz7S7lQUgTkdkYE/U8rkcpJsINjsWh/vDv0IW/uz6GB
	 uQF6q1P6PJr/Y72GhFtbcT3LDsbGg3tBIS5kxFmbESg2IRBLvWiZmnVtNsTnaDc0TR4KtnKj1oB0
	 IRB+HuxEb+uk9oeGWFW4wfTIGwYAs5dti4VQig5hCRszO59orjj53y6Kkayst7SD7W2xR1re/LyK
	 NXggl4nqAdbdDRJhUuHRoyZ7ME1cjkXV9r00rirCo6qScyTnGlJcSY1j4/fRo+arFmNMDmL8rJmL
	 8zVQS9pgqDqEwtAYr/fDWtSdeTxGiinyKZzUeGlzkIvS/ygg6BMn8SR9tZrfRtd8BtzF7UanX60O
	 IWZC4NAOLUJjVV6KyNSXUXJGIEiEEP1MXb3fLTx5px3EUeB79Q8bY8sNrHrspuFestd32/zMh5au
	 /Bd6aBBrAMt/TGwrVpUuiE20JEc6uMknjxvDHhepDU2w44boDyHM/EMANonQEv064TGIW0BV4EPM
	 QiznA8yDIBlX2GAKmUlJKlW461WXc=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: "driz2t@qq.com" <driz2t@qq.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "hch@infradead.org" <hch@infradead.org>, "djwong@kernel.org"
	<djwong@kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"leah.rumancik@gmail.com" <leah.rumancik@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com"
	<syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com>
Subject: [PATCH] iomap: don't invalidate folios after writeback errors
Thread-Topic: [PATCH] iomap: don't invalidate folios after writeback errors
Thread-Index: AQHcu5MDWVXtmvYYjUG63JPfg9TWNw==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Tue, 24 Mar 2026 13:45:51 +0000
X-OQ-MSGID:
	<SG2PR02MB58419261748074ED3C8C79EBF248A@SG2PR02MB5841.apcprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_DN_EQ_ADDR(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230163-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[driz2t@qq.com,stable@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[qq.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,c6104ecfe56e0fd6b616];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qq.com:dkim,qq.com:email,qq.com:mid]
X-Rspamd-Queue-Id: 8F464309A97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch is a backport to stable 5.15.y of upstream commit e9c3a8e820ed0e=
eb2be05072f29f80d1b79f053b=0A=
("iomap: don't invalidate folios after writeback errors").=0A=
=0A=
Fixes: 3330a8d33e08 ("iomap, xfs: fix page discard handling on shutdown")=
=0A=
Reported-by: syzbot+c0ffed3897231d71f047@syzkaller.appspotmail.com=0A=
Tested-by: syzbot+c0ffed3897231d71f047@syzkaller.appspotmail.com=0A=
Signed-off-by: Changjian Liu <driz2t@qq.com>=0A=
---=0A=
 fs/iomap/buffered-io.c | 1 -=0A=
 fs/xfs/xfs_aops.c      | 4 +---=0A=
 2 files changed, 1 insertion(+), 4 deletions(-)=0A=
=0A=
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c=0A=
index 87a4f5a2ded0..1f0bfe0b8bae 100644=0A=
--- a/fs/iomap/buffered-io.c=0A=
+++ b/fs/iomap/buffered-io.c=0A=
@@ -1350,7 +1350,6 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,=
=0A=
 		if (wpc->ops->discard_page)=0A=
 			wpc->ops->discard_page(page, file_offset);=0A=
 		if (!count) {=0A=
-			ClearPageUptodate(page);=0A=
 			unlock_page(page);=0A=
 			goto done;=0A=
 		}=0A=
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c=0A=
index c8c15c3c3147..56a5bd7ad8c4 100644=0A=
--- a/fs/xfs/xfs_aops.c=0A=
+++ b/fs/xfs/xfs_aops.c=0A=
@@ -450,7 +450,7 @@ xfs_discard_page(=0A=
 	int			error;=0A=
 =0A=
 	if (xfs_is_shutdown(mp))=0A=
-		goto out_invalidate;=0A=
+		return;=0A=
 =0A=
 	xfs_alert_ratelimited(mp,=0A=
 		"page discard on page "PTR_FMT", inode 0x%llx, offset %llu.",=0A=
@@ -460,8 +460,6 @@ xfs_discard_page(=0A=
 			i_blocks_per_page(inode, page) - pageoff_fsb);=0A=
 	if (error && !xfs_is_shutdown(mp))=0A=
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");=0A=
-out_invalidate:=0A=
-	iomap_invalidatepage(page, pageoff, PAGE_SIZE - pageoff);=0A=
 }=0A=
 =0A=
 static const struct iomap_writeback_ops xfs_writeback_ops =3D {=0A=
-- =0A=
2.43.0=


