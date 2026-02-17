Return-Path: <stable+bounces-217155-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ImWBlrVlGnnIAIAu9opvQ
	(envelope-from <stable+bounces-217155-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:53:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B496B1507C9
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3EB03046AB1
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF43C28C009;
	Tue, 17 Feb 2026 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hKjMrOcd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA7280CC1;
	Tue, 17 Feb 2026 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771361611; cv=none; b=XnXx0AZ/wIliOgrzOqhikxCDgJo4DNs6JG3Zd9JqcpHzfdWeOMZlzfG+Kjft4ImOBpIoUjdSEvTk7BgZ4aNLpDnRlo5nBQmwh7aKXA0IZ0LwSPJ6RpMClOqyIeLJvd4lkNJOFBg+Be9FXNNAeoddPIAjDJABmNMgg1zJOx/phUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771361611; c=relaxed/simple;
	bh=tse+bC3aOOtKQ11g6Cm87d+NUyvKrHMzDFViIcuzK0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0IrGpuBkhM5W8LO9WBAd0+ufmQUdg2l7cIqmnzRezw49KAs//mZfpbv13IH402eBngBEJAij0jUFBnz2ATCjIvK+TK1i1i4GvC6nYvMLvoyVtSU4dvVdz9PbRWGxNKnqPcddyhqsPEQYl4x5+Msjs0FHTqXuYGQz5GxDFk424U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hKjMrOcd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14295C4CEF7;
	Tue, 17 Feb 2026 20:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771361611;
	bh=tse+bC3aOOtKQ11g6Cm87d+NUyvKrHMzDFViIcuzK0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hKjMrOcd9JPP6lGK46EJliWDQiFg8irn4STFaLS5VJm9DdWtRmubUjdgwZafw9DwP
	 RO+MkJfuSuQRrtAgTShbesC1II5cTVsJph29ocPIl3iyt3NmrmxJToCA8pG8lKhwvt
	 rVzDg+5/UxpeE0P9ejPbrbbn+jDiVAEpwauK77/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 03/42] bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code
Date: Tue, 17 Feb 2026 21:31:54 +0100
Message-ID: <20260217200006.134130797@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217200005.998240758@linuxfoundation.org>
References: <20260217200005.998240758@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217155-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,msgid.link:url,arndb.de:email]
X-Rspamd-Queue-Id: B496B1507C9
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 8ff6175139967cd17b2a62bca4b2de2559942b7e upstream.

The CONFIG_DEFAULT_HUNG_TASK_TIMEOUT setting is only available when the
hung task detection is enabled, otherwise the code now produces a build
failure:

drivers/net/ethernet/broadcom/bnxt/bnxt.c:10188:21: error: use of undeclared identifier 'CONFIG_DEFAULT_HUNG_TASK_TIMEOUT'
 10188 |             max_tmo_secs > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT) {

Enclose this warning logic in an #ifdef to ensure this builds.

Fixes: 0fcad44a86bd ("bnxt_en: Change FW message timeout warning")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20250423162827.2189658-1-arnd@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9844,11 +9844,13 @@ static int bnxt_hwrm_ver_get(struct bnxt
 	if (!bp->hwrm_cmd_max_timeout)
 		bp->hwrm_cmd_max_timeout = HWRM_CMD_MAX_TIMEOUT;
 	max_tmo_secs = bp->hwrm_cmd_max_timeout / 1000;
+#ifdef CONFIG_DETECT_HUNG_TASK
 	if (bp->hwrm_cmd_max_timeout > HWRM_CMD_MAX_TIMEOUT ||
 	    max_tmo_secs > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT) {
 		netdev_warn(bp->dev, "Device requests max timeout of %d seconds, may trigger hung task watchdog (kernel default %ds)\n",
 			    max_tmo_secs, CONFIG_DEFAULT_HUNG_TASK_TIMEOUT);
 	}
+#endif
 
 	if (resp->hwrm_intf_maj_8b >= 1) {
 		bp->hwrm_max_req_len = le16_to_cpu(resp->max_req_win_len);



