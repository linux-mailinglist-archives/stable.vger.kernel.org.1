Return-Path: <stable+bounces-167705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF97B2318B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50E1A173B69
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947782FDC2E;
	Tue, 12 Aug 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oL2CHapE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320B2FDC54;
	Tue, 12 Aug 2025 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021717; cv=none; b=BHwXXCQR378FaiZ7ZM4NxPZcPm09cziq/2G4sV+FQujPCMUEzFyegTzFXn40uJk/LgW9JosbbOIW3obAHkmDaT6VjGTD+jABzDbLywR+Evh5sYofseCN6jaLjn6BbXO0zwr1oYOkxdVVtBR24IiY8lOlvkS4W4FLTYK8IcQ8aQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021717; c=relaxed/simple;
	bh=ciYIHFgS4q0vEsdAPyKTYa+bpBuFc42v36yEKnPxLec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Joy/y+nTkN4jlgbcgQVUx4eWO2wA4C8JQu4xcNOdFAZYuoAYb0x+IP8Jh8zc7MRdOccQKfJJmr2mE2v731V+Juwut60FA2wYLLx0JFs0+a8OIicmSA94IKrn2kLHUpU3a62Mnz/P1H4bjTGeNyXC7krU4K6IKjpwPksqnSFfVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oL2CHapE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1819C4CEF0;
	Tue, 12 Aug 2025 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021717;
	bh=ciYIHFgS4q0vEsdAPyKTYa+bpBuFc42v36yEKnPxLec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oL2CHapEJNrgyqU9sC6Z9050F9GBPV3niWWwfKAiqy53++u2syHDDfQ9/9/8rDEjW
	 r2qCg78eIEKCiSlYvza51gz2DKHMXM3k/YhOvtmwgWvXAaOtKIV8iEN6yY5/BXQghE
	 ooZ8ETYIYzXbBZmuLyW3iFH6YgcNJ802BaSanIAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca.weiss@fairphone.com>,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Alex Elder <elder@riscstar.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 205/262] net: ipa: add IPA v5.1 and v5.5 to ipa_version_string()
Date: Tue, 12 Aug 2025 19:29:53 +0200
Message-ID: <20250812173001.883178172@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit f2aa00e4f65efcf25ff6bc8198e21f031e7b9b1b ]

Handle the case for v5.1 and v5.5 instead of returning "0.0".

Also reword the comment below since I don't see any evidence of such a
check happening, and - since 5.5 has been missing - can happen.

Fixes: 3aac8ec1c028 ("net: ipa: add some new IPA versions")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Alex Elder <elder@riscstar.com>
Link: https://patch.msgid.link/20250728-ipa-5-1-5-5-version_string-v1-1-d7a5623d7ece@fairphone.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipa/ipa_sysfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_sysfs.c b/drivers/net/ipa/ipa_sysfs.c
index 2ff09ce343b7..2e676b9d4042 100644
--- a/drivers/net/ipa/ipa_sysfs.c
+++ b/drivers/net/ipa/ipa_sysfs.c
@@ -38,8 +38,12 @@ static const char *ipa_version_string(struct ipa *ipa)
 		return "4.11";
 	case IPA_VERSION_5_0:
 		return "5.0";
+	case IPA_VERSION_5_1:
+		return "5.1";
+	case IPA_VERSION_5_5:
+		return "5.5";
 	default:
-		return "0.0";	/* Won't happen (checked at probe time) */
+		return "0.0";	/* Should not happen */
 	}
 }
 
-- 
2.39.5




