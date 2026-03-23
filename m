Return-Path: <stable+bounces-228364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OpnEahNwWmxSAQAu9opvQ
	(envelope-from <stable+bounces-228364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:26:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D662F47ED
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250593074F19
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66A13AF66C;
	Mon, 23 Mar 2026 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ntysGZ6g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F13AD50A;
	Mon, 23 Mar 2026 14:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274917; cv=none; b=YYgQ+r4g40uiE/vdCgkL51Cx+PI9ucIhFGDJcd/0xwvW5bpZRn2Y8wmKB2vx5vagteseb8davLiVOR+CwUh4VdwcrdeNVT0zS1W6QB9lG7g9meodEoLi66yQonxSKXu0jFsPqw4ypnYo2nQXhwC+2K6jkOtk600q5YHn+m1VGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274917; c=relaxed/simple;
	bh=0bZzcpCHdpn5+zdv5T6JYBcOPKR5qlXXyigTAQIAN2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HAta2HUEc7G3EzImM9YFwmUGUtWGrbdsj85HB7m6AJE+YK2H+yZC9HNY3XlgJCoYFRlMvFqvXOFnBKxGJJi4Tb7Q8aP8pi77q7FSQsMsBvlOZslRCm3L1KUXl3WYFFd4mgNgulrToX2yELqTWU1MOR0WYNezvcMGNVRyfIcgndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ntysGZ6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0562EC4CEF7;
	Mon, 23 Mar 2026 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274917;
	bh=0bZzcpCHdpn5+zdv5T6JYBcOPKR5qlXXyigTAQIAN2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntysGZ6g5LT8tc8fAjsKMED8Q+/i64vdPU8VoKSXSUhvvhHtbCeQRt6QgtasrMyvu
	 2xfVD21GVM6kzVcqeIV3rGFb+kMlMPPhMylk7fxFljH+/Hvm3coh1H6Y0u1Eld1Mwj
	 tr5odOG+p1aP4hA5R0zuWgPaDTy8BvahlCp3whTY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Saket Dumbre <saket.dumbre@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 155/212] ACPICA: Update the format of Arg3 of _DSM
Date: Mon, 23 Mar 2026 14:46:16 +0100
Message-ID: <20260323134508.658176580@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228364-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A8D662F47ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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




