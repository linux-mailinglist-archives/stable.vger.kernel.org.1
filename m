Return-Path: <stable+bounces-230985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG4yM//WyWnE2wUAu9opvQ
	(envelope-from <stable+bounces-230985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 03:50:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D11F0354A86
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 03:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63DF3300B068
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 01:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B8022A817;
	Mon, 30 Mar 2026 01:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d5nwJ4ET"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0C7175A94;
	Mon, 30 Mar 2026 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774835451; cv=none; b=JvzYrUwl0sYkkOQA0K+NIt3YDYBN9Q+2xGoMH+b+o1Fn9+7eRpSRvkgEhsrqpG+ACwb2LNq7QPGWkObgycJoB5Xx5KwiD6cAvMbHG1c1D1SwOd8knt/fsy8eNxYx7Fla4BhUQHFHppMziPjeQ7nA+F7K0eUKYDX2N3PIWH8qqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774835451; c=relaxed/simple;
	bh=ixolLrzbUpURqHptEtvef9b4lOdNhT+Rdvm7+Wzk7oI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H9fGqnnpVxIvYfwYputrgCl2vZotg9vtxHblmhI7H3fVKJU4f6c3ZchzEKtbQoGwOW5wP3P2FyQ97ChSU9IJS+BfvoZKxeFZyynBNhXOQAheTzU9uaqAyCiyYH4xe+WZWmFvxgcTCJhBO9p+PIbiIR8Q4ZO+HcBgUeGz68zaehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d5nwJ4ET; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NE
	ibGSjdedDB2R09UgpFcazFFhoARzqkN4HerJmT4qc=; b=d5nwJ4ETho8JxC7O5k
	DZjech+vSWq+RCUoQjp88dhvQ7nEJDuSBUGNVAtSt54eRvlEspNUonPkWkfIJ9TK
	VKlE4dEMfcRt4Lv7qzROffSECnQIEbKCFyKMeFlXMwvED5M/rHmujhGlZjYDPeqt
	g4kotpPI7GK4rQ7iEm25bkt3I=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wBXIKzC1slpl0wrCA--.20436S2;
	Mon, 30 Mar 2026 09:49:56 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	John Garry <john.g.garry@oracle.com>,
	stable@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH v3] scsi: sd: fix missing put_disk() when device_add(&disk_dev) fails
Date: Mon, 30 Mar 2026 09:49:52 +0800
Message-Id: <20260330014952.152776-1-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXIKzC1slpl0wrCA--.20436S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury5KF48tFWDAFW3KF1DAwb_yoWDurX_Cw
	1jvwn7Xr4UAr1xtF1fGr4avrWvgrnFgrWrur48tF93A3yYgr9IvFykCw1Yy3W8WwsFvF18
	Xwn0vw4kJw4UJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU189NPUUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwgSzRGnJ1sSd2QAA3H
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230985-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[163.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxiuwei@kylinos.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Queue-Id: D11F0354A86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If device_add(&sdkp->disk_dev) fails, put_device() runs
scsi_disk_release(), which frees the scsi_disk but leaves the gendisk
referenced. The device_add_disk() error path in sd_probe() calls
put_disk(gd); call put_disk(gd) here to mirror that cleanup.

Fixes: 265dfe8ebbab ("scsi: sd: Free scsi_disk device via put_device()")
Cc: stable@vger.kernel.org
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
v2: Add Fixes: and Cc: stable; add a short note on how the issue was found.
v3: Commit message and subject refined per review; add Reviewed-by from John Garry.

 drivers/scsi/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 628a1d0a74ba..aba22060fcd5 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4018,6 +4018,7 @@ static int sd_probe(struct scsi_device *sdp)
 	error = device_add(&sdkp->disk_dev);
 	if (error) {
 		put_device(&sdkp->disk_dev);
+		put_disk(gd);
 		goto out;
 	}
 
-- 
2.25.1


