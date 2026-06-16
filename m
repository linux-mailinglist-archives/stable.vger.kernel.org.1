Return-Path: <stable+bounces-264245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GeA1OyR0MWrtjgUAu9opvQ
	(envelope-from <stable+bounces-264245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:04:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64986691AAE
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:04:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=I2oJgk0i;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264245-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264245-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DD34316FA8E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AAF449EB0;
	Tue, 16 Jun 2026 15:48:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349A364024;
	Tue, 16 Jun 2026 15:48:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624905; cv=none; b=d+oXvNnxxsZB3n3l5bKIbJ7mArofrTrhIQis9X+KwahTbkSkiL/8JPNmkttCYFEu1sLvTQV8nxlUGtwjbZb5FhfYe518sXDUkwLOeCql+gxlF2g5xqOzQPS7H5RQqGULXgo0efC+cQbUcyObaEetPTTNwfrYw0d0PepMjraRR4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624905; c=relaxed/simple;
	bh=pl8IQd2jdpZsvpzEI4vbDDtGSv9P7mkskH3/nq9Db0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxWYmSAyJy2dvt8wG+xszYBbJ8enbXNOoLWwmYq20vj9+GQ8V2G7SVDbdwM+M/wIHR2zYVgYwCxsVkTMS/I7DbDKcu2F8uv6kp06cUWUTAFMk4wABFWNxx2zb2/ykrBfFJp5+t3STfB1eMqaFRsH1XfNeOyBWctl0XPQT4UMTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I2oJgk0i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B4E1F000E9;
	Tue, 16 Jun 2026 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624904;
	bh=DNXXNweTyflMGnczeEb8XYJY2NZp5XbpepzUCL+tYGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I2oJgk0insBBiYZM9eTsQ1p6aVNTuBGaJyOckXEu8NBvXShDn3LHyYhldSfrX2uEu
	 O/L94Pi4bSnsSfSu9m4IIkcq8+sdLYVLTR+V8NG1/i9gZM1byDgPQwrPnMBNhrzXV/
	 qOL6ND9MSc+iWNscIatKz4E8GNKc2HXsiX0rZkBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robertus Diawan Chris <robertusdchris@gmail.com>,
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 016/325] tee: qcomtee: add missing va_end in early return qcomtee_object_user_init()
Date: Tue, 16 Jun 2026 20:26:52 +0530
Message-ID: <20260616145058.609905017@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,linaro.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-264245-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:robertusdchris@gmail.com,m:amirreza.zarrabi@oss.qualcomm.com,m:jens.wiklander@linaro.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,linaro.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64986691AAE

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robertus Diawan Chris <robertusdchris@gmail.com>

[ Upstream commit 471c18323dfdfe7844e193b896a9267ae23a1026 ]

qcomtee_object_user_init() is a variadic function and when the function
return because there's no dispatch callback in QCOMTEE_OBJECT_TYPE_CB
case, there's no va_end to cleanup "ap" object initialized by va_start
and that can cause undefined behavior. So make sure to use va_end before
returning the error code when there's no dispatch callback.

This is reported by Coverity Scan as "Missing varargs init or cleanup".

Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>
Reviewed-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tee/qcomtee/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
index ecd04403591cf9..10717434275b1b 100644
--- a/drivers/tee/qcomtee/core.c
+++ b/drivers/tee/qcomtee/core.c
@@ -306,8 +306,10 @@ int qcomtee_object_user_init(struct qcomtee_object *object,
 		break;
 	case QCOMTEE_OBJECT_TYPE_CB:
 		object->ops = ops;
-		if (!object->ops->dispatch)
-			return -EINVAL;
+		if (!object->ops->dispatch) {
+			ret = -EINVAL;
+			break;
+		}
 
 		/* If failed, "no-name". */
 		object->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
-- 
2.53.0




