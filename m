Return-Path: <stable+bounces-118869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F474A41D28
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70EA317D2AF
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8735C27183B;
	Mon, 24 Feb 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZk/UYUK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6E260A3E;
	Mon, 24 Feb 2025 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396018; cv=none; b=WHLj1S3ucWrBwVwSO0d/mqH/iqbe6nyIWJ5lSjkwwR+tBIR7V0I+9qzZ5tI2+jpxwRdeNLEha3tUTVIYfXF+wnJQ+RXNV0/idl5qEV9yHvSky3n2IKz1QscA1cq2sCrPOjKIp4PPq4ipE8S18W5iuMdrT2l/uldIdraBtoSoa/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396018; c=relaxed/simple;
	bh=5C+zOcIF4cD1DS/AqOtgiI6/3sXbmaxbU7iRGfT/9fA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRSWmNi3wFFhkGSXz2H1I9o5B+kcvgLXTX3/pgSjXNcIitH8TaYmisu+sQXlZGzGxrpk4Afnstu0HfIP1jsqcfXQ54UEuYmAvGRijCo6DBd82Xlwzr3JHz0QLnRkYRqszpssWgidLKPSZQXAUbQz6phdXuQh2eN+sqS3wgc8TM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZk/UYUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA2DC4CED6;
	Mon, 24 Feb 2025 11:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396018;
	bh=5C+zOcIF4cD1DS/AqOtgiI6/3sXbmaxbU7iRGfT/9fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZk/UYUKPN92q0LulK4SXZspmxwkAj9YUaUbbaRf7o7DXYz4iGZcaWg58E4WNiZm2
	 sMG2LIqBGk8Zfad21ac414xiCBdPEZH89o4N1RpNMO5J7GhIsUoaKegMmqpN3yNzie
	 K190scEhtoJ3rfhM0e1R+6rWywIPK4JdgLs3ex8YIpp4p3CtKWfy20tM9VnOEqmlu2
	 u3nEN3AkkSQoGidiJc4UaXU/XuGdnELWFxkfuZLud1DmGMSepu7NfMpbyjGqSWJOpX
	 rbJ+2UjSAmWt4d5eFitQaF2X/+WL505Mc/OPrP3qT2yNtzwUQprgPpaRwwnTll6iK1
	 z37SJU9DaYxZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 6.1 05/12] ASoC: cs35l41: Fallback to using HID for system_name if no SUB is available
Date: Mon, 24 Feb 2025 06:19:53 -0500
Message-Id: <20250224112002.2214613-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112002.2214613-1-sashal@kernel.org>
References: <20250224112002.2214613-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 1d44a30ae3f9195cb4eb7d81bb9ced2776232094 ]

For systems which load firmware on the cs35l41 which use ACPI, the
_SUB value is used to differentiate firmware and tuning files for the
individual systems. In the case where a system does not have a _SUB
defined in ACPI node for cs35l41, there needs to be a fallback to
allow the files for that system to be differentiated. Since all
ACPI nodes for cs35l41 should have a HID defined, the HID should be a
safe option.

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Reviewed-by: André Almeida <andrealmeid@igalia.com>
Tested-by: André Almeida <andrealmeid@igalia.com>
Link: https://patch.msgid.link/20250205164806.414020-1-sbinding@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs35l41.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index e91c1a4640e46..40b71d29b3910 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1157,19 +1157,28 @@ static int cs35l41_dsp_init(struct cs35l41_private *cs35l41)
 
 static int cs35l41_acpi_get_name(struct cs35l41_private *cs35l41)
 {
-	acpi_handle handle = ACPI_HANDLE(cs35l41->dev);
+	struct acpi_device *adev = ACPI_COMPANION(cs35l41->dev);
+	acpi_handle handle = acpi_device_handle(adev);
+	const char *hid;
 	const char *sub;
 
-	/* If there is no ACPI_HANDLE, there is no ACPI for this system, return 0 */
-	if (!handle)
+	/* If there is no acpi_device, there is no ACPI for this system, return 0 */
+	if (!adev)
 		return 0;
 
 	sub = acpi_get_subsystem_id(handle);
 	if (IS_ERR(sub)) {
-		/* If bad ACPI, return 0 and fallback to legacy firmware path, otherwise fail */
-		if (PTR_ERR(sub) == -ENODATA)
-			return 0;
-		else
+		/* If no _SUB, fallback to _HID, otherwise fail */
+		if (PTR_ERR(sub) == -ENODATA) {
+			hid = acpi_device_hid(adev);
+			/* If dummy hid, return 0 and fallback to legacy firmware path */
+			if (!strcmp(hid, "device"))
+				return 0;
+			sub = kstrdup(hid, GFP_KERNEL);
+			if (!sub)
+				sub = ERR_PTR(-ENOMEM);
+
+		} else
 			return PTR_ERR(sub);
 	}
 
-- 
2.39.5


