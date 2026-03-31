Return-Path: <stable+bounces-232130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG2NMNoEzGm4NQYAu9opvQ
	(envelope-from <stable+bounces-232130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:31:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B453036ED93
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6FA93084D4C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD09426D0A;
	Tue, 31 Mar 2026 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DrFDTP6Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706BB4266B2;
	Tue, 31 Mar 2026 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975953; cv=none; b=uWuOd+PqmvrLy7cHAFL3LGHUBDI5NlfMPmpU5fWzDvWh6dCu1YlabUhrPlwaKsyH0k5VoUUg/56BfKu+UrSGYtPR5aW74l3AVk0kiOaQmgNUAPh8h54DwfFJZRAtaZqv+X3QFuGLimrDRu58lIYZ6r4OdlfoMoy1rpyxbItTJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975953; c=relaxed/simple;
	bh=mbl6RDov6mR7F4hM/jFYH1ULxfYR7yhZoZ6V4n2gsjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGg0qUqKOKyLOg5RJ9VD3u4G3VcxcS+VpR+jNhSQhOK0DQiq5/fgGA398h3HtujlvGIo7T123wt5VqlluBWwTi5klKhuxAQ+zOF57IXG8oVHempZLlU5hui4kkKaGtkQLDSNfv0tyNPTRR6uVlNjKbBk1RDAf5FA59+7Fip1ccU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DrFDTP6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EF2C19423;
	Tue, 31 Mar 2026 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975953;
	bh=mbl6RDov6mR7F4hM/jFYH1ULxfYR7yhZoZ6V4n2gsjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DrFDTP6YI8QJkuitMYDN3SeB2o3T6Vts/91vXJBo7EBbvuwprIcmwq3eBM+h4Ln0S
	 CwEPUU89s6GAsCxMkhjH++ZkfhpX5+Gb3DRawPzpII5DQFcGzFaM7yTe6Zh8/TSY7Q
	 Aw0y+YcGVunK5XZuCRI+d2qW/8C2TXCmUfe0i64c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.12 151/244] hwmon: (peci/cputemp) Fix off-by-one in cputemp_is_visible()
Date: Tue, 31 Mar 2026 18:21:41 +0200
Message-ID: <20260331161747.339973320@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232130-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,juniper.net:email,roeck-us.net:email]
X-Rspamd-Queue-Id: B453036ED93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

commit b0c9d8ae71509f25690d57f2efddebf7f4b12194 upstream.

cputemp_is_visible() validates the channel index against
CPUTEMP_CHANNEL_NUMS, but currently uses '>' instead of '>='.
As a result, channel == CPUTEMP_CHANNEL_NUMS is not rejected even though
valid indices are 0 .. CPUTEMP_CHANNEL_NUMS - 1.

Fix the bounds check by using '>=' so invalid channel indices are
rejected before indexing the core bitmap.

Fixes: bf3608f338e9 ("hwmon: peci: Add cputemp driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260323002352.93417-3-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/peci/cputemp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/peci/cputemp.c
+++ b/drivers/hwmon/peci/cputemp.c
@@ -339,7 +339,7 @@ static umode_t cputemp_is_visible(const
 {
 	const struct peci_cputemp *priv = data;
 
-	if (channel > CPUTEMP_CHANNEL_NUMS)
+	if (channel >= CPUTEMP_CHANNEL_NUMS)
 		return 0;
 
 	if (channel < channel_core)



