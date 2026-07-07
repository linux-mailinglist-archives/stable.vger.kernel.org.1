Return-Path: <stable+bounces-272340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TKr9J/1tTGqskQEAu9opvQ
	(envelope-from <stable+bounces-272340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 05:09:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14668716F4A
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 05:09:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=iC7cUdHA;
	dmarc=pass (policy=none) header.from=uniontech.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272340-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272340-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B908A3026C82
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 03:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A04F37DEAF;
	Tue,  7 Jul 2026 03:09:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80F35F603;
	Tue,  7 Jul 2026 03:09:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393781; cv=none; b=MfobTZrpHBTzW9THU+G/a5TUABA9BnEcRucW7CEvTxEO3v/AIEcBpYMO27iqGWZvfzTNqTq9NX+zXXUit4HdPRMWRGeZbiteoZ4Lo7P6f5FkaGU5SxPW8Pia6drgFydVEFWUv+59NJufI1W5biCyxPWj5L6BnSaGrfLIHpfw2QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393781; c=relaxed/simple;
	bh=HhiEufE36SGUE2dY0WHlh1XdM0dvTUmOhkbW3J0Br9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sD6gfL1tOMq82a9QdZQoyCWdWKdOeQmm8J+LuJeXd0tDITywmXlb4WUgKqG6M4XX0H6cGBpT6fka0a6KZVh89iWbZx2EL6QVUGSIqx3jGRdLUEi/ryPV7uLJWRO9BKr8Qdu9Z0IeN8Ex5yLAMlcaBBfh/cewcjwpIEdha/GbAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=iC7cUdHA; arc=none smtp.client-ip=18.132.163.193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783393749;
	bh=qkKBFpzNu/wULnmAxCjbcVhjTkkQsCGSNz5xBCjzuDo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iC7cUdHA61oow8HHjcg1/0AqNry8d/MR537pfVTzhCPjIiOrY3n7ZuZP218XurJGj
	 ooOdti85zlzdkzza65DMh5LI2uBXZx8AriLW67P1pGLex36d8bp2VsCoegAOz9jwjM
	 7PkAdHFx7x09wx/vpikXscUaNc2nsAE1nJNy9clc=
X-QQ-mid: zesmtpsz8t1783393729t1b86c291
X-QQ-Originating-IP: /8HG9Q4M+PD1YOTCZzpMSI6maqlWW7NuLQil0IaFttE=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Jul 2026 11:08:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 8539510006418174834
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: dgilbert@interlog.com
Cc: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH v2] scsi: sg: report request-table problems when any status is set
Date: Tue,  7 Jul 2026 11:08:45 +0800
Message-ID: <54B60C19F7DB8889+20260707030845.970018-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MIzUghsjsbalDAFyLKhRZv43YzFmqJGBwP8+QJwFLNN/+QjFNZnz/10+
	DmRgpLLu8k2+/iEqncPvlvrWZ+QsS3fnukp4IFcdKKntyHd+jqCJ2rTZjGpxOWtbgkZqGHh
	UoFcs3yzIuiOkbw5vWui4PAzB5pFclZDvJJQQlNuRNcHRkohtdlV0QlKQ8zWhVGwY2h4ur7
	6VsgzCdkLCKMzUbE2esJgXZXz0JILJLn11bhfjgp6/F1gadg9uwAY9nCJ62ofFBw1aBo0pd
	geAWjY0CU/C9gAqGGvnlxJlVwwfhdRUIOZoMm70S62Lxbk4Lx6e+Ui0mlh8nVaAPqQCC8uD
	c7sb54ur94xE0aPmiuTunpwyFrp+TW0+/OuMqwwa9uUeSU3Y/14X9NMy/mNIfU0toRE5miS
	6cjdHiPrmXOoS1Gh50r/DY7cEbSb8b44R+IJRTDKuOuOnV7TMIUO1jee9dwSvGnYd3KQE72
	Wi04CJ8rKh3i2dBqRohXPMg0gNgeGquj2bgZTRSZKTOxof5Qg8+9KzadNoIImUj6Lab7WME
	HISFeayTzlwSRWuWWJsvnHTyRXumpsWdvmz0PuYvDYUH9jBtJKUK/ogjI++t8wRGl3Wugla
	eifprZf/nGnjMVtkJN2h1JXr26HZH+rh5a5MOQIjdyhVRMh+LjM6/5OSmGj/X1i8kzgb5h+
	yfnKDG3SvznFjlvQGOkuV9gRXefUZOih+2Fbui7JV16GVexiKFfbWN5gt8BKEmxVaT2IctQ
	zKT05USqce7z1hYdmXMWNRPCVBk4fEFJv6TuXAK5bZfDWJ6BDjDb+1E02OgiUY91998zW4b
	NOKFjHGIuknQOd48WXwGCkBqDmELTby5acRSZLhjRLCqma/6gizfFPsW9cLNP5JYI5/f51C
	EeVZPbwh8wP05/xlsP6voRE9bKqAZFsHH+yAsG4b9eqgR40ojhO42OaeHsfougNpPP9ZRtL
	Dqqx3PbUe84p//G9JdqbWdoCF7T4nsuVmLNgfcMSTqmgvFDyYUKyfbcI488A2oRJDsIj/ye
	UiNgDCr1qops/N8q114UW7Xqfjgrua9nMyjz+J3Q==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272340-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dgilbert@interlog.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:raoxu@uniontech.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raoxu@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[uniontech.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,uniontech.com:from_mime,uniontech.com:email,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14668716F4A

From: Xu Rao <raoxu@uniontech.com>

SG_GET_REQUEST_TABLE reports per-request diagnostic state through
sg_req_info::problem. The field is meant to indicate whether there is
an error to report for a completed request.

sg_fill_request_table() currently combines masked_status, host_status
and driver_status with bitwise AND. This only reports a problem when all
three status fields are non-zero at the same time. A normal target check
condition, for example, has masked_status set while host_status and
driver_status may both be zero, so the request is incorrectly reported
as clean.

Use the same condition as sg_new_read(), which sets SG_INFO_CHECK when
any of the three status fields is non-zero.

Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org as suggested by Bart Van Assche.

 drivers/scsi/sg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 74cd4e8a61c2..5408f002e6c0 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -863,10 +863,9 @@ sg_fill_request_table(Sg_fd *sfp, sg_req_info_t *rinfo)
 		if (val >= SG_MAX_QUEUE)
 			break;
 		rinfo[val].req_state = srp->done + 1;
-		rinfo[val].problem =
-			srp->header.masked_status &
-			srp->header.host_status &
-			srp->header.driver_status;
+		rinfo[val].problem = srp->header.masked_status ||
+					     srp->header.host_status ||
+					     srp->header.driver_status;
 		if (srp->done)
 			rinfo[val].duration =
 				srp->header.duration;
--
2.50.1

