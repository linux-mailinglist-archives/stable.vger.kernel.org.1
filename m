Return-Path: <stable+bounces-220111-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAJuOowoo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220111-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F771C502D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E047A309B1A3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C2647DF9C;
	Sat, 28 Feb 2026 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYE8Sprg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4747E33A6F2;
	Sat, 28 Feb 2026 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300022; cv=none; b=cOEiusZNRpv2oFpKVWPPV1RQZ77ihNYKJkoXNrDZyeuly8sH2pnUHBmEu2g/o9Qu4k9C4xVsh9/k6muuxxj7euS5G/lDlwp9j8ERlawBy+pTFZ6ISCQUW/O7N4zfdHFsc+Bn3/vJwkN0hkkISOUbIUyeQET48GNtQnGH4FVhXrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300022; c=relaxed/simple;
	bh=D5N9c4KjXXhj07dBWuc9h4/fSwtFdozgTaLnNQb5bUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ua9r40F77WgQyw6QVie/pxYXksdf+othg7BYrctFOLDlhsajs62cGi2xdHGktxeeEWPPyteOIZvh/6TQ95GKb3OwIQqTu8MiMQpuNAyuz8p5bHAsT6DCB5axJm2HXdpUw3/6yr6x8aewFw+khqwJ6M3neg5Q1AhQFXneyuWv+b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYE8Sprg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C56C2BCAF;
	Sat, 28 Feb 2026 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300022;
	bh=D5N9c4KjXXhj07dBWuc9h4/fSwtFdozgTaLnNQb5bUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYE8SprgMBAmPuyCjP5w+5Do/G9xdFMLA6k55P4h4Tfq3vPoK1r9ziRAXoYN+YkUj
	 A9EDfbUkQoYMGetSznLx3pLCBvczstvz7IZBdgfCwUwXAZyZWCMnyplmpNPf7izNxj
	 HJn1TBLG7OJFAYdPTbDqcv58SebsGe3YUp3rgGNcWPIkOM4rZcNUc3vq0OIpux3fg0
	 1dqSMQKl8ER7S2aWAa7b88ykXWyEHTJIfC+x3SyavFgtRm3xsTNx24ETEm4+XVnQTt
	 k2+JFo1wooMMJsMWs8eoeNksyloUiAS27dYwcK0DtTRQNS/kJshrH0cepWhJzYulkS
	 JpknpZDtbjKbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>,
	Esben Haabendal <esben@geanix.com>,
	Nick Bowler <nbowler@draconx.ca>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 033/844] rtc: interface: Alarm race handling should not discard preceding error
Date: Sat, 28 Feb 2026 12:19:06 -0500
Message-ID: <20260228173244.1509663-34-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220111-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:email,msgid.link:url,nokia.com:email]
X-Rspamd-Queue-Id: 92F771C502D
X-Rspamd-Action: no action

From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>

[ Upstream commit 81be22cd4ace020045cc6d31255c6f7c071eb7c0 ]

Commit 795cda8338ea ("rtc: interface: Fix long-standing race when setting
alarm") should not discard any errors from the preceding validations.

Prior to that commit, if the alarm feature was disabled, or the
set_alarm failed, a meaningful error code would be returned to the
caller for further action.

After, more often than not, the __rtc_read_time will cause a success
return code instead, misleading the caller.

An example of this is when timer_enqueue is called for a rtc-abx080x
device. Since that driver does not clear the alarm feature bit, but
instead relies on the set_alarm operation to return invalid, the discard
of the return code causes very different behaviour; i.e.
    hwclock: select() to /dev/rtc0 to wait for clock tick timed out

Fixes: 795cda8338ea ("rtc: interface: Fix long-standing race when setting alarm")
Signed-off-by: Anthony Pighin (Nokia) <anthony.pighin@nokia.com>
Reviewed-by: Esben Haabendal <esben@geanix.com>
Tested-by: Nick Bowler <nbowler@draconx.ca>
Link: https://patch.msgid.link/BN0PR08MB6951415A751F236375A2945683D1A@BN0PR08MB6951.namprd08.prod.outlook.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index b8b298efd9a9c..1906f4884a834 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -457,7 +457,7 @@ static int __rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	 * are in, we can return -ETIME to signal that the timer has already
 	 * expired, which is true in both cases.
 	 */
-	if ((scheduled - now) <= 1) {
+	if (!err && (scheduled - now) <= 1) {
 		err = __rtc_read_time(rtc, &tm);
 		if (err)
 			return err;
-- 
2.51.0


