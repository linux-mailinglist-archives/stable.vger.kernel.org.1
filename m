Return-Path: <stable+bounces-150519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E86ACB7DA
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60F816C132
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D01221F39;
	Mon,  2 Jun 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="drbPLy2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E37221727;
	Mon,  2 Jun 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877376; cv=none; b=G9PQM0oIqUDHqLDSjs0LtUPTI6/JRAKl7GkpzQBdh2L2qSCl0DHnQfz94DwPHjDW1TvKah16dFzdEtK9EYsJzg6/0pGqi/0iUOSRrdNPatt/elblBmIggOu2sTLUzh1NIXaGOKVrUelt6ny9OfjpAn/YVvT/QGf9yLglsEtYzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877376; c=relaxed/simple;
	bh=xtnkm6U1Mwhtc+jg8qs4xZlcJQKrgZ3sF9I6E++S8S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DuG8FCHQwe35SPNB007dujc7tAvH+9w/wkSzixStyGbykWcfmWCop6ZBlipc8Ke32s8muxrnCzo5yPMLua82reBxNb/tCHufwkpZPk3IUVGDNlEBB7LyvTwvZgFWkgc4dBJNNOXrNssdzs0AEwK0FSWgyLcOa3vjs93wzQGuqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=drbPLy2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B51C4CEEB;
	Mon,  2 Jun 2025 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877376;
	bh=xtnkm6U1Mwhtc+jg8qs4xZlcJQKrgZ3sF9I6E++S8S8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=drbPLy2L0KorqZXp5nzsC3tAL3Cszg+mBK8HOSyKYf+uKCJ/f5Ph9ovA1H0X/EQNE
	 zZmUBnx9YEMjisBHmSEzuj5Uslqzj4NRQYyw4lvvGyGrAAOk7IrTOAWKNrAEoR2Bit
	 7/vHUG0mXyxa38elGxSB5Nj1PeQ6wxDDsGW8KrlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.1 258/325] platform/x86: dell-wmi-sysman: Avoid buffer overflow in current_password_store()
Date: Mon,  2 Jun 2025 15:48:54 +0200
Message-ID: <20250602134330.261709832@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>

commit 4e89a4077490f52cde652d17e32519b666abf3a6 upstream.

If the 'buf' array received from the user contains an empty string, the
'length' variable will be zero. Accessing the 'buf' array element with
index 'length - 1' will result in a buffer overflow.

Add a check for an empty string.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: e8a60aa7404b ("platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems")
Cc: stable@vger.kernel.org
Signed-off-by: Vladimir Moskovkin <Vladimir.Moskovkin@kaspersky.com>
Link: https://lore.kernel.org/r/39973642a4f24295b4a8fad9109c5b08@kaspersky.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/passobj-attributes.c
@@ -45,7 +45,7 @@ static ssize_t current_password_store(st
 	int length;
 
 	length = strlen(buf);
-	if (buf[length-1] == '\n')
+	if (length && buf[length - 1] == '\n')
 		length--;
 
 	/* firmware does verifiation of min/max password length,



