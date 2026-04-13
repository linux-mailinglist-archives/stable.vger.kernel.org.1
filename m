Return-Path: <stable+bounces-236989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLHMD8si3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-236989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:07:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC93F0C89
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF9A31CFB65
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A35930DEAC;
	Mon, 13 Apr 2026 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wzM6y+z2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21842D5A19;
	Mon, 13 Apr 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098305; cv=none; b=JjJ6Td7yo9GB7S1WPWVRwoW8LfPrx060itE5bUxyg7Sr/tIzQWaaSVnuoHcMeQh/uOKsaJ+Ga5dXutHOrofdZNOq9FkLOi8Rb65q/2hXGAFKZY3PIHgwYH7GQPOO3RBe0zExzE5x1KNtDvNrVqs3D+pC7JHvyx0xqE+9N1lHhM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098305; c=relaxed/simple;
	bh=ZF2kl/hPqpcwWv7IhXLTpNFDCEwdc2B9xz+khF3mgHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eb0MwAkWX9Rgmof80F33tt+2OJiFSEwEky3HyxwXpG8oiwztAAqatVUOCgFNhe14dhOc6jaDtW8SPXy5q9ACTkMqg3MkCFyH3n4Njptyp828ndjrvPxafR18mhMH9UQOUgw/i/numpBWrC3+HnrQg+PBOeusXL9JJFbLfTqLF3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wzM6y+z2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5953DC2BCAF;
	Mon, 13 Apr 2026 16:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098305;
	bh=ZF2kl/hPqpcwWv7IhXLTpNFDCEwdc2B9xz+khF3mgHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wzM6y+z2DOIvQMvpp5O/T+Q1vMibUC3ecTn1LS4OPDSH/BoIybOlzCxZfRdmqpmzo
	 6LJ0nAc8nkH1YKemiMANi4FNPbux4uB6b9Q1ovzqBml9GbBqWFHOrxS1SG5M0j1zwj
	 CrFD8/6Pt3JI1gjRi/Cg80o0MRHbvXDXWyGoS6Wc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanman Pradhan <psanman@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 441/570] hwmon: (occ) Fix missing newline in occ_show_extended()
Date: Mon, 13 Apr 2026 17:59:32 +0200
Message-ID: <20260413155846.992702717@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-236989-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[juniper.net:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:email]
X-Rspamd-Queue-Id: 98DC93F0C89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanman Pradhan <psanman@juniper.net>

[ Upstream commit 09773978879ecf71a7990fe9a28ce4eb92bce645 ]

In occ_show_extended() case 0, when the EXTN_FLAG_SENSOR_ID flag
is set, the sysfs_emit format string "%u" is missing the trailing
newline that the sysfs ABI expects. The else branch correctly uses
"%4phN\n", and all other show functions in this file include the
trailing newline.

Add the missing "\n" for consistency and correct sysfs output.

Fixes: c10e753d43eb ("hwmon (occ): Add sensor types and versions")
Signed-off-by: Sanman Pradhan <psanman@juniper.net>
Link: https://lore.kernel.org/r/20260326224510.294619-3-sanman.pradhan@hpe.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/occ/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/occ/common.c b/drivers/hwmon/occ/common.c
index 44007858c23fc..f178cb16b28cb 100644
--- a/drivers/hwmon/occ/common.c
+++ b/drivers/hwmon/occ/common.c
@@ -724,7 +724,7 @@ static ssize_t occ_show_extended(struct device *dev,
 	switch (sattr->nr) {
 	case 0:
 		if (extn->flags & EXTN_FLAG_SENSOR_ID) {
-			rc = sysfs_emit(buf, "%u",
+			rc = sysfs_emit(buf, "%u\n",
 					get_unaligned_be32(&extn->sensor_id));
 		} else {
 			rc = sysfs_emit(buf, "%02x%02x%02x%02x\n",
-- 
2.53.0




