Return-Path: <stable+bounces-219426-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDByLK+inmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219426-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:20:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D801933CA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5496231D1B24
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C83081C2;
	Wed, 25 Feb 2026 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ImGIC1yG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCDF30E855;
	Wed, 25 Feb 2026 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002707; cv=none; b=KhPMJubmJwnI3PGvo5vnU2vdUZwWRACYyWuOXGk6sEwUprqmxrXc6q6wZ5zqLcwQFFJxDT0coIXnAKZ8neew6TFwoK1zShZSBR3OMOShHOg8TurGJp6JdBLJvVnjXtPFEis04kKGsaPY5tBFXjLMEBbjhjyk8b/DF2w2FFeJyZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002707; c=relaxed/simple;
	bh=gxF+QLsVOPdiDd90odlSHwXsHLcD5YJVQxvmHuAogLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgWEQsRkJ8YyDPBngeoQOp4ti+RabLrI23/4pCPcSo+Ff9UONmXkbB0NSkSuk/7/pxoH89bBIw7Wo/73iTZxS3q48t8ddS7hf5K+dxk7e7OQfW6BSPRbABlLiw9pJhCskZY2MgR7fK4rPbMOdKNzBqQQw6d86AUj0/+XgBdfY+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ImGIC1yG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72DCC116D0;
	Wed, 25 Feb 2026 06:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002707;
	bh=gxF+QLsVOPdiDd90odlSHwXsHLcD5YJVQxvmHuAogLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImGIC1yGhqgNvPfS0mEN4l+4RaPehCixDNfVEIEdDq++RCc97PztrybvKXNIfofnA
	 DyJSjt/Fk+a1Jh0mRywAjrbQ2b09p3/mVD9DBTv57Xu4oA+Y3RQeKfXluYVP0fYaLA
	 YlLnSnDYObVoHtlt0hSDs5C+g2AcXs9Q/ojXgk9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhai Can <bczhc0@126.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 508/641] ACPI: PM: Add unused power resource quirk for THUNDEROBOT ZERO
Date: Tue, 24 Feb 2026 17:23:54 -0800
Message-ID: <20260225012400.834606110@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219426-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,126.com,intel.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2D801933CA
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhai Can <bczhc0@126.com>

[ Upstream commit cd7ef20ba8c6e936dba133b4136537a8ada22976 ]

On the THUNDEROBOT ZERO laptop, the second NVMe slot and the discrete
NVIDIA GPU are both controlled by power-resource PXP. Due to the SSDT table
bug (lack of reference), PXP will be shut dow as an "unused" power resource
during initialization, making the NVMe slot #2 + NVIDIA both inaccessible.

This issue was introduced by commit a1224f34d72a ("ACPI: PM: Check
states of power resources during initialization"). Here are test
results on the three consecutive commits:

(bad again!) a1224f34d72a ACPI: PM: Check states of power resources during initialization
(good) bc2836859643 ACPI: PM: Do not turn off power resources in unknown state
(bad) 519d81956ee2 Linux 5.15-rc6

On commit bc2836859643 ("ACPI: PM: Do not turn off power resources in
unknown state") this was not an issue because the power resource state
left UNKNOWN thus being ignored.

See also commit 9b04d99788cf ("ACPI: PM: Do not turn of unused power
resources on the Toshiba Click Mini") which is another almost identical
case to this one.

Fixes: a1224f34d72a ("ACPI: PM: Check states of power resources during initialization")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221087
Signed-off-by: Zhai Can <bczhc0@126.com>
Link: https://patch.msgid.link/20260214161452.2849346-1-bczhc0@126.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/power.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 361a7721a6a87..7da5ae5594a72 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -1113,6 +1113,19 @@ static const struct dmi_system_id dmi_leave_unused_power_resources_on[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE Click Mini L9W-B"),
 		},
 	},
+	{
+		/*
+		 * THUNDEROBOT ZERO laptop: Due to its SSDT table bug, power
+		 * resource 'PXP' will be shut down on initialization, making
+		 * the NVMe #2 and the NVIDIA dGPU both unavailable (they're
+		 * both controlled by 'PXP').
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "THUNDEROBOT"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZERO"),
+		}
+
+	},
 	{}
 };
 
-- 
2.51.0




