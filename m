Return-Path: <stable+bounces-227318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGGQIK8NvGkirwIAu9opvQ
	(envelope-from <stable+bounces-227318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:52:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC312CD359
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 15:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86A51300B77F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B432D2DBF78;
	Thu, 19 Mar 2026 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="gObhPUzi"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CED3A5E92
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931940; cv=none; b=ljxTmZFiozSbnioejrmU4zu5AuR52VI5wPNuKyPCz8SoZQfBzqTm81p0mAHwmNAsaxf/IoLd/nBGaO80PV9oqr7ujxlkgSKwTWmPvVjhi0rMJb4w3WTvq0bOi2Aasn35pLWQyv33XLq1FwNJ8vscUAX9zZIbmz85w8Z6KV+ITco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931940; c=relaxed/simple;
	bh=RJ41S1snfyuQgrhKqvYt8cog5cMZwGsaPY/mqZngtdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tcS57gzUJzmR5kDOZKQOBaUe/5e5kRrUVa0iJq37VzPseXKjqB7cnOxNvIrnn7ufeYtLMUFjffAR4V+B7caThggVAtTIF9oIIsPxNmw7G9kPh2rAZ0sq4PWXYkvx1Bf0mqzipADHWsEeQY+XJ+VPCh/op5DR4/j8+gzj4LegOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=gObhPUzi; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1E2F33FE29
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1773931936;
	bh=3KJpXt63kzGfwrgcWC7T+DbVFRnuXxbhtvmi/paNSmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=gObhPUziXVJ3NsKzHLe4zO0BYfG4T9242aFJKHquPt4PHjVn2+hT9CeShNQI7E5wh
	 JkpzYOcf6k3kLWKDTsKUl4ERrc3s3bGQdaHHwSrtKUWZTRbqniqQ5WGDKrCA1s6Kp5
	 D58bbWQZ6CYGquvh7A6I8Gn0+bSmnaVSP/sU1esXKhF3j6obUdzuVYcrbve7iQr0xb
	 qj66GTRWQ0Ch2UJS2+vxApUyhuX6O8E6KvIrS4HEDFn24qRJkg+1Op159j+Gl5k1KY
	 ZHIRs+imyuj0KMK6c8CSu2gZOhLvBIWiX0JiE+i1PKddgxvo52k2bqeblR6XPdX+d1
	 N66m6c4sYgZdt0s/YRq7dlUfeZsiXmWLIf9lor565RTzGutXDHpiXXgZoKFykbgf31
	 bsHP5NeTlKK/7lgWTzZ51BN+i40QiogY2+sRJ4gCUj56r1g+wnztEQLY9F3Gz9OrbD
	 BmOZS6qC9beAbWlS0hUaTHYWH/od6w/DPxuILXp/9YnZf2R108toCzVRyHAfIzbHgs
	 11xt1Pq4d4TbzkCKgE3BPSoMfzkYwvQvqb0K3Txrbyisn+un/aJ82EDWFUCv03J+ac
	 c1MlhlwE8zOCVxTe7usQFLEw8d3I1/NlpjY3mf7CpE67ejtjXd7uAPpV/9CkIeJ0At
	 ZosPuWrlGf5tz7264JN3GWr8=
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4852cf0318dso9574835e9.3
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 07:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773931935; x=1774536735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KJpXt63kzGfwrgcWC7T+DbVFRnuXxbhtvmi/paNSmc=;
        b=JWy0tNC+2PHYMpx0q6gu8xTEwFaTmZSP1Kpcjof0xGKiUdezYGpTglxSzEjvx7tRc/
         1EFtu2v+0BAyJUpV1nbkbnME5QG28Zyp+vdJI/6kWR8iEiwWyNHibnE9ISIZ7IULgXQv
         aGOV1NUKb+Ct9SXhgI9YaEz1SiXsqWaeV+QN7WFBpykmVWHq1CJ/xN9XfIy+qRnf4fXG
         IhyVP0pgdc8DfcCRPrENKS5Np4SJZcCFd2s8npXaKqHYuYg/Wr7zEd7ic8XixBYHtVNA
         bjjHRJ0n2Tf+ogzHrshzEVV8EBry7c3NvcbVqNHnEnYAlMI3uKe6RACv9HpD5WH3h56k
         JmiQ==
X-Gm-Message-State: AOJu0Yxq5WbxUZ1ESzdKu/Nc3iIHZQF3F0KTQK3weBSEBmUtV/FI2Ehm
	Was6H99ajLhZpNKwU84h2/N4uAJXK+d6sJ8v1/cSo+YRyX6F267j2psQezKXfxpoVSXQ35ul+qQ
	qKi22onX+8dL0YCm+VN7ftDd4Ls7nt3pdMjdwiDcjYqFCSQ977D2PXBvJPwsIFgYigSRRMyNiWp
	sY6qPbBrngJ6k=
X-Gm-Gg: ATEYQzw+za2x6sE4B4jndqtG8w5CNT+uA1HS2yJQ62gxpffJS3YPkvPxqemCQLxY2KQ
	gBA3rWssXXVvdwy12nF8SJRswWBEZCAxsP0rgDIYaYCyayZmEdfYdoPWEVpOZ4UhANq422BU1Gu
	rsToukpiAMlTNnX7kluQrceiDwQFBzhf5843IhTIegnnIRponwt5BXoU5aSDxYai9M6rNRzvUiy
	8A4aWEKua/QaDDYeTjES8QGZvvEJH3ErVxcW0u4suYs38BGbzpOa20M81rZPlLoSwe1CQV3+QHV
	rp6nhNBPAJCURy5ZIB1Sq54JYXb5MhZOERgw0bHiiC1Q9cj6T2u1fykV9i/IyNtX3JZyuD46FxT
	S/U856kSabT9BFaJ2bSDo7vBN9vgnyuOBTfvr+p/q45WUcr+qHqwf
X-Received: by 2002:a05:600c:3551:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-486f456fe98mr130513865e9.29.1773931935235;
        Thu, 19 Mar 2026 07:52:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3551:b0:485:9a50:3369 with SMTP id 5b1f17b1804b1-486f456fe98mr130513445e9.29.1773931934756;
        Thu, 19 Mar 2026 07:52:14 -0700 (PDT)
Received: from XPS-17-9720.han-hoki.ts.net ([213.204.117.164])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8c4aa85sm56566895e9.12.2026.03.19.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:52:14 -0700 (PDT)
From: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
To: stable@vger.kernel.org
Cc: Ghadi Elie Rahme <ghadi.rahme@canonical.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@cjr.nz>,
	Ronnie Sahlberg <lsahlber@redhat.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Aurelien Aptel <aaptel@suse.com>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH v2 6.1.y] smb/dfs_cache: Fix NULL pointer dereference on session connection failure
