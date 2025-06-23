Return-Path: <stable+bounces-155778-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9EAE43C6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3AE93BBB9F
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE60253939;
	Mon, 23 Jun 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KXSaV7wB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A19253925;
	Mon, 23 Jun 2025 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685308; cv=none; b=Y1SnjYSzTNFMseD45nS0Pqp9i1N/82sTNquI1B2Doq7HGVPJu+SJ74lFVHlcLxYiLy/KwtNR6beixea4BGLQfqSC7L9IE0sri5xVtit5u7gLzPl4jnKgYZStm77OQ3PDTa8bKNilSnvW4g/mqhObrjhqxMYpPAHbDIQ6eZGakTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685308; c=relaxed/simple;
	bh=C8zx0zG+oLUO9uHuZAS4zIuCHcBj6RRBkml8JkgTGK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6P/5/Hw6KCEyqCvpTiwHR7xVM6O4pwJNyZ9dzFafugjhQI71j2puaAqcvzcH3MdDFxHENSkFLopLoZU3vDOKnI4Dyl2ctgWOZgO5g/iHoLd9ZAJQArxyWtpco4dJj9+d0b/nkaoEO6M2ddydIeDsa1M/TrXxLCsS5z3ya6f7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KXSaV7wB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BC0C4CEEA;
	Mon, 23 Jun 2025 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750685308;
	bh=C8zx0zG+oLUO9uHuZAS4zIuCHcBj6RRBkml8JkgTGK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KXSaV7wBPwkH83IgCnTF0rEQWZuxNd8MmJ5QBQGuEg90ZZjzp4W8GBArkizpVTSZf
	 tEhpXw+3iNCgXolObyqOj6Q4xQNqQ9QQedUkKaF2xw6ihzhN74c+l69uAv2THH9hxx
	 laVPcuSuKBogm+BnC2I8bKyT3HiascM9+Wq00fn4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Armin Wolf <W_Armin@gmx.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 025/411] ACPI: OSI: Stop advertising support for "3.0 _SCP Extensions"
Date: Mon, 23 Jun 2025 15:02:49 +0200
Message-ID: <20250623130633.758608110@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit 8cf4fdac9bdead7bca15fc56fdecdf78d11c3ec6 ]

As specified in section 5.7.2 of the ACPI specification the feature
group string "3.0 _SCP Extensions" implies that the operating system
evaluates the _SCP control method with additional parameters.

However the ACPI thermal driver evaluates the _SCP control method
without those additional parameters, conflicting with the above
feature group string advertised to the firmware thru _OSI.

Stop advertising support for this feature string to avoid confusing
the ACPI firmware.

Fixes: e5f660ebef68 ("ACPI / osi: Collect _OSI handling into one single file")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://patch.msgid.link/20250410165456.4173-2-W_Armin@gmx.de
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/osi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
index 9f68538091384..d93409f2b2a07 100644
--- a/drivers/acpi/osi.c
+++ b/drivers/acpi/osi.c
@@ -42,7 +42,6 @@ static struct acpi_osi_entry
 osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
 	{"Module Device", true},
 	{"Processor Device", true},
-	{"3.0 _SCP Extensions", true},
 	{"Processor Aggregator Device", true},
 	/*
 	 * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
-- 
2.39.5




