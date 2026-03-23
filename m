Return-Path: <stable+bounces-228141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH1sBdtPwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:36:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 458B42F4D17
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092E13053DF6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9048B3AC0E3;
	Mon, 23 Mar 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZ0gMrQb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA61EB9F2;
	Mon, 23 Mar 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274249; cv=none; b=EouPGr3psU+i6WMiyNpVOstjTokPP+1dMgcCcSfwI8LenayLChcG01zc7W3GN5K/628kiDEk7OTTsbGcz2ul86jFwh1DfJVe5xfbC+dJG6/MxIsdRFtH99nhc/eunMgJqUZQSBcMz0bXMyqy4QdeWMVxRGOl3VYTi+gdyfZdoRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274249; c=relaxed/simple;
	bh=oZ32sqpoowpo6zVpXtxt8jjm4Ix6XGaoS9szJCwnM+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ab74eELvXUgTVLP4tjfcXZtbBrC427ek8l/r1xGWTc2AJ7XaQnJstJ9i2Q4BjtwIX//TzKjMD4CSC1sl9r50RkSXv7QYQJLZWjtUJvs2PhbmOnMlKZMjA7Y+j7JuZ15nwi0CRlsh2pDg42t5vQM2ynfy9ZHUL6/qkmSLzL5ynYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZ0gMrQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DD2C4CEF7;
	Mon, 23 Mar 2026 13:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274248;
	bh=oZ32sqpoowpo6zVpXtxt8jjm4Ix6XGaoS9szJCwnM+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZ0gMrQbgF7QDlK9dgQGsHd525vdbbJCEbtzoMBKX2OtjA9+hOxXpmsT/dEJyy+qg
	 o9a/qdObAy8aYTjWvEgLR/MrGlU6yceukAwkEHiz0ZhDr2vyMd0WSw9VnIUFOqelqe
	 CZWrqb/6x+dLmcERJZJAoZMPfUocsTmdb+03CZZk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saket Dumbre <saket.dumbre@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 156/220] ACPICA: Update the format of Arg3 of _DSM
Date: Mon, 23 Mar 2026 14:45:33 +0100
Message-ID: <20260323134509.502328016@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228141-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 458B42F4D17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Saket Dumbre <saket.dumbre@intel.com>

[ Upstream commit ab93d7eee94205430fc3b0532557cb0494bf2faf ]

To get rid of type incompatibility warnings in Linux.

Fixes: 81f92cff6d42 ("ACPICA: ACPI_TYPE_ANY does not include the package type")
Link: https://github.com/acpica/acpica/commit/4fb74872dcec
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/12856643.O9o76ZdvQC@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpica/acpredef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index da2c45880cc7e..c9e65c6a20690 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -450,7 +450,7 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 
 	{{"_DSM",
 	  METHOD_4ARGS(ACPI_TYPE_BUFFER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER,
-		       ACPI_TYPE_ANY | ACPI_TYPE_PACKAGE) |
+		       ACPI_TYPE_PACKAGE | ACPI_TYPE_ANY) |
 		       ARG_COUNT_IS_MINIMUM,
 	  METHOD_RETURNS(ACPI_RTYPE_ALL)}},	/* Must return a value, but it can be of any type */
 
-- 
2.51.0




