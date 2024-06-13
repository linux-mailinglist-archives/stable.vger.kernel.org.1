Return-Path: <stable+bounces-52036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67359072C5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75AC1C21B5E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543424A0F;
	Thu, 13 Jun 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W3ZKiTkC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4617FD;
	Thu, 13 Jun 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283046; cv=none; b=VBE6RaWrAr4Gq7uG0JBmYMOVFM1MDmaOxeO0kknZHqik1OPbye81s2Ql965npyE0n5gvfPWRUOYnt5CHPsX77X3hoE6dTmywwJob65ohBZ3S2Di7VqmoWDVw1IYtaYv0vj9HLYra10fHXowuYXL1P6bJIO/VMy5OAa/KqZohR7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283046; c=relaxed/simple;
	bh=Tf3W8elHE/gsLUsWjfqIhi8EpIadXw2WlsGBgkkIK10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z155boohriSZaj+uDCjAOgnt/IlsFRXODP3e/EoYlkmH3SQzVxnW4dvtDU04K0jkGU6zj9K9GtZYMlavRF7UFo4nrJmogQbmjMZ8AsOMi+D+xEmam61Bz8zfOEnvxbNwtHQdwqgvgB20hltV9BGPSwyvyi6EoDNIRjQkVK6ynLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W3ZKiTkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA35C2BBFC;
	Thu, 13 Jun 2024 12:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718283046;
	bh=Tf3W8elHE/gsLUsWjfqIhi8EpIadXw2WlsGBgkkIK10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W3ZKiTkCVSg8atfF2aPLHuh2EZUQ/HreQL1h5sbmzGt8sjzcxbrb3uzAorpEZnuyq
	 1FV95jBZz4asyyO1KhXzYnYlypC/uqcDwacnVvDj1+sxsVmZUWQMXH001H5EX5DR8C
	 q5wiLzShLkFXfIR3pF4BWQz/G8C0E8+mFpeY7kiU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [PATCH 6.1 80/85] EDAC/igen6: Convert PCIBIOS_* return codes to errnos
Date: Thu, 13 Jun 2024 13:36:18 +0200
Message-ID: <20240613113217.222853362@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113214.134806994@linuxfoundation.org>
References: <20240613113214.134806994@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit f8367a74aebf88dc8b58a0db6a6c90b4cb8fc9d3 upstream.

errcmd_enable_error_reporting() uses pci_{read,write}_config_word()
that return PCIBIOS_* codes. The return code is then returned all the
way into the probe function igen6_probe() that returns it as is. The
probe functions, however, should return normal errnos.

Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
errno before returning it from errcmd_enable_error_reporting().

Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240527132236.13875-2-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/igen6_edac.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -627,7 +627,7 @@ static int errcmd_enable_error_reporting
 
 	rc = pci_read_config_word(imc->pdev, ERRCMD_OFFSET, &errcmd);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (enable)
 		errcmd |= ERRCMD_CE | ERRSTS_UE;
@@ -636,7 +636,7 @@ static int errcmd_enable_error_reporting
 
 	rc = pci_write_config_word(imc->pdev, ERRCMD_OFFSET, errcmd);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	return 0;
 }