Date: Thu, 19 Mar 2026 16:49:29 +0200
Message-ID: <20260319144929.455978-1-ghadi.rahme@canonical.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[canonical.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227318-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghadi.rahme@canonical.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,canonical.com:dkim,canonical.com:email,canonical.com:mid]
X-Rspamd-Queue-Id: DBC312CD359
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 6916881f443f67f6893b504fa2171468c8aed915 ]

It is possible for find_ipc_from_server_path to run while the tcon is NULL,
resulting in a NULL pointer dereference crash when calling strcasecmp().
This happens when the ipc connection fails freeing the tcon and setting it
to NULL while the dfs cache worker thread was already executing.
This issue was fixed upstream indirectly by a rewrite that removed this
function. Although with this fix the issue can still occur, the window of
the race is now much narrower.
A fix that would completely fix it using mutexes was tested and
worked fine. However the regression potential would be much higher and so
would be the deviation from upstream.
This is a good balance of safety while minimizing upstream deviation.

Stack trace:

 BUG: kernel NULL pointer dereference, address: 0000000000000050
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 1013dc64067 P4D 10125f65067 PUD 10125f64067 PMD 0
 Oops: 0000 [#1] SMP NOPTI
 CPU: 80 PID: 3913754 Comm: kworker/u256:1 Kdump: loaded Not tainted 5.15.0-143-generic #153-Ubuntu
 Hardware name: Dell Inc. PowerEdge R760/09XV41, BIOS 2.3.5 09/10/2024
 Workqueue: cifs-dfscache refresh_cache_worker [cifs]
 RIP: 0010:strcasecmp+0x19/0x50
 Code: 01 84 c9 75 f1 c3 cc cc cc cc 0f 1f 80 00 00 00 00 49 89 f9 31 ff 41 0f b6 04 39 0f b6 c8 89 c2 83 c2 20 f6 81 e0 39 89 85  01 <0f> b6 0c 3e 0f b6 d2 0f 45 c2 89 ca 44 0f b6 c1 83 c2 20 41 f6 80
 RSP: 0018:ff4043e68aadb900 EFLAGS: 00010246
 RAX: 000000000000005c RBX: ff4043e68aadbc68 RCX: 000000000000005c
 RDX: 000000000000007c RSI: 0000000000000050 RDI: 0000000000000000
 RBP: ff4043e68aadb990 R08: 0000000000000064 R09: ff4043e68aadb91f
 R10: 0000000000000012 R11: 0000000000000000 R12: ff210c171f193c00
 R13: 0000000000000009 R14: 0000000000000008 R15: ff210d1d3f19a7c0
 FS:  0000000000000000(0000) GS:ff210d127fc00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000050 CR3: 0000011f2cc38005 CR4: 0000000000771ee0
 PKRU: 55555554
 Call Trace:
 <TASK>
 ? find_ipc_from_server_path+0xd9/0x110 [cifs]
 refresh_cache+0xf1/0x470 [cifs]
 ? in4_pton+0x7a/0x160
 ? kfree+0x1f7/0x250
 ? target_share_equal+0x198/0x210 [cifs]
 ? __refresh_tcon.isra.0+0x242/0x670 [cifs]
 ? kfree+0x1f7/0x250
 ? __refresh_tcon.isra.0+0x242/0x670 [cifs]
 ? cifs_put_tcon.part.0+0x39/0x220 [cifs]
 ? cifs_put_tcon+0x1c/0x30 [cifs]
 ? refresh_mounts+0x147/0x210 [cifs]
 refresh_cache_worker+0x1ac/0x300 [cifs]
 ? lock_timer_base+0x3b/0xd0
 process_one_work+0x228/0x3d0
 worker_thread+0x53/0x420
 ? process_one_work+0x3d0/0x3d0
 kthread+0x127/0x150
 ? set_kthread_struct+0x50/0x50
 ret_from_fork+0x1f/0x30
 </TASK>

Fixes: c870a8e70e68 ("cifs: handle different charsets in dfs cache")
Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@cjr.nz>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Aurelien Aptel <aaptel@suse.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
---
Changes in v2:
- Added maintainers to CC.

v2: https://lore.kernel.org/stable/20260303173139.517020-1-ghadi.rahme@canonical.com/T/#u

 fs/smb/client/dfs_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
index 3bc1d3494be3..af2177b96f2f 100644
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -98,7 +98,7 @@ static struct cifs_ses *find_ipc_from_server_path(struct cifs_ses **ses, const c

 	get_ipc_unc(path, unc, sizeof(unc));
 	for (; *ses; ses++) {
-		if (!strcasecmp(unc, (*ses)->tcon_ipc->tree_name))
+		if ((*ses)->tcon_ipc && !strcasecmp(unc, (*ses)->tcon_ipc->tree_name))
 			return *ses;
 	}
 	return ERR_PTR(-ENOENT);
--
2.51.0


