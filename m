Return-Path: <stable+bounces-212568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLaNKIg7emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:38:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D17A5EDB
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74C1C31930EC
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CB03033C3;
	Wed, 28 Jan 2026 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qz1CYxJ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F02874FE;
	Wed, 28 Jan 2026 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615954; cv=none; b=shM1D4cgDnLwsdtrSfKY32tvYIMYND9E8cTVSHkkMxkmNbByk5po+tn25OF7+YTxSvQDZXqm08bm75X3kI0uB4I2PjVxywSCH6KF5i+Nhr93hRXjU028WahaKlq64YvC/mrS96v4AaIVvIah/KlchjvnkefA5CXUGKW+obGLNEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615954; c=relaxed/simple;
	bh=E7NPyEpMhe4wJW20KmoB20dfhcPNQ2eIFv63qrnI2zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JytxP/TdUf1Jn+DmTqZx5RcFMCn3ajLZNV75AhA3FAHeIqgQ+i9J+Odqzhs/uRMi/nb4r1U7j+R7soJKanmtYefPctQ1r3BnHNP+HDuBTg7flrfdxam7qw7g45E+myJg1Nxr3eSb5xnZYAThXhEnYrXOczSD+caC73MmatoAxrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qz1CYxJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC8CC4CEF1;
	Wed, 28 Jan 2026 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615954;
	bh=E7NPyEpMhe4wJW20KmoB20dfhcPNQ2eIFv63qrnI2zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qz1CYxJ5Eqd725QiGzUbmNjkm7V3p1moqwBYgJeq80KfUGaAuZCGyeuTI9dG9OCWV
	 1MQuBjbtE2aaNgxB/UYlJQSiM4z3wHNPTnWBnYqYCA5OQ4gKxy8xiiiw1LdmKRZLiW
	 QldZBBgnh7zPBeKQeQgYS8ALk+mbj02v14Wpyy6Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6.18 162/227] iio: adc: pac1934: Fix clamped value in pac1934_reg_snapshot
Date: Wed, 28 Jan 2026 16:23:27 +0100
Message-ID: <20260128145350.283345867@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212568-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 03D17A5EDB
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit da934ef0fdff5ba21e82ec3ab3f95fe73137b0c9 upstream.

The local variable 'curr_energy' was never clamped to
PAC_193X_MIN_POWER_ACC or PAC_193X_MAX_POWER_ACC because the return
value of clamp() was not used. Fix this by assigning the clamped value
back to 'curr_energy'.

Cc: stable@vger.kernel.org
Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/adc/pac1934.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -665,9 +665,9 @@ static int pac1934_reg_snapshot(struct p
 			/* add the power_acc field */
 			curr_energy += inc;
 
-			clamp(curr_energy, PAC_193X_MIN_POWER_ACC, PAC_193X_MAX_POWER_ACC);
-
-			reg_data->energy_sec_acc[cnt] = curr_energy;
+			reg_data->energy_sec_acc[cnt] = clamp(curr_energy,
+							      PAC_193X_MIN_POWER_ACC,
+							      PAC_193X_MAX_POWER_ACC);
 		}
 
 		offset_reg_data_p += PAC1934_VPOWER_ACC_REG_LEN;



