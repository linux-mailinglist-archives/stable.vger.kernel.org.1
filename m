Return-Path: <stable+bounces-217916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LC9J8yonWnRQwQAu9opvQ
	(envelope-from <stable+bounces-217916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 14:34:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E5D187C14
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 14:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E23ED31A6F17
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F05821FF2A;
	Tue, 24 Feb 2026 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Jqy/upLG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CBB39E177
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771939627; cv=none; b=MEuHsNEPmrJ2HCZynVP8dAe9EOdFfYJwcdsZHoLeBD/GhPbHzny0j3nSPxVh106Pa/aETHIhXM//IRYCknymf4U3NsO5fBs9iPlR5HSWXV7ulzWWRcZAvB6ZvPZveiWbcj5z2L+hIMuknz1U+yludAvTjmjbOjlR2XAv84jBCss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771939627; c=relaxed/simple;
	bh=8SpNNi1ayJAt5gC7ktESwVWjn6vLZMtM1DHLO/Koa+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLwx1y8817JwG49XH+slCPgBq3bwwmYyutCw1N/qY0yqzmqeojc5074pywSF23+itaIjAbhqTQ0zP3qSe1VdAY/Tq10LPLGNSLmyiBJYsWxzIGuhNm2xe0bnMBmytRUMy8ZcJqNESafUVTNPLp5N9RjDNvatSVW+UbSvZTykqRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Jqy/upLG; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48375f10628so35873685e9.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 05:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771939624; x=1772544424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GFbQTyVOM7RroKjlHHm350U6lcOBB7oSufXTXuhGOpo=;
        b=Jqy/upLGCRxQj3x3SCvLuhOg7OyBodPOBnuP++qSE3gIyWVWbEMCabBLhn3MuiIQuj
         bhpeWRtIB8rQZRHXNSWR9cwHTfmo+VbGmyDl/VR3kxQjGJ1T+OqUh7KokaW92CjMR1JL
         Gpcdp1JQRjzbL5HdymNn6aZogcpx3ZpPgojSw9cIr2brg86A1+6kwnINAeWT0W+LESez
         16Vper6yBjesoPdefxJ9+WWLP3YOlvP7HNphkXvEUbSr//iydbVtX9ZSi+qrmQbBBeWD
         FrztH5V50MZbcQRkEJlRr/wQYghcgaQsS1PpuL5J5u554A5e8srrm8G8aagJLB97BTPm
         lcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771939624; x=1772544424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFbQTyVOM7RroKjlHHm350U6lcOBB7oSufXTXuhGOpo=;
        b=E37IBIRd7UBVwFDBQ3yoqK7OlcKoFa4v/jdX1NLadpIIqnLw7x3D/J5np+J5gw2xXv
         qoe5tEWA2ukbUn9Z1djV92SFePL9BRIYoiWu1rnjnirqw6MP0x2FLLV+4bhXfESrnkcj
         MHq0xTI/02m5KqrZwSgaChw9BV817rRQUo3JWhNUBpgA1pqCmKCm0eE2zVJHKJ44XouA
         WzDE9Zs61QhACNTYnhlqHranA6i7QNJB+L4JE6wsIIHTJXnXUT3g9muFatTnolCIPdrw
         hs6Gg/lYNqiLdPdJ2G5WvyLR0OIhtJHt66/sAL+ysX5EDdHZLvRGHBr0oYx24ETjvUyc
         3JCw==
X-Forwarded-Encrypted: i=1; AJvYcCXodKfxDXacRdPttAU093EInaEODPbEfhno5DX0y/MwDT0BfyEVA9uASwJTX8AO48KS2UvUs/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6N9/nHSnDs4cp5zUraFLpT9MYq6NFjmQ94LuZ0H5iGfdMAxT5
	neLjhHbjw/uYZSZf1SixRmMFcewc4HRPMj/LYCPr64/Q1p3+ceZQxHdVHmb5ecudzOo=
X-Gm-Gg: AZuq6aJLUNpnlfp6mEs9yzOQX29A3CLkYmVQmqd4pE5rouopfGZurDAG6/DtYj+A3i0
	0l2uqkkFub6mnEt68ZvB9Y0LLuQLgYRAtjFCHnF80A/NNgbgJvT/0ADvXtRJ7fxBlRjaBHLw1ji
	sQYHJGCr7T/49g2zqZ4Ov8EdNjPIjxJmX3bhKzu0WQMmGf+UvI0KNI3dgsfJlMuE1inI/3YJZz4
	3slrhom1pDL03guFzfZI6EWUq27cMA7iR+ZCov/lJQKl9wqIgp8MsoYyjgbLgR/y5inBWl+cwBh
	BRbgOrmmrIfAupMaS7ETL800/5KVW01PzXGJf0yNJwuHnrUuFlK5iVhpzndiSeO89SV+q1wZVJF
	VvJzkvqkMitSMGe5XvkYIFYQYbt7xcaNYrx6SPPYWph5BYpQThJSdw1r1oyV43F/PpMPD7e/QGz
	qM8/8a+34CcW/NrSpaYun2wgGI94UCCh7TM5XCcXqtRv61bv926QYXsFYk6PEsxJhAlbQ4W7kF8
	zsdm9SKejq9AP8Vixra7ue/xg==
X-Received: by 2002:a05:600c:6206:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-483a95b3e23mr185005635e9.3.1771939623542;
        Tue, 24 Feb 2026 05:27:03 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f3d0100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f3d:100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483b820def3sm46597665e9.2.2026.02.24.05.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 05:27:03 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph/mds_client: fix memory leaks in ceph_mdsc_build_path()
Date: Tue, 24 Feb 2026 14:26:57 +0100
Message-ID: <20260224132657.3055222-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-217916-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[ionos.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.kellermann@ionos.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ionos.com:mid,ionos.com:dkim,ionos.com:email]
X-Rspamd-Queue-Id: 30E5D187C14
X-Rspamd-Action: no action

Add __putname() calls to error code paths that did not free the "path"
pointer obtained by __getname().  If ownership of this pointer is not
passed to the caller via path_info.path, the function must free it
before returning.

Fixes: 3fd945a79e14 ("ceph: encode encrypted name in ceph_mdsc_build_path and dentry release")
Fixes: 550f7ca98ee0 ("ceph: give up on paths longer than PATH_MAX")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 23b6d00643c9..b1746273f186 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2768,6 +2768,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 			if (ret < 0) {
 				dput(parent);
 				dput(cur);
+				__putname(path);
 				return ERR_PTR(ret);
 			}
 
@@ -2777,6 +2778,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 				if (len < 0) {
 					dput(parent);
 					dput(cur);
+					__putname(path);
 					return ERR_PTR(len);
 				}
 			}
@@ -2813,6 +2815,7 @@ char *ceph_mdsc_build_path(struct ceph_mds_client *mdsc, struct dentry *dentry,
 		 * cannot ever succeed.  Creating paths that long is
 		 * possible with Ceph, but Linux cannot use them.
 		 */
+		__putname(path);
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 
-- 
2.47.3


