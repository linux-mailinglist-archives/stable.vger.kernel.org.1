Return-Path: <stable+bounces-236577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMuFCM8a3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:33:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2953EF393
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C339D30F4FB7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5082FFFA4;
	Mon, 13 Apr 2026 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QZmI90qU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6682F6931;
	Mon, 13 Apr 2026 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097265; cv=none; b=m2KiIBN0PBGf4NI4xaLtooxLG5zu2yQ886Q+m30DH0lI43SIeQjDlr19rkNBWhhkh5lmgyGVQcy7z/7bj+atMqm84tsatiKqXf6rzmx5re+VIQcyuiJ12OyQM12s/yUGPvyp/LFLfLQAcGaH55Ke803VXCxYVJIqUSTM8OWYOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097265; c=relaxed/simple;
	bh=etkuvXffcM+AiwRsjcRjC9Ta4ycky7YU2ET6kPPm31o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QCUwVuS5H/j0wgnes+7h2MsuDzx5PiD6zYXFo4Q3ZOpAWLU4R3icjXYw9NXnG7i6TOdtDUVTVQsXolpOZ2ypkK8ne1/gmZZQTpeEZNdxTmwfTcXL9gXuZabO7aivBxU330lYiv0Uwf+pgLMLTYy3dev5ouA/gECXsxkupOQQm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QZmI90qU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAD6C2BCAF;
	Mon, 13 Apr 2026 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097265;
	bh=etkuvXffcM+AiwRsjcRjC9Ta4ycky7YU2ET6kPPm31o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QZmI90qUW2nEP6Xk1/E8SVoQlzzxF4Oz4a4apbGlyCtdmulOth7HzvcbpPtaRBU/I
	 018lmiiSn2BmLugubtgWwL+3l4VlF4YxLpkPIIvmLysiMsu8WDy86+btJ/kk98lCGI
	 7B4MTMD6K5AqdFc2Io6fWfuXKx5VD9ydPhhdMBj4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5.15 052/570] platform/x86: dell-wmi-sysman: Dont hex dump plaintext password data
Date: Mon, 13 Apr 2026 17:53:03 +0200
Message-ID: <20260413155832.390445348@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236577-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,intel.com:email]
X-Rspamd-Queue-Id: 9C2953EF393
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit d1a196e0a6dcddd03748468a0e9e3100790fc85c upstream.

set_new_password() hex dumps the entire buffer, which contains plaintext
password data, including current and new passwords. Remove the hex dump
to avoid leaking credentials.

Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260303113050.58127-2-thorsten.blum@linux.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passwordattr-interface.c
@@ -93,7 +93,6 @@ int set_new_password(const char *passwor
 	if (ret < 0)
 		goto out;
 
-	print_hex_dump_bytes("set new password data: ", DUMP_PREFIX_NONE, buffer, buffer_size);
 	ret = call_password_interface(wmi_priv.password_attr_wdev, buffer, buffer_size);
 	/* on success copy the new password to current password */
 	if (!ret)



