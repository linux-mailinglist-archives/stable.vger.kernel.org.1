Return-Path: <stable+bounces-216331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBjzDLTJj2nMTgEAu9opvQ
	(envelope-from <stable+bounces-216331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:02:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8CA13A3E1
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 02:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B264530091E0
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0A1CAA68;
	Sat, 14 Feb 2026 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3E1+FQK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980B3EBF2C
	for <stable@vger.kernel.org>; Sat, 14 Feb 2026 01:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771030959; cv=none; b=eEwwca+Frt/afT0GkEcoARElUeGvjGiPa9oHkM/Yx0hxU0Z1ys91m/Mu1CywcYSDy57KoFd6iBTU+A5fQXo8i6jsSdv5N6ubEp24Fg5AimulB8tl4y8x9JsjCokeCFjKimTi7wFH9/RypxyfwBVwv5D+yneUmUdJfLgKzndMkHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771030959; c=relaxed/simple;
	bh=vW2WilTv8rqnu27DqG6JPB5q4Xqd69d5N1L7ZALohHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBwVhhHn1yE/7lBBsZu5IjZ90tmPB6lm6R/pYp+v4k7Uko80vtLAQFlHzQ9LTSH/OVEa3BOV/1pdTnbI4++gZ8UrZ6oL5wqYzCUhZtWFPfTkrT9Bo3AM7eJPrBdL1J92F4l5OVzi7Tt3g/rL7oeA4anlRXQJKhbrKncOicSeWok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3E1+FQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E73AC19424;
	Sat, 14 Feb 2026 01:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771030959;
	bh=vW2WilTv8rqnu27DqG6JPB5q4Xqd69d5N1L7ZALohHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3E1+FQK1z6kWabE+Ad/1VFAm4sIf83RywPAaKkOJc922oFd7C/n8jsvdt0KZbaOV
	 0QYFAiOzzKKa6loJVDOA80EbnNr+iC0HEy5h6Bq31q6zDo0GjQQRmdLwDzNssYVTg+
	 cGQV0wWLFPPRtWezJ4gvGzs/1C+Bhekgl7fm4HU6a0Jh+enUNClA1R7wJi6t9O23nW
	 w8j4boq+pvYiwr63Hyl4BwrV949evCnrmc8zJi5tO3xPNlyWlINW09xEKcaHtbMnrg
	 Dx0yK8r0nUQCM7NzVnjOdTP9to09XXUd5qiaeG9iKsKcYkycHzK9PoO7weuoWDOvcn
	 sOJ1HWy0FNIAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gui-Dong Han <hanguidong02@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] bus: fsl-mc: fix use-after-free in driver_override_show()
Date: Fri, 13 Feb 2026 20:02:36 -0500
Message-ID: <20260214010236.3700986-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214010236.3700986-1-sashal@kernel.org>
References: <2026021348-eldest-semantic-7287@gregkh>
 <20260214010236.3700986-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,nxp.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216331-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4C8CA13A3E1
X-Rspamd-Action: no action

From: Gui-Dong Han <hanguidong02@gmail.com>

[ Upstream commit 148891e95014b5dc5878acefa57f1940c281c431 ]

The driver_override_show() function reads the driver_override string
without holding the device_lock. However, driver_override_store() uses
driver_set_override(), which modifies and frees the string while holding
the device_lock.

This can result in a concurrent use-after-free if the string is freed
by the store function while being read by the show function.

Fix this by holding the device_lock around the read operation.

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20251202174438.12658-1-hanguidong02@gmail.com
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 7b0c58f31acf2..48e5990394a51 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -194,8 +194,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.51.0


