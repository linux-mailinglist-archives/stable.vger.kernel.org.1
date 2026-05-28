Return-Path: <stable+bounces-255021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDFIH9tPGGpMiwgAu9opvQ
	(envelope-from <stable+bounces-255021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:23:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA7A5F39EA
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C5433003821
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260003B9937;
	Thu, 28 May 2026 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzKwz3K3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrRnWQS9"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9D83B7B96
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978193; cv=none; b=kmT2742c+V5RrkYpXYwRD98IGcDjuP6IiWE7QyFOspSEkYSaI6wvXaWtFrMk4UxRxQIrG8JqyVIEzj2hIGaAOFZiYN8Zy9vm2xDr6TNIvuf5AZcN0BoJsCTkygZqDZzcw74T48U8wb3AtGV7eBPDEko70zxBmNCHtgqx+3+Q+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978193; c=relaxed/simple;
	bh=IZf6t8sPZN1B+G6nvb7rFXFrG/QkXWtEe0zXAaVYtPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N7Wlj5wmOVK9fFcSXVigMvoNG2USWAnFGeBAHas1+JVCIrjY/p5fYLVoUNa5uUOwKfRxmk7CkMbonbr41lanDJGi77jIBnZqaZJlqAQllMhSm5b4RMA76vB6pt1Pvx6EP7Ui0Sgj1Kn/R03H7vDxo/qfcXV6X51zIsuT2MiA/Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzKwz3K3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrRnWQS9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779978191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T2ez4wLwO2XJ3M2x5UCP7Se5+Vs6+9kWYp+rbjdRbK0=;
	b=OzKwz3K3QcHoq9OvuzMQAuc378zEMdMlIVHIpBoSFLBg2WfaU1xsKTZpKH4oQF+VGJk3Og
	NWUYhp2mbItfM5rbCA4jE87HPS2lW3qdUqexC2xx87hkwAQKkCde6vFpmNzHV2zhUZ9/bN
	MoJCDffhfjrvNwnq1+otV55L5HU3ZSw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-0q4stIJQNOmIIDIaVTLz3w-1; Thu, 28 May 2026 10:23:10 -0400
X-MC-Unique: 0q4stIJQNOmIIDIaVTLz3w-1
X-Mimecast-MFC-AGG-ID: 0q4stIJQNOmIIDIaVTLz3w_1779978189
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44a71109b94so8590274f8f.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779978189; x=1780582989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2ez4wLwO2XJ3M2x5UCP7Se5+Vs6+9kWYp+rbjdRbK0=;
        b=HrRnWQS9qYcAW4+E3phC/zhkVAJeDdGSh1rACdhSgCjgV5zhqscOV/fAUCXPzCM9hJ
         dnNz7uR/Oie8+3XbRyhwa+qH8XCkHpwTh1G2sgNrtPymVkmdmkWcj0TIA+oJyfatU9eg
         vY7GsrqYr0mNJtdodpzr7KizHm5ltwwDW3pK0r65Qbbs7SddqAauDBll5WDRLEh1Ttpy
         aYXgJrEW136FoZLbDlRZux+/qGfEBqdh86+cZwnV+LGq6F+vcp/VC+0JgbLXVTJE8XAz
         Jj1eYfeTQMk19wGqq7TCxhOKIdaNmV1pB+64bp98tiwepBqxsiD+/ukT19F9tcFCmDda
         AKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978189; x=1780582989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2ez4wLwO2XJ3M2x5UCP7Se5+Vs6+9kWYp+rbjdRbK0=;
        b=q3cJq3mMczrYZ67o+mmw6m100YF51H4UtWk7wffk8Rs/kzaWHHX3Ty0bO1Ciq3WpkI
         JdwkAGEmINaVdcUOQJ6Eru4owudk0xxQylvKdwwAAvBCuZmNpFckySJEhpPPojBrIM7b
         w+WdEzqxHyCIvcGfTfdTX9NQO/TBr76bCnUWtFOg8CBDpz1yemVEA4m4oQvdO07MQ0Ul
         JcGV5C8qGRUB+4x4FFetAW7lKoVbllwhW/AQMYU6I9r0DSwytftMnLbvO7MxVFhCYSoI
         ZRZKDjksxHfpPYe+w+rvw06s77+rBXpQd7a4vryhSpDWpqCy+/DEbvFUbqmIATl3NATG
         YY+A==
X-Forwarded-Encrypted: i=1; AFNElJ9ZMJWoiYyif56e9hsHs8qDHj4OEWqWPHfdy7rPc9TQD60Moy2f0iyEMabif77VDdWuXV5P8jU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdX6ptOvpEJY+pIsAvCVMg7MdwnSWNwpi79VwCEqz5UP7Yok8t
	lLvhc7E0Ew6bNd6gv1yKjTMYr6WnBnzPIiyZOIXyRA4X1DATw/hoCUd6QCBSTS0ZAM87Ao77j7V
	N79J+Mi8TzRby1k+w5K8KGOoS9mlx07mTkYzrv/qepbDI/hgE6DL8SkMeJQ==
X-Gm-Gg: Acq92OFOl2Pm/Kuyd8oXQ+V0hia2Tod30AY4npfJ7LMwFG9d+lkHQoSWRHALrop3gQA
	0qzkOo8cw0HAnGw6OS7cLpImX+k47CElIugncZZT7aaHpWmIWIOtNIV1oY+/YxIFXZGXZ4bTRi3
	CLpdkPzr7MlvkpEatdYTl8fQ8a1SXK9uE43z7TUQzQ4J71DDcn1ksZDWO7zTZx7SyMja48S4h3g
	q/09FoE0mj3/nZdiqZoO6a04cSjB3vDDnaXqkXYgV9UN6hKv9J66F+r0wqUzdtxWxM70E1LCfU3
	zjmffdxnd0jkhOCkR7TWtExa6emIkEhB4UvBsjkl57UULAE1NX0gY0UHnVj71sXg0zEfhtEiPDs
	6rMI2b8AO7vxjj8ZCt53oJgKFwurCie70ZntCTdGS0ie7638xb8nWtPpSdXveDqSQfpnTrWvnAY
	AhZUXy71H0490=
X-Received: by 2002:a05:6000:25e3:b0:45e:73b4:85cc with SMTP id ffacd0b85a97d-45eb38a6b5amr42307151f8f.35.1779978188783;
        Thu, 28 May 2026 07:23:08 -0700 (PDT)
X-Received: by 2002:a05:6000:25e3:b0:45e:73b4:85cc with SMTP id ffacd0b85a97d-45eb38a6b5amr42307095f8f.35.1779978188310;
        Thu, 28 May 2026 07:23:08 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (78-131-46-194.pool.digikabel.hu. [78.131.46.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b1a28sm13876873f8f.26.2026.05.28.07.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:23:07 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev
Cc: =?UTF-8?q?Aur=C3=A9lien=20Bombo?= <abombo@microsoft.com>,
	Greg Kurz <gkurz@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] virtiofs: fix UAF on submount umount
Date: Thu, 28 May 2026 16:23:05 +0200
Message-ID: <20260528142306.1792392-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255021-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mszeredi@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2CA7A5F39EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iput() called from fuse_release_end() can Oops if the super block has
already been destroyed.  Normally this is prevented by waiting for
num_waiting to go down to zero before commencing with super block shutdown.

This only works, however, for the last submount instance, as the wait
counter is per connection, not per superblock.

Revert to using synchronous release requests for the auto_submounts case,
which is virtiofs only at this time.

Reported-by: Aurélien Bombo <abombo@microsoft.com>
Cc: Greg Kurz <gkurz@redhat.com>
Closes: https://github.com/kata-containers/kata-containers/issues/12589
Fixes: 26e5c67deb2e ("fuse: fix livelock in synchronous file put from fuseblk workers")
Cc: stable@vger.kernel.org
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3bdab8d03373..e8833e2a6610 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -380,8 +380,14 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * aio and closes the fd before the aio completes.  Since aio takes its
 	 * own ref to the file, the IO completion has to drop the ref, which is
 	 * how the fuse server can end up closing its clients' files.
+	 *
+	 * Exception is virtio-fs, which is not affected by the above (server is
+	 * on host, cannot close open files in guest).  Virtio-fs needs sync
+	 * release, because the num_waiting mechanism to wait for all requests
+	 * before commencing with fs shutdown doesn't work if submounts are
+	 * used.
 	 */
-	fuse_file_put(ff, false);
+	fuse_file_put(ff, ff->fm->fc->auto_submounts);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
-- 
2.54.0


