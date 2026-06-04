Return-Path: <stable+bounces-260470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8PTdMTppIWohGAEAu9opvQ
	(envelope-from <stable+bounces-260470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 14:02:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC52963FAC6
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 14:02:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=Qi6jzjaf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260470-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260470-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAE4C30182CC
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 12:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E385F421F0F;
	Thu,  4 Jun 2026 12:01:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528694028CB
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:01:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574519; cv=none; b=NVeKtUvH+Kkn/IHYDse8h0Swi+63w8Syzbft1Kef+TTGcjkwJrMmbJUT9SbAOTWz+oj8wn5MURfrEVGnFB3nXSAy8Tyi4RZ2Gp6ermrRn+/vCMWyDkrJpT+6tzoQowcxblIDPDY8NCbWnpBkelfHfn1eJLAXZHUrr5P5YMWNXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574519; c=relaxed/simple;
	bh=ZM6f0eCw9JYN0eFB+IzJL2AO5YSNKkge7oh3x0mIL9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJXj9AwdSLNdzcNDhMdoVCzH0BHHzvB4UZnnhrZdvZJmxQV13uZSPCcd2a9mWV8tALcahz4Ms77vEQNUy1wwEGFLZDHtE72FQoxVPIa5pXSINcc6YZEwswpUrNXQTPt/WOAIH/+p3dRZubNtVOjidT5WNlMJJHbjOZXstgRajAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Qi6jzjaf; arc=none smtp.client-ip=54.92.39.34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1780574514;
	bh=s0SOSgnZPxT0aZX+C5VOVu4hhsXwJgTrAroZMlvrXik=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Qi6jzjafYZNfszgPdeYl4S9ZJT+0zqG0YcUO0kqNVDfWbODv3bEwDz4Es9Ry7TIuH
	 N/ypIpEg0kRCpv1pPweZ3on6IZLvk3MjJTWMb6DNHatyUHOCfL4Li/lrPlcxxrHoOM
	 nMhE+Kv0UwOH2+qz7+VlFuUpKBHv/7fHBKUYFmrY=
X-QQ-mid: esmtpsz17t1780574500tb188a5ec
X-QQ-Originating-IP: gbR/tJSf6Z6Khf3zDINlDvAlHKDWGkrA1P8sN6AE198=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jun 2026 20:01:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9837222749658445388
EX-QQ-RecipientCnt: 2
From: Yingjie Gao <gaoyingjie@uniontech.com>
To: gaoyingjie@uniontech.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/1] xfs: fix exchmaps reservation limit check
Date: Thu,  4 Jun 2026 20:01:31 +0800
Message-Id: <20260604120131.930018-2-gaoyingjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260604120131.930018-1-gaoyingjie@uniontech.com>
References: <20260604120131.930018-1-gaoyingjie@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: OBCaDO5Vzid5h+xeC1xRxwTluTV5UtlWACQDyM89PP/EWqQPqU0U9vMy
	cWHHqcTazslJPz1C4pSyDUWvBPnt7tAvMGwnj1pmQfDOuiMKae35JHgKkmtoGwGc211dPmD
	c343dIXxBGAEw2KVREQAFlUtjjQhfBSv8JIERz40X23XjXPxEiRsxYMjbhiMqJx/L6Py0Lx
	L+e7poH5Hqqx9lMlA0NsgapiYgqEv0FW7whHIBQ2OJWvoCe1hs3z+VGUt+fDvYCSxtqJKJw
	NCpSNhvAAU4s+mo2kpVTFuA5ndWwzcSwF3C/TpmsCsn5p5eJEmbA5DFDTM7Pf+nY12Q/NqH
	V0F0j2pfaVwOxi9F1xYPbcMnNfu2kDbIe/W7I/Mz1Qire/Y0p567SdLVcxhB+KQpyE5GWLT
	D4JAMr99f4WHHid7m8hyUaLjXnv2hvOPRvBbvkMRCLEYu6oSEOshX9AIYw5Vmj0sFj5Gd3x
	Q7m8rOgcU1ugZwe1NODLJD508mjacutu3f7JRk5Pf5ZQBJx7nAxcsxCtI5km0mxcocDKTki
	t6TDQRL1j/GaRJiSJ+1ind/8OUvBkbWuUlN53aejHBgMJmKkpOGvMo9iBX5HmsEMidcO1MR
	aIlyKaPI8V6PZtS0z13NglSilJNzIXVtWtDeieFnVKbLzBkJ/xzytJUKUK8EpHpK0pX/+qR
	efj29TKqK1BfDUiJ7gfYmvDv0AP1EOUi6cFduShE0ozZ1TiuXVdtATP84WARCJBJHRGcbjP
	55pVM4n+TuWo1M1X7cZ541MJlsDJhd8hFtuEaIUUYa2Jrwy00UfxJMgrMClc3mT1xr5gWLH
	nZ7M1Wo0I0FjeYMQXQ/obK7HmTEfadwqm3Y8NA1ILpufgh0iuJNIvIGkJJwfTm6vt3zKPiE
	7uxncKyx5IdoSU1zuwLticsQlrvVBO7OGwPAiw3jox9yuXr1X2Sr/unL9Bg4+B3wluq6slC
	5/CUrsmdI3/3sZG/eWYhx9INAJpOChUayUiKqXl4lQ+luOPgdpD6KuFwIimykBuAcyIu53I
	NsARf9OZZ3Q86Xrww2vwfXGChXUAg3xOavwkVTDw==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-260470-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gaoyingjie@uniontech.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gaoyingjie@uniontech.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gaoyingjie@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim,uniontech.com:from_mime,uniontech.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC52963FAC6

xfs_exchmaps_estimate_overhead() adds the bmbt and rmapbt
overhead to a local resblks variable, but the final UINT_MAX
check still tests req->resblks.  That is the reservation value
from before the overhead was added.

The computed value is stored back in req->resblks and later passed
to xfs_trans_alloc(), whose block reservation argument is unsigned
int.  Check the computed reservation so the existing limit applies
to the value that will be used.

Fixes: 966ceafc7a43 ("xfs: create deferred log items for file mapping exchanges")
Cc: <stable@vger.kernel.org> # v6.10
Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>
---
 fs/xfs/libxfs/xfs_exchmaps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index 5d28f4eac527..541e33f33167 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -711,7 +711,7 @@ xfs_exchmaps_estimate_overhead(
 		return -ENOSPC;
 
 	/* Can't actually reserve more than UINT_MAX blocks. */
-	if (req->resblks > UINT_MAX)
+	if (resblks > UINT_MAX)
 		return -ENOSPC;
 
 	req->resblks = resblks;
-- 
2.20.1


