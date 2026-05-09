Return-Path: <stable+bounces-244973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDkCOSBc/2mQ5QAAu9opvQ
	(envelope-from <stable+bounces-244973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:09:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1C45006EE
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2822E301389E
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 16:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A442EDD70;
	Sat,  9 May 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VenlDU4P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0962EA754
	for <stable@vger.kernel.org>; Sat,  9 May 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342935; cv=none; b=r73cvtfIlTvXZNjtk/Kwe7pZktV9eUKVGqVshNOu+tXPekDzNBtAXKFKNSiEZufe/6pZbgX3fsfizRImK4OF/ze5yOobbb18fmG8ix/gvgiz9m6S7oWEt7WbAurn1ePswOh7HR+Lc0aRJnMdTjlboGJqXEbqXfZliKl9+8ZCvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342935; c=relaxed/simple;
	bh=0lvATBHnhzCFHSY1c7UCF/17TjR/39SDBHYIMgaIK7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjlWaLrBX7fM7KvquKGZjKFzlt5uLPX7+XTRvTEGXt6AsJETyq8RQPhAmeCRHDxfYn8P7uv3zcKEhYFIN5UaK6WwchvkQnT0t5QGHVdZTfIGtBfv1+6rKsqI1sw1Z/z1KtHmuUy/Zy391rzgFMC452ojfo+toRXWDhtZPPlBumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VenlDU4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFB1C2BCC9;
	Sat,  9 May 2026 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342935;
	bh=0lvATBHnhzCFHSY1c7UCF/17TjR/39SDBHYIMgaIK7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VenlDU4PUTbEjLRK8bWd2xReI3mWqi3hA1nRWER1B+s0VCMD12bKqZ0jL4WjOBAZp
	 obFlAP8k6CJfLnYiO+88KZ/ESr+Yvj9dceOG8grbJ8fI4dz93TWI2o/UMKZVonrsOu
	 MVNu/DMtVlef/+enucyKUPr4SgthZqiTeLNWQYomZqcvyPmxxZq681y5g/cH9F5quP
	 k+YOU3nqI5Nw3iAu6zdp+jft1tdyv/Sw7MAnlstAj1ICq1LNuuUNPt7eS3nLhMWtUX
	 J2WEWLTnGJAE7MbzI3yJyXR9tmUthbj0X9Tcm3qYUdmp+vlQEJMVMfiwNiiy7927lL
	 1QZLglB/kXfiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Xiuwei <yangxiuwei@kylinos.cn>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] scsi: sd: fix missing put_disk() when device_add(&disk_dev) fails
Date: Sat,  9 May 2026 12:08:49 -0400
Message-ID: <20260509160849.3584738-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509160849.3584738-1-sashal@kernel.org>
References: <2026050456-overview-shaking-6135@gregkh>
 <20260509160849.3584738-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B1C45006EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244973-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,msgid.link:url,kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Yang Xiuwei <yangxiuwei@kylinos.cn>

[ Upstream commit 1e111c4b3a726df1254670a5cc4868cedb946d37 ]

If device_add(&sdkp->disk_dev) fails, put_device() runs
scsi_disk_release(), which frees the scsi_disk but leaves the gendisk
referenced. The device_add_disk() error path in sd_probe() calls
put_disk(gd); call put_disk(gd) here to mirror that cleanup.

Fixes: 265dfe8ebbab ("scsi: sd: Free scsi_disk device via put_device()")
Cc: stable@vger.kernel.org
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
Link: https://patch.msgid.link/20260330014952.152776-1-yangxiuwei@kylinos.cn
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 6c6cca6664c94..358354fe6c76f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3420,6 +3420,7 @@ static int sd_probe(struct device *dev)
 	error = device_add(&sdkp->disk_dev);
 	if (error) {
 		put_device(&sdkp->disk_dev);
+		put_disk(gd);
 		goto out;
 	}
 
-- 
2.53.0


