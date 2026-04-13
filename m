Return-Path: <stable+bounces-237443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BaoBaUh3WndaAkAu9opvQ
	(envelope-from <stable+bounces-237443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:02:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6993F08DC
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6D68306D2FB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386A32D43C;
	Mon, 13 Apr 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FVPtdrRR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C71329371;
	Mon, 13 Apr 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099470; cv=none; b=d/zZlaXAZWjC5IElXfimKpgvFsus+NMGyyBJvO7G1Y6Sqwf0D0aCyRx1crcFx2FfTuKJUitFLFkpjBsQTbTfAxdQB1+ltIF6PZNeV71E4gxWCav3OA5uyZb27qyahCHxEKmZ01UejgaK4pAVB33KLkhHbEe6q12jsY8pzdCIn/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099470; c=relaxed/simple;
	bh=s07MTp0xSjOom67sVknCO0vJxzn5fJ8iv3NvdQVR9/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CN1tFAn+Ols1loLVek/wWK9xiLZbLeSI5f3kar8haEBgSCz9GVgH+dMh90EYTs15554EBT5QHMU3tlhXvxebJWhboshJuoa9se6ZCh+zBgbArdf2DHW6sba665SN2YAj/FZ2nvVulEh3tsM294W3F1MT1HjYfw2QlzkNBUe2PkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FVPtdrRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A9CC2BCAF;
	Mon, 13 Apr 2026 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099470;
	bh=s07MTp0xSjOom67sVknCO0vJxzn5fJ8iv3NvdQVR9/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FVPtdrRRxt6yYCn86bOPRTuVuAtV+thG2GIQXyfcZNKLGGBSf4H7oGmtWk2+91Py4
	 YJw9hzNnCfWjebwsWgAklYZ4Tjrr4OJLi3J5YHb69ElgZZXTjSxq/Tw7EEWhNuIQMx
	 tt7M6uV1sDou3DSqsIPVZ3DwFrHX6QPQVQTa8ayY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lee Jones <lee@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 320/491] HID: multitouch: Check to ensure report responses match the request
Date: Mon, 13 Apr 2026 17:59:25 +0200
Message-ID: <20260413155831.024400935@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-237443-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: AD6993F08DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lee Jones <lee@kernel.org>

[ Upstream commit e716edafedad4952fe3a4a273d2e039a84e8681a ]

It is possible for a malicious (or clumsy) device to respond to a
specific report's feature request using a completely different report
ID.  This can cause confusion in the HID core resulting in nasty
side-effects such as OOB writes.

Add a check to ensure that the report ID in the response, matches the
one that was requested.  If it doesn't, omit reporting the raw event and
return early.

Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-multitouch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 227cf3f6ca227..948bd59ab5d21 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -442,12 +442,19 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
 			 report->id);
 	} else {
+		/* The report ID in the request and the response should match */
+		if (report->id != buf[0]) {
+			hid_err(hdev, "Returned feature report did not match the request\n");
+			goto free;
+		}
+
 		ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf,
 					   size, 0);
 		if (ret)
 			dev_warn(&hdev->dev, "failed to report feature\n");
 	}
 
+free:
 	kfree(buf);
 }
 
-- 
2.53.0




