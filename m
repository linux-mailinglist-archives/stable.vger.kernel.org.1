Return-Path: <stable+bounces-38858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2461F8A10B8
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFCD1F2CCC1
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE4C1494A9;
	Thu, 11 Apr 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WvdmMwxK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B56149C59;
	Thu, 11 Apr 2024 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831800; cv=none; b=kSBjohd/ylFOfPxAbdvRznTB6XSt3CVTHjqO0ykYAOMiGpU9Lpap+/K4IAhEw3VY5GDerQHzrgb6FnJ9y7autMGUs6cLFFefumRdxp0fshSs41M1iMU587OV29yFsYMNYSrEEFVin00HgUBfbrPYFJ3Ty8MFRlZQCIxVliizQeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831800; c=relaxed/simple;
	bh=4b5mEgfBxld4wS9Yny8g26gryR+JypXwJuYmMSgknm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQ6ZjYsOeBYiv5oZMuNGm2p0vX6SMQ3Qf1bzsF0JmDRZiJWJmXAJ/X7uhuMzO4Nq5eXM5gpyjn14ERqz6libJ7VC1vS+rUT2dGoSvkw5556BXqW58B+pEqCSiShUDO/w8Rc43xpq911xicNFerXuK+oF2w2j0GCYj1Tj8O7HS18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WvdmMwxK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C8CC433C7;
	Thu, 11 Apr 2024 10:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712831800;
	bh=4b5mEgfBxld4wS9Yny8g26gryR+JypXwJuYmMSgknm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvdmMwxKB2PYpXrc5HZyNn8hlNrgMqZX3LP94uJtc1CvjSCUxXnWB5XI+Tj7Y+sjV
	 jz0IG0XLtRIPgvbmgc9egaNmGMBWu1j+Pc8mzlzl6PzNg3E0uap4TRm8QGmruiWFLF
	 gD+g3cRcCvR5jBbgk3TEEs4Exezunl5PKGbYj0gs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 5.10 130/294] mei: me: add arrow lake point S DID
Date: Thu, 11 Apr 2024 11:54:53 +0200
Message-ID: <20240411095439.574812772@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit 7a9b9012043e126f6d6f4683e67409312d1b707b upstream.

Add Arrow Lake S device id.

Cc: stable@vger.kernel.org
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20240211103912.117105-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/hw-me-regs.h |    1 +
 drivers/misc/mei/pci-me.c     |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -112,6 +112,7 @@
 #define MEI_DEV_ID_RPL_S      0x7A68  /* Raptor Lake Point S */
 
 #define MEI_DEV_ID_MTL_M      0x7E70  /* Meteor Lake Point M */
+#define MEI_DEV_ID_ARL_S      0x7F68  /* Arrow Lake Point S */
 
 /*
  * MEI HW Section
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -118,6 +118,7 @@ static const struct pci_device_id mei_me
 	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MTL_M, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},
 
 	/* required last entry */
 	{0, }



